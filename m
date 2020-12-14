Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC52DA467
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 00:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgLNXxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 18:53:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgLNXxx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:53:53 -0500
Message-ID: <979d78d04d882744d944f5723ad7a98b14badf8b.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607989992;
        bh=fdhvh40XSvNJTdZhesTxxgsXw8agxPu12C7HDN0rG+Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xzw/f2W+tv9XAeAbW1cwl5413sLDMIzy2+2l/ACVTbAg6Uc7lo8XUeylTQ5emPo52
         N0rgWqWuo/VI/grdgdC4V1CuNPCTK777UdpJgll8T5tbFce59Gng5FWEec1gUKUGv/
         dFqo1u/f2BtbkQ7IdiCUmRAIhEGQwD/weg3jmgSDtlt6p81nlKT1cDamlPECy5hUgd
         SSEUlXggVLlfzM883WDbGcsgqJDk/QrJnkXHrtR110SqKcCWaDKhOorAaIXcw5W3An
         YkJ5mqG/uK4tczzZALPZidv3y8sXTp3hJLTA3a2XHDo54qMk2J0fVmgGtZleRQJRve
         oHaD27qSaWpFA==
Subject: Re: [RFC PATCH 2/2] overlayfs: propagate errors from upper to
 overlay sb in sync_fs
From:   Jeff Layton <jlayton@kernel.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Date:   Mon, 14 Dec 2020 18:53:10 -0500
In-Reply-To: <20201214213843.GA3453@redhat.com>
References: <20201213132713.66864-1-jlayton@kernel.org>
         <20201213132713.66864-3-jlayton@kernel.org>
         <20201214213843.GA3453@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-12-14 at 16:38 -0500, Vivek Goyal wrote:
> On Sun, Dec 13, 2020 at 08:27:13AM -0500, Jeff Layton wrote:
> > Peek at the upper layer's errseq_t at mount time for volatile mounts,
> > and record it in the per-sb info. In sync_fs, check for an error since
> > the recorded point and set it in the overlayfs superblock if there was
> > one.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> 
> While we are solving problem for non-volatile overlay mount, I also
> started thinking, what about non-volatile overlay syncfs() writeback errors.
> Looks like these will not be reported to user space at all as of now
> (because we never update overlay_sb->s_wb_err ever).
> 
> A patch like this might fix it. (compile tested only).
> 
> overlayfs: Report syncfs() errors to user space
> 
> Currently, syncfs(), calls filesystem ->sync_fs() method but ignores the
> return code. But certain writeback errors can still be reported on 
> syncfs() by checking errors on super block.
> 
> ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> 
> For the case of overlayfs, we never set overlayfs super block s_wb_err. That
> means sync() will never report writeback errors on overlayfs uppon syncfs().
> 
> Fix this by updating overlay sb->sb_wb_err upon ->sync_fs() call. And that
> should mean that user space syncfs() call should see writeback errors.
> 
> ovl_fsync() does not need anything special because if there are writeback
> errors underlying filesystem will report it through vfs_fsync_range() return
> code and user space will see it.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/overlayfs/ovl_entry.h |    1 +
>  fs/overlayfs/super.c     |   14 +++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> Index: redhat-linux/fs/overlayfs/super.c
> ===================================================================
> --- redhat-linux.orig/fs/overlayfs/super.c	2020-12-14 15:33:43.934400880 -0500
> +++ redhat-linux/fs/overlayfs/super.c	2020-12-14 16:15:07.127400880 -0500
> @@ -259,7 +259,7 @@ static int ovl_sync_fs(struct super_bloc
>  {
>  	struct ovl_fs *ofs = sb->s_fs_info;
>  	struct super_block *upper_sb;
> -	int ret;
> +	int ret, ret2;
>  
> 
> 
> 
>  	if (!ovl_upper_mnt(ofs))
>  		return 0;
> @@ -283,7 +283,14 @@ static int ovl_sync_fs(struct super_bloc
>  	ret = sync_filesystem(upper_sb);
>  	up_read(&upper_sb->s_umount);
>  
> 
> 
> 
> -	return ret;
> +	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
> +		/* Upper sb has errors since last time */
> +		spin_lock(&ofs->errseq_lock);
> +		ret2 = errseq_check_and_advance(&upper_sb->s_wb_err,
> +						&sb->s_wb_err);
> +		spin_unlock(&ofs->errseq_lock);
> +	}
> +	return ret ? ret : ret2;

I think this is probably not quite right.

The problem I think is that the SEEN flag is always going to end up
being set in sb->s_wb_err, and that is going to violate the desired
semantics. If the writeback error occurred after all fd's were closed,
then the next opener wouldn't see it and you'd lose the error.

We probably need a function to cleanly propagate the error from one
errseq_t to another so that that doesn't occur. I'll have to think about
it.

>  }
>  
> 
> 
> 
>  /**
> @@ -1873,6 +1880,7 @@ static int ovl_fill_super(struct super_b
>  	if (!cred)
>  		goto out_err;
>  
> 
> 
> 
> +	spin_lock_init(&ofs->errseq_lock);
>  	/* Is there a reason anyone would want not to share whiteouts? */
>  	ofs->share_whiteout = true;
>  
> 
> 
> 
> @@ -1945,7 +1953,7 @@ static int ovl_fill_super(struct super_b
>  
> 
> 
> 
>  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
>  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> -
> +		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
>  	}
>  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
>  	err = PTR_ERR(oe);
> Index: redhat-linux/fs/overlayfs/ovl_entry.h
> ===================================================================
> --- redhat-linux.orig/fs/overlayfs/ovl_entry.h	2020-12-14 15:33:43.934400880 -0500
> +++ redhat-linux/fs/overlayfs/ovl_entry.h	2020-12-14 15:34:13.509400880 -0500
> @@ -79,6 +79,7 @@ struct ovl_fs {
>  	atomic_long_t last_ino;
>  	/* Whiteout dentry cache */
>  	struct dentry *whiteout;
> +	spinlock_t errseq_lock;
>  };
>  
> 
> 
> 
>  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> 

-- 
Jeff Layton <jlayton@kernel.org>

