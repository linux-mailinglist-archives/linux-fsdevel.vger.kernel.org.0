Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABD780C19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376946AbjHRMrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 08:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377081AbjHRMrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD23AB4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 05:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7BA65052
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 12:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA50C433C7;
        Fri, 18 Aug 2023 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692362821;
        bh=YtoTZdoniYjKV4QeombFvADRPFHtlKR6yaGDgRIEnAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7u45yayN02TCXl22h9Z/2XdIG+tutw/OdVRtPNIsG1iQ5qcPLQ6GTFiCj34bSjfO
         hSW4iosZ5bDAfI9qy290UUlPfBHt35IqirjvOdxLPz4+5ZaxhCgybZ3gR5NJvSFjgN
         aX5mDPl1gBqsxdL0IK+aSOYFapwJ2HrVe22KrAOfvJqo+wtOOLaIsvYcVL7Z7RSsnd
         paYtxnVnWl42faNSIxjDT2TcEsMy44g9sVuyvB0+cbjhxV7HVFIRL4lV1dmAuR2qNM
         wjyEQjnwr5D3BFnbMLJdpCORegad6TOk/ZcYZ3H5A2B1OpC963FqcyGRzp8axv5fdd
         NrM+kYUW94fsQ==
Date:   Fri, 18 Aug 2023 14:46:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] super: wait for nascent superblocks
Message-ID: <20230818-fanden-magisch-2fe542f097d0@brauner>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
 <20230818-vfs-super-fixes-v3-v2-3-cdab45934983@kernel.org>
 <20230818120215.nalsrrfs26nhddpj@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818120215.nalsrrfs26nhddpj@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:02:15PM +0200, Jan Kara wrote:
> On Fri 18-08-23 12:54:17, Christian Brauner wrote:
> > Recent patches experiment with making it possible to allocate a new
> > superblock before opening the relevant block device. Naturally this has
> > intricate side-effects that we get to learn about while developing this.
> > 
> > Superblock allocators such as sget{_fc}() return with s_umount of the
> > new superblock held and lock ordering currently requires that block
> > level locks such as bdev_lock and open_mutex rank above s_umount.
> > 
> > Before aca740cecbe5 ("fs: open block device after superblock creation")
> > ordering was guaranteed to be correct as block devices were opened prior
> > to superblock allocation and thus s_umount wasn't held. But now s_umount
> > must be dropped before opening block devices to avoid locking
> > violations.
> > 
> > This has consequences. The main one being that iterators over
> > @super_blocks and @fs_supers that grab a temporary reference to the
> > superblock can now also grab s_umount before the caller has managed to
> > open block devices and called fill_super(). So whereas before such
> > iterators or concurrent mounts would have simply slept on s_umount until
> > SB_BORN was set or the superblock was discard due to initalization
> > failure they can now needlessly spin through sget{_fc}().
> > 
> > If the caller is sleeping on bdev_lock or open_mutex one caller waiting
> > on SB_BORN will always spin somewhere and potentially this can go on for
> > quite a while.
> > 
> > It should be possible to drop s_umount while allowing iterators to wait
> > on a nascent superblock to either be born or discarded. This patch
> > implements a wait_var_event() mechanism allowing iterators to sleep
> > until they are woken when the superblock is born or discarded.
> > 
> > This also allows us to avoid relooping through @fs_supers and
> > @super_blocks if a superblock isn't yet born or dying.
> > 
> > Link: aca740cecbe5 ("fs: open block device after superblock creation")
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Looks mostly good to me. I've spotted only a couple of nits and one
> possible memory ordering issue...
> 
> > @@ -86,6 +81,94 @@ static inline void super_unlock_shared(struct super_block *sb)
> >  	super_unlock(sb, false);
> >  }
> >  
> > +static inline bool wait_born(struct super_block *sb)
> > +{
> > +	unsigned int flags;
> > +
> > +	/*
> > +	 * Pairs with smp_store_release() in super_wake() and ensures
> > +	 * that we see SB_BORN or SB_DYING after we're woken.
> > +	 */
> > +	flags = smp_load_acquire(&sb->s_flags);
> > +	return flags & (SB_BORN | SB_DYING);
> > +}
> > +
> > +/**
> > + * super_lock - wait for superblock to become ready
> 
> Perhaps expand this a bit to "wait for superblock to become ready and
> lock it"

Ok.

> 
> > + * @sb: superblock to wait for
> > + * @excl: whether exclusive access is required
> > + *
> > + * If the superblock has neither passed through vfs_get_tree() or
> > + * generic_shutdown_super() yet wait for it to happen. Either superblock
> > + * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
> > + * woken and we'll see SB_DYING.
> > + *
> > + * The caller must have acquired a temporary reference on @sb->s_count.
> > + *
> > + * Return: This returns true if SB_BORN was set, false if SB_DYING was
> > + *         set. The function acquires s_umount and returns with it held.
> > + */
> > +static bool super_lock(struct super_block *sb, bool excl)
> 
> Perhaps we can make the function __must_check? Because if you don't care
> about the result you should be using __super_lock().

Ok.

> 
> > +{
> > +
> > +	lockdep_assert_not_held(&sb->s_umount);
> > +
> > +relock:
> > +	__super_lock(sb, excl);
> > +
> > +	/*
> > +	 * Has gone through generic_shutdown_super() in the meantime.
> > +	 * @sb->s_root is NULL and @sb->s_active is 0. No one needs to
> > +	 * grab a reference to this. Tell them so.
> > +	 */
> > +	if (sb->s_flags & SB_DYING)
> > +		return false;
> > +
> > +	/* Has called ->get_tree() successfully. */
> > +	if (sb->s_flags & SB_BORN)
> > +		return true;
> > +
> > +	super_unlock(sb, excl);
> > +
> > +	/* wait until the superblock is ready or dying */
> > +	wait_var_event(&sb->s_flags, wait_born(sb));
> > +
> > +	/*
> > +	 * Neither SB_BORN nor SB_DYING are ever unset so we never loop.
> > +	 * Just reacquire @sb->s_umount for the caller.
> > +	 */
> > +	goto relock;
> > +}
> > +
> > +/* wait and acquire read-side of @sb->s_umount */
> > +static inline bool super_lock_shared(struct super_block *sb)
> > +{
> > +	return super_lock(sb, false);
> > +}
> > +
> > +/* wait and acquire write-side of @sb->s_umount */
> > +static inline bool super_lock_excl(struct super_block *sb)
> > +{
> > +	return super_lock(sb, true);
> > +}
> > +
> > +/* wake waiters */
> > +#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING)
> > +static void super_wake(struct super_block *sb, unsigned int flag)
> > +{
> > +	unsigned int flags = sb->s_flags;
> > +
> > +	WARN_ON_ONCE((flag & ~SUPER_WAKE_FLAGS));
> > +	WARN_ON_ONCE(hweight32(flag & SUPER_WAKE_FLAGS) > 1);
> 
> Maybe assert here that s_umount is held?

I think that should be asserted in callers because we don't hold it when
we do wake SB_DEAD in deactivate_locked_super() because we don't have or
need it.

> 
> > +
> > +	/*
> > +	 * Pairs with smp_load_acquire() in super_lock() and
> > +	 * ensures that @flag is set before we wake anyone.
> > +	 */
> > +	smp_store_release(&sb->s_flags, flags | flag);
> > +	wake_up_var(&sb->s_flags);
> 
> As I'm thinking about it now, we may need at least a smp_rmb() between the
> store and wake_up_var(). What I'm worried about is the following:
> 
> TASK1					TASK2
> super_wake()				super_lock()
> 					  check s_flags, SB_BORN not set yet
>   waitqueue_active() from wake_up_var()
>     which got reordered by the CPU before
>     smp_store_release(). This seems possible
>     because release is a one-way permeable in
>     this direction.
> 					  wait_var_event(..)
> 					    prepare_to_wait_event()
> 					    wait_born()
> 					      SB_BORN still not set => sleep
>   smp_store_release() sets SB_BORN
>   wake_up_var() does nothing because it thinks
>     the waitqueue is empty.

Then I propse we use smp_mb() here similar to what we do for __I_NEW.
Does that sounds ok?
