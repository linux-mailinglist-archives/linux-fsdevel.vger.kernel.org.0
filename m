Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A045867BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 12:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiHAKmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 06:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiHAKm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DF9DD6
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659350542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k1SB3jWY6iy3jPM3BFAzl6DIaTlKQJipefko9OVG/m0=;
        b=bgJ4ddz1WpiMPUmLjyVEHLnHIljYJ1XzikRYX5gux1uY5lPccVpfeqZy4rgdAqJh9p9kl3
        7cF4+Krk5tu8qWt/kWXcwPDdUmQFkTo10qDenKqRqSLCXC7wcEZbWrwgFBX0U12KlFALPE
        2QMbiC1XeVvZ4GvW1Pg/Of+zmZrPA9Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-wUxvdLfDNCm4w7kAkTguWg-1; Mon, 01 Aug 2022 06:42:16 -0400
X-MC-Unique: wUxvdLfDNCm4w7kAkTguWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61620280048A;
        Mon,  1 Aug 2022 10:42:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 544D4C15D67;
        Mon,  1 Aug 2022 10:42:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 271AgFew024213;
        Mon, 1 Aug 2022 06:42:15 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 271AgFCC024209;
        Mon, 1 Aug 2022 06:42:15 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 1 Aug 2022 06:42:15 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Will Deacon <will@kernel.org>,
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
Subject: [PATCH v4 1/2] introduce test_bit_acquire and use it in
 wait_on_bit
In-Reply-To: <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com> <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com> <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com> <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wait_on_bit tests the bit without any memory barriers, consequently the
code that follows wait_on_bit may be moved before testing the bit on
architectures with weak memory ordering. When the code tests for some
event using wait_on_bit and then performs a load operation, the load may
be unexpectedly moved before wait_on_bit and it may return data that
existed before the event occurred.

Such bugs exist in fs/buffer.c:__wait_on_buffer,
drivers/md/dm-bufio.c:new_read,
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:dvb_usb_start_feed,
drivers/bluetooth/btusb.c:btusb_mtk_hci_wmt_sync
and perhaps in other places.

We fix this class of bugs by adding a new function test_bit_acquire that
reads the bit and provides acquire memory ordering semantics.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 arch/s390/include/asm/bitops.h                       |   10 ++++++++++
 arch/x86/include/asm/bitops.h                        |    7 ++++++-
 include/asm-generic/bitops/instrumented-non-atomic.h |   11 +++++++++++
 include/asm-generic/bitops/non-atomic.h              |   13 +++++++++++++
 include/linux/wait_bit.h                             |    8 ++++----
 kernel/sched/wait_bit.c                              |    6 +++---
 6 files changed, 47 insertions(+), 8 deletions(-)

Index: linux-2.6/arch/x86/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
+++ linux-2.6/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
@@ -203,8 +203,10 @@ arch_test_and_change_bit(long nr, volati
 
 static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
-	return ((1UL << (nr & (BITS_PER_LONG-1))) &
+	bool r = ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
+	barrier();
+	return r;
 }
 
 static __always_inline bool variable_test_bit(long nr, volatile const unsigned long *addr)
@@ -224,6 +226,9 @@ static __always_inline bool variable_tes
 	 ? constant_test_bit((nr), (addr))	\
 	 : variable_test_bit((nr), (addr)))
 
+#define arch_test_bit_acquire(nr, addr)		\
+	arch_test_bit(nr, addr)
+
 /**
  * __ffs - find first set bit in word
  * @word: The word to search
Index: linux-2.6/include/asm-generic/bitops/instrumented-non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/instrumented-non-atomic.h	2022-08-01 12:27:43.000000000 +0200
+++ linux-2.6/include/asm-generic/bitops/instrumented-non-atomic.h	2022-08-01 12:28:33.000000000 +0200
@@ -135,4 +135,15 @@ static __always_inline bool test_bit(lon
 	return arch_test_bit(nr, addr);
 }
 
+/**
+ * test_bit_acquire - Determine whether a bit is set with acquire semantics
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static __always_inline bool test_bit_acquire(long nr, const volatile unsigned long *addr)
+{
+	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
+	return arch_test_bit_acquire(nr, addr);
+}
+
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
Index: linux-2.6/include/asm-generic/bitops/non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/non-atomic.h	2022-08-01 12:27:43.000000000 +0200
+++ linux-2.6/include/asm-generic/bitops/non-atomic.h	2022-08-01 12:27:43.000000000 +0200
@@ -119,4 +119,17 @@ arch_test_bit(unsigned int nr, const vol
 }
 #define test_bit arch_test_bit
 
+/**
+ * arch_test_bit - Determine whether a bit is set with acquire semantics
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static __always_inline int
+arch_test_bit_acquire(unsigned int nr, const volatile unsigned long *addr)
+{
+	unsigned val = smp_load_acquire(&addr[BIT_WORD(nr)]);
+	return 1UL & (val >> (nr & (BITS_PER_LONG-1)));
+}
+#define test_bit_acquire arch_test_bit_acquire
+
 #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
Index: linux-2.6/arch/s390/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
+++ linux-2.6/arch/s390/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
@@ -184,6 +184,16 @@ static inline bool arch_test_bit(unsigne
 	return *addr & mask;
 }
 
+static inline bool arch_test_bit_acquire(unsigned long nr,
+					 const volatile unsigned long *ptr)
+{
+	const volatile unsigned long *addr = __bitops_word(nr, ptr);
+	unsigned long val = smp_load_acquire(addr);
+	unsigned long mask = __bitops_mask(nr);
+
+	return val & mask;
+}
+
 static inline bool arch_test_and_set_bit_lock(unsigned long nr,
 					      volatile unsigned long *ptr)
 {
Index: linux-2.6/include/linux/wait_bit.h
===================================================================
--- linux-2.6.orig/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
+++ linux-2.6/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
@@ -71,7 +71,7 @@ static inline int
 wait_on_bit(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait,
@@ -96,7 +96,7 @@ static inline int
 wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait_io,
@@ -123,7 +123,7 @@ wait_on_bit_timeout(unsigned long *word,
 		    unsigned long timeout)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit_timeout(word, bit,
 					       bit_wait_timeout,
@@ -151,7 +151,7 @@ wait_on_bit_action(unsigned long *word,
 		   unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit, action, mode);
 }
Index: linux-2.6/kernel/sched/wait_bit.c
===================================================================
--- linux-2.6.orig/kernel/sched/wait_bit.c	2022-08-01 12:27:43.000000000 +0200
+++ linux-2.6/kernel/sched/wait_bit.c	2022-08-01 12:27:43.000000000 +0200
@@ -25,7 +25,7 @@ int wake_bit_function(struct wait_queue_
 
 	if (wait_bit->key.flags != key->flags ||
 			wait_bit->key.bit_nr != key->bit_nr ||
-			test_bit(key->bit_nr, key->flags))
+			test_bit_acquire(key->bit_nr, key->flags))
 		return 0;
 
 	return autoremove_wake_function(wq_entry, mode, sync, key);
@@ -45,9 +45,9 @@ __wait_on_bit(struct wait_queue_head *wq
 
 	do {
 		prepare_to_wait(wq_head, &wbq_entry->wq_entry, mode);
-		if (test_bit(wbq_entry->key.bit_nr, wbq_entry->key.flags))
+		if (test_bit_acquire(wbq_entry->key.bit_nr, wbq_entry->key.flags))
 			ret = (*action)(&wbq_entry->key, mode);
-	} while (test_bit(wbq_entry->key.bit_nr, wbq_entry->key.flags) && !ret);
+	} while (test_bit_acquire(wbq_entry->key.bit_nr, wbq_entry->key.flags) && !ret);
 
 	finish_wait(wq_head, &wbq_entry->wq_entry);
 

