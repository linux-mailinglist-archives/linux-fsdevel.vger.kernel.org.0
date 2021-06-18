Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3503ACE9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhFRPXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29198 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235062AbhFRPWH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624029598; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=N8wgFa33745Covxxr7BCaZw8EVHqxftnjArcIHaJM4Y=; b=FXlIaPXcn1fuhXeOKJCn25maECKuijichni/Rm025EtjimafyAVCpX6c/5bg9AXxdlE068Xm
 pD5dmyMRByJNEm8EUPu4yJPO+QYGLW6REZOL/907ybhMOjMjzOwVMxQ6qBpUv7ELk72FvkfU
 t8p+fvWmyTmfEXYHREw1eliE3gc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60ccb994abfd22a3dc39ea42 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 15:19:48
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5259CC4323A; Fri, 18 Jun 2021 15:19:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0834AC43217;
        Fri, 18 Jun 2021 15:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0834AC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, rientjes@google.com, mchehab+huawei@kernel.org,
        lokeshgidra@google.com, andrew.a.klychkov@gmail.com,
        xi.fengfei@h3c.com, nigupta@nvidia.com,
        dave.hansen@linux.intel.com, famzheng@amazon.com,
        mateusznosek0@gmail.com, oleksandr@redhat.com, sh_def@163.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH V4 2/3] mm: compaction: support triggering of proactive compaction by user
Date:   Fri, 18 Jun 2021 20:48:54 +0530
Message-Id: <1647ec8c1a08c47c33e6fcbd0e91a9f57e0428a4.1624028025.git.charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1624028025.git.charante@codeaurora.org>
References: <cover.1624028025.git.charante@codeaurora.org>
In-Reply-To: <cover.1624028025.git.charante@codeaurora.org>
References: <cover.1624028025.git.charante@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The proactive compaction[1] gets triggered for every 500msec and run
compaction on the node for COMPACTION_HPAGE_ORDER (usually order-9)
pages based on the value set to sysctl.compaction_proactiveness.
Triggering the compaction for every 500msec in search of
COMPACTION_HPAGE_ORDER pages is not needed for all applications,
especially on the embedded system usecases which may have few MB's of
RAM. Enabling the proactive compaction in its state will endup in
running almost always on such systems.

Other side, proactive compaction can still be very much useful for
getting a set of higher order pages in some controllable
manner(controlled by using the sysctl.compaction_proactiveness). Thus on
systems where enabling the proactive compaction always may proove not
required, can trigger the same from user space on write to its sysctl
interface. As an example, say app launcher decide to launch the memory
heavy application which can be launched fast if it gets more higher
order pages thus launcher can prepare the system in advance by
triggering the proactive compaction from userspace.

This triggering of proactive compaction is done on a write to
sysctl.compaction_proactiveness by user.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 Changes in V4:
	-- Changed the code as the 'proactive_defer' counter is removed.
	-- No changes in the logic of triggering the proactive compaction.

 Changes in V3:
        -- Fixed review comments from Valstimil and others.
        -- https://lore.kernel.org/patchwork/patch/1438211/

 Changes in V2:
	-- remove /proc/../proactive_compact_memory interface trigger for proactive compaction
        -- Intention is same that add a way to trigger proactive compaction by user.
        -- https://lore.kernel.org/patchwork/patch/1431283/

 changes in V1:
	-- Created the new /proc/sys/vm/proactive_compact_memory in
	   interface to trigger proactive compaction from user 
        -- https://lore.kernel.org/lkml/1619098678-8501-1-git-send-email-charante@codeaurora.org/

 Documentation/admin-guide/sysctl/vm.rst |  3 ++-
 include/linux/compaction.h              |  2 ++
 include/linux/mmzone.h                  |  1 +
 kernel/sysctl.c                         |  2 +-
 mm/compaction.c                         | 32 ++++++++++++++++++++++++++++++--
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 586cd4b..5e8097d 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -126,7 +126,8 @@ compaction_proactiveness
 
 This tunable takes a value in the range [0, 100] with a default value of
 20. This tunable determines how aggressively compaction is done in the
-background. Setting it to 0 disables proactive compaction.
+background. On write of non zero value to this tunable will immediately
+trigger the proactive compaction. Setting it to 0 disables proactive compaction.
 
 Note that compaction has a non-trivial system-wide impact as pages
 belonging to different processes are moved around, which could also lead
diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 4221888..04d5d9f 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -84,6 +84,8 @@ static inline unsigned long compact_gap(unsigned int order)
 extern unsigned int sysctl_compaction_proactiveness;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos);
+extern int compaction_proactiveness_sysctl_handler(struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_extfrag_threshold;
 extern int sysctl_compact_unevictable_allowed;
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0d53eba..9455809 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -815,6 +815,7 @@ typedef struct pglist_data {
 	enum zone_type kcompactd_highest_zoneidx;
 	wait_queue_head_t kcompactd_wait;
 	struct task_struct *kcompactd;
+	bool proactive_compact_trigger;
 #endif
 	/*
 	 * This is a per-node reserve of pages that are not available
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d4a78e0..85b473e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2859,7 +2859,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &sysctl_compaction_proactiveness,
 		.maxlen		= sizeof(sysctl_compaction_proactiveness),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= compaction_proactiveness_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_hundred,
 	},
diff --git a/mm/compaction.c b/mm/compaction.c
index bfbcb97..7672be3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2708,6 +2708,30 @@ static void compact_nodes(void)
  */
 unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
 
+int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *length, loff_t *ppos)
+{
+	int rc, nid;
+
+	rc = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (rc)
+		return rc;
+
+	if (write && sysctl_compaction_proactiveness) {
+		for_each_online_node(nid) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+
+			if (pgdat->proactive_compact_trigger)
+				continue;
+
+			pgdat->proactive_compact_trigger = true;
+			wake_up_interruptible(&pgdat->kcompactd_wait);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
@@ -2752,7 +2776,8 @@ void compaction_unregister_node(struct node *node)
 
 static inline bool kcompactd_work_requested(pg_data_t *pgdat)
 {
-	return pgdat->kcompactd_max_order > 0 || kthread_should_stop();
+	return pgdat->kcompactd_max_order > 0 || kthread_should_stop() ||
+		pgdat->proactive_compact_trigger;
 }
 
 static bool kcompactd_node_suitable(pg_data_t *pgdat)
@@ -2905,7 +2930,8 @@ static int kcompactd(void *p)
 
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
 		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
-			kcompactd_work_requested(pgdat), timeout)) {
+			kcompactd_work_requested(pgdat), timeout) &&
+			!pgdat->proactive_compact_trigger) {
 
 			psi_memstall_enter(&pflags);
 			kcompactd_do_work(pgdat);
@@ -2940,6 +2966,8 @@ static int kcompactd(void *p)
 				timeout =
 				   default_timeout << COMPACT_MAX_DEFER_SHIFT;
 		}
+		if (unlikely(pgdat->proactive_compact_trigger))
+			pgdat->proactive_compact_trigger = false;
 	}
 
 	return 0;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

