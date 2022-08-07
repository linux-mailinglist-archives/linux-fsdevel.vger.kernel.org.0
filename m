Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD558BAAA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Aug 2022 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiHGLhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Aug 2022 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiHGLhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Aug 2022 07:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF2F264E0
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Aug 2022 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659872251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o1EMRzMlY6/eJQLdXyI2BRTqKZiVN5D0fmDyLdtZOXU=;
        b=P4I9YvCELila31csKEyclRcTazUVTc3sKKiT0kc0/+rFJjtHohNNV5WFMNtQtj20PD+mkp
        U1JyE35Fv7gWN1PIdgcZrdhdS4GU3uzZnK7G7hgzQGRoHUnSGDuPXUZaGNAdaGKA3mARy8
        coKp+1g7AKpC4S/+Yv8Am2k6nwHJoQ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-BMw6k7YDOjC-6Vds6LUy8g-1; Sun, 07 Aug 2022 07:37:27 -0400
X-MC-Unique: BMw6k7YDOjC-6Vds6LUy8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1588F3C021AD;
        Sun,  7 Aug 2022 11:37:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3AFB403D0E2;
        Sun,  7 Aug 2022 11:37:24 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 277BbOAm030983;
        Sun, 7 Aug 2022 07:37:24 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 277BbMZf030978;
        Sun, 7 Aug 2022 07:37:23 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 7 Aug 2022 07:37:22 -0400 (EDT)
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
Subject: [PATCH v5] add barriers to buffer functions
In-Reply-To: <YuyNE5c06WStxQ2z@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com> <YuflGG60pHiXp2z/@casper.infradead.org> <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
 <YuyNE5c06WStxQ2z@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Fri, 5 Aug 2022, Matthew Wilcox wrote:

> On Mon, Aug 01, 2022 at 11:01:40AM -0400, Mikulas Patocka wrote:
> > 
> > In most cases, the buffer is set uptodate while it is locked, so that 
> > there is no race on the uptodate flag (the race exists on the locked 
> > flag). Are there any cases where the uptodate flag is modified on unlocked 
> > buffer, so that it needs special treatment too?
> 
> I think you misunderstand the purpose of locked/uptodate.  At least
> for pages, the lock flag does not order access to the data in the page.
> Indeed, the contents of the page can be changed while you hold the lock.
> But the uptodate flag does order access to the data.  At the point where
> you can observe the uptodate flag set, you know the contents of the page
> have been completely read from storage.  And you don't need to hold the
> lock to check the uptodate flag.  So this is wrong:
> 
> 	buffer_lock()
> 	*data = 0x12345678;
> 	buffer_set_uptodate_not_ordered()
> 	buffer_unlock_ordered()
> 
> because a reader can do:
> 
> 	while (!buffer_test_uptodate()) {
> 		buffer_lock();
> 		buffer_unlock();
> 	}
> 	x = *data;
> 
> and get x != 0x12345678 because the compiler can move the
> buffer_set_uptodate_not_ordered() before the store to *data.

Thanks for explanation. Would you like this patch?



From: Mikulas Patocka <mpatocks@redhat.com>

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

Fix this bug by adding a write memory barrier to set_buffer_uptodate and a
read memory barrier to buffer_uptodate (in the same way as
folio_test_uptodate and folio_mark_uptodate).

We also add a barrier to buffer_locked - it pairs with a barrier in
unlock_buffer.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -117,10 +117,8 @@ static __always_inline int test_clear_bu
  * of the form "mark_buffer_foo()".  These are higher-level functions which
  * do something in addition to setting a b_state bit.
  */
-BUFFER_FNS(Uptodate, uptodate)
 BUFFER_FNS(Dirty, dirty)
 TAS_BUFFER_FNS(Dirty, dirty)
-BUFFER_FNS(Lock, locked)
 BUFFER_FNS(Req, req)
 TAS_BUFFER_FNS(Req, req)
 BUFFER_FNS(Mapped, mapped)
@@ -135,6 +133,49 @@ BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
 
+static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
+{
+	/*
+	 * make it consistent with folio_mark_uptodate
+	 * pairs with smp_acquire__after_ctrl_dep in buffer_uptodate
+	 */
+	smp_wmb();
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
+	bool ret = test_bit(BH_Uptodate, &bh->b_state);
+	/*
+	 * make it consistent with folio_test_uptodate
+	 * pairs with smp_wmb in set_buffer_uptodate
+	 */
+	if (ret)
+		smp_acquire__after_ctrl_dep();
+	return ret;
+}
+
+static __always_inline void set_buffer_locked(struct buffer_head *bh)
+{
+	set_bit(BH_Lock, &bh->b_state);
+}
+
+static __always_inline int buffer_locked(const struct buffer_head *bh)
+{
+	bool ret = test_bit(BH_Lock, &bh->b_state);
+	/*
+	 * pairs with smp_mb__after_atomic in unlock_buffer
+	 */
+	if (!ret)
+		smp_acquire__after_ctrl_dep();
+	return ret;
+}
+
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
 /* If we *know* page->private refers to buffer_heads */

