Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B77B3DDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 05:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjI3Dmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 23:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjI3Dmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:42:51 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B758F
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:42:49 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a2536adaf3so5446197b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696045368; x=1696650168; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2x6fH+w1PdDZvpTev5khLvy5t3y2+BALqf/PDla7s+s=;
        b=KDXuLjk9D3qhT2wExeqdG8th+lOtxMeAclFPpxw8Eplb+nuCJ1qj2C+wlM8Vnp4Q+s
         5vh+3t3SxmP41GhssWSZpCjIG40O0JH2t0ACsKhF2hQtVNpf9OguwKMtxFLTPjtGtKg5
         AzymlDy38Gz4I5ApfOtFiQ6H3YNVRJ5vTceGXaGciuWzPgPBSqpe6dsg2Z/dv+cGF46G
         p1ElRPE1/+n0bb9P/Rs7Zkhw+34L6Vk2Bkr9iS7SaaosTcBNG6OJfpA0stcivAeo1PW1
         hzA7calsNJNQeTy37dthP2VWY4Sbd/3s9FH/l/x6a+5gkb03En7M3eQV5KYcjduXk/5R
         ackw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696045368; x=1696650168;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2x6fH+w1PdDZvpTev5khLvy5t3y2+BALqf/PDla7s+s=;
        b=AYMQk8jyI21NjPgGtwGgTqbj0dPoS83pSjJNbYmVZ2zL6TCXUFbcLPzG4ubDNNs81c
         OhRvy1mzIJ5mxpBHZ/+bdGPOxeT8uG+dbHyiejIC1DRlHJl36Uu8xaGuWFrmfwoalIDb
         862LR7cGeLjA4Kg3TekYMedgPIrJMdULsR/SHvqS8WcC08rUxbXSzKwOMmxi1aKNtYkD
         zkNJ6zd45SuskVAtUt+wv57JfdlawYOg2OVJG5wE2ZtkmbNR8GF4nbYjUhQDIrjgtY4o
         eVzz5xjfX/WhSUtHG9zgZEfZ+qqVwT6Sh2HrGY16s8jG3Kg2oiJiwwUq+U8ceDhQChW2
         t/VQ==
X-Gm-Message-State: AOJu0YyffJojI5TvAen8hpokmaJHwpQA4m4rBrQZ7r++hll7Iv5bJfZV
        U61H698I+195shYAjum2VP0EPg==
X-Google-Smtp-Source: AGHT+IHb14+lcWYvYpZ5abpN3vaue9DpNWsOHa4WiXVhBeSyALADDXCj4J3VWtqEBUCWVKYnyTLA1A==
X-Received: by 2002:a81:a24e:0:b0:59b:5170:a0f3 with SMTP id z14-20020a81a24e000000b0059b5170a0f3mr5957990ywg.36.1696045368515;
        Fri, 29 Sep 2023 20:42:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f184-20020a0dc3c1000000b0059ae483b89dsm5983309ywd.50.2023.09.29.20.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 20:42:47 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:42:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Tim Chen <tim.c.chen@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
In-Reply-To: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
Message-ID: <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Percpu counter's compare and add are separate functions: without locking
around them (which would defeat their purpose), it has been possible to
overflow the intended limit.  Imagine all the other CPUs fallocating
tmpfs huge pages to the limit, in between this CPU's compare and its add.

I have not seen reports of that happening; but tmpfs's recent addition
of dquot_alloc_block_nodirty() in between the compare and the add makes
it even more likely, and I'd be uncomfortable to leave it unfixed.

Introduce percpu_counter_limited_add(fbc, limit, amount) to prevent it.

I believe this implementation is correct, and slightly more efficient
than the combination of compare and add (taking the lock once rather
than twice when nearing full - the last 128MiB of a tmpfs volume on a
machine with 128 CPUs and 4KiB pages); but it does beg for a better
design - when nearing full, there is no new batching, but the costly
percpu counter sum across CPUs still has to be done, while locked.

Follow __percpu_counter_sum()'s example, including cpu_dying_mask as
well as cpu_online_mask: but shouldn't __percpu_counter_compare() and
__percpu_counter_limited_add() then be adding a num_dying_cpus() to
num_online_cpus(), when they calculate the maximum which could be held
across CPUs?  But the times when it matters would be vanishingly rare.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Darrick J. Wong <djwong@kernel.org>
---
Tim, Dave, Darrick: I didn't want to waste your time on patches 1-7,
which are just internal to shmem, and do not affect this patch (which
applies to v6.6-rc and linux-next as is): but want to run this by you.

 include/linux/percpu_counter.h | 23 +++++++++++++++
 lib/percpu_counter.c           | 53 ++++++++++++++++++++++++++++++++++
 mm/shmem.c                     | 10 +++----
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index d01351b1526f..8cb7c071bd5c 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -57,6 +57,8 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
 int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
+bool __percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit,
+				  s64 amount, s32 batch);
 void percpu_counter_sync(struct percpu_counter *fbc);
 
 static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
@@ -69,6 +71,13 @@ static inline void percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 	percpu_counter_add_batch(fbc, amount, percpu_counter_batch);
 }
 
+static inline bool
+percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit, s64 amount)
+{
+	return __percpu_counter_limited_add(fbc, limit, amount,
+					    percpu_counter_batch);
+}
+
 /*
  * With percpu_counter_add_local() and percpu_counter_sub_local(), counts
  * are accumulated in local per cpu counter and not in fbc->count until
@@ -185,6 +194,20 @@ percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 	local_irq_restore(flags);
 }
 
+static inline bool
+percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit, s64 amount)
+{
+	unsigned long flags;
+	s64 count;
+
+	local_irq_save(flags);
+	count = fbc->count + amount;
+	if (count <= limit)
+		fbc->count = count;
+	local_irq_restore(flags);
+	return count <= limit;
+}
+
 /* non-SMP percpu_counter_add_local is the same with percpu_counter_add */
 static inline void
 percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 9073430dc865..58a3392f471b 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -278,6 +278,59 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
 }
 EXPORT_SYMBOL(__percpu_counter_compare);
 
+/*
+ * Compare counter, and add amount if the total is within limit.
+ * Return true if amount was added, false if it would exceed limit.
+ */
+bool __percpu_counter_limited_add(struct percpu_counter *fbc,
+				  s64 limit, s64 amount, s32 batch)
+{
+	s64 count;
+	s64 unknown;
+	unsigned long flags;
+	bool good;
+
+	if (amount > limit)
+		return false;
+
+	local_irq_save(flags);
+	unknown = batch * num_online_cpus();
+	count = __this_cpu_read(*fbc->counters);
+
+	/* Skip taking the lock when safe */
+	if (abs(count + amount) <= batch &&
+	    fbc->count + unknown <= limit) {
+		this_cpu_add(*fbc->counters, amount);
+		local_irq_restore(flags);
+		return true;
+	}
+
+	raw_spin_lock(&fbc->lock);
+	count = fbc->count + amount;
+
+	/* Skip percpu_counter_sum() when safe */
+	if (count + unknown > limit) {
+		s32 *pcount;
+		int cpu;
+
+		for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
+			pcount = per_cpu_ptr(fbc->counters, cpu);
+			count += *pcount;
+		}
+	}
+
+	good = count <= limit;
+	if (good) {
+		count = __this_cpu_read(*fbc->counters);
+		fbc->count += count + amount;
+		__this_cpu_sub(*fbc->counters, count);
+	}
+
+	raw_spin_unlock(&fbc->lock);
+	local_irq_restore(flags);
+	return good;
+}
+
 static int __init percpu_counter_startup(void)
 {
 	int ret;
diff --git a/mm/shmem.c b/mm/shmem.c
index 4f4ab26bc58a..7cb72c747954 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -217,15 +217,15 @@ static int shmem_inode_acct_blocks(struct inode *inode, long pages)
 
 	might_sleep();	/* when quotas */
 	if (sbinfo->max_blocks) {
-		if (percpu_counter_compare(&sbinfo->used_blocks,
-					   sbinfo->max_blocks - pages) > 0)
+		if (!percpu_counter_limited_add(&sbinfo->used_blocks,
+						sbinfo->max_blocks, pages))
 			goto unacct;
 
 		err = dquot_alloc_block_nodirty(inode, pages);
-		if (err)
+		if (err) {
+			percpu_counter_sub(&sbinfo->used_blocks, pages);
 			goto unacct;
-
-		percpu_counter_add(&sbinfo->used_blocks, pages);
+		}
 	} else {
 		err = dquot_alloc_block_nodirty(inode, pages);
 		if (err)
-- 
2.35.3

