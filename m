Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E762970D8B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjEWJRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjEWJRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 05:17:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E159F94;
        Tue, 23 May 2023 02:17:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82DCB22869;
        Tue, 23 May 2023 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684833456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pWi8uAPoIo9Xe5/+DeceQaNoWoaXaifm86KXKbe2RMY=;
        b=oJ3/q9pVf0oftEJob12hsC/n8pqz5bXhfHj2wUKI3FZ8bVS8EV8ME7fFMM1vSv9NWbRoSv
        XxqcIB3VaU2ca4P4reVRg8xUJJaYregXdj5BXEYYdOfDS/L2tKhqlue2HpWG3IrwiP4hyn
        bEnmkDGDFAP8b1VYAb+nvZlV/oi3TQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684833456;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pWi8uAPoIo9Xe5/+DeceQaNoWoaXaifm86KXKbe2RMY=;
        b=gttdgXRuz7NX4J7ZUEj8Tya0FZUeauI/D4BjXM1H7Od2s3Tvntm4UPHEBNPSoItZyWZHKM
        0cZGgQCM5kNRj2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66CA213588;
        Tue, 23 May 2023 09:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EIz9GLCEbGQtUQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 09:17:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EE2BEA075D; Tue, 23 May 2023 11:17:35 +0200 (CEST)
Date:   Tue, 23 May 2023 11:17:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v4 1/9] fs: pass the request_mask to generic_fillattr
Message-ID: <20230523091735.vlzui6lf3rgsnh3w@quack3>
References: <20230518114742.128950-1-jlayton@kernel.org>
 <20230518114742.128950-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518114742.128950-2-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-05-23 07:47:34, Jeff Layton wrote:
> generic_fillattr just fills in the entire stat struct indiscriminately
> today, copying data from the inode. There is at least one attribute
> (STATX_CHANGE_COOKIE) that can have side effects when it is reported,
> and we're looking at adding more with the addition of multigrain
> timestamps.
> 
> Add a request_mask argument to generic_fillattr and have most callers
> just pass in the value that is passed to getattr. Have other callers
> (e.g. ksmbd) just pass in STATX_BASIC_STATS. Also move the setting of
> STATX_CHANGE_COOKIE into generic_fillattr.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/9p/vfs_inode.c      |  4 ++--
>  fs/9p/vfs_inode_dotl.c |  4 ++--
>  fs/afs/inode.c         |  2 +-
>  fs/btrfs/inode.c       |  2 +-
>  fs/ceph/inode.c        |  2 +-
>  fs/cifs/inode.c        |  2 +-
>  fs/coda/inode.c        |  3 ++-
>  fs/ecryptfs/inode.c    |  5 +++--
>  fs/erofs/inode.c       |  2 +-
>  fs/exfat/file.c        |  2 +-
>  fs/ext2/inode.c        |  2 +-
>  fs/ext4/inode.c        |  2 +-
>  fs/f2fs/file.c         |  2 +-
>  fs/fat/file.c          |  2 +-
>  fs/fuse/dir.c          |  2 +-
>  fs/gfs2/inode.c        |  2 +-
>  fs/hfsplus/inode.c     |  2 +-
>  fs/kernfs/inode.c      |  2 +-
>  fs/ksmbd/smb2pdu.c     | 22 +++++++++++-----------
>  fs/ksmbd/vfs.c         |  3 ++-
>  fs/libfs.c             |  4 ++--
>  fs/minix/inode.c       |  2 +-
>  fs/nfs/inode.c         |  2 +-
>  fs/nfs/namespace.c     |  3 ++-
>  fs/ntfs3/file.c        |  2 +-
>  fs/ocfs2/file.c        |  2 +-
>  fs/orangefs/inode.c    |  2 +-
>  fs/proc/base.c         |  4 ++--
>  fs/proc/fd.c           |  2 +-
>  fs/proc/generic.c      |  2 +-
>  fs/proc/proc_net.c     |  2 +-
>  fs/proc/proc_sysctl.c  |  2 +-
>  fs/proc/root.c         |  3 ++-
>  fs/stat.c              | 18 ++++++++++--------
>  fs/sysv/itree.c        |  3 ++-
>  fs/ubifs/dir.c         |  2 +-
>  fs/udf/symlink.c       |  2 +-
>  fs/vboxsf/utils.c      |  2 +-
>  include/linux/fs.h     |  2 +-
>  mm/shmem.c             |  2 +-
>  40 files changed, 70 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 36b466e35887..11bd069d038b 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -1016,7 +1016,7 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
>  	v9ses = v9fs_dentry2v9ses(dentry);
>  	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
> -		generic_fillattr(&nop_mnt_idmap, inode, stat);
> +		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  		return 0;
>  	} else if (v9ses->cache & CACHE_WRITEBACK) {
>  		if (S_ISREG(inode->i_mode)) {
> @@ -1037,7 +1037,7 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		return PTR_ERR(st);
>  
>  	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
> -	generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
>  
>  	p9stat_free(st);
>  	kfree(st);
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 5361cd2d7996..04083fbf0c91 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -451,7 +451,7 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
>  	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
>  	v9ses = v9fs_dentry2v9ses(dentry);
>  	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
> -		generic_fillattr(&nop_mnt_idmap, inode, stat);
> +		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  		return 0;
>  	} else if (v9ses->cache) {
>  		if (S_ISREG(inode->i_mode)) {
> @@ -476,7 +476,7 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
>  		return PTR_ERR(st);
>  
>  	v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
> -	generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
>  	/* Change block size to what the server returned */
>  	stat->blksize = st->st_blksize;
>  
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 866bab860a88..54a4a1dd3bba 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -773,7 +773,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  
>  	do {
>  		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
> -		generic_fillattr(&nop_mnt_idmap, inode, stat);
> +		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
>  		    stat->nlink > 0)
>  			stat->nlink -= 1;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 19c707bc8801..2335b5e1cecc 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8625,7 +8625,7 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
>  				  STATX_ATTR_IMMUTABLE |
>  				  STATX_ATTR_NODUMP);
>  
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  	stat->dev = BTRFS_I(inode)->root->anon_dev;
>  
>  	spin_lock(&BTRFS_I(inode)->lock);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 8e5f41d45283..2e479dca6845 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2465,7 +2465,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
>  			return err;
>  	}
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	stat->ino = ceph_present_inode(inode);
>  
>  	/*
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 1087ac6104a9..1ba09e39a1de 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -2540,7 +2540,7 @@ int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  			return rc;
>  	}
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	stat->blksize = cifs_sb->ctx->bsize;
>  	stat->ino = CIFS_I(inode)->uniqueid;
>  
> diff --git a/fs/coda/inode.c b/fs/coda/inode.c
> index d661e6cf17ac..f0be47be3587 100644
> --- a/fs/coda/inode.c
> +++ b/fs/coda/inode.c
> @@ -256,7 +256,8 @@ int coda_getattr(struct mnt_idmap *idmap, const struct path *path,
>  {
>  	int err = coda_revalidate_inode(d_inode(path->dentry));
>  	if (!err)
> -		generic_fillattr(&nop_mnt_idmap, d_inode(path->dentry), stat);
> +		generic_fillattr(&nop_mnt_idmap, request_mask,
> +				 d_inode(path->dentry), stat);
>  	return err;
>  }
>  
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 83274915ba6d..e4c1b62a2de2 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -982,7 +982,7 @@ static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
>  
>  	mount_crypt_stat = &ecryptfs_superblock_to_private(
>  						dentry->d_sb)->mount_crypt_stat;
> -	generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
>  	if (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) {
>  		char *target;
>  		size_t targetsiz;
> @@ -1011,7 +1011,8 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap,
>  	if (!rc) {
>  		fsstack_copy_attr_all(d_inode(dentry),
>  				      ecryptfs_inode_to_lower(d_inode(dentry)));
> -		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
> +		generic_fillattr(&nop_mnt_idmap, request_mask,
> +				 d_inode(dentry), stat);
>  		stat->blocks = lower_stat.blocks;
>  	}
>  	return rc;
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index d70b12b81507..b8aeb1251997 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -372,7 +372,7 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>  				  STATX_ATTR_IMMUTABLE);
>  
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index e99183a74611..29b6229fddad 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -232,7 +232,7 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	struct inode *inode = d_backing_inode(path->dentry);
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	exfat_truncate_atime(&stat->atime);
>  	stat->result_mask |= STATX_BTIME;
>  	stat->btime.tv_sec = ei->i_crtime.tv_sec;
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 26f135e7ffce..eb4d32fcbf17 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1614,7 +1614,7 @@ int ext2_getattr(struct mnt_idmap *idmap, const struct path *path,
>  			STATX_ATTR_IMMUTABLE |
>  			STATX_ATTR_NODUMP);
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ce5f21b6c2b3..e0bbcf7a07b5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5539,7 +5539,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>  				  STATX_ATTR_NODUMP |
>  				  STATX_ATTR_VERITY);
>  
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5ac53d2627d2..bb16319a9491 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -888,7 +888,7 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  				  STATX_ATTR_NODUMP |
>  				  STATX_ATTR_VERITY);
>  
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  
>  	/* we need to show initial sectors used for inline_data/dentries */
>  	if ((S_ISREG(inode->i_mode) && f2fs_has_inline_data(inode)) ||
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 795a4fad5c40..650f77422057 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -401,7 +401,7 @@ int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	struct inode *inode = d_inode(path->dentry);
>  	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
>  
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  	stat->blksize = sbi->cluster_size;
>  
>  	if (sbi->options.nfs == FAT_NFS_NOSTALE_RO) {
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 35bc174f9ba2..a445d72bd98f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1224,7 +1224,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
>  		forget_all_cached_acls(inode);
>  		err = fuse_do_getattr(inode, stat, file);
>  	} else if (stat) {
> -		generic_fillattr(&nop_mnt_idmap, inode, stat);
> +		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  		stat->mode = fi->orig_i_mode;
>  		stat->ino = fi->orig_ino;
>  	}
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 17c994a0c0d0..5b3c62d20db5 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2071,7 +2071,7 @@ static int gfs2_getattr(struct mnt_idmap *idmap,
>  				  STATX_ATTR_IMMUTABLE |
>  				  STATX_ATTR_NODUMP);
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  
>  	if (gfs2_holder_initialized(&gh))
>  		gfs2_glock_dq_uninit(&gh);
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index b21660475ac1..6aefdbd3e7b6 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -298,7 +298,7 @@ int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	stat->attributes_mask |= STATX_ATTR_APPEND | STATX_ATTR_IMMUTABLE |
>  				 STATX_ATTR_NODUMP;
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index b22b74d1a115..b01cc38ed843 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -191,7 +191,7 @@ int kernfs_iop_getattr(struct mnt_idmap *idmap,
>  
>  	down_read(&root->kernfs_iattr_rwsem);
>  	kernfs_refresh_inode(kn, inode);
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	up_read(&root->kernfs_iattr_rwsem);
>  
>  	return 0;
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index cb93fd231f4e..d39ddb344417 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -4342,8 +4342,8 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
>  	}
>  
>  	basic_info = (struct smb2_file_basic_info *)rsp->Buffer;
> -	generic_fillattr(file_mnt_idmap(fp->filp), file_inode(fp->filp),
> -			 &stat);
> +	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
> +			 file_inode(fp->filp), &stat);
>  	basic_info->CreationTime = cpu_to_le64(fp->create_time);
>  	time = ksmbd_UnixTimeToNT(stat.atime);
>  	basic_info->LastAccessTime = cpu_to_le64(time);
> @@ -4383,7 +4383,7 @@ static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
>  	struct kstat stat;
>  
>  	inode = file_inode(fp->filp);
> -	generic_fillattr(file_mnt_idmap(fp->filp), inode, &stat);
> +	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
>  
>  	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
>  	delete_pending = ksmbd_inode_pending_delete(fp);
> @@ -4437,7 +4437,7 @@ static int get_file_all_info(struct ksmbd_work *work,
>  		return PTR_ERR(filename);
>  
>  	inode = file_inode(fp->filp);
> -	generic_fillattr(file_mnt_idmap(fp->filp), inode, &stat);
> +	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
>  
>  	ksmbd_debug(SMB, "filename = %s\n", filename);
>  	delete_pending = ksmbd_inode_pending_delete(fp);
> @@ -4514,8 +4514,8 @@ static void get_file_stream_info(struct ksmbd_work *work,
>  	int buf_free_len;
>  	struct smb2_query_info_req *req = ksmbd_req_buf_next(work);
>  
> -	generic_fillattr(file_mnt_idmap(fp->filp), file_inode(fp->filp),
> -			 &stat);
> +	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
> +			 file_inode(fp->filp), &stat);
>  	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
>  
>  	buf_free_len =
> @@ -4605,8 +4605,8 @@ static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
>  	struct smb2_file_internal_info *file_info;
>  	struct kstat stat;
>  
> -	generic_fillattr(file_mnt_idmap(fp->filp), file_inode(fp->filp),
> -			 &stat);
> +	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
> +			 file_inode(fp->filp), &stat);
>  	file_info = (struct smb2_file_internal_info *)rsp->Buffer;
>  	file_info->IndexNumber = cpu_to_le64(stat.ino);
>  	rsp->OutputBufferLength =
> @@ -4631,7 +4631,7 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
>  	file_info = (struct smb2_file_ntwrk_info *)rsp->Buffer;
>  
>  	inode = file_inode(fp->filp);
> -	generic_fillattr(file_mnt_idmap(fp->filp), inode, &stat);
> +	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
>  
>  	file_info->CreationTime = cpu_to_le64(fp->create_time);
>  	time = ksmbd_UnixTimeToNT(stat.atime);
> @@ -4692,8 +4692,8 @@ static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
>  	struct smb2_file_comp_info *file_info;
>  	struct kstat stat;
>  
> -	generic_fillattr(file_mnt_idmap(fp->filp), file_inode(fp->filp),
> -			 &stat);
> +	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
> +			 file_inode(fp->filp), &stat);
>  
>  	file_info = (struct smb2_file_comp_info *)rsp->Buffer;
>  	file_info->CompressedFileSize = cpu_to_le64(stat.blocks << 9);
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index 778c152708e4..47a4fe1e5043 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -1597,7 +1597,8 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
>  	u64 time;
>  	int rc;
>  
> -	generic_fillattr(idmap, d_inode(dentry), ksmbd_kstat->kstat);
> +	generic_fillattr(idmap, STATX_BASIC_STATS, d_inode(dentry),
> +			 ksmbd_kstat->kstat);
>  
>  	time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
>  	ksmbd_kstat->create_time = time;
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 89cf614a3271..b8f7be638f17 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -33,7 +33,7 @@ int simple_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		   unsigned int query_flags)
>  {
>  	struct inode *inode = d_inode(path->dentry);
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	stat->blocks = inode->i_mapping->nrpages << (PAGE_SHIFT - 9);
>  	return 0;
>  }
> @@ -1315,7 +1315,7 @@ static int empty_dir_getattr(struct mnt_idmap *idmap,
>  			     u32 request_mask, unsigned int query_flags)
>  {
>  	struct inode *inode = d_inode(path->dentry);
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index e9fbb5303a22..a7f927e3760c 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -660,7 +660,7 @@ int minix_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	struct super_block *sb = path->dentry->d_sb;
>  	struct inode *inode = d_inode(path->dentry);
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	if (INODE_VERSION(inode) == MINIX_V1)
>  		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, sb);
>  	else
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index a910b9a638c5..7f490c29ab6b 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -912,7 +912,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	/* Only return attributes that were revalidated. */
>  	stat->result_mask = nfs_get_valid_attrmask(inode) | request_mask;
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
>  	stat->change_cookie = inode_peek_iversion_raw(inode);
>  	stat->attributes_mask |= STATX_ATTR_CHANGE_MONOTONIC;
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index 19d51ebf842c..e7494cdd957e 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -215,7 +215,8 @@ nfs_namespace_getattr(struct mnt_idmap *idmap,
>  	if (NFS_FH(d_inode(path->dentry))->size != 0)
>  		return nfs_getattr(idmap, path, stat, request_mask,
>  				   query_flags);
> -	generic_fillattr(&nop_mnt_idmap, d_inode(path->dentry), stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(path->dentry),
> +			 stat);
>  	return 0;
>  }
>  
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 9a3d55c367d9..43ffd48eb048 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -85,7 +85,7 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  
>  	stat->attributes_mask |= STATX_ATTR_COMPRESSED | STATX_ATTR_ENCRYPTED;
>  
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  
>  	stat->result_mask |= STATX_BTIME;
>  	stat->btime = ni->i_crtime;
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index efb09de4343d..5dc659a53311 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1317,7 +1317,7 @@ int ocfs2_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		goto bail;
>  	}
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	/*
>  	 * If there is inline data in the inode, the inode will normally not
>  	 * have data blocks allocated (it may have an external xattr block).
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 9014bbcc8031..a52c30e80f45 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -871,7 +871,7 @@ int orangefs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	ret = orangefs_inode_getattr(inode,
>  	    request_mask & STATX_SIZE ? ORANGEFS_GETATTR_SIZE : 0);
>  	if (ret == 0) {
> -		generic_fillattr(&nop_mnt_idmap, inode, stat);
> +		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  
>  		/* override block size reported to stat */
>  		if (!(request_mask & STATX_SIZE))
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 05452c3b9872..98eab84553f9 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1966,7 +1966,7 @@ int pid_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
>  	struct task_struct *task;
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  
>  	stat->uid = GLOBAL_ROOT_UID;
>  	stat->gid = GLOBAL_ROOT_GID;
> @@ -3899,7 +3899,7 @@ static int proc_task_getattr(struct mnt_idmap *idmap,
>  {
>  	struct inode *inode = d_inode(path->dentry);
>  	struct task_struct *p = get_proc_task(inode);
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  
>  	if (p) {
>  		stat->nlink += get_nr_threads(p);
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index b3140deebbbf..6276b3938842 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -352,7 +352,7 @@ static int proc_fd_getattr(struct mnt_idmap *idmap,
>  	struct inode *inode = d_inode(path->dentry);
>  	int rv = 0;
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  
>  	/* If it's a directory, put the number of open fds there */
>  	if (S_ISDIR(inode->i_mode)) {
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 42ae38ff6e7e..775ce0bcf08c 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -146,7 +146,7 @@ static int proc_getattr(struct mnt_idmap *idmap,
>  		}
>  	}
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index a0c0419872e3..75f35f128e63 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -308,7 +308,7 @@ static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
>  
>  	net = get_proc_task_net(inode);
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  
>  	if (net != NULL) {
>  		stat->nlink = net->proc_net->nlink;
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 8038833ff5b0..c00b15b0ba81 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -855,7 +855,7 @@ static int proc_sys_getattr(struct mnt_idmap *idmap,
>  	if (IS_ERR(head))
>  		return PTR_ERR(head);
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	if (table)
>  		stat->mode = (stat->mode & S_IFMT) | table->mode;
>  
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index a86e65a608da..9191248f2dac 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -314,7 +314,8 @@ static int proc_root_getattr(struct mnt_idmap *idmap,
>  			     const struct path *path, struct kstat *stat,
>  			     u32 request_mask, unsigned int query_flags)
>  {
> -	generic_fillattr(&nop_mnt_idmap, d_inode(path->dentry), stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(path->dentry),
> +			 stat);
>  	stat->nlink = proc_root.nlink + nr_processes();
>  	return 0;
>  }
> diff --git a/fs/stat.c b/fs/stat.c
> index 7c238da22ef0..9b513a142a56 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -29,6 +29,7 @@
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
>   * @idmap:	idmap of the mount the inode was found from
> + * @req_mask	statx request_mask
>   * @inode:	Inode to use as the source
>   * @stat:	Where to fill in the attributes
>   *
> @@ -42,8 +43,8 @@
>   * uid and gid filds. On non-idmapped mounts or if permission checking is to be
>   * performed on the raw inode simply passs @nop_mnt_idmap.
>   */
> -void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
> -		      struct kstat *stat)
> +void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
> +		      struct inode *inode, struct kstat *stat)
>  {
>  	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
>  	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> @@ -61,6 +62,12 @@ void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
>  	stat->ctime = inode->i_ctime;
>  	stat->blksize = i_blocksize(inode);
>  	stat->blocks = inode->i_blocks;
> +
> +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> +		stat->result_mask |= STATX_CHANGE_COOKIE;
> +		stat->change_cookie = inode_query_iversion(inode);
> +	}
> +
>  }
>  EXPORT_SYMBOL(generic_fillattr);
>  
> @@ -123,17 +130,12 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
>  				  STATX_ATTR_DAX);
>  
> -	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> -		stat->result_mask |= STATX_CHANGE_COOKIE;
> -		stat->change_cookie = inode_query_iversion(inode);
> -	}
> -
>  	idmap = mnt_idmap(path->mnt);
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(idmap, path, stat,
>  					    request_mask, query_flags);
>  
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  EXPORT_SYMBOL(vfs_getattr_nosec);
> diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> index b22764fe669c..d41189cd9ec2 100644
> --- a/fs/sysv/itree.c
> +++ b/fs/sysv/itree.c
> @@ -445,7 +445,8 @@ int sysv_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		 struct kstat *stat, u32 request_mask, unsigned int flags)
>  {
>  	struct super_block *s = path->dentry->d_sb;
> -	generic_fillattr(&nop_mnt_idmap, d_inode(path->dentry), stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(path->dentry),
> +			 stat);
>  	stat->blocks = (s->s_blocksize / 512) * sysv_nblocks(s, stat->size);
>  	stat->blksize = s->s_blocksize;
>  	return 0;
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index ef0499edc248..ca044f31c49d 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -1665,7 +1665,7 @@ int ubifs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  				STATX_ATTR_ENCRYPTED |
>  				STATX_ATTR_IMMUTABLE);
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	stat->blksize = UBIFS_BLOCK_SIZE;
>  	stat->size = ui->ui_size;
>  
> diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
> index a34c8c4e6d21..69f6982aec9a 100644
> --- a/fs/udf/symlink.c
> +++ b/fs/udf/symlink.c
> @@ -153,7 +153,7 @@ static int udf_symlink_getattr(struct mnt_idmap *idmap,
>  	struct inode *inode = d_backing_inode(dentry);
>  	struct page *page;
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	page = read_mapping_page(inode->i_mapping, 0, NULL);
>  	if (IS_ERR(page))
>  		return PTR_ERR(page);
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index dd0ae1188e87..482f778709d6 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -252,7 +252,7 @@ int vboxsf_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	if (err)
>  		return err;
>  
> -	generic_fillattr(&nop_mnt_idmap, d_inode(dentry), kstat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), kstat);
>  	return 0;
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 21a981680856..d5896f90093a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2857,7 +2857,7 @@ extern void page_put_link(void *);
>  extern int page_symlink(struct inode *inode, const char *symname, int len);
>  extern const struct inode_operations page_symlink_inode_operations;
>  extern void kfree_link(void *);
> -void generic_fillattr(struct mnt_idmap *, struct inode *, struct kstat *);
> +void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
>  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
>  extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e40a08c5c6d7..8208d4f85dff 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1073,7 +1073,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>  	stat->attributes_mask |= (STATX_ATTR_APPEND |
>  			STATX_ATTR_IMMUTABLE |
>  			STATX_ATTR_NODUMP);
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  
>  	if (shmem_is_huge(inode, 0, false, NULL, 0))
>  		stat->blksize = HPAGE_PMD_SIZE;
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
