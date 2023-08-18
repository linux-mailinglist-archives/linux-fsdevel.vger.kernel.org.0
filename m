Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0424780C1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 14:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376949AbjHRMsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376940AbjHRMsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E23A8B
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 05:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F4767C06
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 12:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF7FC43142;
        Fri, 18 Aug 2023 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692362899;
        bh=lIXD3S/sXE6eyZZzkSpTNpNQ6HrFigd3MSQK6StfUBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgocgPIYUnxu6bVGfvf8Kd3cgZp365hV2fqp8MK7FCQWbI89mOdtEQZFTqQv2Iust
         SaOx4BwGLXiM+Ah8/tuweEBt09nm+qI7wMxasjNJ/HocmOfstqHfZn26GE2flLSvWw
         2GWzWH1/D/gYGQU4vN9hTJ61FeFmWMhXtKibFAM6Wf/XlUbgEme0XDOY8waI93+k7o
         jm/LPxMwb5Z2siAQBu7enjM8pg5JWxRGCBKqq9HBjqxVNUr/66vpeqIOkHHbcUaIfC
         Z90vlP0VcXi58LevIWejRN8ErhaDvHE1bdTQWQ1FZT0h6S4ve82KKiDN/SEKstWy0D
         CeRsNhlp1sxnw==
Date:   Fri, 18 Aug 2023 14:48:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] super: wait until we passed kill super
Message-ID: <20230818-umbruch-wahldebakel-ec87b7549afd@brauner>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
 <20230818-vfs-super-fixes-v3-v2-4-cdab45934983@kernel.org>
 <20230818122609.kzuw76wqz4plmsyb@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818122609.kzuw76wqz4plmsyb@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:26:09PM +0200, Jan Kara wrote:
> On Fri 18-08-23 12:54:18, Christian Brauner wrote:
> > Recent rework moved block device closing out of sb->put_super() and into
> > sb->kill_sb() to avoid deadlocks as s_umount is held in put_super() and
> > blkdev_put() can end up taking s_umount again.
> > 
> > That means we need to move the removal of the superblock from @fs_supers
> > out of generic_shutdown_super() and into deactivate_locked_super() to
> > ensure that concurrent mounters don't fail to open block devices that
> > are still in use because blkdev_put() in sb->kill_sb() hasn't been
> > called yet.
> > 
> > We can now do this as we can make iterators through @fs_super and
> > @super_blocks wait without holding s_umount. Concurrent mounts will wait
> > until a dying superblock is fully dead so until sb->kill_sb() has been
> > called and SB_DEAD been set. Concurrent iterators can already discard
> > any SB_DYING superblock.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> One nit below:
> 
> > +static inline bool wait_dead(struct super_block *sb)
> > +{
> > +	unsigned int flags;
> > +
> > +	/*
> > +	 * Pairs with smp_store_release() in super_wake() and ensures
> > +	 * that we see SB_DEAD after we're woken.
> > +	 */
> > +	flags = smp_load_acquire(&sb->s_flags);
> > +	return flags & SB_DEAD;
> > +}
> > +
> >  /**
> >   * super_lock - wait for superblock to become ready
> >   * @sb: superblock to wait for
> > @@ -140,6 +152,33 @@ static bool super_lock(struct super_block *sb, bool excl)
> >  	goto relock;
> >  }
> >  
> > +/**
> > + * super_lock_dead - wait for superblock to become ready or fully dead
> > + * @sb: superblock to wait for
> > + *
> > + * Wait for a superblock to be SB_BORN or to be SB_DEAD. In other words,
> > + * don't just wait for the superblock to be shutdown in
> > + * generic_shutdown_super() but actually wait until sb->kill_sb() has
> > + * finished.
> > + *
> > + * The caller must have acquired a temporary reference on @sb->s_count.
> > + *
> > + * Return: This returns true if SB_BORN was set, false if SB_DEAD was
> > + *         set. The function acquires s_umount and returns with it held.
> > + */
> > +static bool super_lock_dead(struct super_block *sb)
> > +{
> > +	if (super_lock(sb, true))
> > +		return true;
> > +
> > +	lockdep_assert_held(&sb->s_umount);
> > +	super_unlock_excl(sb);
> > +	/* If superblock is dying, wait for everything to be shutdown. */
> > +	wait_var_event(&sb->s_flags, wait_dead(sb));
> > +	__super_lock_excl(sb);
> > +	return false;
> > +}
> > +
> >  /* wait and acquire read-side of @sb->s_umount */
> >  static inline bool super_lock_shared(struct super_block *sb)
> >  {
> > @@ -153,7 +192,7 @@ static inline bool super_lock_excl(struct super_block *sb)
> >  }
> >  
> >  /* wake waiters */
> > -#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING)
> > +#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
> >  static void super_wake(struct super_block *sb, unsigned int flag)
> >  {
> >  	unsigned int flags = sb->s_flags;
> > @@ -169,6 +208,35 @@ static void super_wake(struct super_block *sb, unsigned int flag)
> >  	wake_up_var(&sb->s_flags);
> >  }
> >  
> > +/**
> > + * grab_super_dead - acquire an active reference to a superblock
> > + * @sb: superblock to acquire
> > + *
> > + * Acquire a temporary reference on a superblock and try to trade it for
> > + * an active reference. This is used in sget{_fc}() to wait for a
> > + * superblock to either become SB_BORN or for it to pass through
> > + * sb->kill() and be marked as SB_DEAD.
> > + *
> > + * Return: This returns true if an active reference could be acquired,
> > + *         false if not. The function acquires s_umount and returns with
> > + *         it held.
> > + */
> > +static bool grab_super_dead(struct super_block *s) __releases(sb_lock)
> > +{
> > +	bool born;
> > +
> > +	s->s_count++;
> > +	spin_unlock(&sb_lock);
> > +	born = super_lock_dead(s);
> > +	if (born && atomic_inc_not_zero(&s->s_active)) {
> > +		put_super(s);
> > +		return true;
> > +	}
> > +	up_write(&s->s_umount);
> > +	put_super(s);
> > +	return false;
> > +}
> > +
> 
> As I'm looking at it now, I'm wondering whether we are not overdoing it a
> bit. Why not implement grab_super_dead() as:
> 
> static bool grab_super_dead(struct super_block *s) __releases(sb_lock)
> {
> 	s->s_count++;
> 	if (grab_super(s))
> 		return true;
> 	wait_var_event(&sb->s_flags, wait_dead(sb));
> 	put_super(s);
> 	return false;
> }

Sounds good. Thanks for the suggestion.

> 
> And just remove super_lock_dead() altogether? I don't expect more users of
> that functionality...

Famous last words... :)
