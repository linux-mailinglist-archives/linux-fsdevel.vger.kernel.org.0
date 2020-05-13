Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755BE1D17DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbgEMOrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 10:47:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:40868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389013AbgEMOrK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 10:47:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2EC9DB0BA;
        Wed, 13 May 2020 14:47:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D98B41E12AE; Wed, 13 May 2020 16:47:06 +0200 (CEST)
Date:   Wed, 13 May 2020 16:47:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs/ext4: Introduce DAX inode flag
Message-ID: <20200513144706.GH27709@quack2.suse.cz>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513054324.2138483-9-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-05-20 22:43:23, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> 
> Set the flag to be user visible and changeable.  Set the flag to be
> inherited.  Allow applications to change the flag at any time.
> 
> Finally, on regular files, flag the inode to not be cached to facilitate
> changing S_DAX on the next creation of the inode.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Change from RFC:
> 	use new d_mark_dontcache()
> 	Allow caching if ALWAYS/NEVER is set
> 	Rebased to latest Linus master
> 	Change flag to unused 0x01000000
> 	update ext4_should_enable_dax()
> ---
>  fs/ext4/ext4.h  | 13 +++++++++----
>  fs/ext4/inode.c |  4 +++-
>  fs/ext4/ioctl.c | 25 ++++++++++++++++++++++++-
>  3 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 01d1de838896..715f8f2029b2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -415,13 +415,16 @@ struct flex_groups {
>  #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
>  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
>  /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
> +
> +#define EXT4_DAX_FL			0x01000000 /* Inode is DAX */
> +
>  #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
>  #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
>  #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
>  #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
>  
> -#define EXT4_FL_USER_VISIBLE		0x705BDFFF /* User visible flags */
> -#define EXT4_FL_USER_MODIFIABLE		0x604BC0FF /* User modifiable flags */
> +#define EXT4_FL_USER_VISIBLE		0x715BDFFF /* User visible flags */
> +#define EXT4_FL_USER_MODIFIABLE		0x614BC0FF /* User modifiable flags */

Hum, I think this was already mentioned but there are also definitions in
include/uapi/linux/fs.h which should be kept in sync... Also if DAX flag
gets modified through FS_IOC_SETFLAGS, we should call ext4_doncache() as
well, shouldn't we?

> @@ -802,6 +807,21 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	return error;
>  }
>  
> +static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	if (S_ISDIR(inode->i_mode))
> +		return;
> +
> +	if (test_opt2(inode->i_sb, DAX_NEVER) ||
> +	    test_opt(inode->i_sb, DAX_ALWAYS))
> +		return;
> +
> +	if (((ei->i_flags ^ flags) & EXT4_DAX_FL) == EXT4_DAX_FL)
> +		d_mark_dontcache(inode);
> +}
> +
>  long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -1267,6 +1287,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			return err;
>  
>  		inode_lock(inode);
> +
> +		ext4_dax_dontcache(inode, flags);
> +

I don't think we should set dontcache flag when setting of DAX flag fails -
it could event be a security issue). So I think you'll have to check
whether DAX flag is being changed, call vfs_ioc_fssetxattr_check(), and
only if it succeeded and DAX flags was changing call ext4_dax_dontcache().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
