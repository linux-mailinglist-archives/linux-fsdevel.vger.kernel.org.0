Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D428D6A329E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBZQDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBZQDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:03:35 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3EDBDEB;
        Sun, 26 Feb 2023 08:03:23 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id D189C831AB;
        Sun, 26 Feb 2023 16:03:18 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677427403;
        bh=VLdIA0Ryrjg4sqcZ4qs9212xaCVaprtzgyOR34VDtxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQ0KI6MLmFZy5fNV0dblCFChQ7CoCIrNnIkAJTvDHbO2K2nCKsvV0ZhdZNpW7+NnQ
         IOI263lqaJo4TBbDplL4Th3KYfgol/qUGoVYiduQViA5IuOfg1wRxmSHnTibJFBOpm
         LS7V5ikK1AUlWRPQFKcwJH3mU0r6I+fSGaMS/6VUlW2dUXZAoFzK5901bap+We8Bn4
         xIVeyUo0nNBOqBQB3qcENdMYKOpB0exofmUbaiyIZ6V0Yrf5rZejsSziBcg7ityiJQ
         qz44FB23tC+PMCMhPl5p/JJc9UicgOvVM4IMAZSvQ7nyMccVQXw9/IC3r2qjcmY9FV
         AzyspPQipjinw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v1 1/6] workqueue: Add set_workqueue_cpumask() helper function
Date:   Sun, 26 Feb 2023 23:02:54 +0700
Message-Id: <20230226160259.18354-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow users to specify a CPU set for the workqueue. The first use case
of this helper function is to set the CPU affinity of Btrfs workqueues.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 include/linux/workqueue.h |  3 +++
 kernel/workqueue.c        | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index ac551b8ee7d9f2f4..e3bd6f47e74ecd66 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -710,6 +710,9 @@ int workqueue_online_cpu(unsigned int cpu);
 int workqueue_offline_cpu(unsigned int cpu);
 #endif
 
+int set_workqueue_cpumask(struct workqueue_struct *wq,
+			  const cpumask_var_t mask);
+
 void __init workqueue_init_early(void);
 void __init workqueue_init(void);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed4854a4..adc1478fafb1811c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4398,6 +4398,25 @@ static int init_rescuer(struct workqueue_struct *wq)
 	return 0;
 }
 
+int set_workqueue_cpumask(struct workqueue_struct *wq, const cpumask_var_t mask)
+{
+	struct workqueue_attrs *tmp_attrs;
+	int ret;
+
+	tmp_attrs = alloc_workqueue_attrs();
+	if (!tmp_attrs)
+		return -ENOMEM;
+
+	apply_wqattrs_lock();
+	copy_workqueue_attrs(tmp_attrs, wq->unbound_attrs);
+	cpumask_copy(tmp_attrs->cpumask, mask);
+	ret = apply_workqueue_attrs_locked(wq, tmp_attrs);
+	apply_wqattrs_unlock();
+	free_workqueue_attrs(tmp_attrs);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(set_workqueue_cpumask);
+
 __printf(1, 4)
 struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
-- 
Ammar Faizi

