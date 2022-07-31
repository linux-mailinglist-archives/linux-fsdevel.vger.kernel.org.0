Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23B585F67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiGaPIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGaPIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8F55BF71
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659280090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qwgOflw1XbrvVIGX1NtZYJq0Zdca6rMcXu+6e4uFK6A=;
        b=FqSlOsvyhgzVyzUZefTawm9mFGhEh0a70o912KP/yAD4EvYBA/A16YpOpdKAtlKiMXpTZD
        i02Q4WL3FKdIBhnAJYHRNVWmMt8Lp6Z5WKBcdJUt1QQydbLPkfwijgyo4MDhtYMp+kXWm5
        ebcwuVW8v7VnejrHoSsSxb3daHuZJ4I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-cSECzgojN3ayQWbNcLgCaA-1; Sun, 31 Jul 2022 11:08:07 -0400
X-MC-Unique: cSECzgojN3ayQWbNcLgCaA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D0DF3C02B7D;
        Sun, 31 Jul 2022 15:08:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D8DE492C3B;
        Sun, 31 Jul 2022 15:08:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26VF86R8016557;
        Sun, 31 Jul 2022 11:08:06 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26VF846u016553;
        Sun, 31 Jul 2022 11:08:04 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 31 Jul 2022 11:08:04 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] make buffer_locked provide an acquire semantics
In-Reply-To: <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com> <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com> <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The only problem is that test_bit doesn't provide any memory barriers. 
> Should we add the barrier to buffer_locked() instead of wait_on_buffer()? 
> Perhaps it would fix more bugs - in reiserfs, there's this piece of code:

Her I'm sending the second version of the patch that changes buffer_locked 
to provide an acquire semantics.

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

Also, there is this pattern present several times:
	wait_on_buffer(bh);
	if (!buffer_uptodate(bh))
		err = -EIO;
It may be possible that buffer_uptodate is executed before wait_on_buffer
and it may return spurious error.

Fix these bugs by chaning the function buffer_locked to have the acquire
semantics - so that code that follows buffer_locked cannot be moved before
it. We must also add a read barrier after wait_on_bit_io because
wait_on_bit_io doesn't provide any barrier. (perhaps, should this
smp_rmb() be moved into wait_on_bit_io?)

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -120,7 +120,6 @@ static __always_inline int test_clear_bu
 BUFFER_FNS(Uptodate, uptodate)
 BUFFER_FNS(Dirty, dirty)
 TAS_BUFFER_FNS(Dirty, dirty)
-BUFFER_FNS(Lock, locked)
 BUFFER_FNS(Req, req)
 TAS_BUFFER_FNS(Req, req)
 BUFFER_FNS(Mapped, mapped)
@@ -135,6 +134,17 @@ BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
 
+static __always_inline void set_buffer_locked(struct buffer_head *bh)
+{
+	set_bit(BH_Lock, &bh->b_state);
+}
+
+static __always_inline int buffer_locked(const struct buffer_head *bh)
+{
+	unsigned long state = smp_load_acquire(&bh->b_state);
+	return test_bit(BH_Lock, &state);
+}
+
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
 /* If we *know* page->private refers to buffer_heads */
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -120,6 +120,7 @@ EXPORT_SYMBOL(buffer_check_dirty_writeba
 void __wait_on_buffer(struct buffer_head * bh)
 {
 	wait_on_bit_io(&bh->b_state, BH_Lock, TASK_UNINTERRUPTIBLE);
+	smp_rmb();
 }
 EXPORT_SYMBOL(__wait_on_buffer);
 

