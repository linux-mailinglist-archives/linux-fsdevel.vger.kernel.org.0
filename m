Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496CF780C3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376995AbjHRNGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377007AbjHRNGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:06:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEA3A9A
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 06:06:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 359711F8AE;
        Fri, 18 Aug 2023 13:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692363997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JrtF0iSZsBP6BuUHZooRtyy+VRHvHkchZX6ooweLRA=;
        b=YSjkld+WQjYQuPhYCuStfOdqDMwrMX4RX2KDHbqLIP6u9bIia7lmkRCBgrXiDbFSaHy6xA
        TKUP1SXK2V7VpYD8C3jiny19kBJbhYc+8w4j5kDvsmb6l0SqFF3ZGqoxRxv3pON3GcJ4q8
        SFLEZUHIyl7A7Rm9Yp62tpwmgHf/+o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692363997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JrtF0iSZsBP6BuUHZooRtyy+VRHvHkchZX6ooweLRA=;
        b=tAgrGiLIW/7crGfNEKTTWT15ugc3vPeISVtW/+RTn+Vm9TY6h7NQzQUcJGPsddGHg12QQU
        Y7EN9JWUdbKuW8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27374138F0;
        Fri, 18 Aug 2023 13:06:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +GGQCd1s32SYGAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 18 Aug 2023 13:06:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ABCD9A076B; Fri, 18 Aug 2023 15:06:36 +0200 (CEST)
Date:   Fri, 18 Aug 2023 15:06:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] super: wait for nascent superblocks
Message-ID: <20230818130636.g2gqgnxau2nrfnjm@quack3>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
 <20230818-vfs-super-fixes-v3-v2-3-cdab45934983@kernel.org>
 <20230818120215.nalsrrfs26nhddpj@quack3>
 <20230818-fanden-magisch-2fe542f097d0@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-fanden-magisch-2fe542f097d0@brauner>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-08-23 14:46:57, Christian Brauner wrote:
> On Fri, Aug 18, 2023 at 02:02:15PM +0200, Jan Kara wrote:
> > On Fri 18-08-23 12:54:17, Christian Brauner wrote:
> > > Recent patches experiment with making it possible to allocate a new
> > > superblock before opening the relevant block device. Naturally this has
> > > intricate side-effects that we get to learn about while developing this.
> > > 
> > > Superblock allocators such as sget{_fc}() return with s_umount of the
> > > new superblock held and lock ordering currently requires that block
> > > level locks such as bdev_lock and open_mutex rank above s_umount.
> > > 
> > > Before aca740cecbe5 ("fs: open block device after superblock creation")
> > > ordering was guaranteed to be correct as block devices were opened prior
> > > to superblock allocation and thus s_umount wasn't held. But now s_umount
> > > must be dropped before opening block devices to avoid locking
> > > violations.
> > > 
> > > This has consequences. The main one being that iterators over
> > > @super_blocks and @fs_supers that grab a temporary reference to the
> > > superblock can now also grab s_umount before the caller has managed to
> > > open block devices and called fill_super(). So whereas before such
> > > iterators or concurrent mounts would have simply slept on s_umount until
> > > SB_BORN was set or the superblock was discard due to initalization
> > > failure they can now needlessly spin through sget{_fc}().
> > > 
> > > If the caller is sleeping on bdev_lock or open_mutex one caller waiting
> > > on SB_BORN will always spin somewhere and potentially this can go on for
> > > quite a while.
> > > 
> > > It should be possible to drop s_umount while allowing iterators to wait
> > > on a nascent superblock to either be born or discarded. This patch
> > > implements a wait_var_event() mechanism allowing iterators to sleep
> > > until they are woken when the superblock is born or discarded.
> > > 
> > > This also allows us to avoid relooping through @fs_supers and
> > > @super_blocks if a superblock isn't yet born or dying.
> > > 
> > > Link: aca740cecbe5 ("fs: open block device after superblock creation")
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > Looks mostly good to me. I've spotted only a couple of nits and one
> > possible memory ordering issue...
...
> > > +/* wait and acquire read-side of @sb->s_umount */
> > > +static inline bool super_lock_shared(struct super_block *sb)
> > > +{
> > > +	return super_lock(sb, false);
> > > +}
> > > +
> > > +/* wait and acquire write-side of @sb->s_umount */
> > > +static inline bool super_lock_excl(struct super_block *sb)
> > > +{
> > > +	return super_lock(sb, true);
> > > +}
> > > +
> > > +/* wake waiters */
> > > +#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING)
> > > +static void super_wake(struct super_block *sb, unsigned int flag)
> > > +{
> > > +	unsigned int flags = sb->s_flags;
> > > +
> > > +	WARN_ON_ONCE((flag & ~SUPER_WAKE_FLAGS));
> > > +	WARN_ON_ONCE(hweight32(flag & SUPER_WAKE_FLAGS) > 1);
> > 
> > Maybe assert here that s_umount is held?
> 
> I think that should be asserted in callers because we don't hold it when
> we do wake SB_DEAD in deactivate_locked_super() because we don't have or
> need it.

Right, I've realized that after I've sent this.

> > > +
> > > +	/*
> > > +	 * Pairs with smp_load_acquire() in super_lock() and
> > > +	 * ensures that @flag is set before we wake anyone.
> > > +	 */
> > > +	smp_store_release(&sb->s_flags, flags | flag);
> > > +	wake_up_var(&sb->s_flags);
> > 
> > As I'm thinking about it now, we may need at least a smp_rmb() between the
> > store and wake_up_var(). What I'm worried about is the following:
> > 
> > TASK1					TASK2
> > super_wake()				super_lock()
> > 					  check s_flags, SB_BORN not set yet
> >   waitqueue_active() from wake_up_var()
> >     which got reordered by the CPU before
> >     smp_store_release(). This seems possible
> >     because release is a one-way permeable in
> >     this direction.
> > 					  wait_var_event(..)
> > 					    prepare_to_wait_event()
> > 					    wait_born()
> > 					      SB_BORN still not set => sleep
> >   smp_store_release() sets SB_BORN
> >   wake_up_var() does nothing because it thinks
> >     the waitqueue is empty.
> 
> Then I propse we use smp_mb() here similar to what we do for __I_NEW.
> Does that sounds ok?

Sure, fine by me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
