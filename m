Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904D780BC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376869AbjHRM0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 08:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376886AbjHRM0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:26:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9F73C3E
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 05:26:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34EB121883;
        Fri, 18 Aug 2023 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692361570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WOFPJxoFnBTSQTPToDuYAWAAh7dXSXu3C4S+dj8mJJ4=;
        b=vWlL57F8qeTZO8iHb1HLpbPB9sZZFgqbDtoFwQPsueqqHGehdH1NrwUZOEAeY1GVcNojkO
        Ij5736Jn1MlDeM1z6r5DjEO/972RI/9XTGEf5AdPaMyyRzuDgdCzSH8UpfYThMnmg4XrA+
        NtYuf6RWMCPRJgTjDTNG7Xwd0Vvo9vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692361570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WOFPJxoFnBTSQTPToDuYAWAAh7dXSXu3C4S+dj8mJJ4=;
        b=9lXnfz7jpFmyTKFpM2l0JUXwH9q0BhsYpW8vyI9soOUnROAghuGWlLe11qQqW2SK7g3PgP
        qoh97SZbt9aFHRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2792F138F0;
        Fri, 18 Aug 2023 12:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 83imCWJj32ShAwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 18 Aug 2023 12:26:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B01E0A076B; Fri, 18 Aug 2023 14:26:09 +0200 (CEST)
Date:   Fri, 18 Aug 2023 14:26:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] super: wait until we passed kill super
Message-ID: <20230818122609.kzuw76wqz4plmsyb@quack3>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
 <20230818-vfs-super-fixes-v3-v2-4-cdab45934983@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-vfs-super-fixes-v3-v2-4-cdab45934983@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-08-23 12:54:18, Christian Brauner wrote:
> Recent rework moved block device closing out of sb->put_super() and into
> sb->kill_sb() to avoid deadlocks as s_umount is held in put_super() and
> blkdev_put() can end up taking s_umount again.
> 
> That means we need to move the removal of the superblock from @fs_supers
> out of generic_shutdown_super() and into deactivate_locked_super() to
> ensure that concurrent mounters don't fail to open block devices that
> are still in use because blkdev_put() in sb->kill_sb() hasn't been
> called yet.
> 
> We can now do this as we can make iterators through @fs_super and
> @super_blocks wait without holding s_umount. Concurrent mounts will wait
> until a dying superblock is fully dead so until sb->kill_sb() has been
> called and SB_DEAD been set. Concurrent iterators can already discard
> any SB_DYING superblock.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

One nit below:

> +static inline bool wait_dead(struct super_block *sb)
> +{
> +	unsigned int flags;
> +
> +	/*
> +	 * Pairs with smp_store_release() in super_wake() and ensures
> +	 * that we see SB_DEAD after we're woken.
> +	 */
> +	flags = smp_load_acquire(&sb->s_flags);
> +	return flags & SB_DEAD;
> +}
> +
>  /**
>   * super_lock - wait for superblock to become ready
>   * @sb: superblock to wait for
> @@ -140,6 +152,33 @@ static bool super_lock(struct super_block *sb, bool excl)
>  	goto relock;
>  }
>  
> +/**
> + * super_lock_dead - wait for superblock to become ready or fully dead
> + * @sb: superblock to wait for
> + *
> + * Wait for a superblock to be SB_BORN or to be SB_DEAD. In other words,
> + * don't just wait for the superblock to be shutdown in
> + * generic_shutdown_super() but actually wait until sb->kill_sb() has
> + * finished.
> + *
> + * The caller must have acquired a temporary reference on @sb->s_count.
> + *
> + * Return: This returns true if SB_BORN was set, false if SB_DEAD was
> + *         set. The function acquires s_umount and returns with it held.
> + */
> +static bool super_lock_dead(struct super_block *sb)
> +{
> +	if (super_lock(sb, true))
> +		return true;
> +
> +	lockdep_assert_held(&sb->s_umount);
> +	super_unlock_excl(sb);
> +	/* If superblock is dying, wait for everything to be shutdown. */
> +	wait_var_event(&sb->s_flags, wait_dead(sb));
> +	__super_lock_excl(sb);
> +	return false;
> +}
> +
>  /* wait and acquire read-side of @sb->s_umount */
>  static inline bool super_lock_shared(struct super_block *sb)
>  {
> @@ -153,7 +192,7 @@ static inline bool super_lock_excl(struct super_block *sb)
>  }
>  
>  /* wake waiters */
> -#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING)
> +#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
>  static void super_wake(struct super_block *sb, unsigned int flag)
>  {
>  	unsigned int flags = sb->s_flags;
> @@ -169,6 +208,35 @@ static void super_wake(struct super_block *sb, unsigned int flag)
>  	wake_up_var(&sb->s_flags);
>  }
>  
> +/**
> + * grab_super_dead - acquire an active reference to a superblock
> + * @sb: superblock to acquire
> + *
> + * Acquire a temporary reference on a superblock and try to trade it for
> + * an active reference. This is used in sget{_fc}() to wait for a
> + * superblock to either become SB_BORN or for it to pass through
> + * sb->kill() and be marked as SB_DEAD.
> + *
> + * Return: This returns true if an active reference could be acquired,
> + *         false if not. The function acquires s_umount and returns with
> + *         it held.
> + */
> +static bool grab_super_dead(struct super_block *s) __releases(sb_lock)
> +{
> +	bool born;
> +
> +	s->s_count++;
> +	spin_unlock(&sb_lock);
> +	born = super_lock_dead(s);
> +	if (born && atomic_inc_not_zero(&s->s_active)) {
> +		put_super(s);
> +		return true;
> +	}
> +	up_write(&s->s_umount);
> +	put_super(s);
> +	return false;
> +}
> +

As I'm looking at it now, I'm wondering whether we are not overdoing it a
bit. Why not implement grab_super_dead() as:

static bool grab_super_dead(struct super_block *s) __releases(sb_lock)
{
	s->s_count++;
	if (grab_super(s))
		return true;
	wait_var_event(&sb->s_flags, wait_dead(sb));
	put_super(s);
	return false;
}

And just remove super_lock_dead() altogether? I don't expect more users of
that functionality...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
