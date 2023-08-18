Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83910780AC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376375AbjHRLI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376398AbjHRLIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:08:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECBA2722
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 04:08:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D1EA121884;
        Fri, 18 Aug 2023 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692356885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpoW2LIzzEmTIsD19HOCw6J3D0FnvscU9JF9BUS3SJ8=;
        b=28LNuXusRTUmSzBA8lKNahhkwYGUo+SlqRr9S+J8/j3bVX8m5KpWe2rj7HDbKxNEfjB3LC
        +PME87CXi+wRdZMkCme1rjxmzVWayAvMst01w5pzssrGMKftnsRwvIXRLeUV6yzgEd9NOn
        sxtVn9vBeQj0vWM2zQ89UMa5fu/SJwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692356885;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpoW2LIzzEmTIsD19HOCw6J3D0FnvscU9JF9BUS3SJ8=;
        b=3wr1gjl0dVg/Oc6YgCAsPgMqZRIjjlQQV91Qbd+IPeoGvgqdS0+8vfa1me0zqrfNDJhoE8
        zFj9zkLyX2f2uGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C416213441;
        Fri, 18 Aug 2023 11:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pMn0LxVR32TcWgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 18 Aug 2023 11:08:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 51474A076B; Fri, 18 Aug 2023 13:08:05 +0200 (CEST)
Date:   Fri, 18 Aug 2023 13:08:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] super: use locking helpers
Message-ID: <20230818110805.wgbuwghato2b6xaj@quack3>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
 <20230818-vfs-super-fixes-v3-v2-1-cdab45934983@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-vfs-super-fixes-v3-v2-1-cdab45934983@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-08-23 12:54:15, Christian Brauner wrote:
> Replace the open-coded {down,up}_{read,write}() calls with simple
> wrappers. Follow-up patches will benefit from this as well.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 126 ++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 78 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index c878e7373f93..b12e2f247e1e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -50,6 +50,42 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
>  	"sb_internal",
>  };
>  
> +static inline void super_lock(struct super_block *sb, bool excl)
> +{
> +	if (excl)
> +		down_write(&sb->s_umount);
> +	else
> +		down_read(&sb->s_umount);
> +}
> +
> +static inline void super_unlock(struct super_block *sb, bool excl)
> +{
> +	if (excl)
> +		up_write(&sb->s_umount);
> +	else
> +		up_read(&sb->s_umount);
> +}
> +
> +static inline void super_lock_excl(struct super_block *sb)
> +{
> +	super_lock(sb, true);
> +}
> +
> +static inline void super_lock_shared(struct super_block *sb)
> +{
> +	super_lock(sb, false);
> +}
> +
> +static inline void super_unlock_excl(struct super_block *sb)
> +{
> +	super_unlock(sb, true);
> +}
> +
> +static inline void super_unlock_shared(struct super_block *sb)
> +{
> +	super_unlock(sb, false);
> +}
> +
>  /*
>   * One thing we have to be careful of with a per-sb shrinker is that we don't
>   * drop the last active reference to the superblock from within the shrinker.
> @@ -110,7 +146,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
>  		freed += sb->s_op->free_cached_objects(sb, sc);
>  	}
>  
> -	up_read(&sb->s_umount);
> +	super_unlock_shared(sb);
>  	return freed;
>  }
>  
> @@ -176,7 +212,7 @@ static void destroy_unused_super(struct super_block *s)
>  {
>  	if (!s)
>  		return;
> -	up_write(&s->s_umount);
> +	super_unlock_excl(s);
>  	list_lru_destroy(&s->s_dentry_lru);
>  	list_lru_destroy(&s->s_inode_lru);
>  	security_sb_free(s);
> @@ -340,7 +376,7 @@ void deactivate_locked_super(struct super_block *s)
>  		put_filesystem(fs);
>  		put_super(s);
>  	} else {
> -		up_write(&s->s_umount);
> +		super_unlock_excl(s);
>  	}
>  }
>  
> @@ -357,7 +393,7 @@ EXPORT_SYMBOL(deactivate_locked_super);
>  void deactivate_super(struct super_block *s)
>  {
>  	if (!atomic_add_unless(&s->s_active, -1, 1)) {
> -		down_write(&s->s_umount);
> +		super_lock_excl(s);
>  		deactivate_locked_super(s);
>  	}
>  }
> @@ -381,12 +417,12 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
>  {
>  	s->s_count++;
>  	spin_unlock(&sb_lock);
> -	down_write(&s->s_umount);
> +	super_lock_excl(s);
>  	if ((s->s_flags & SB_BORN) && atomic_inc_not_zero(&s->s_active)) {
>  		put_super(s);
>  		return 1;
>  	}
> -	up_write(&s->s_umount);
> +	super_unlock_excl(s);
>  	put_super(s);
>  	return 0;
>  }
> @@ -414,7 +450,7 @@ bool trylock_super(struct super_block *sb)
>  		if (!hlist_unhashed(&sb->s_instances) &&
>  		    sb->s_root && (sb->s_flags & SB_BORN))
>  			return true;
> -		up_read(&sb->s_umount);
> +		super_unlock_shared(sb);
>  	}
>  
>  	return false;
> @@ -439,13 +475,13 @@ bool trylock_super(struct super_block *sb)
>  void retire_super(struct super_block *sb)
>  {
>  	WARN_ON(!sb->s_bdev);
> -	down_write(&sb->s_umount);
> +	super_lock_excl(sb);
>  	if (sb->s_iflags & SB_I_PERSB_BDI) {
>  		bdi_unregister(sb->s_bdi);
>  		sb->s_iflags &= ~SB_I_PERSB_BDI;
>  	}
>  	sb->s_iflags |= SB_I_RETIRED;
> -	up_write(&sb->s_umount);
> +	super_unlock_excl(sb);
>  }
>  EXPORT_SYMBOL(retire_super);
>  
> @@ -521,7 +557,7 @@ void generic_shutdown_super(struct super_block *sb)
>  	/* should be initialized for __put_super_and_need_restart() */
>  	hlist_del_init(&sb->s_instances);
>  	spin_unlock(&sb_lock);
> -	up_write(&sb->s_umount);
> +	super_unlock_excl(sb);
>  	if (sb->s_bdi != &noop_backing_dev_info) {
>  		if (sb->s_iflags & SB_I_PERSB_BDI)
>  			bdi_unregister(sb->s_bdi);
> @@ -685,7 +721,7 @@ EXPORT_SYMBOL(sget);
>  
>  void drop_super(struct super_block *sb)
>  {
> -	up_read(&sb->s_umount);
> +	super_unlock_shared(sb);
>  	put_super(sb);
>  }
>  
> @@ -693,7 +729,7 @@ EXPORT_SYMBOL(drop_super);
>  
>  void drop_super_exclusive(struct super_block *sb)
>  {
> -	up_write(&sb->s_umount);
> +	super_unlock_excl(sb);
>  	put_super(sb);
>  }
>  EXPORT_SYMBOL(drop_super_exclusive);
> @@ -739,10 +775,10 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  		sb->s_count++;
>  		spin_unlock(&sb_lock);
>  
> -		down_read(&sb->s_umount);
> +		super_lock_shared(sb);
>  		if (sb->s_root && (sb->s_flags & SB_BORN))
>  			f(sb, arg);
> -		up_read(&sb->s_umount);
> +		super_unlock_shared(sb);
>  
>  		spin_lock(&sb_lock);
>  		if (p)
> @@ -773,10 +809,10 @@ void iterate_supers_type(struct file_system_type *type,
>  		sb->s_count++;
>  		spin_unlock(&sb_lock);
>  
> -		down_read(&sb->s_umount);
> +		super_lock_shared(sb);
>  		if (sb->s_root && (sb->s_flags & SB_BORN))
>  			f(sb, arg);
> -		up_read(&sb->s_umount);
> +		super_unlock_shared(sb);
>  
>  		spin_lock(&sb_lock);
>  		if (p)
> @@ -813,7 +849,7 @@ struct super_block *get_active_super(struct block_device *bdev)
>  		if (sb->s_bdev == bdev) {
>  			if (!grab_super(sb))
>  				goto restart;
> -			up_write(&sb->s_umount);
> +			super_unlock_excl(sb);
>  			return sb;
>  		}
>  	}
> @@ -833,17 +869,11 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  		if (sb->s_dev ==  dev) {
>  			sb->s_count++;
>  			spin_unlock(&sb_lock);
> -			if (excl)
> -				down_write(&sb->s_umount);
> -			else
> -				down_read(&sb->s_umount);
> +			super_lock(sb, excl);
>  			/* still alive? */
>  			if (sb->s_root && (sb->s_flags & SB_BORN))
>  				return sb;
> -			if (excl)
> -				up_write(&sb->s_umount);
> -			else
> -				up_read(&sb->s_umount);
> +			super_unlock(sb, excl);
>  			/* nope, got unmounted */
>  			spin_lock(&sb_lock);
>  			__put_super(sb);
> @@ -889,9 +919,9 @@ int reconfigure_super(struct fs_context *fc)
>  
>  	if (remount_ro) {
>  		if (!hlist_empty(&sb->s_pins)) {
> -			up_write(&sb->s_umount);
> +			super_unlock_excl(sb);
>  			group_pin_kill(&sb->s_pins);
> -			down_write(&sb->s_umount);
> +			super_lock_excl(sb);
>  			if (!sb->s_root)
>  				return 0;
>  			if (sb->s_writers.frozen != SB_UNFROZEN)
> @@ -954,7 +984,7 @@ int reconfigure_super(struct fs_context *fc)
>  
>  static void do_emergency_remount_callback(struct super_block *sb)
>  {
> -	down_write(&sb->s_umount);
> +	super_lock_excl(sb);
>  	if (sb->s_root && sb->s_bdev && (sb->s_flags & SB_BORN) &&
>  	    !sb_rdonly(sb)) {
>  		struct fs_context *fc;
> @@ -967,7 +997,7 @@ static void do_emergency_remount_callback(struct super_block *sb)
>  			put_fs_context(fc);
>  		}
>  	}
> -	up_write(&sb->s_umount);
> +	super_unlock_excl(sb);
>  }
>  
>  static void do_emergency_remount(struct work_struct *work)
> @@ -990,12 +1020,12 @@ void emergency_remount(void)
>  
>  static void do_thaw_all_callback(struct super_block *sb)
>  {
> -	down_write(&sb->s_umount);
> +	super_lock_excl(sb);
>  	if (sb->s_root && sb->s_flags & SB_BORN) {
>  		emergency_thaw_bdev(sb);
>  		thaw_super_locked(sb);
>  	} else {
> -		up_write(&sb->s_umount);
> +		super_unlock_excl(sb);
>  	}
>  }
>  
> @@ -1182,10 +1212,10 @@ EXPORT_SYMBOL(get_tree_keyed);
>   */
>  static bool lock_active_super(struct super_block *sb)
>  {
> -	down_read(&sb->s_umount);
> +	super_lock_shared(sb);
>  	if (!sb->s_root ||
>  	    (sb->s_flags & (SB_ACTIVE | SB_BORN)) != (SB_ACTIVE | SB_BORN)) {
> -		up_read(&sb->s_umount);
> +		super_unlock_shared(sb);
>  		return false;
>  	}
>  	return true;
> @@ -1208,7 +1238,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  	if (sb->s_op->shutdown)
>  		sb->s_op->shutdown(sb);
>  
> -	up_read(&sb->s_umount);
> +	super_unlock_shared(sb);
>  }
>  
>  static void fs_bdev_sync(struct block_device *bdev)
> @@ -1220,7 +1250,7 @@ static void fs_bdev_sync(struct block_device *bdev)
>  	if (!lock_active_super(sb))
>  		return;
>  	sync_filesystem(sb);
> -	up_read(&sb->s_umount);
> +	super_unlock_shared(sb);
>  }
>  
>  const struct blk_holder_ops fs_holder_ops = {
> @@ -1342,9 +1372,9 @@ int get_tree_bdev(struct fs_context *fc,
>  		 * bdev_mark_dead()). It is safe because we have active sb
>  		 * reference and SB_BORN is not set yet.
>  		 */
> -		up_write(&s->s_umount);
> +		super_unlock_excl(s);
>  		error = setup_bdev_super(s, fc->sb_flags, fc);
> -		down_write(&s->s_umount);
> +		super_lock_excl(s);
>  		if (!error)
>  			error = fill_super(s, fc);
>  		if (error) {
> @@ -1394,9 +1424,9 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
>  		 * bdev_mark_dead()). It is safe because we have active sb
>  		 * reference and SB_BORN is not set yet.
>  		 */
> -		up_write(&s->s_umount);
> +		super_unlock_excl(s);
>  		error = setup_bdev_super(s, flags, NULL);
> -		down_write(&s->s_umount);
> +		super_lock_excl(s);
>  		if (!error)
>  			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
>  		if (error) {
> @@ -1685,29 +1715,29 @@ int freeze_super(struct super_block *sb)
>  	int ret;
>  
>  	atomic_inc(&sb->s_active);
> -	down_write(&sb->s_umount);
> +	super_lock_excl(sb);
>  	if (sb->s_writers.frozen != SB_UNFROZEN) {
>  		deactivate_locked_super(sb);
>  		return -EBUSY;
>  	}
>  
>  	if (!(sb->s_flags & SB_BORN)) {
> -		up_write(&sb->s_umount);
> +		super_unlock_excl(sb);
>  		return 0;	/* sic - it's "nothing to do" */
>  	}
>  
>  	if (sb_rdonly(sb)) {
>  		/* Nothing to do really... */
>  		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> -		up_write(&sb->s_umount);
> +		super_unlock_excl(sb);
>  		return 0;
>  	}
>  
>  	sb->s_writers.frozen = SB_FREEZE_WRITE;
>  	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
> -	up_write(&sb->s_umount);
> +	super_unlock_excl(sb);
>  	sb_wait_write(sb, SB_FREEZE_WRITE);
> -	down_write(&sb->s_umount);
> +	super_lock_excl(sb);
>  
>  	/* Now we go and block page faults... */
>  	sb->s_writers.frozen = SB_FREEZE_PAGEFAULT;
> @@ -1743,7 +1773,7 @@ int freeze_super(struct super_block *sb)
>  	 */
>  	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  	lockdep_sb_freeze_release(sb);
> -	up_write(&sb->s_umount);
> +	super_unlock_excl(sb);
>  	return 0;
>  }
>  EXPORT_SYMBOL(freeze_super);
> @@ -1753,7 +1783,7 @@ static int thaw_super_locked(struct super_block *sb)
>  	int error;
>  
>  	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
> -		up_write(&sb->s_umount);
> +		super_unlock_excl(sb);
>  		return -EINVAL;
>  	}
>  
> @@ -1770,7 +1800,7 @@ static int thaw_super_locked(struct super_block *sb)
>  			printk(KERN_ERR
>  				"VFS:Filesystem thaw failed\n");
>  			lockdep_sb_freeze_release(sb);
> -			up_write(&sb->s_umount);
> +			super_unlock_excl(sb);
>  			return error;
>  		}
>  	}
> @@ -1790,7 +1820,7 @@ static int thaw_super_locked(struct super_block *sb)
>   */
>  int thaw_super(struct super_block *sb)
>  {
> -	down_write(&sb->s_umount);
> +	super_lock_excl(sb);
>  	return thaw_super_locked(sb);
>  }
>  EXPORT_SYMBOL(thaw_super);
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
