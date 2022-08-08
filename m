Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D553A58CB50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbiHHPbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiHHPbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:31:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A0F1402F;
        Mon,  8 Aug 2022 08:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A9D2B80EE6;
        Mon,  8 Aug 2022 15:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AB9C433C1;
        Mon,  8 Aug 2022 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659972672;
        bh=qOvwZkGh7HLkeEg6nfF9Kxo7AMoAIc1CMELa4sVqOWw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OjgXoJ3ODIV4FhwtawMvRiSA1XIShisIr5GMZZuVyNrQxt4KpyssI2/uLrc1orCuy
         Svkf/B0iShPLaSbV82yN7Ol3ZYdbAcUQ5MS0T4PkDKAnzHOQGx5XANm0Prs4qoJN55
         pyuoEjiuTo2CdgqOHMTajprcXMksE6z+ExETh/tRxTxOpzL0333WhwBBZP65wt8J4F
         orGjgJDGvFKZA/78KmmQRGQXAtgMYozYfDVzphMyurxmMuEH5WL+FQJWToxd4Ljm4u
         Hco8bsHSvyCyq2Jebct9eDE+V7F/ClI4gzSqPWBwxiw3/b3PQlIkGOnZtwuinRtfJV
         Jbm2wQ3X4DJ0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AE1FF5C128A; Mon,  8 Aug 2022 08:31:11 -0700 (PDT)
Date:   Mon, 8 Aug 2022 08:31:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] add barriers to buffer functions
Message-ID: <20220808153111.GE2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <YuflGG60pHiXp2z/@casper.infradead.org>
 <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
 <YuyNE5c06WStxQ2z@casper.infradead.org>
 <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com>
 <Yu/RJtoJPhkWXIdP@casper.infradead.org>
 <alpine.LRH.2.02.2208080928580.8160@file01.intranet.prod.int.rdu2.redhat.com>
 <YvEgZuSdv8XHtkJg@casper.infradead.org>
 <alpine.LRH.2.02.2208081050330.8160@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208081050330.8160@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:57:45AM -0400, Mikulas Patocka wrote:
> 
> 
> On Mon, 8 Aug 2022, Matthew Wilcox wrote:
> 
> > On Mon, Aug 08, 2022 at 10:26:10AM -0400, Mikulas Patocka wrote:
> > > On Sun, 7 Aug 2022, Matthew Wilcox wrote:
> > > > > +static __always_inline void set_buffer_locked(struct buffer_head *bh)
> > > > > +{
> > > > > +	set_bit(BH_Lock, &bh->b_state);
> > > > > +}
> > > > > +
> > > > > +static __always_inline int buffer_locked(const struct buffer_head *bh)
> > > > > +{
> > > > > +	bool ret = test_bit(BH_Lock, &bh->b_state);
> > > > > +	/*
> > > > > +	 * pairs with smp_mb__after_atomic in unlock_buffer
> > > > > +	 */
> > > > > +	if (!ret)
> > > > > +		smp_acquire__after_ctrl_dep();
> > > > > +	return ret;
> > > > > +}
> > > > 
> > > > Are there places that think that lock/unlock buffer implies a memory
> > > > barrier?
> > > 
> > > There's this in fs/reiserfs:
> > > 
> > > if (!buffer_dirty(bh) && !buffer_locked(bh)) {
> > > 	reiserfs_free_jh(bh); <--- this could be moved before buffer_locked
> > 
> > It might be better to think of buffer_locked() as
> > buffer_someone_has_exclusive_access().  I can't see the problem with
> > moving the reads in reiserfs_free_jh() before the read of buffer_locked.
> > 
> > > if (buffer_locked((journal->j_header_bh))) {
> > > 	...
> > > }
> > > journal->j_last_flush_trans_id = trans_id;
> > > journal->j_first_unflushed_offset = offset;
> > > jh = (struct reiserfs_journal_header *)(journal->j_header_bh->b_data); <--- this could be moved before buffer_locked
> > 
> > I don't think b_data is going to be changed while someone else holds
> > the buffer locked.  That's initialised by set_bh_page(), which is an
> > initialisation-time thing, before the BH is visible to any other thread.
> 
> So, do you think that we don't need a barrier in buffer_locked()?

The question to ask here is "What prevents another call to buffer_locked()
from returning false?"

> There is also this (where the BUG_ON(!buffer_uptodate(bh)) saves it).
>                 if (buffer_locked(bh)) {

Right here, for example.  If something prevents any change that might
cause buffer_locked() to return false here, we don't need a barrier.
If there is nothing preventing such a change, how is a barrier going
to help?

One way this code could be correct is if the above check is a heuristic,
so that a false positive just consumes a bit more CPU and a false negative
just delays this action.

I must leave final judgment to those having better understanding of this
code than do I.

							Thanx, Paul

>                         int depth;
>                         PROC_INFO_INC(sb, scan_bitmap.wait);
>                         depth = reiserfs_write_unlock_nested(sb);
>                         __wait_on_buffer(bh);
>                         reiserfs_write_lock_nested(sb, depth);
>                 }
>                 BUG_ON(!buffer_uptodate(bh));
>                 BUG_ON(atomic_read(&bh->b_count) == 0);
> 
>                 if (info->free_count == UINT_MAX)
>                         reiserfs_cache_bitmap_metadata(sb, bh, info); <--- this could be moved before buffer_locked if there were no BUG_ONs
> 
> Mikulas
> 
