Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955EA58615F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiGaUlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiGaUlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEBA310550
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659300065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ENXs4KNatAt1vNlNvabUC/2wLtlGpelIh4Gerar+5NA=;
        b=N7M/vNIEmxfGjI8oafvV6wTsTgQd2Pc9inRBOeMySVOySlBdaf1I4XCwSvajZ1x/X7EuTH
        RdnqP3ryZ8XqdU6BmCga87Uhwxc2KlZE44BXNr5f2Mf5h0UbLaCSSKppnVPQcCboDBetq3
        8ndfF4MuYxi3ircq100PlaKenBldpYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-md_PfdAANH-w4tCsf2fmQw-1; Sun, 31 Jul 2022 16:41:00 -0400
X-MC-Unique: md_PfdAANH-w4tCsf2fmQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9AF8185A794;
        Sun, 31 Jul 2022 20:40:59 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFE8118EA8;
        Sun, 31 Jul 2022 20:40:59 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26VKexpW006901;
        Sun, 31 Jul 2022 16:40:59 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26VKexBM006897;
        Sun, 31 Jul 2022 16:40:59 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 31 Jul 2022 16:40:59 -0400 (EDT)
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
Subject: [PATCH v3 1/2] wait_bit: do read barrier after testing a bit
In-Reply-To: <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com> <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com> <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com> <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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

We fix this class of bugs by adding a read barrier after test_bit().

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

Index: linux-2.6/include/linux/wait_bit.h
===================================================================
--- linux-2.6.orig/include/linux/wait_bit.h
+++ linux-2.6/include/linux/wait_bit.h
@@ -71,8 +71,10 @@ static inline int
 wait_on_bit(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit(bit, word)) {
+		smp_rmb();
 		return 0;
+	}
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait,
 				       mode);
@@ -96,8 +98,10 @@ static inline int
 wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit(bit, word)) {
+		smp_rmb();
 		return 0;
+	}
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait_io,
 				       mode);
@@ -123,8 +127,10 @@ wait_on_bit_timeout(unsigned long *word,
 		    unsigned long timeout)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit(bit, word)) {
+		smp_rmb();
 		return 0;
+	}
 	return out_of_line_wait_on_bit_timeout(word, bit,
 					       bit_wait_timeout,
 					       mode, timeout);
@@ -151,8 +157,10 @@ wait_on_bit_action(unsigned long *word,
 		   unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit(bit, word)) {
+		smp_rmb();
 		return 0;
+	}
 	return out_of_line_wait_on_bit(word, bit, action, mode);
 }
 
Index: linux-2.6/kernel/sched/wait_bit.c
===================================================================
--- linux-2.6.orig/kernel/sched/wait_bit.c
+++ linux-2.6/kernel/sched/wait_bit.c
@@ -51,6 +51,8 @@ __wait_on_bit(struct wait_queue_head *wq
 
 	finish_wait(wq_head, &wbq_entry->wq_entry);
 
+	smp_rmb();
+
 	return ret;
 }
 EXPORT_SYMBOL(__wait_on_bit);

