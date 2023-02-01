Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E5686B14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjBAQEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 11:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjBAQEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:04:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6711E3D92E
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675267437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AiUOCdYZiZ0EhpszTzQvWhcI8sDqoZDTm+/tkKX62Oo=;
        b=VP5TzDkf9S18e+CqoEBlbpvYRu1JILNva9zV/GxWD2JgohizIlmqPhMhlt8sBgKQAvQC1T
        zoyz+prHnfS4QtfMS4tvYtXFSJVW72dKr++hBpW9kphsI+ltjy73s7e280m7Af9bwIK120
        oqY/UE0Z16IYCki4gYzibc7SoylFk6w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-hY-NQHINNpGkAjV3mvyciA-1; Wed, 01 Feb 2023 11:03:54 -0500
X-MC-Unique: hY-NQHINNpGkAjV3mvyciA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E1DE38149AB;
        Wed,  1 Feb 2023 16:03:53 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9741D404BEC4;
        Wed,  1 Feb 2023 16:03:52 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 30599403CC75B; Wed,  1 Feb 2023 13:01:47 -0300 (-03)
Date:   Wed, 1 Feb 2023 13:01:47 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: [PATCH v3] fs/buffer.c: update per-CPU bh_lru cache via RCU
Message-ID: <Y9qM68F+nDSYfrJ1@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


umount calls invalidate_bh_lrus which IPIs each
CPU that has non empty per-CPU buffer_head cache:

       	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);

This interrupts CPUs which might be executing code sensitive
to interferences.

To avoid the IPI, free the per-CPU caches remotely via RCU.
Two bh_lrus structures for each CPU are allocated: one is being
used (assigned to per-CPU bh_lru pointer), and the other is
being freed (or idle).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v3: fix CPU hotplug 
v2: fix sparse warnings (kernel test robot)

diff --git a/fs/buffer.c b/fs/buffer.c
index d9c6d1fbb6dd..0c54ffe9fd62 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1203,7 +1203,21 @@ struct bh_lru {
 	struct buffer_head *bhs[BH_LRU_SIZE];
 };
 
-static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
+
+/*
+ * Allocate two bh_lrus structures for each CPU. bh_lru points to the
+ * one that is currently in use, and the update path does
+ * (consider cpu->bh_lru = bh_lrus[0]).
+ *
+ * cpu->bh_lrup = bh_lrus[1]
+ * synchronize_rcu()
+ * free bh's in bh_lrus[0]
+ */
+static unsigned int bh_lru_idx;
+static DEFINE_PER_CPU(struct bh_lru, bh_lrus[2]) = {{{ NULL }}, {{NULL}}};
+static DEFINE_PER_CPU(struct bh_lru __rcu *, bh_lrup);
+
+static DEFINE_MUTEX(bh_lru_invalidate_mutex);
 
 #ifdef CONFIG_SMP
 #define bh_lru_lock()	local_irq_disable()
@@ -1245,16 +1259,19 @@ static void bh_lru_install(struct buffer_head *bh)
 		return;
 	}
 
-	b = this_cpu_ptr(&bh_lrus);
+	rcu_read_lock();
+	b = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		swap(evictee, b->bhs[i]);
 		if (evictee == bh) {
+			rcu_read_unlock();
 			bh_lru_unlock();
 			return;
 		}
 	}
 
 	get_bh(bh);
+	rcu_read_unlock();
 	bh_lru_unlock();
 	brelse(evictee);
 }
@@ -1266,28 +1283,32 @@ static struct buffer_head *
 lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 {
 	struct buffer_head *ret = NULL;
+	struct bh_lru *lru;
 	unsigned int i;
 
 	check_irqs_on();
 	bh_lru_lock();
+	rcu_read_lock();
+
+	lru = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
 	for (i = 0; i < BH_LRU_SIZE; i++) {
-		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
+		struct buffer_head *bh = lru->bhs[i];
 
 		if (bh && bh->b_blocknr == block && bh->b_bdev == bdev &&
 		    bh->b_size == size) {
 			if (i) {
 				while (i) {
-					__this_cpu_write(bh_lrus.bhs[i],
-						__this_cpu_read(bh_lrus.bhs[i - 1]));
+					lru->bhs[i] = lru->bhs[i - 1];
 					i--;
 				}
-				__this_cpu_write(bh_lrus.bhs[0], bh);
+				lru->bhs[0] = bh;
 			}
 			get_bh(bh);
 			ret = bh;
 			break;
 		}
 	}
+	rcu_read_unlock();
 	bh_lru_unlock();
 	return ret;
 }
@@ -1381,35 +1402,54 @@ static void __invalidate_bh_lrus(struct bh_lru *b)
 		b->bhs[i] = NULL;
 	}
 }
-/*
- * invalidate_bh_lrus() is called rarely - but not only at unmount.
- * This doesn't race because it runs in each cpu either in irq
- * or with preempt disabled.
- */
-static void invalidate_bh_lru(void *arg)
-{
-	struct bh_lru *b = &get_cpu_var(bh_lrus);
-
-	__invalidate_bh_lrus(b);
-	put_cpu_var(bh_lrus);
-}
 
 bool has_bh_in_lru(int cpu, void *dummy)
 {
-	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
+	struct bh_lru *b;
 	int i;
-	
+
+	rcu_read_lock();
+	b = rcu_dereference(per_cpu(bh_lrup, cpu));
 	for (i = 0; i < BH_LRU_SIZE; i++) {
-		if (b->bhs[i])
+		if (b->bhs[i]) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
 
+	rcu_read_unlock();
 	return false;
 }
 
+/*
+ * invalidate_bh_lrus() is called rarely - but not only at unmount.
+ */
 void invalidate_bh_lrus(void)
 {
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
+	int cpu, oidx;
+
+	mutex_lock(&bh_lru_invalidate_mutex);
+	cpus_read_lock();
+	oidx = bh_lru_idx;
+	bh_lru_idx++;
+	if (bh_lru_idx >= 2)
+		bh_lru_idx = 0;
+
+	/* Assign the per-CPU bh_lru pointer */
+	for_each_online_cpu(cpu)
+		rcu_assign_pointer(per_cpu(bh_lrup, cpu),
+				   per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));
+	synchronize_rcu_expedited();
+
+	for_each_online_cpu(cpu) {
+		struct bh_lru *b = per_cpu_ptr(&bh_lrus[oidx], cpu);
+
+		bh_lru_lock();
+		__invalidate_bh_lrus(b);
+		bh_lru_unlock();
+	}
+	cpus_read_unlock();
+	mutex_unlock(&bh_lru_invalidate_mutex);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
@@ -1422,8 +1462,10 @@ void invalidate_bh_lrus_cpu(void)
 	struct bh_lru *b;
 
 	bh_lru_lock();
-	b = this_cpu_ptr(&bh_lrus);
+	rcu_read_lock();
+	b = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
 	__invalidate_bh_lrus(b);
+	rcu_read_unlock();
 	bh_lru_unlock();
 }
 
@@ -2920,15 +2962,25 @@ void free_buffer_head(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(free_buffer_head);
 
+static int buffer_cpu_online(unsigned int cpu)
+{
+	rcu_assign_pointer(per_cpu(bh_lrup, cpu),
+			   per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));
+	return 0;
+}
+
 static int buffer_exit_cpu_dead(unsigned int cpu)
 {
 	int i;
-	struct bh_lru *b = &per_cpu(bh_lrus, cpu);
+	struct bh_lru *b;
 
+	rcu_read_lock();
+	b = rcu_dereference(per_cpu(bh_lrup, cpu));
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		brelse(b->bhs[i]);
 		b->bhs[i] = NULL;
 	}
+	rcu_read_unlock();
 	this_cpu_add(bh_accounting.nr, per_cpu(bh_accounting, cpu).nr);
 	per_cpu(bh_accounting, cpu).nr = 0;
 	return 0;
@@ -3021,7 +3073,7 @@ EXPORT_SYMBOL(__bh_read_batch);
 void __init buffer_init(void)
 {
 	unsigned long nrpages;
-	int ret;
+	int ret, cpu;
 
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,
@@ -3029,6 +3081,11 @@ void __init buffer_init(void)
 				SLAB_MEM_SPREAD),
 				NULL);
 
+	cpus_read_lock();
+	for_each_online_cpu(cpu)
+		rcu_assign_pointer(per_cpu(bh_lrup, cpu), per_cpu_ptr(&bh_lrus[0], cpu));
+	cpus_read_unlock();
+
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
 	 */
@@ -3037,4 +3094,7 @@ void __init buffer_init(void)
 	ret = cpuhp_setup_state_nocalls(CPUHP_FS_BUFF_DEAD, "fs/buffer:dead",
 					NULL, buffer_exit_cpu_dead);
 	WARN_ON(ret < 0);
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "fs/buffer:online",
+					NULL, buffer_cpu_online);
+	WARN_ON(ret < 0);
 }

