Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8A77F6BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 14:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350976AbjHQMua (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351055AbjHQMuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:50:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999C2D7B
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 05:50:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DDE4C1F37F;
        Thu, 17 Aug 2023 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692276621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=llFrlwBwOHodP9OLELrQMY0rWaMLpHWbwBqnZDrUgWg=;
        b=YWe+OT2hwwB17LodOMeUm9ZevWO44MWhJlNsvWYTvAAmcOus4BzJWnW+ldhXGn9wWciO7e
        UvVOLPS3vxmT8ROFYWQg7Q6k905MJAUpRNq8TTpQ4IZgx3AmsiKz/v3bFwiRahxA7SJL17
        dBvx2vh66HSL2Br3LybzDQBUrGo0o0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692276621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=llFrlwBwOHodP9OLELrQMY0rWaMLpHWbwBqnZDrUgWg=;
        b=UP2M22AhZBnTooav83Q3cwGw5McKF0h5Zlb5wZqXY1R7SvT8WHu6GZsJQaTftfgRgx167J
        g62iFgjZGvMKKpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF07A1392B;
        Thu, 17 Aug 2023 12:50:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 202IMo0X3mRpagAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 12:50:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 55B95A0769; Thu, 17 Aug 2023 14:50:21 +0200 (CEST)
Date:   Thu, 17 Aug 2023 14:50:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] super: wait for nascent superblocks
Message-ID: <20230817125021.l6h4ipibfuzd3xdx@quack3>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
 <20230817-vfs-super-fixes-v3-v1-2-06ddeca7059b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817-vfs-super-fixes-v3-v1-2-06ddeca7059b@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 12:47:43, Christian Brauner wrote:
> Recent patches experiment with making it possible to allocate a new
> superblock before opening the relevant block device. Naturally this has
> intricate side-effects that we get to learn about while developing this.
> 
> Superblock allocators such as sget{_fc}() return with s_umount of the
> new superblock held and ock ordering currently requires that block level
> locks such as bdev_lock and open_mutex rank above s_umount.
> 
> Before aca740cecbe5 ("fs: open block device after superblock creation")
> ordering was guaranteed to be correct as block devices were opened prior
> to superblock allocation and thus s_umount wasn't held. But now s_umount
> must be dropped before opening block devices to avoid locking
> violations.
> 
> This has consequences. The main one being that iterators over
> @super_blocks and @fs_supers that grab a temporary reference to the
> superblock can now also grab s_umount before the caller has managed to
> open block devices and called fill_super(). So whereas before such
> iterators or concurrent mounts would have simply slept on s_umount until
> SB_BORN was set or the superblock was discard due to initalization
> failure they can now needlessly spin through sget{_fc}().
> 
> If the caller is sleeping on bdev_lock or open_mutex one caller waiting
> on SB_BORN will always spin somewhere potentially this can go on for
					^^ and potentially?
> quite a while.
> 
> It should be possible to drop s_umount while allowing iterators to wait
> on a nascent superblock to either be born or discarded. This patch
> implements a wait_var_event() mechanism allowing iterators to sleep
> until they are woken when the superblock is born or discarded.
> 
> This should also allows us to avoid relooping through @fs_supers and
       ^^^ superfluous "should"

> @super_blocks if a superblock isn't yet born or dying.
> 
> Link: aca740cecbe5 ("fs: open block device after superblock creation")
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/super.c         | 146 +++++++++++++++++++++++++++++++++++++++++++++--------
>  include/linux/fs.h |   1 +
>  2 files changed, 125 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 878675921bdc..55bf495763d9 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -86,6 +86,89 @@ static inline void super_unlock_read(struct super_block *sb)
>  	super_unlock(sb, false);
>  }
>  
> +static inline bool wait_born(struct super_block *sb)
> +{
> +	unsigned int flags;
> +
> +	/*
> +	 * Pairs with smp_store_release() in super_wake() and ensure
> +	 * that we see SB_BORN or SB_DYING after we're woken.
> +	 */
> +	flags = smp_load_acquire(&sb->s_flags);
> +	return flags & (SB_BORN | SB_DYING);
> +}
> +
> +/**
> + * super_wait - wait for superblock to become ready
> + * @sb: superblock to wait for
> + * @excl: whether exclusive access is required
> + *
> + * If the superblock has neither passed through vfs_get_tree() or
> + * generic_shutdown_super() yet wait for it to happen. Either superblock
> + * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
> + * woken and we'll see SB_DYING.
> + *
> + * The caller must have acquired a temporary reference on @sb->s_count.
> + *
> + * Return: true if SB_BORN was set, false if SB_DYING was set.

The comment should mention that this acquires s_umount and returns with it
held. Also the name is a bit too generic for my taste and not expressing
the fact this is in fact a lock operation. Maybe something like
super_lock_wait_born()?

> + */
> +static bool super_wait(struct super_block *sb, bool excl)
> +{
> +
> +	lockdep_assert_not_held(&sb->s_umount);
> +
> +relock:
> +	super_lock(sb, excl);
> +
> +	/*
> +	 * Has gone through generic_shutdown_super() in the meantime.
> +	 * @sb->s_root is NULL and @sb->s_active is 0. No one needs to
> +	 * grab a reference to this. Tell them so.
> +	 */
> +	if (sb->s_flags & SB_DYING)
> +		return false;
> +
> +	/* Has called ->get_tree() successfully. */
> +	if (sb->s_flags & SB_BORN)
> +		return true;
> +
> +	super_unlock(sb, excl);
> +
> +	/* wait until the superblock is ready or dying */
> +	wait_var_event(&sb->s_flags, wait_born(sb));
> +
> +	/*
> +	 * Neither SB_BORN nor SB_DYING are ever unset so we never loop.
> +	 * Just reacquire @sb->s_umount for the caller.
> +	 */
> +	goto relock;
> +}
> +
> +/* wait and acquire read-side of @sb->s_umount */
> +static inline bool super_wait_read(struct super_block *sb)
> +{
> +	return super_wait(sb, false);
> +}

And I'd call this super_lock_read_wait_born().

> +
> +/* wait and acquire write-side of @sb->s_umount */
> +static inline bool super_wait_write(struct super_block *sb)
> +{
> +	return super_wait(sb, true);
> +}
> +
> +/* wake waiters */
> +static void super_wake(struct super_block *sb, unsigned int flag)
> +{
> +	unsigned int flags = sb->s_flags;

	I kind of miss the point of this local variable but whatever...

> +
> +	/*
> +	 * Pairs with smp_load_acquire() in super_wait() and ensure that
							     ^^^ ensures
> +	 * we @flag is set before we wake anyone.
	   ^^ the

> +	 */
> +	smp_store_release(&sb->s_flags, flags | flag);
> +	wake_up_var(&sb->s_flags);
> +}
> +
>  /*
>   * One thing we have to be careful of with a per-sb shrinker is that we don't
>   * drop the last active reference to the superblock from within the shrinker.
> @@ -415,10 +498,12 @@ EXPORT_SYMBOL(deactivate_super);
>   */
>  static int grab_super(struct super_block *s) __releases(sb_lock)
>  {
> +	bool born;
> +
>  	s->s_count++;
>  	spin_unlock(&sb_lock);
> -	super_lock_write(s);
> -	if ((s->s_flags & SB_BORN) && atomic_inc_not_zero(&s->s_active)) {
> +	born = super_wait_write(s);
> +	if (born && atomic_inc_not_zero(&s->s_active)) {
>  		put_super(s);
>  		return 1;
>  	}
> @@ -557,6 +642,13 @@ void generic_shutdown_super(struct super_block *sb)
>  	/* should be initialized for __put_super_and_need_restart() */
>  	hlist_del_init(&sb->s_instances);
>  	spin_unlock(&sb_lock);
> +	/*
> +	 * Broadcast to everyone that grabbed a temporary reference to this
> +	 * superblock before we removed it from @fs_supers that the superblock
> +	 * is dying. Every walker of @fs_supers outside of sget{_fc}() will now
> +	 * discard this superblock and treat it as dead.
> +	 */
> +	super_wake(sb, SB_DYING);
>  	super_unlock_write(sb);
>  	if (sb->s_bdi != &noop_backing_dev_info) {
>  		if (sb->s_iflags & SB_I_PERSB_BDI)
> @@ -631,6 +723,11 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	s->s_type = fc->fs_type;
>  	s->s_iflags |= fc->s_iflags;
>  	strscpy(s->s_id, s->s_type->name, sizeof(s->s_id));
> +	/*
> +	 * Make the superblock visible on @super_blocks and @fs_supers.
> +	 * It's in a nascent state and users should wait on SB_BORN or
> +	 * SB_DYING to be set.
> +	 */

But now sget_fc() (and sget()) will be looping on superblocks with SB_DYING
set? Ah, that's solved by the next patch. OK.

>  	list_add_tail(&s->s_list, &super_blocks);
>  	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
>  	spin_unlock(&sb_lock);

<snip>

> @@ -841,15 +942,14 @@ struct super_block *get_active_super(struct block_device *bdev)
>  	if (!bdev)
>  		return NULL;
>  
> -restart:
>  	spin_lock(&sb_lock);
>  	list_for_each_entry(sb, &super_blocks, s_list) {
>  		if (hlist_unhashed(&sb->s_instances))
>  			continue;
>  		if (sb->s_bdev == bdev) {
>  			if (!grab_super(sb))
> -				goto restart;
> -			super_unlock_write(sb);
> +				return NULL;
  Let me check whether I understand the rationale of this change: We found
a matching sb and it's SB_DYING. Instead of waiting for it to die and retry
the search (to likely not find anything) we just return NULL right away to
save us some trouble.

> +                        super_unlock_write(sb);
   ^^^ whitespace damage here

>  			return sb;
>  		}
>  	}

<snip>

> @@ -1212,9 +1314,9 @@ EXPORT_SYMBOL(get_tree_keyed);
>   */
>  static bool lock_active_super(struct super_block *sb)

Another inconsistently named locking function after you've introduced your
locking helpers...

>  {
> -	super_lock_read(sb);
> -	if (!sb->s_root ||
> -	    (sb->s_flags & (SB_ACTIVE | SB_BORN)) != (SB_ACTIVE | SB_BORN)) {
> +	bool born = super_wait_read(sb);
> +
> +	if (!born || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
>  		super_unlock_read(sb);
>  		return false;
>  	}
> @@ -1572,7 +1674,7 @@ int vfs_get_tree(struct fs_context *fc)
>  	 * flag.
>  	 */
>  	smp_wmb();

Is the barrier still needed here when super_wake() has smp_store_release()?

> -	sb->s_flags |= SB_BORN;
> +	super_wake(sb, SB_BORN);

I'm also kind of wondering whether when we have SB_BORN and SB_DYING isn't
the SB_ACTIVE flag redundant. SB_BORN is set practically at the same moment
as SB_ACTIVE. SB_ACTIVE gets cleared somewhat earlier than SB_DYING is set
but I believe SB_DYING can be set earlier (after all by the time SB_ACTIVE
is cleared we have sb->s_root == NULL which basically stops most of the
places looking at superblocks. As I'm grepping we've grown a lot of
SB_ACTIVE handling all over the place so this would be a bit non-trivial
but I belive it will make it easier for filesystem developers to decide
which flag they should be using... Also we could then drop sb->s_root
checks from many places because the locking helpers will return false if
SB_DYING is set.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
