Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C10449DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 22:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhKHVXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 16:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbhKHVW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:22:57 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65705C061570
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Nov 2021 13:20:12 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r7-20020a63ce47000000b002a5cadd2f25so10720322pgi.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Nov 2021 13:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=HuOsUesI41VMxHbd9WL9Fs5X3h8wZbAlymoJuWa+M0o=;
        b=mgCbALj0RzI1y7dYKpXbyaiAMLfsKBudFfa7Ub2nVulXL0OgGprL2nvZQ5jgnYWFQk
         FyRwZRuXkDXDZQg/EmG5RPSKJ0THWJP0Gn8tavb7JhK0Lx6F7Dj9+4l1egra+m7YtrPy
         lpmGx4XlaWZ9qtVHp2GizypVKABYErQ15IN9nQhWjo3/L/uwJ8MJb1L7MoiMNoVeyH0V
         iwZn7AfMAJUXEPjwLeaNB9ZvVpm0reoL4Ua4Yl6E+SYJvPNIlcuk4x63koSryTbpjh2C
         Dfoc/LjYIFQeWJUEHu9QP2jJta84c10T9HT3Jpk5hQhWEHbsuURruitDfys71o4MWJGi
         BxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=HuOsUesI41VMxHbd9WL9Fs5X3h8wZbAlymoJuWa+M0o=;
        b=Wr4yjSIO3VdivCp2NKw/DV8ITuEhMBn1XEgJguaHeeTa/yF3VKKJs5XCzpKcgqlpni
         pkgau+bnsGDJ2DMIDMPDcHCr76qT0Szdtt+hjf4FFhd0T7d+BNr8UZTfPdcPWIiEnbwJ
         2SXLN95YPX87yuBmds5qMYexqKOd/HDqcoRave26VAhK4y4APd8AN9GRM6k0jyeegolK
         9jobt8FWVthyb2HqTrBDhsNFTcslBI0UJ+CaW7O4QGyRxGXGpRqvh0PAu5/lsUZXT3tl
         gqPxIUVAzyTHS8EEtfQtML3OcMdqBi4tNwTiXxXp5W1ZnVYp/FcNBnRvNgfMNuyWy3Pe
         IBFA==
X-Gm-Message-State: AOAM533vUKLqlq/pMxlywdBE94OoMBeXeeOV5PzRSuZUbFuzLdEMkMEp
        wBsBbLity1vXn/lksRzHXEcSEq5FEFBRgms3+g==
X-Google-Smtp-Source: ABdhPJxtKMCyalpwo6Rk4XPSadnMPMqQz4M27ofn10pg+q/fy4JS+sm19K/CP1QUZKWIjfQ6AuvOtu9HpgCeOuOOeQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:8717:7707:fb59:664e])
 (user=almasrymina job=sendgmr) by 2002:aa7:88cb:0:b0:49f:ad17:c08 with SMTP
 id k11-20020aa788cb000000b0049fad170c08mr2017245pff.19.1636406411895; Mon, 08
 Nov 2021 13:20:11 -0800 (PST)
Date:   Mon,  8 Nov 2021 13:19:57 -0800
In-Reply-To: <20211108211959.1750915-1-almasrymina@google.com>
Message-Id: <20211108211959.1750915-4-almasrymina@google.com>
Mime-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 3/5] mm/oom: handle remote ooms
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
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
Cc: Roman Gushchin <songmuchun@bytedance.com>
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
 mm/memcontrol.c | 21 +++++++++++++++++++++
 mm/oom_kill.c   | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2e4c20d09f959..fc9c6280266b6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2664,6 +2664,27 @@ int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf, size_t len)
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
+	current_memcg = get_mem_cgroup_from_mm(current->mm);
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
index 0a7e16b16b8c3..556329dee273f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1106,6 +1106,27 @@ bool out_of_memory(struct oom_control *oc)
 	}

 	select_bad_process(oc);
+
+	/*
+	 * For remote ooms in userfaults, we have no choice but to kill the
+	 * allocating process.
+	 */
+	if (!oc->chosen && is_remote_oom(oc->memcg) && current->in_user_fault &&
+	    !oom_unkillable_task(current)) {
+		get_task_struct(current);
+		oc->chosen = current;
+		oom_kill_process(
+			oc, "Out of memory (Killing remote allocating task)");
+		return true;
+	}
+
+	/*
+	 * For remote ooms in non-userfaults, simply return ENOMEM to the
+	 * caller.
+	 */
+	if (!oc->chosen && is_remote_oom(oc->memcg))
+		return false;
+
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
 		dump_header(oc, NULL);
--
2.34.0.rc0.344.g81b53c2807-goog
