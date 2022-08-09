Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149558DF97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 21:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbiHITAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbiHIS7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8131C26ACA
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660069942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k+BeaTfVMUnsn/KH0avfSZ9dOxb93xKAhJDQYTFb27o=;
        b=LrRM6kw0CGVHYARhhCVuFVwvtL+88C7mxqEjUasZN65EBOf4vpkMm0DniWILNeCTWHEiom
        eC0IFUN348mEb0xdoM7kHfDOESGKiPdN9w+d/dII9aX79GmsQh8kjd32FUBZYn/zeRZfVO
        n4KIL82ASNr3uhdg3BThyuyJeWQ0q7M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-K9PfdN9eOnipk3nuBQkONg-1; Tue, 09 Aug 2022 14:32:17 -0400
X-MC-Unique: K9PfdN9eOnipk3nuBQkONg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20F2B3C10226;
        Tue,  9 Aug 2022 18:32:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC6B9492C3B;
        Tue,  9 Aug 2022 18:32:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 279IWE3A015903;
        Tue, 9 Aug 2022 14:32:14 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 279IWDHD015899;
        Tue, 9 Aug 2022 14:32:14 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 9 Aug 2022 14:32:13 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [PATCH v6] add barriers to buffer_uptodate and set_buffer_uptodate
In-Reply-To: <YvEuIg3669UeSwjD@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2208091359220.5899@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com> <YuflGG60pHiXp2z/@casper.infradead.org> <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
 <YuyNE5c06WStxQ2z@casper.infradead.org> <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com> <Yu/RJtoJPhkWXIdP@casper.infradead.org> <alpine.LRH.2.02.2208080928580.8160@file01.intranet.prod.int.rdu2.redhat.com>
 <YvEgZuSdv8XHtkJg@casper.infradead.org> <alpine.LRH.2.02.2208081050330.8160@file01.intranet.prod.int.rdu2.redhat.com> <YvEuIg3669UeSwjD@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 8 Aug 2022, Matthew Wilcox wrote:

> On Mon, Aug 08, 2022 at 10:57:45AM -0400, Mikulas Patocka wrote:
> > On Mon, 8 Aug 2022, Matthew Wilcox wrote:
> > 
> > > On Mon, Aug 08, 2022 at 10:26:10AM -0400, Mikulas Patocka wrote:
> > > > On Sun, 7 Aug 2022, Matthew Wilcox wrote:
> > > > > > +static __always_inline void set_buffer_locked(struct buffer_head *bh)
> > > > > > +{
> > > > > > +	set_bit(BH_Lock, &bh->b_state);
> > > > > > +}
> > > > > > +
> > > > > > +static __always_inline int buffer_locked(const struct buffer_head *bh)
> > > > > > +{
> > > > > > +	bool ret = test_bit(BH_Lock, &bh->b_state);
> > > > > > +	/*
> > > > > > +	 * pairs with smp_mb__after_atomic in unlock_buffer
> > > > > > +	 */
> > > > > > +	if (!ret)
> > > > > > +		smp_acquire__after_ctrl_dep();
> > > > > > +	return ret;
> > > > > > +}
> > > > > 
> > > > > Are there places that think that lock/unlock buffer implies a memory
> > > > > barrier?
> > > > 
> > > > There's this in fs/reiserfs:
> > > > 
> > > > if (!buffer_dirty(bh) && !buffer_locked(bh)) {
> > > > 	reiserfs_free_jh(bh); <--- this could be moved before buffer_locked
> > > 
> > > It might be better to think of buffer_locked() as
> > > buffer_someone_has_exclusive_access().  I can't see the problem with
> > > moving the reads in reiserfs_free_jh() before the read of buffer_locked.
> > > 
> > > > if (buffer_locked((journal->j_header_bh))) {
> > > > 	...
> > > > }
> > > > journal->j_last_flush_trans_id = trans_id;
> > > > journal->j_first_unflushed_offset = offset;
> > > > jh = (struct reiserfs_journal_header *)(journal->j_header_bh->b_data); <--- this could be moved before buffer_locked
> > > 
> > > I don't think b_data is going to be changed while someone else holds
> > > the buffer locked.  That's initialised by set_bh_page(), which is an
> > > initialisation-time thing, before the BH is visible to any other thread.
> > 
> > So, do you think that we don't need a barrier in buffer_locked()?
> 
> That's my feeling.  Of course, you might not be the only one confused,
> and if fs authors in general have made the mistake of thinking that
> buffer_locked is serialising, then it might be better to live up to
> that expectation.

In my spadfs filesystem, I used lock_buffer/unlock_buffer to prevent the 
system from seeing or writing back incomplete data. The patterns is
	lock_buffer(bh);
	... do several changes to the buffer that should appear atomically
	unlock_buffer(bh);
	mark_buffer_dirty(bh);
but it seems to be ok, because both lock_buffer and unlock_buffer have 
acquire/release semantics. I'm not sure about buffer_locked - perhaps it 
really doesn't need the barriers - spin_is_locked, mutex_is_locked and 
rwsem_is_locked also don't have any barriers.

Here I'm sending the patch without the change to buffer_locked.

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

Let's have a look at this piece of code in __bread_slow:
	get_bh(bh);
	bh->b_end_io = end_buffer_read_sync;
	submit_bh(REQ_OP_READ, 0, bh);
	wait_on_buffer(bh);
	if (buffer_uptodate(bh))
		return bh;
Neither wait_on_buffer nor buffer_uptodate contain any memory barrier.
Consequently, if someone calls sb_bread and then reads the buffer data,
the read of buffer data may be executed before wait_on_buffer(bh) on
architectures with weak memory ordering and it may return invalid data.

Fix this bug by adding a memory barrier to set_buffer_uptodate and an
acquire barrier to buffer_uptodate (in a similar way as
folio_test_uptodate and folio_mark_uptodate).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -117,7 +117,6 @@ static __always_inline int test_clear_bu
  * of the form "mark_buffer_foo()".  These are higher-level functions which
  * do something in addition to setting a b_state bit.
  */
-BUFFER_FNS(Uptodate, uptodate)
 BUFFER_FNS(Dirty, dirty)
 TAS_BUFFER_FNS(Dirty, dirty)
 BUFFER_FNS(Lock, locked)
@@ -135,6 +134,30 @@ BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
 
+static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
+{
+	/*
+	 * make it consistent with folio_mark_uptodate
+	 * pairs with smp_load_acquire in buffer_uptodate
+	 */
+	smp_mb__before_atomic();
+	set_bit(BH_Uptodate, &bh->b_state);
+}
+
+static __always_inline void clear_buffer_uptodate(struct buffer_head *bh)
+{
+	clear_bit(BH_Uptodate, &bh->b_state);
+}
+
+static __always_inline int buffer_uptodate(const struct buffer_head *bh)
+{
+	/*
+	 * make it consistent with folio_test_uptodate
+	 * pairs with smp_mb__before_atomic in set_buffer_uptodate
+	 */
+	return (smp_load_acquire(&bh->b_state) & (1UL << BH_Uptodate)) != 0;
+}
+
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
 /* If we *know* page->private refers to buffer_heads */

