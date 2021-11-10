Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3931D44CB32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhKJVWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 16:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhKJVWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 16:22:48 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E59AC061766
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 13:20:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x9-20020a056a00188900b0049fd22b9a27so2613547pfh.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 13:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=VaRLTVJVm8bc5oD03oVAGrqeOn+Oq3c9ZULJFx/+Xrg=;
        b=ZRt8IcmyzTVn4UbNUqU42UgqUs8gj+sBg7Q2DWoy2p/NXaPWqgCIbES5OSatgTBOpQ
         ZsbTzfPvlARVBLkmi6Xg/raHqeKIlpKRd86dCQlXLorUydu9M+SdMZvMjDroflzf8hPk
         47KT6GjuZezkT5mQ4/F8NI2VJcYKiMz9Koih0cg792tqeKSi6WEbmJf8CxAiTu5/pDoZ
         gbG7a2ROhqitQXIbe+8A9uMYD1vkr1Bb9jeYXQGClhsgnTQsV0K7PA0l912tYXiQsGDr
         xrr3FJ82UN6xOK8T8XZatXvlk9TXZ9lgYsP+T9PCYxa0swZdC7WjKtxn9VKbevA02w8r
         t+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=VaRLTVJVm8bc5oD03oVAGrqeOn+Oq3c9ZULJFx/+Xrg=;
        b=sAkuKh/FPzht42mBQyZvNRNMI4UuMksNEPsRtV6/rcWzfdtMnAiHOCuqlvs6eJHL/w
         J3m1k3CfNVk/zMKuK7b8zjvZIq8x/1hdDCSThBo+kPFOb0/Q9iCSHOJCgdqNYoDX5MUc
         i1cX3U3RvuqBoZ4ijnELbVkOSDZXhxS3RtBCEvvbZhm05ZrrjHvQ6NGnCHScc72Sensl
         SKlg2c2Jldjrnf2f1xjiuqFLLtJwjWFviKpA9F9l1H7gxtnRxzycd3KXaWZhjIuRrY+V
         zLfb/+J+3e/JL7LmRQJMElJOzYj+Wli++2DbqdgtSdS7YhspHKF0IOFpw1zBym4p2BYm
         QuNw==
X-Gm-Message-State: AOAM532eXdBskD4fKhj+WsaXYvb2zgSMgWGuOgMtluwfk20xBWP1VX0z
        3hd6HQqfr7ZH82CXD62ABSTQHVn6kxJyhm9D+w==
X-Google-Smtp-Source: ABdhPJylK9Pk5yV60fTq5Y86bT/Tm9l66NLfqghwFP3nZWIBJYZ5SXo41dy/Z/6REFG1TXK7TWCJCHDQVvxQi0yclQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:59c8:7b4e:e859:9db0])
 (user=almasrymina job=sendgmr) by 2002:a63:e107:: with SMTP id
 z7mr1257112pgh.294.1636579199881; Wed, 10 Nov 2021 13:19:59 -0800 (PST)
Date:   Wed, 10 Nov 2021 13:19:48 -0800
In-Reply-To: <20211110211951.3730787-1-almasrymina@google.com>
Message-Id: <20211110211951.3730787-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20211110211951.3730787-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 2/4] mm/oom: handle remote ooms
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On remote ooms (OOMs due to remote charging), the oom-killer will attempt
to find a task to kill in the memcg under oom, if the oom-killer
is unable to find one, the oom-killer should simply return ENOMEM to the
allocating process.

If we're in pagefault path and we're unable to return ENOMEM to the
allocating process, we instead kill the allocating process.

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: Michal Hocko <mhocko@suse.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Thelen <gthelen@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
CC: Roman Gushchin <guro@fb.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: riel@surriel.com
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: cgroups@vger.kernel.org

---

Changes in v2:
- Moved the remote oom handling as Roman requested.
- Used mem_cgroup_from_task(current) instead of grabbing the memcg from
current->mm

---
 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 29 +++++++++++++++++++++++++++++
 mm/oom_kill.c              | 22 ++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 866904afd3563..ae4686abd4d32 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -937,6 +937,7 @@ struct mem_cgroup *mem_cgroup_get_from_path(const char *path);
  * it.
  */
 int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf, size_t len);
+bool is_remote_oom(struct mem_cgroup *memcg_under_oom);

 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 		int zid, int nr_pages);
@@ -1270,6 +1271,11 @@ static inline int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf,
 	return 0;
 }

+static inline bool is_remote_oom(struct mem_cgroup *memcg_under_oom)
+{
+	return false;
+}
+
 static inline int mem_cgroup_swapin_charge_page(struct page *page,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b3d8f52a63d17..8019c396bfdd9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2664,6 +2664,35 @@ int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf, size_t len)
 	return ret < 0 ? ret : 0;
 }

+/*
+ * Returns true if current's mm is a descendant of the memcg_under_oom (or
+ * equal to it). False otherwise. This is used by the oom-killer to detect
+ * ooms due to remote charging.
+ */
+bool is_remote_oom(struct mem_cgroup *memcg_under_oom)
+{
+	struct mem_cgroup *current_memcg;
+	bool is_remote_oom;
+
+	if (!memcg_under_oom)
+		return false;
+
+	rcu_read_lock();
+	current_memcg = mem_cgroup_from_task(current);
+	if (current_memcg && !css_tryget_online(&current_memcg->css))
+		current_memcg = NULL;
+	rcu_read_unlock();
+
+	if (!current_memcg)
+		return false;
+
+	is_remote_oom =
+		!mem_cgroup_is_descendant(current_memcg, memcg_under_oom);
+	css_put(&current_memcg->css);
+
+	return is_remote_oom;
+}
+
 /*
  * Set or clear (if @memcg is NULL) charge association from file system to
  * memcg.  If @memcg != NULL, then a css reference must be held by the caller to
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 0a7e16b16b8c3..0e0097a0aed45 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1108,6 +1108,28 @@ bool out_of_memory(struct oom_control *oc)
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
+		if (is_remote_oom(oc->memcg)) {
+			/*
+			 * For remote ooms in userfaults, we have no choice but
+			 * to kill the allocating process.
+			 */
+			if (current->in_user_fault &&
+			    !oom_unkillable_task(current)) {
+				get_task_struct(current);
+				oc->chosen = current;
+				oom_kill_process(
+					oc,
+					"Out of memory (Killing remote allocating task)");
+				return true;
+			}
+
+			/*
+			 * For remote ooms in non-userfaults, simply return
+			 * ENOMEM to the caller.
+			 */
+			return false;
+		}
+
 		dump_header(oc, NULL);
 		pr_warn("Out of memory and no killable processes...\n");
 		/*
--
2.34.0.rc0.344.g81b53c2807-goog
