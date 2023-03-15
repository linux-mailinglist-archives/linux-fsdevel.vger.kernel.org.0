Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9233B6BAB1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 09:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjCOIuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 04:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCOIt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:49:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6305D47A
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 01:49:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d10so10321407pgt.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678870192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkFj6yYLyA565/QhOvX6PgrnENIUFczCaPlTlQYQGRk=;
        b=P8lBfpG7IED6FPgo2ZB7apKwy3nUll9jUKZ8XzlrGpjDtYG8AbCcwo7zvIxIedMAi2
         H6VZUAxroyRe59ECAAvynvkq8QSQkYykDwiNYazLkZA+lH3wCju9gPC+hT8a43f2BmoA
         j9RpQWC41i0mNupI+oXacSSvjKAGJ4+vgvsFXxD4G/haDpYnbt0PZ0RSkuEWQjljHrLG
         hGZcIKjas3JKkHHKlgv2t0oVs/hWgaL7pp9XDcpTbRs3hXgx0O3YC0Xiy7NF2n3Ej7tU
         RslGq9jpYn6NsD498EG4rurP0SM0c4G4pWSHhohSvWR1DWUZXDA7LXMdnh2+YmirVJdi
         9A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkFj6yYLyA565/QhOvX6PgrnENIUFczCaPlTlQYQGRk=;
        b=dRpC7LmQRjPtYoaFIBfpFSaiDUgddpP2vHHhlsyTTNTyYIfr+AylmpBBfjp3iM7qhS
         HBucFibRJThtSY5l7USDbKf/pv6Ua9aq51sZBd4pSoxNIx3TUJBvAy1rxjLeMGLPTVBx
         NVlmshgSLjbnNM+Jdoc4p5PePNIoQXaN++amS/v6rewHRvTo9zeGNEm558e6zKbfgHEl
         eJOzVjN5F38HNgADHQQCsA0YIekMPYRkWouUdrOcZCFilPEerg2kXXfYD2gC4NKJ03RW
         u/+vqOpd8Z8gqWD0ziQ8PEWRpImU5Wv6Lf19a6G94nQ04p1+5oNxXoCtZw0FB0n6r0TY
         aLvA==
X-Gm-Message-State: AO0yUKWdVmQ34fBRO+HW1PkVTfpQj3zRYD7GGTTdgD1EjjZsnbY8ptjv
        KSwth0UZuOx2qhhRyXu2eJ0b8rhd6JE30QXAWn4=
X-Google-Smtp-Source: AK7set9m56zOUn9/VDRZB2SidWtzW+u6ZCwpdH8KJIhu6v/dpLkJCqq28QRPyVmDBf4S/L86vLXNpQ==
X-Received: by 2002:a05:6a00:41:b0:625:5560:696e with SMTP id i1-20020a056a00004100b006255560696emr5343794pfk.16.1678870192212;
        Wed, 15 Mar 2023 01:49:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id h11-20020a62b40b000000b0062505afff9fsm2971980pfn.126.2023.03.15.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 01:49:51 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pcMpQ-008zeT-3D; Wed, 15 Mar 2023 19:49:48 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pcMpQ-00Ag6P-0I;
        Wed, 15 Mar 2023 19:49:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yebin10@huawei.com
Subject: [PATCH 2/4] pcpcntrs: fix dying cpu summation race
Date:   Wed, 15 Mar 2023 19:49:36 +1100
Message-Id: <20230315084938.2544737-3-david@fromorbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315084938.2544737-1-david@fromorbit.com>
References: <20230315084938.2544737-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

In commit f689054aace2 ("percpu_counter: add percpu_counter_sum_all
interface") a race condition between a cpu dying and
percpu_counter_sum() iterating online CPUs was identified. The
solution was to iterate all possible CPUs for summation via
percpu_counter_sum_all().

We recently had a percpu_counter_sum() call in XFS trip over this
same race condition and it fired a debug assert because the
filesystem was unmounting and the counter *should* be zero just
before we destroy it. That was reported here:

https://lore.kernel.org/linux-kernel/20230314090649.326642-1-yebin@huaweicloud.com/

likely as a result of running generic/648 which exercises
filesystems in the presence of CPU online/offline events.

The solution to use percpu_counter_sum_all() is an awful one. We
use percpu counters and percpu_counter_sum() for accurate and
reliable threshold detection for space management, so a summation
race condition during these operations can result in overcommit of
available space and that may result in filesystem shutdowns.

As percpu_counter_sum_all() iterates all possible CPUs rather than
just those online or even those present, the mask can include CPUs
that aren't even installed in the machine, or in the case of
machines that can hot-plug CPU capable nodes, even have physical
sockets present in the machine.

Fundamentally, this race condition is caused by the CPU being
offlined being removed from the cpu_online_mask before the notifier
that cleans up per-cpu state is run. Hence percpu_counter_sum() will
not sum the count for a cpu currently being taken offline,
regardless of whether the notifier has run or not. This is
the root cause of the bug.

The percpu counter notifier iterates all the registered counters,
locks the counter and moves the percpu count to the global sum.
This is serialised against other operations that move the percpu
counter to the global sum as well as percpu_counter_sum() operations
that sum the percpu counts while holding the counter lock.

Hence the notifier is safe to run concurrently with sum operations,
and the only thing we actually need to care about is that
percpu_counter_sum() iterates dying CPUs. That's trivial to do,
and when there are no CPUs dying, it has no addition overhead except
for a cpumask_or() operation.

This change makes percpu_counter_sum() always do the right thing in
the presence of CPU hot unplug events and makes
percpu_counter_sum_all() unnecessary. This, in turn, means that
filesystems like XFS, ext4, and btrfs don't have to work out when
they should use percpu_counter_sum() vs percpu_counter_sum_all() in
their space accounting algorithms

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 lib/percpu_counter.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index dba56c5c1837..0e096311e0c0 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -131,7 +131,7 @@ static s64 __percpu_counter_sum_mask(struct percpu_counter *fbc,
 
 	raw_spin_lock_irqsave(&fbc->lock, flags);
 	ret = fbc->count;
-	for_each_cpu(cpu, cpu_mask) {
+	for_each_cpu_or(cpu, cpu_online_mask, cpu_mask) {
 		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
 		ret += *pcount;
 	}
@@ -141,11 +141,20 @@ static s64 __percpu_counter_sum_mask(struct percpu_counter *fbc,
 
 /*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
- * but much slower version of percpu_counter_read_positive()
+ * but much slower version of percpu_counter_read_positive().
+ *
+ * We use the cpu mask of (cpu_online_mask | cpu_dying_mask) to capture sums
+ * from CPUs that are in the process of being taken offline. Dying cpus have
+ * been removed from the online mask, but may not have had the hotplug dead
+ * notifier called to fold the percpu count back into the global counter sum.
+ * By including dying CPUs in the iteration mask, we avoid this race condition
+ * so __percpu_counter_sum() just does the right thing when CPUs are being taken
+ * offline.
  */
 s64 __percpu_counter_sum(struct percpu_counter *fbc)
 {
-	return __percpu_counter_sum_mask(fbc, cpu_online_mask);
+
+	return __percpu_counter_sum_mask(fbc, cpu_dying_mask);
 }
 EXPORT_SYMBOL(__percpu_counter_sum);
 
-- 
2.39.2

