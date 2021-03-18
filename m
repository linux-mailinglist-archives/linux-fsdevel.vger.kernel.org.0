Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841B833FE0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 05:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCREIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 00:08:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:32577 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhCREIY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:08:24 -0400
IronPort-SDR: 2GzHjxpFwVJvSWrC1NlfpsoXnDnAJsaLgwokfne/tB/SHGQg2Ma8PEzqTkEhEwQKRPzfltDBat
 LCHHBtBmiJaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="186242965"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="186242965"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:08:23 -0700
IronPort-SDR: 1rq8sqVWSe6YHQ+WVrPVpOsMt43EYcMglJqHZo97oYfutFoyx3sJkcavfyuGw3PDOsaLdR1Dfz
 oB7zwAcabX0Q==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="389086762"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:08:18 -0700
Subject: [PATCH 1/3] mm/memory-failure: Prepare for mass memory_failure()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org, linux-nvdimm@lists.01.org
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        vishal.l.verma@intel.com, david@fromorbit.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Date:   Wed, 17 Mar 2021 21:08:08 -0700
Message-ID: <161604048859.1463742.10087657197118774859.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently memory_failure() assumes an infrequent report on a handful of
pages. A new use case for surprise removal of a persistent memory device
needs to trigger memory_failure() on a large range. Rate limit
memory_failure() error logging, and allow the
memory_failure_dev_pagemap() helper to be called directly.

Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory-failure.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 24210c9bd843..43ba4307c526 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -395,8 +395,9 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
 			 * signal and then access the memory. Just kill it.
 			 */
 			if (fail || tk->addr == -EFAULT) {
-				pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
-				       pfn, tk->tsk->comm, tk->tsk->pid);
+				pr_err_ratelimited(
+					"Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
+					pfn, tk->tsk->comm, tk->tsk->pid);
 				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
 						 tk->tsk, PIDTYPE_PID);
 			}
@@ -408,8 +409,9 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
 			 * process anyways.
 			 */
 			else if (kill_proc(tk, pfn, flags) < 0)
-				pr_err("Memory failure: %#lx: Cannot send advisory machine check signal to %s:%d\n",
-				       pfn, tk->tsk->comm, tk->tsk->pid);
+				pr_err_ratelimited(
+					"Memory failure: %#lx: Cannot send advisory machine check signal to %s:%d\n",
+					pfn, tk->tsk->comm, tk->tsk->pid);
 		}
 		put_task_struct(tk->tsk);
 		kfree(tk);
@@ -919,8 +921,8 @@ static void action_result(unsigned long pfn, enum mf_action_page_type type,
 {
 	trace_memory_failure_event(pfn, type, result);
 
-	pr_err("Memory failure: %#lx: recovery action for %s: %s\n",
-		pfn, action_page_types[type], action_name[result]);
+	pr_err_ratelimited("Memory failure: %#lx: recovery action for %s: %s\n",
+			   pfn, action_page_types[type], action_name[result]);
 }
 
 static int page_action(struct page_state *ps, struct page *p,
@@ -1375,8 +1377,6 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 unlock:
 	dax_unlock_page(page, cookie);
 out:
-	/* drop pgmap ref acquired in caller */
-	put_dev_pagemap(pgmap);
 	action_result(pfn, MF_MSG_DAX, rc ? MF_FAILED : MF_RECOVERED);
 	return rc;
 }
@@ -1415,9 +1415,12 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!p) {
 		if (pfn_valid(pfn)) {
 			pgmap = get_dev_pagemap(pfn, NULL);
-			if (pgmap)
-				return memory_failure_dev_pagemap(pfn, flags,
-								  pgmap);
+			if (pgmap) {
+				res = memory_failure_dev_pagemap(pfn, flags,
+								 pgmap);
+				put_dev_pagemap(pgmap);
+				return res;
+			}
 		}
 		pr_err("Memory failure: %#lx: memory outside kernel control\n",
 			pfn);

