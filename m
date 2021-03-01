Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934A8327C98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 11:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhCAKuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 05:50:55 -0500
Received: from z11.mailgun.us ([104.130.96.11]:11789 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234766AbhCAKuw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:50:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614595833; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Z6iFUxoiBsHFARzbI4gTg2kb9vnADIPjoZSG+52+ZEA=; b=hsxomhVMpcx1Q+cqqjg5Hq193X1x55ofjLNxmBjWFSdUGoki5ccwOH3oraUpy5JT6WmsmJwi
 0uWnaqQ3vw/D3BMzuZQRK9dt8Ko3qemVaRgFI0u0vFPBfeeE8jOn5yoSNhg5lUCsFemFoc4y
 N9C0KtzlR2z3KP1ogBv9wGDD8Ac=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 603cc6f016ba7452010130f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Mar 2021 10:50:24
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1FB1CC43465; Mon,  1 Mar 2021 10:50:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-498.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE0E3C433CA;
        Mon,  1 Mar 2021 10:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE0E3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pintu@codeaurora.org
From:   Pintu Kumar <pintu@codeaurora.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, jaewon31.kim@samsung.com,
        yuzhao@google.com, shakeelb@google.com, guro@fb.com,
        mchehab+huawei@kernel.org, xi.fengfei@h3c.com,
        pintu@codeaurora.org, lokeshgidra@google.com, hannes@cmpxchg.org,
        nigupta@nvidia.com, famzheng@amazon.com,
        andrew.a.klychkov@gmail.com, bigeasy@linutronix.de,
        ping.ping@gmail.com, vbabka@suse.cz, yzaikin@google.com,
        keescook@chromium.org, mcgrof@kernel.org, corbet@lwn.net
Cc:     pintu.ping@gmail.com
Subject: [PATCH] mm: introduce clear all vm events counters
Date:   Mon,  1 Mar 2021 16:19:26 +0530
Message-Id: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At times there is a need to regularly monitor vm counters while we
reproduce some issue, or it could be as simple as gathering some system
statistics when we run some scenario and every time we like to start from
beginning.
The current steps are:
Dump /proc/vmstat
Run some scenario
Dump /proc/vmstat again
Generate some data or graph
reboot and repeat again

So, each time we wanted to capture fresh data a reboot is required.

Thus, in this patch I introduce a way to clear/reset all vm counters to 0
without rebooting the system.
With this patch the steps can be:
Dump /proc/vmstat
Run some scenario
Dump /proc/vmstat again
Generate some data or graph
Do: echo 1 > /proc/sys/vm/clear_all_vm_events
Then repeat again

Thus, when 1 is written to this file, it resets all the vm counters present
under /proc/vmstat to its default value or zero.
The next time when you read /proc/vmstat, each node is filled with default
or current value.

There could be few other use cases where this can be useful.

Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
Signed-off-by: Pintu Agarwal <ping.ping@gmail.com>
---
 Documentation/admin-guide/sysctl/vm.rst |  8 ++++++++
 include/linux/vmstat.h                  |  7 +++++++
 kernel/sysctl.c                         |  9 +++++++++
 mm/vmstat.c                             | 26 ++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index e35a3f2..54382ab 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -26,6 +26,7 @@ Currently, these files are in /proc/sys/vm:
 
 - admin_reserve_kbytes
 - block_dump
+- clear_all_vm_events
 - compact_memory
 - compaction_proactiveness
 - compact_unevictable_allowed
@@ -112,6 +113,13 @@ block_dump
 block_dump enables block I/O debugging when set to a nonzero value. More
 information on block I/O debugging is in Documentation/admin-guide/laptops/laptop-mode.rst.
 
+clear_all_vm_events
+===================
+
+When 1 is written to this file, it resets all the vm counters present under
+/proc/vmstat to its default value or zeros.
+The next time when you read /proc/vmstat, each node is filled with default or
+current value.
 
 compact_memory
 ==============
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 773135f..8ab9be5 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -11,6 +11,8 @@
 #include <linux/mmdebug.h>
 
 extern int sysctl_stat_interval;
+extern int sysctl_clearvmevents_handler(struct ctl_table *table, int write,
+	void __user *buffer, size_t *length, loff_t *ppos);
 
 #ifdef CONFIG_NUMA
 #define ENABLE_NUMA_STAT   1
@@ -83,6 +85,8 @@ static inline void count_vm_events(enum vm_event_item item, long delta)
 
 extern void all_vm_events(unsigned long *);
 
+extern void clear_all_vm_events(void);
+
 extern void vm_events_fold_cpu(int cpu);
 
 #else
@@ -103,6 +107,9 @@ static inline void __count_vm_events(enum vm_event_item item, long delta)
 static inline void all_vm_events(unsigned long *ret)
 {
 }
+static inline void clear_all_vm_events(void)
+{
+}
 static inline void vm_events_fold_cpu(int cpu)
 {
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9fbdd8..25299a4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -200,6 +200,8 @@ static int min_extfrag_threshold;
 static int max_extfrag_threshold = 1000;
 #endif
 
+static int sysctl_clear_vm_events;
+
 #endif /* CONFIG_SYSCTL */
 
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
@@ -2891,6 +2893,13 @@ static struct ctl_table vm_table[] = {
 
 #endif /* CONFIG_COMPACTION */
 	{
+		.procname	= "clear_all_vm_events",
+		.data		= &sysctl_clear_vm_events,
+		.maxlen		= sizeof(int),
+		.mode		= 0200,
+		.proc_handler	= sysctl_clearvmevents_handler,
+	},
+	{
 		.procname	= "min_free_kbytes",
 		.data		= &min_free_kbytes,
 		.maxlen		= sizeof(min_free_kbytes),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f894216..26b8f81 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -136,6 +136,32 @@ void all_vm_events(unsigned long *ret)
 }
 EXPORT_SYMBOL_GPL(all_vm_events);
 
+void clear_all_vm_events(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
+		int sz = NR_VM_EVENT_ITEMS * sizeof(unsigned long);
+
+		memset(this->event, 0, sz);
+	}
+}
+EXPORT_SYMBOL_GPL(clear_all_vm_events);
+
+/*
+ * This is the node to reset all vm events in /proc/vmstat
+ * via /proc/sys/vm/clear_all_vm_events
+ */
+int sysctl_clearvmevents_handler(struct ctl_table *table, int write,
+	void __user *buffer, size_t *length, loff_t *ppos)
+{
+	if (write)
+		clear_all_vm_events();
+
+	return 0;
+}
+
 /*
  * Fold the foreign cpu events into our own.
  *
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

