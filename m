Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29613782DB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjHUQCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHUQCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:02:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6C5E4
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 09:02:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23D2B22C41;
        Mon, 21 Aug 2023 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692633745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+As9oRWrjH1fviC3MpVL5hV5uj2l4pYagQsdrVBNTCo=;
        b=tHoovV6QIKxGRq6qqNGKZELhsp0/Y0O5kF1+fLr4gNNdEATd8Vz8tc5DK5ATR7DQiV+o7+
        FshvqP1zj5rCeIPiVdP9dInKA4Swmt3hAeScVJGgb6AVTlXbjmiff//OK1B97RHKluUzeI
        A9UgaTD6jQF3u5vdmo/Uw47YqT9OZqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692633745;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+As9oRWrjH1fviC3MpVL5hV5uj2l4pYagQsdrVBNTCo=;
        b=NdkklMmRS3qSJTyKm3NCZJm7s113DX8rzm80TJY/Ad8R4uLCmnR3o5XEa/Up/1dwuGw1Ta
        DV1wcxF5KyD8HVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14E0B1330D;
        Mon, 21 Aug 2023 16:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yVoOBZGK42QdLgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Aug 2023 16:02:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 96146A0774; Mon, 21 Aug 2023 18:02:24 +0200 (CEST)
Date:   Mon, 21 Aug 2023 18:02:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] super: wait for nascent superblocks
Message-ID: <20230821160224.ees2jmlddqtupvsc@quack3>
References: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
 <20230818-vfs-super-fixes-v3-v3-3-9f0b1876e46b@kernel.org>
 <20230821155237.d4luoqrzhnlffbti@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821155237.d4luoqrzhnlffbti@quack3>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-08-23 17:52:37, Jan Kara wrote:
> On Fri 18-08-23 16:00:50, Christian Brauner wrote:
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
> ...
> > +/* wake waiters */
> > +#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING)
> > +static void super_wake(struct super_block *sb, unsigned int flag)
> > +{
> > +	WARN_ON_ONCE((flag & ~SUPER_WAKE_FLAGS));
> > +	WARN_ON_ONCE(hweight32(flag & SUPER_WAKE_FLAGS) > 1);
> > +
> > +	/*
> > +	 * Pairs with smp_load_acquire() in super_lock() and
> > +	 * ensures that @flag is set before we wake anyone and ensures
> > +	 * that checking whether waitqueue is active isn't hoisted
> > +	 * before the store of @flag.
> > +	 */
> > +	sb->s_flags |= flag;
> > +	smp_mb();
> > +	wake_up_var(&sb->s_flags);
> 
> I think we misunderstood here. I believe we need:
> 
> 	/*
> 	 * Pairs with smp_load_acquire() in super_lock() to make sure
> 	 * all initializations in the superblock are seen by the user
> 	 * seeing SB_BORN sent.
> 	 */
> 	smp_store_release(&sb->s_flags, sb->s_flags | flag);
> 	/*
> 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> 	 * ___wait_var_event() either sees SB_BORN set or
> 	 * waitqueue_active() check in wake_up_var() sees the waiter
> 	 */
> 	smp_rmb();
> 	wake_up_var(&sb->s_flags);
> 
> or we need something equivalent with stronger barriers. Like:
> 
> 	smp_wmb();
> 	sb->s_flags |= flag;
> 	smp_rmb();
> 	wake_up_var(&sb->s_flags);

Ah, in both of the above cases we actually need smp_mb() (as you properly
chose) instead of smp_rmb() I wrote above because we need to establish
write-vs-read ordering.

BTW, if you pick one of these two schemes, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

If you decide for something else, I'd like to see the result first...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
