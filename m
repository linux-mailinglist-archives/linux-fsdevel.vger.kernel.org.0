Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41A858CB64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 17:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbiHHPjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiHHPjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:39:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3267A6599;
        Mon,  8 Aug 2022 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XPl7JeNLjk9TMLNSixLvsZ+qQ4KPho8175mhT8bLnNk=; b=v4A/aroBq0LryFSV4/Iuj+CePP
        m/2j3fglEbks9mGRfNYBKV1iPkq4IN5rhOjpm0HbxzULHD5jnaFMgRAPHKslHdSoLpNu/EeMoSlPh
        Fiw8j16eHxehCM4fUs4fmZGWoIPT3QBwfDIb7mf4jTpi6wNzh8WeYqnPPA6Q2cobwzksPSMHlfISN
        qHg7OoKxEAGDU0SJwE2PYxHs17+jtZDyfXK8/VXUM29uMieBz7YRX7kUsh0R05Y+oJUMnWGeomNSL
        aWdkuecqof+I8HtG9vXkzgVxrpfVXl9vA4YCIsmMFWiHr6TKpDaD8qOtWmJ5gRH2VXxPQA3W5Nc9L
        GDJWprLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oL4qY-00E1Vg-4F; Mon, 08 Aug 2022 15:39:14 +0000
Date:   Mon, 8 Aug 2022 16:39:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <YvEuIg3669UeSwjD@casper.infradead.org>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:57:45AM -0400, Mikulas Patocka wrote:
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

That's my feeling.  Of course, you might not be the only one confused,
and if fs authors in general have made the mistake of thinking that
buffer_locked is serialising, then it might be better to live up to
that expectation.

> There is also this (where the BUG_ON(!buffer_uptodate(bh)) saves it).
>                 if (buffer_locked(bh)) {
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

It could be moved before buffer_locked(), but I don't see the harm in
that.  Look at how reiserfs_read_bitmap_block() gets the bh:

        bh = sb_bread(sb, block);

__bread_gfp() has either already read the buffer (and it's uptodate),
in which case it returns it.  Or it calls __bread_slow() which will do
the read and check uptodate before returning it.  I wouldn't be surprised
to find that this buffer_locked() check is actually dead code, but I have
no desire to dive into reiserfs far enough to find out whether it's dead
code or not.
