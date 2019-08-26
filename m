Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F909CD26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfHZKOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 06:14:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:46996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbfHZKOk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:14:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8830AD09;
        Mon, 26 Aug 2019 10:14:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4BE381E3FE3; Mon, 26 Aug 2019 12:14:38 +0200 (CEST)
Date:   Mon, 26 Aug 2019 12:14:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     " Steven J. Magnani " <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: augment owner permissions on new inodes
Message-ID: <20190826101438.GC10614@quack2.suse.cz>
References: <20190819142707.18070-1-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819142707.18070-1-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 19-08-19 09:27:07,  Steven J. Magnani  wrote:
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
> Fix this by granting UDF delete and change attribute permissions
> to the owner when creating a new inode.
> 
> Reported by: Ty Young
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

Thanks for the patch! The behavior for CHATTR and DELETE permissions is
defined by UDF specification in 3.3.3.3 section. From that I'd say that we
should set CHATTR for user on creation and otherwise leave it untouched
(which is what you seem to be doing). For DELETE permission we should set
it to match WRITE permission (needs handling on file create in in
udf_setattr() when changing file permissions). Can you please fixup the
DELETE permission behavior?

								Honza

> ---
> --- a/fs/udf/udf_i.h	2019-08-14 07:24:05.029508342 -0500
> +++ b/fs/udf/udf_i.h	2019-08-19 08:55:37.797394177 -0500
> @@ -38,6 +38,7 @@ struct udf_inode_info {
>  	__u32			i_next_alloc_block;
>  	__u32			i_next_alloc_goal;
>  	__u32			i_checkpoint;
> +	__u32			i_extraPerms;
>  	unsigned		i_alloc_type : 3;
>  	unsigned		i_efe : 1;	/* extendedFileEntry */
>  	unsigned		i_use : 1;	/* unallocSpaceEntry */
> --- a/fs/udf/ialloc.c	2019-08-14 07:24:05.029508342 -0500
> +++ b/fs/udf/ialloc.c	2019-08-19 08:33:08.992422457 -0500
> @@ -118,6 +118,7 @@ struct inode *udf_new_inode(struct inode
>  	iinfo->i_lenAlloc = 0;
>  	iinfo->i_use = 0;
>  	iinfo->i_checkpoint = 1;
> +	iinfo->i_extraPerms = FE_PERM_U_DELETE | FE_PERM_U_CHATTR;
>  	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_AD_IN_ICB))
>  		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
>  	else if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
> --- a/fs/udf/inode.c	2019-08-14 07:24:05.029508342 -0500
> +++ b/fs/udf/inode.c	2019-08-19 08:42:46.537530051 -0500
> @@ -45,6 +45,10 @@
>  
>  #define EXTENT_MERGE_SIZE 5
>  
> +#define FE_MAPPED_PERMS	(FE_PERM_U_READ | FE_PERM_U_WRITE | FE_PERM_U_EXEC | \
> +			 FE_PERM_G_READ | FE_PERM_G_WRITE | FE_PERM_G_EXEC | \
> +			 FE_PERM_O_READ | FE_PERM_O_WRITE | FE_PERM_O_EXEC)
> +
>  static umode_t udf_convert_permissions(struct fileEntry *);
>  static int udf_update_inode(struct inode *, int);
>  static int udf_sync_inode(struct inode *inode);
> @@ -1458,6 +1462,8 @@ reread:
>  	else
>  		inode->i_mode = udf_convert_permissions(fe);
>  	inode->i_mode &= ~sbi->s_umask;
> +	iinfo->i_extraPerms = le32_to_cpu(fe->permissions) & ~FE_MAPPED_PERMS;
> +
>  	read_unlock(&sbi->s_cred_lock);
>  
>  	link_count = le16_to_cpu(fe->fileLinkCount);
> @@ -1691,10 +1697,7 @@ static int udf_update_inode(struct inode
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
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
