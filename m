Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D222E205F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgLWSVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 13:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgLWSVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:21:17 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 10:20:31 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n4so15843242iow.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Jwm6PFfbgH80SQwNj2he2wbJIKTrfdiS6RAFt5HJF8=;
        b=zNR08C5AEwbFUPMAv79Z8zW8IY4EgUpgbmde2lvXatnVvmxdu4Lsh/zCfqux6ukJjT
         ncSFIdoE2ocyCEC553ksY/XciQXyyx4nFP8SlpdwbYXiVzDyQA5SR4RdC4fRqjZmHAs+
         5kmzp/KtvM05nA9GS5IJmIy3pMdyjPI3QIDLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Jwm6PFfbgH80SQwNj2he2wbJIKTrfdiS6RAFt5HJF8=;
        b=sgo1LdJeaSNkhdjcyShYZb7BI3Vi2u5npE1PdkPeMJz8zZAKqe24JAZNXRZnRKbRA2
         C5veb3bqEbMJR6EUjgFTkYkHUSGmLEaX00fqu8x6iQDZca4T/aANWzsgr788I0HO1OiL
         I1gglHbM73OKrW1CBRnayFNxl1V0K7W8Tde9i4unq7tV6MVOMi8dATaZY12lYuB0AZH5
         cENZ9SY4Xm9H09JNi079/EM95yioZ7c6nXq7CovR1UgZ6llqkzOSHbvs9U5D41Rep3e1
         VBAoB6xclCtE9sKCP/0GWzy4Dji1GLnhhxR4josv/kNaWH+G9TF8p09tTDEJXX2CG0cT
         7MfA==
X-Gm-Message-State: AOAM531FcqAjKxzNoAPNSRZbuKdugTrzjcoM+vKFgFrW+UhztKzXT8KF
        Ug2oqmJEoJoW8al0UIKMK4o9zw==
X-Google-Smtp-Source: ABdhPJxvkZ9EaTJCgSfLZQUK9l0ijPvawI39Bu8FnTgTYT50qUlruCDWpnpEnc07pSPGOYCfMy36HQ==
X-Received: by 2002:a02:c9cc:: with SMTP id c12mr23915038jap.116.1608747629296;
        Wed, 23 Dec 2020 10:20:29 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id y15sm17688530ili.65.2020.12.23.10.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Dec 2020 10:20:28 -0800 (PST)
Date:   Wed, 23 Dec 2020 18:20:27 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221195055.35295-4-vgoyal@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 02:50:55PM -0500, Vivek Goyal wrote:
> Currently syncfs() and fsync() seem to be two interfaces which check and
> return writeback errors on superblock to user space. fsync() should
> work fine with overlayfs as it relies on underlying filesystem to
> do the check and return error. For example, if ext4 is on upper filesystem,
> then ext4_sync_file() calls file_check_and_advance_wb_err(file) on
> upper file and returns error. So overlayfs does not have to do anything
> special.
> 
> But with syncfs(), error check happens in vfs in syncfs() w.r.t
> overlay_sb->s_wb_err. Given overlayfs is stacked filesystem, it
> does not do actual writeback and all writeback errors are recorded
> on underlying filesystem. So sb->s_wb_err is never updated hence
> syncfs() does not work with overlay.
> 
> Jeff suggested that instead of trying to propagate errors to overlay
> super block, why not simply check for errors against upper filesystem
> super block. I implemented this idea.
> 
> Overlay file has "since" value which needs to be initialized at open
> time. Overlay overrides VFS initialization and re-initializes
> f->f_sb_err w.r.t upper super block. Later when
> ovl_sb->errseq_check_advance() is called, f->f_sb_err is used as
> since value to figure out if any error on upper sb has happened since
> then.
> 
> Note, Right now this patch only deals with regular file and directories.
> Yet to deal with special files like device inodes, socket, fifo etc.
> 
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/overlayfs/file.c      |  1 +
>  fs/overlayfs/overlayfs.h |  1 +
>  fs/overlayfs/readdir.c   |  1 +
>  fs/overlayfs/super.c     | 23 +++++++++++++++++++++++
>  fs/overlayfs/util.c      | 13 +++++++++++++
>  5 files changed, 39 insertions(+)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index efccb7c1f9bc..7b58a44dcb71 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -163,6 +163,7 @@ static int ovl_open(struct inode *inode, struct file *file)
>  		return PTR_ERR(realfile);
>  
>  	file->private_data = realfile;
> +	ovl_init_file_errseq(file);
>  
>  	return 0;
>  }
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index f8880aa2ba0e..47838abbfb3d 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -322,6 +322,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
>  bool ovl_is_metacopy_dentry(struct dentry *dentry);
>  char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
>  			     int padding);
> +void ovl_init_file_errseq(struct file *file);
>  
>  static inline bool ovl_is_impuredir(struct super_block *sb,
>  				    struct dentry *dentry)
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 01620ebae1bd..0c48f1545483 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -960,6 +960,7 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
>  	od->is_real = ovl_dir_is_real(file->f_path.dentry);
>  	od->is_upper = OVL_TYPE_UPPER(type);
>  	file->private_data = od;
> +	ovl_init_file_errseq(file);
>  
>  	return 0;
>  }
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 290983bcfbb3..d99867983722 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -390,6 +390,28 @@ static int ovl_remount(struct super_block *sb, int *flags, char *data)
>  	return ret;
>  }
>  
> +static int ovl_errseq_check_advance(struct super_block *sb, struct file *file)
> +{
> +	struct ovl_fs *ofs = sb->s_fs_info;
> +	struct super_block *upper_sb;
> +	int ret;
> +
> +	if (!ovl_upper_mnt(ofs))
> +		return 0;
> +
> +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> +
> +	if (!errseq_check(&upper_sb->s_wb_err, file->f_sb_err))
> +		return 0;
> +
> +	/* Something changed, must use slow path */
> +	spin_lock(&file->f_lock);
> +	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> +	spin_unlock(&file->f_lock);
> +
> +	return ret;
> +}
> +
>  static const struct super_operations ovl_super_operations = {
>  	.alloc_inode	= ovl_alloc_inode,
>  	.free_inode	= ovl_free_inode,
> @@ -400,6 +422,7 @@ static const struct super_operations ovl_super_operations = {
>  	.statfs		= ovl_statfs,
>  	.show_options	= ovl_show_options,
>  	.remount_fs	= ovl_remount,
> +	.errseq_check_advance	= ovl_errseq_check_advance,
>  };
>  
>  enum {
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 23f475627d07..a1742847f3a8 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -950,3 +950,16 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
>  	kfree(buf);
>  	return ERR_PTR(res);
>  }
> +
> +void ovl_init_file_errseq(struct file *file)
> +{
> +	struct super_block *sb = file_dentry(file)->d_sb;
> +	struct ovl_fs *ofs = sb->s_fs_info;
> +	struct super_block *upper_sb;
> +
> +	if (!ovl_upper_mnt(ofs))
> +		return;
> +
> +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> +	file->f_sb_err = errseq_sample(&upper_sb->s_wb_err);
> +}
> -- 
> 2.25.4
> 

I fail to see why this is neccessary if you incorporate error reporting into the 
sync_fs callback. Why is this separate from that callback? If you pickup Jeff's
patch that adds the 2nd flag to errseq for "observed", you should be able to
stash the first errseq seen in the ovl_fs struct, and do the check-and-return
in there instead instead of adding this new infrastructure.

IMHO, if we're going to fix this, sync_fs should be replaced, and there should 
be a generic_sync_fs wrapper which does the errseq, callback, and sync blockdev, 
but then filesystems should be able to override it and do the requisite work.
