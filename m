Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F29E9A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 15:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfH0NjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 09:39:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0NjN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:39:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9B2BB684;
        Tue, 27 Aug 2019 13:39:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 703F71E4362; Tue, 27 Aug 2019 15:39:08 +0200 (CEST)
Date:   Tue, 27 Aug 2019 15:39:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     " Steven J. Magnani " <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udf: augment UDF permissions on new inodes
Message-ID: <20190827133908.GA10098@quack2.suse.cz>
References: <20190827121359.9954-1-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827121359.9954-1-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-08-19 07:13:59,  Steven J. Magnani  wrote:
> Windows presents files created within Linux as read-only, even when
> permissions in Linux indicate the file should be writable.
> 
> 
> UDF defines a slightly different set of basic file permissions than Linux.
> Specifically, UDF has "delete" and "change attribute" permissions for each
> access class (user/group/other). Linux has no equivalents for these.
> 
> When the Linux UDF driver creates a file (or directory), no UDF delete or
> change attribute permissions are granted. The lack of delete permission
> appears to cause Windows to mark an item read-only when its permissions
> otherwise indicate that it should be read-write.
> 
> Fix this by having UDF delete permissions track Linux write permissions.
> Also grant UDF change attribute permission to the owner when creating a
> new inode.
> 
> Reported by: Ty Young
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

Thanks for the patch! I've added it to my tree.

								Honza

> ---
> 
> Changes since rev 1:
> UDF delete permission tracks with Linux write permission instead
> of being unconditionally granted to the owner at inode creation
> 
> --- a/fs/udf/udf_i.h	2019-08-14 07:24:05.029508342 -0500
> +++ b/fs/udf/udf_i.h	2019-08-26 21:33:05.064410067 -0500
> @@ -38,6 +38,7 @@ struct udf_inode_info {
>  	__u32			i_next_alloc_block;
>  	__u32			i_next_alloc_goal;
>  	__u32			i_checkpoint;
> +	__u32			i_extraPerms;
>  	unsigned		i_alloc_type : 3;
>  	unsigned		i_efe : 1;	/* extendedFileEntry */
>  	unsigned		i_use : 1;	/* unallocSpaceEntry */
> --- a/fs/udf/udfdecl.h	2019-08-26 21:38:12.138562583 -0500
> +++ b/fs/udf/udfdecl.h	2019-08-26 21:09:19.465000110 -0500
> @@ -178,6 +178,7 @@ extern int8_t udf_next_aext(struct inode
>  			    struct kernel_lb_addr *, uint32_t *, int);
>  extern int8_t udf_current_aext(struct inode *, struct extent_position *,
>  			       struct kernel_lb_addr *, uint32_t *, int);
> +extern void udf_update_extra_perms(struct inode *inode, umode_t mode);
>  
>  /* misc.c */
>  extern struct buffer_head *udf_tgetblk(struct super_block *sb,
> --- a/fs/udf/ialloc.c	2019-08-14 07:24:05.029508342 -0500
> +++ b/fs/udf/ialloc.c	2019-08-26 21:16:43.379449924 -0500
> @@ -125,6 +125,9 @@ struct inode *udf_new_inode(struct inode
>  	iinfo->i_lenAlloc = 0;
>  	iinfo->i_use = 0;
>  	iinfo->i_checkpoint = 1;
> +	iinfo->i_extraPerms = FE_PERM_U_CHATTR;
> +	udf_update_extra_perms(inode, mode);
> +
>  	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_AD_IN_ICB))
>  		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
>  	else if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
> --- a/fs/udf/inode.c	2019-08-14 07:24:05.029508342 -0500
> +++ b/fs/udf/inode.c	2019-08-26 21:40:17.865649383 -0500
> @@ -45,6 +45,13 @@
>  
>  #define EXTENT_MERGE_SIZE 5
>  
> +#define FE_MAPPED_PERMS	(FE_PERM_U_READ | FE_PERM_U_WRITE | FE_PERM_U_EXEC | \
> +			 FE_PERM_G_READ | FE_PERM_G_WRITE | FE_PERM_G_EXEC | \
> +			 FE_PERM_O_READ | FE_PERM_O_WRITE | FE_PERM_O_EXEC)
> +
> +#define FE_DELETE_PERMS	(FE_PERM_U_DELETE | FE_PERM_G_DELETE | \
> +			 FE_PERM_O_DELETE)
> +
>  static umode_t udf_convert_permissions(struct fileEntry *);
>  static int udf_update_inode(struct inode *, int);
>  static int udf_sync_inode(struct inode *inode);
> @@ -1458,6 +1465,8 @@ reread:
>  	else
>  		inode->i_mode = udf_convert_permissions(fe);
>  	inode->i_mode &= ~sbi->s_umask;
> +	iinfo->i_extraPerms = le32_to_cpu(fe->permissions) & ~FE_MAPPED_PERMS;
> +
>  	read_unlock(&sbi->s_cred_lock);
>  
>  	link_count = le16_to_cpu(fe->fileLinkCount);
> @@ -1631,6 +1640,23 @@ static umode_t udf_convert_permissions(s
>  	return mode;
>  }
>  
> +void udf_update_extra_perms(struct inode *inode, umode_t mode)
> +{
> +	struct udf_inode_info *iinfo = UDF_I(inode);
> +
> +	/*
> +	 * UDF 2.01 sec. 3.3.3.3 Note 2:
> +	 * In Unix, delete permission tracks write
> +	 */
> +	iinfo->i_extraPerms &= ~FE_DELETE_PERMS;
> +	if (mode & 0200)
> +		iinfo->i_extraPerms |= FE_PERM_U_DELETE;
> +	if (mode & 0020)
> +		iinfo->i_extraPerms |= FE_PERM_G_DELETE;
> +	if (mode & 0002)
> +		iinfo->i_extraPerms |= FE_PERM_O_DELETE;
> +}
> +
>  int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
>  {
>  	return udf_update_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
> @@ -1703,10 +1729,7 @@ static int udf_update_inode(struct inode
>  		   ((inode->i_mode & 0070) << 2) |
>  		   ((inode->i_mode & 0700) << 4);
>  
> -	udfperms |= (le32_to_cpu(fe->permissions) &
> -		    (FE_PERM_O_DELETE | FE_PERM_O_CHATTR |
> -		     FE_PERM_G_DELETE | FE_PERM_G_CHATTR |
> -		     FE_PERM_U_DELETE | FE_PERM_U_CHATTR));
> +	udfperms |= iinfo->i_extraPerms;
>  	fe->permissions = cpu_to_le32(udfperms);
>  
>  	if (S_ISDIR(inode->i_mode) && inode->i_nlink > 0)
> --- a/fs/udf/file.c	2019-08-26 21:38:12.138562583 -0500
> +++ b/fs/udf/file.c	2019-08-26 21:12:44.664536308 -0500
> @@ -280,6 +280,9 @@ static int udf_setattr(struct dentry *de
>  			return error;
>  	}
>  
> +	if (attr->ia_valid & ATTR_MODE)
> +		udf_update_extra_perms(inode, attr->ia_mode);
> +
>  	setattr_copy(inode, attr);
>  	mark_inode_dirty(inode);
>  	return 0;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
