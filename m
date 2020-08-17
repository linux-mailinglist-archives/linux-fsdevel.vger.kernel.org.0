Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9F246818
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 16:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgHQOKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 10:10:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728971AbgHQOKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=YtkHP8yUHAR+QqSRHcyYDisXPjLvOXyhm/pXyropj8M=;
        b=O7uU1Z6OaQgh61MW7eDV5DQO2mDdcjfMYMEtnjjkXoNgk6b60dwqx78SBDKixZEZfk2f63
        A33YGfpVy47URP3sbJ7+BUHw/k7tdN1tXtSbO8w38CRI1LvtGG69b0+t2Pt9nnc3JBcL5C
        ZxE8V+LwMGBHHI6mWhCDQxqhopu7r5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-bMwIf74GM1KLBLKidSrXBg-1; Mon, 17 Aug 2020 10:10:11 -0400
X-MC-Unique: bMwIf74GM1KLBLKidSrXBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B49C0425D3;
        Mon, 17 Aug 2020 14:10:09 +0000 (UTC)
Received: from llong.com (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9B1921E8F;
        Mon, 17 Aug 2020 14:09:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 7/8] memcg: Enable logging of memory control mitigation action
Date:   Mon, 17 Aug 2020 10:08:30 -0400
Message-Id: <20200817140831.30260-8-longman@redhat.com>
In-Reply-To: <20200817140831.30260-1-longman@redhat.com>
References: <20200817140831.30260-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some of the migitation actions of PR_SET_MEMCONTROL give no visible
signal that some actions are being done inside the kernel. To make it
more visble, a new PR_MEMFLAG_LOG flag is added to enable the logging
of the migitation action done in the kernel ring buffer.

The logging is done once when the mitigation action starts through the
setting of an internal PR_MEMFLAG_LOGGED flag. This flag will be cleared
when it is detected that the memory limit no longer exceeds memory.high.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/uapi/linux/prctl.h |  1 +
 mm/memcontrol.c            | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 7ba40e10737d..faa7a51fc52a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -266,6 +266,7 @@ struct prctl_mm_map {
 /* Flags for PR_SET_MEMCONTROL */
 # define PR_MEMFLAG_SIGCONT		(1UL <<  0) /* Continuous signal delivery */
 # define PR_MEMFLAG_DIRECT		(1UL <<  1) /* Direct memory limit */
+# define PR_MEMFLAG_LOG			(1UL <<  2) /* Log action done */
 # define PR_MEMFLAG_RSS_ANON		(1UL <<  8) /* Check anonymous pages */
 # define PR_MEMFLAG_RSS_FILE		(1UL <<  9) /* Check file pages */
 # define PR_MEMFLAG_RSS_SHMEM		(1UL << 10) /* Check shmem pages */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bddf3e659469..5bda2dd755fc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2640,6 +2640,7 @@ get_rss_counter(struct mm_struct *mm, int mm_bit, u16 flags, int rss_bit)
  * Return true if an action has been taken or further check is not needed,
  * false otherwise.
  */
+#define PR_MEMFLAG_LOGGED	(1UL << 7)	/* A log message printed */
 static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action,
 					  u16 flags)
 {
@@ -2714,6 +2715,32 @@ static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action,
 		break;
 	}
 
+	if ((flags & (PR_MEMFLAG_LOG|PR_MEMFLAG_LOGGED)) == PR_MEMFLAG_LOG) {
+		char name[80];
+		static const char * const acts[] = {
+			[PR_MEMACT_ENOMEM]   = "Action: return ENOMEM on some syscalls",
+			[PR_MEMACT_SLOWDOWN] = "Action: slow down process",
+			[PR_MEMACT_SIGNAL]   = "Action: send signal",
+			[PR_MEMACT_KILL]     = "Action: kill the process",
+		};
+
+		name[0] = '\0';
+		if (memcg)
+			cgroup_name(memcg->css.cgroup, name, sizeof(name));
+		else
+			strcpy(name, "N/A");
+
+		/*
+		 * Use printk_deferred() to minimize delay in the memory
+		 * allocation path.
+		 */
+		printk_deferred(KERN_INFO
+			"Cgroup: %s, Comm: %s, Pid: %d, Mem: %ld pages, %s\n",
+			name, current->comm, current->pid, mem, acts[action]);
+		WRITE_ONCE(current->memcg_over_high_flags,
+			   flags | PR_MEMFLAG_LOGGED);
+	}
+
 out:
 	mmput(mm);
 	/*
@@ -2740,8 +2767,13 @@ static inline bool mem_cgroup_over_high_action(struct mem_cgroup *memcg,
 
 	if (flags & PR_MEMFLAG_DIRECT)
 		memcg = NULL;	/* Direct per-task memory limit checking */
-	else if (!mem_high)
+	else if (!mem_high) {
+		/* Clear the PR_MEMFLAG_LOGGED flag, if set */
+		if (flags & PR_MEMFLAG_LOGGED)
+			WRITE_ONCE(current->memcg_over_high_flags,
+				   flags & ~PR_MEMFLAG_LOGGED);
 		return false;
+	}
 
 	return __mem_cgroup_over_high_action(memcg, action, flags);
 }
-- 
2.18.1

