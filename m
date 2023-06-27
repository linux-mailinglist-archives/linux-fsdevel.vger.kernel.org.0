Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB19F74044D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjF0UJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0UJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AAF26BC
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687896521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rnusInJBPW2GEGronAXVDyjVA+cllAQmOUTk55olvn8=;
        b=Eo3jXY5ol5d0I84Hr6lLq/Rp+5RdXR6983YDVaYM+Wcx4ngNNK1e+6TxdUBjXiUVUSMgvs
        OzV5UW+LvPBaD5X7L2upcd0dRbbPScU8X9FOE9Mxa3cWvUPK6KD4l4xAw/UifeewRVO3eV
        9ECMLjq4/uPpcQa+AdJEgGgwuL1WouI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-X3wHMvlBPX6bjTDWtTSNpw-1; Tue, 27 Jun 2023 16:08:37 -0400
X-MC-Unique: X3wHMvlBPX6bjTDWtTSNpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E21B9104D51C;
        Tue, 27 Jun 2023 20:08:35 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B775200BA86;
        Tue, 27 Jun 2023 20:08:35 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 30CBC400F7B5B; Tue, 27 Jun 2023 17:08:15 -0300 (-03)
Date:   Tue, 27 Jun 2023 17:08:15 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: [PATCH] fs/buffer.c: disable per-CPU buffer_head cache for isolated
 CPUs
Message-ID: <ZJtBrybavtb1x45V@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


For certain types of applications (for example PLC software or
RAN processing), upon occurrence of an event, it is necessary to
complete a certain task in a maximum amount of time (deadline).

One way to express this requirement is with a pair of numbers,
deadline time and execution time, where:

        * deadline time: length of time between event and deadline.
        * execution time: length of time it takes for processing of event
                          to occur on a particular hardware platform
                          (uninterrupted).

The particular values depend on use-case. For the case
where the realtime application executes in a virtualized
guest, an IPI which must be serviced in the host will cause
the following sequence of events:

        1) VM-exit
        2) execution of IPI (and function call)
        3) VM-entry

Which causes an excess of 50us latency as observed by cyclictest
(this violates the latency requirement of vRAN application with 1ms TTI,
for example).

invalidate_bh_lrus calls an IPI on each CPU that has non empty
per-CPU cache:

        on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);

The performance when using the per-CPU LRU cache is as follows:

 42 ns per __find_get_block
 68 ns per __find_get_block_slow

Given that the main use cases for latency sensitive applications
do not involve block I/O (data necessary for program operation is 
locked in RAM), disable per-CPU buffer_head caches for isolated CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1..49e9160ce100 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -49,6 +49,7 @@
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
+#include <linux/sched/isolation.h>
 
 #include "internal.h"
 
@@ -1289,7 +1290,7 @@ static void bh_lru_install(struct buffer_head *bh)
 	 * failing page migration.
 	 * Skip putting upcoming bh into bh_lru until migration is done.
 	 */
-	if (lru_cache_disabled()) {
+	if (lru_cache_disabled() || cpu_is_isolated(smp_processor_id())) {
 		bh_lru_unlock();
 		return;
 	}
@@ -1319,6 +1320,10 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 
 	check_irqs_on();
 	bh_lru_lock();
+	if (cpu_is_isolated(smp_processor_id())) {
+		bh_lru_unlock();
+		return NULL;
+	}
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
 

