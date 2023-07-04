Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A195D74737A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGDN7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjGDN7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF52E7E;
        Tue,  4 Jul 2023 06:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0FBE6114F;
        Tue,  4 Jul 2023 13:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4D2C433C7;
        Tue,  4 Jul 2023 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688479187;
        bh=oegsQNHK+SCcU6CNAuGvD7j6B7O6/hCB27ZLmlh2Zek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQILb5CPaW40w+oBfQGm8yeudEdMVWvRQ0N1YP2Ys3eOXoqzzCc06oJM8l50i4R0V
         Cstz6UUgZ5nBh74AarCH1EnaG2j6AveNuGHcIV8yWI34cwyPoe+oyKvazuHn+r9Klo
         AVxSyvdASwPR5A/sHCsWa1fSFwIK+zWo4liP97JyGQupl3sEpsoKLHgWdSK/Mnbk5K
         zGo/k1CFt2LImnYzQzO1LM9kMGLs7FmCSTkb2uUtdnyR78qVkxxLdlvXnUsycyaTgn
         L2Pkn7ybppFqLo7Hb/QhUe5nKHMdQzuK9Lnd85wNskUe8jmqrr8wcv46B36PCABWdO
         GHiDz+JpmNMWw==
Date:   Tue, 4 Jul 2023 15:59:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <20230704-fasching-wertarbeit-7c6ffb01c83d@brauner>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230704125702.23180-6-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:56:54PM +0200, Jan Kara wrote:
> When we don't allow opening of mounted block devices for writing, bind
> mounting is broken because the bind mount tries to open the block device

Sorry, I'm going to be annoying now...

Afaict, the analysis is misleading but I'm happy to be corrected ofc.
Finding an existing superblock is independent of mounts. get_tree_bdev()
and mount_bdev() are really only interested in finding a matching
superblock independent of whether or not a mount for it already exists.
IOW, if you had two filesystem contexts for the same block device with
different mount options:

T1								T2
fd_fs = fsopen("ext4");						fd_fs = fsopen("ext4");
fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");	fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");

// create superblock
fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
								// finds superblock of T1 if opts are compatible
								fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)

you should have the issue that you're describing. But for neither of
them does a mount already exist as the first mount here would only be
created when:

T1								T2
fsmount(fd_fs);							fsmount(fd_fs);

is called at which point the whole superblock issue is already settled.
Afterwards, both mounts of both T1 and T2 refer to the same superblock -
as long as the fs and the mount options support this ofc.

---

Btw, I talked to Karel a while ago. I'd like to add an option like:

FSCONFIG_CMD_CREATE_EXCL

or similar to fsconfig() that fails in scenarios like the one I
described in T1 and T2. IOW, T1 succeeds but T2 would fail even if the
filesystem would consider the sb to be compatible. This way userspace
can be sure that they did indeed succeed in creating the superblock...

> before finding the superblock for it already exists. Reorganize the
> mounting code to first look whether the superblock for a particular
> device is already mounted and open the block device only if it is not.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/super.c | 188 +++++++++++++++++++++++++----------------------------
>  1 file changed, 89 insertions(+), 99 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index ea135fece772..fdf1e286926e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1228,13 +1228,7 @@ static const struct blk_holder_ops fs_holder_ops = {
>  
>  static int set_bdev_super(struct super_block *s, void *data)
>  {
> -	s->s_bdev_handle = data;
> -	s->s_bdev = s->s_bdev_handle->bdev;
> -	s->s_dev = s->s_bdev->bd_dev;
> -	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
> -
> -	if (bdev_stable_writes(s->s_bdev))
> -		s->s_iflags |= SB_I_STABLE_WRITES;
> +	s->s_dev = *(dev_t *)data;
>  	return 0;
>  }
>  
> @@ -1246,7 +1240,53 @@ static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
>  static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
>  {
>  	return !(s->s_iflags & SB_I_RETIRED) &&
> -		s->s_bdev == ((struct bdev_handle *)fc->sget_key)->bdev;
> +	       s->s_dev == *(dev_t *)fc->sget_key;
> +}
> +
> +static int setup_bdev_super(struct super_block *s, int sb_flags,
> +			    struct fs_context *fc)
> +{
> +	struct bdev_handle *bdev_handle;
> +
> +	bdev_handle = blkdev_get_by_dev(s->s_dev, sb_open_mode(sb_flags),
> +					s->s_type, &fs_holder_ops);
> +	if (IS_ERR(bdev_handle)) {
> +		if (fc)
> +			errorf(fc, "%s: Can't open blockdev", fc->source);
> +		return PTR_ERR(bdev_handle);
> +	}
> +	spin_lock(&sb_lock);
> +	s->s_bdev_handle = bdev_handle;
> +	s->s_bdev = bdev_handle->bdev;
> +	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
> +
> +	if (bdev_stable_writes(s->s_bdev))
> +		s->s_iflags |= SB_I_STABLE_WRITES;
> +	spin_unlock(&sb_lock);
> +
> +	/*
> +	 * Until SB_BORN flag is set, there can be no active superblock
> + 	 * references and thus no filesystem freezing. get_active_super()
> +	 * will just loop waiting for SB_BORN so even freeze_bdev() cannot
> +	 * proceed. It is enough to check bdev was not frozen before we set
> +	 * s_bdev.
> +	 */
> +	mutex_lock(&s->s_bdev->bd_fsfreeze_mutex);
> +	if (s->s_bdev->bd_fsfreeze_count > 0) {
> +		mutex_unlock(&s->s_bdev->bd_fsfreeze_mutex);
> +		if (fc)
> +			warnf(fc, "%pg: Can't mount, blockdev is frozen",
> +			      s->s_bdev);
> +		return -EBUSY;
> +	}
> +	mutex_unlock(&s->s_bdev->bd_fsfreeze_mutex);
> +
> +	snprintf(s->s_id, sizeof(s->s_id), "%pg", s->s_bdev);
> +	shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
> +				fc->fs_type->name, s->s_id);
> +	sb_set_blocksize(s, block_size(s->s_bdev));
> +
> +	return 0;
>  }
>  
>  /**
> @@ -1258,75 +1298,51 @@ int get_tree_bdev(struct fs_context *fc,
>  		int (*fill_super)(struct super_block *,
>  				  struct fs_context *))
>  {
> -	struct bdev_handle *bdev_handle;
> -	struct block_device *bdev;
> +	dev_t dev;
>  	struct super_block *s;
>  	int error = 0;
>  
>  	if (!fc->source)
>  		return invalf(fc, "No source specified");
>  
> -	bdev_handle = blkdev_get_by_path(fc->source,
> -					 sb_open_mode(fc->sb_flags),
> -					 fc->fs_type, &fs_holder_ops);
> -	if (IS_ERR(bdev_handle)) {
> -		errorf(fc, "%s: Can't open blockdev", fc->source);
> -		return PTR_ERR(bdev_handle);
> -	}
> -	bdev = bdev_handle->bdev;
> -
> -	/* Once the superblock is inserted into the list by sget_fc(), s_umount
> -	 * will protect the lockfs code from trying to start a snapshot while
> -	 * we are mounting
> -	 */
> -	mutex_lock(&bdev->bd_fsfreeze_mutex);
> -	if (bdev->bd_fsfreeze_count > 0) {
> -		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> -		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
> -		blkdev_put(bdev_handle);
> -		return -EBUSY;
> +	error = lookup_bdev(fc->source, &dev);
> +	if (error) {
> +		errorf(fc, "%s: Can't lookup blockdev", fc->source);
> +		return error;
>  	}
>  
>  	fc->sb_flags |= SB_NOSEC;
> -	fc->sget_key = bdev_handle;
> +	fc->sget_key = &dev;
>  	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
> -	mutex_unlock(&bdev->bd_fsfreeze_mutex);
> -	if (IS_ERR(s)) {
> -		blkdev_put(bdev_handle);
> +	if (IS_ERR(s))
>  		return PTR_ERR(s);
> -	}
>  
>  	if (s->s_root) {
>  		/* Don't summarily change the RO/RW state. */
>  		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
> -			warnf(fc, "%pg: Can't mount, would change RO state", bdev);
> +			warnf(fc, "%pg: Can't mount, would change RO state", s->s_bdev);
>  			deactivate_locked_super(s);
> -			blkdev_put(bdev_handle);
>  			return -EBUSY;
>  		}
> -
> +	} else {
>  		/*
> -		 * s_umount nests inside open_mutex during
> -		 * __invalidate_device().  blkdev_put() acquires open_mutex and
> -		 * can't be called under s_umount.  Drop s_umount temporarily.
> -		 * This is safe as we're holding an active reference.
> +		 * We drop s_umount here because we need to lookup bdev and
> +		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
> +		 * invalidate_bdev()). It is safe because we have active sb
> +		 * reference and SB_BORN is not set yet.
>  		 */
>  		up_write(&s->s_umount);
> -		blkdev_put(bdev_handle);
> +		error = setup_bdev_super(s, fc->sb_flags, fc);
>  		down_write(&s->s_umount);
> -	} else {
> -		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
> -		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
> -					fc->fs_type->name, s->s_id);
> -		sb_set_blocksize(s, block_size(bdev));
> -		error = fill_super(s, fc);
> +		if (!error)
> +			error = fill_super(s, fc);
>  		if (error) {
>  			deactivate_locked_super(s);
>  			return error;
>  		}
>  
>  		s->s_flags |= SB_ACTIVE;
> -		bdev->bd_super = s;
> +		s->s_bdev->bd_super = s;
>  	}
>  
>  	BUG_ON(fc->root);
> @@ -1337,81 +1353,53 @@ EXPORT_SYMBOL(get_tree_bdev);
>  
>  static int test_bdev_super(struct super_block *s, void *data)
>  {
> -	return !(s->s_iflags & SB_I_RETIRED) &&
> -		s->s_bdev == ((struct bdev_handle *)data)->bdev;
> +	return !(s->s_iflags & SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
>  }
>  
>  struct dentry *mount_bdev(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data,
>  	int (*fill_super)(struct super_block *, void *, int))
>  {
> -	struct bdev_handle *bdev_handle;
> -	struct block_device *bdev;
>  	struct super_block *s;
>  	int error = 0;
> +	dev_t dev;
>  
> -	bdev_handle = blkdev_get_by_path(dev_name, sb_open_mode(flags),
> -					 fs_type, &fs_holder_ops);
> -	if (IS_ERR(bdev_handle))
> -		return ERR_CAST(bdev_handle);
> -	bdev = bdev_handle->bdev;
> +	error = lookup_bdev(dev_name, &dev);
> +	if (error)
> +		return ERR_PTR(error);
>  
> -	/*
> -	 * once the super is inserted into the list by sget, s_umount
> -	 * will protect the lockfs code from trying to start a snapshot
> -	 * while we are mounting
> -	 */
> -	mutex_lock(&bdev->bd_fsfreeze_mutex);
> -	if (bdev->bd_fsfreeze_count > 0) {
> -		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> -		error = -EBUSY;
> -		goto error_bdev;
> -	}
> -	s = sget(fs_type, test_bdev_super, set_bdev_super, flags | SB_NOSEC,
> -		 bdev_handle);
> -	mutex_unlock(&bdev->bd_fsfreeze_mutex);
> +	flags |= SB_NOSEC;
> +	s = sget(fs_type, test_bdev_super, set_bdev_super, flags, &dev);
>  	if (IS_ERR(s))
> -		goto error_s;
> +		return ERR_CAST(s);
>  
>  	if (s->s_root) {
>  		if ((flags ^ s->s_flags) & SB_RDONLY) {
>  			deactivate_locked_super(s);
> -			error = -EBUSY;
> -			goto error_bdev;
> +			return ERR_PTR(-EBUSY);
>  		}
> -
> +	} else {
>  		/*
> -		 * s_umount nests inside open_mutex during
> -		 * __invalidate_device().  blkdev_put() acquires open_mutex and
> -		 * can't be called under s_umount.  Drop s_umount temporarily.
> -		 * This is safe as we're holding an active reference.
> +		 * We drop s_umount here because we need to lookup bdev and
> +		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
> +		 * invalidate_bdev()). It is safe because we have active sb
> +		 * reference and SB_BORN is not set yet.
>  		 */
>  		up_write(&s->s_umount);
> -		blkdev_put(bdev_handle);
> +		error = setup_bdev_super(s, flags, NULL);
>  		down_write(&s->s_umount);
> -	} else {
> -		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
> -		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
> -					fs_type->name, s->s_id);
> -		sb_set_blocksize(s, block_size(bdev));
> -		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
> +		if (!error)
> +			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
>  		if (error) {
>  			deactivate_locked_super(s);
> -			goto error;
> +			return ERR_PTR(error);
>  		}
>  
>  		s->s_flags |= SB_ACTIVE;
> -		bdev->bd_super = s;
> +		s->s_bdev->bd_super = s;
>  	}
>  
>  	return dget(s->s_root);
> -
> -error_s:
> -	error = PTR_ERR(s);
> -error_bdev:
> -	blkdev_put(bdev_handle);
> -error:
> -	return ERR_PTR(error);
>  }
>  EXPORT_SYMBOL(mount_bdev);
>  
> @@ -1419,10 +1407,12 @@ void kill_block_super(struct super_block *sb)
>  {
>  	struct block_device *bdev = sb->s_bdev;
>  
> -	bdev->bd_super = NULL;
>  	generic_shutdown_super(sb);
> -	sync_blockdev(bdev);
> -	blkdev_put(sb->s_bdev_handle);
> +	if (bdev) {
> +		bdev->bd_super = NULL;
> +		sync_blockdev(bdev);
> +		blkdev_put(sb->s_bdev_handle);
> +	}
>  }
>  
>  EXPORT_SYMBOL(kill_block_super);
> -- 
> 2.35.3
> 
