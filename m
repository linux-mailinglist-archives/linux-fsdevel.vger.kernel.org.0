Return-Path: <linux-fsdevel+bounces-46912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E7A9671F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10055189A8C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C65A27BF6C;
	Tue, 22 Apr 2025 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN2KMJpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A7277007;
	Tue, 22 Apr 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320767; cv=none; b=F79QHqexhjxz6lwcLNmzbE6z9n9mQpEQtDOMewdW/9ghOgoCJy2zA6WDVPAcxwJBMEQE5+1Zne9Lu1psbKUZtbeTYcfzZTO2/nYMjd963zxB1jz7zyCx0IHbwML/BbrgPZ0ATJ9j3J8PeRnVlDDqciPYAaK1SGNz7FxDB3rybhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320767; c=relaxed/simple;
	bh=eilNR/y9lrTc9DrNowV7wlNdAr9mkqdRmdKvxRStVOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDbh6IN3/CxfAjD2RuRYkCCsTJGs+qmVm9PHFlazavHq3vgyAZDG9J+fuqvhYT8/J3rTAngihZNCwPvfjVtKNsXUmijE9wdRdgC5uZ11g/5I79516xGJz9rok52olSli4T1Og3YP9Hf3o2mXhBNt5pT2XRcWP2EJ+SRMiN1oTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN2KMJpl; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-225df540edcso60109825ad.0;
        Tue, 22 Apr 2025 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745320765; x=1745925565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxUCa1tC3GczEFCo3nXTDpb0Z/3vB+vw0bBDCtEpjQM=;
        b=UN2KMJplDqw8h+EyC5imCrTTlrv715odNUVYh6DMiw+V6rGKsejK7ANbTExslOjA1F
         MIbrg/3dz42aIT5OLcrPlGVplCeOrQ/R8jVRRzGMF5M2n8MVPpd9FBebQqxQSyCwITjm
         iqbJAUr71VHqIoipVsiERZImELjsFIMFoBxWEcNYeOAHv+0OZ9etoJRHdVPXm2YVbz6y
         HnVTdHhkyioVtWF9QBCHc2vlRvIVZ5d7UQE9BbFGE5qBHLejqb1HLQOKy8/pWTzzxkr6
         TgUntIrIXm4IhpWR9anuumhC6fnTOfHlTJeB4PXBile/wRt8BmvfOCdFbqjXEjSsDKdL
         iZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745320765; x=1745925565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxUCa1tC3GczEFCo3nXTDpb0Z/3vB+vw0bBDCtEpjQM=;
        b=TPHH7NGVvVn3uen/sXMhUw/ddHw8bljE5aRxoYCcvV9q30oQ1mjPowTEd4ONN6ldDA
         hWeklaBZim3LgDeH4R0hyYY5q5lESeQqMhob5nFGWEgQe5nUbtDh8TY3KljnFsZ0R7N9
         Iu8LCyx8OkBmbsb8kRb1xeRA0tmYcnMktYxsjdILjmwbTekverMX6/VGTl/sKg6ICynO
         as/uM9KMiOIyPIHoNnba8/emLTQ3MOA10cG4AQCmjzHFANwCvTrkr3pWg2drj8idEjV+
         qnhs992TFzUQYD34PxZuP6nxNIOecbLEVFl6drH0mOovs3ke8gNDhSYyfBuJUOMymWUu
         t9cA==
X-Forwarded-Encrypted: i=1; AJvYcCWIFjwM2+8SBjclcul0kjIUFfG1QimSbkq9IBuyHzz92CdgNUHQ5MBH410pO3kaXsQbB0zxsVGv8exVNbRr@vger.kernel.org, AJvYcCXuJFYwt/j+uxA8eXoxjFZy4O9DtN5Mf+LHlYtT8+1gkOOUdaG2UFY3rQkNkroIlKxGtz9+cwClNewQC2+y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+gon4owh7haW7yxv5Tw4p+5L9QG08m65RRMxRnm/YDCQ1O4Sa
	2D8fDv2ovr66TJyTIkUax5Z9vsFZJMJ3l8roC47wxl/CcW/owrdGk4vKWeTQ
X-Gm-Gg: ASbGnctkRZdT5/6eWfI4SP2kUFyIi3Xk5fxToL/bWLfFxebLNrt83YfMvI5hNt/knA3
	swVb09XNpyyIOfFdDi8TAsd7OAy84JKSyGpMQ/L+PzbMolcDqGjo2DoFi3tsHXAGRIlxIRKtMg/
	8z2Xe6xmmFwa8K0+D/1tyLVSNcycYxff4dmOT0roy/Naslm0ku3WTjtJrYgpzcCfJeYbXBlb3zO
	X7dny9KLKCZDaUneIKxL1ObqgC08GvKIM3ihovu1oA9pFF4CEdHswbipQwkxD2/5pZpkRYZvr/h
	hWiWrFvEMTVzpKdRkb0WDjX3pwjV997LYcUP2bABbLKxsoeoEInfmA==
X-Google-Smtp-Source: AGHT+IHl1Dm3PG8oo/J4jpP7XiUCoLP+Rq0pPIzwl8C08h2/xJKdhjsO/+UsC0SmoqaIjbtDz3Bzew==
X-Received: by 2002:a17:903:1aa4:b0:221:1497:7b08 with SMTP id d9443c01a7336-22c50d643e8mr246918155ad.23.1745320765287;
        Tue, 22 Apr 2025 04:19:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed247esm82519535ad.208.2025.04.22.04.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:19:24 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: [PATCH RESEND 1/6] memcontrol: rename mem_cgroup_scan_tasks()
Date: Tue, 22 Apr 2025 11:19:19 +0000
Message-Id: <20250422111919.3231273-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
References: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current Issue:
==============
The function mem_cgroup_scan_tasks in memcontrol.c has a naming ambiguity.
While its name suggests it only iterates through processes belonging to
the current memcgroup, it actually scans all descendant cgroups under the
subtree rooted at this memcgroup. This discrepancy can cause confusion
for developers relying on the semantic meaning of the function name.

Resolution:
=========
Renaming: We have renamed the original function to
**mem_cgroup_tree_scan_tasks** to explicitly reflect its subtree-traversal
behavior.

A subsequent patch will introduce a new mem_cgroup_scan_tasks function that
strictly iterates processes only within the current memcgroup, aligning its
behavior with its name.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 4 ++--
 mm/oom_kill.c              | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5264d148bdd9..1c1ce25fae4c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -795,7 +795,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 				   struct mem_cgroup *,
 				   struct mem_cgroup_reclaim_cookie *);
 void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
-void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 			   int (*)(struct task_struct *, void *), void *arg);
 
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
@@ -1289,7 +1289,7 @@ static inline void mem_cgroup_iter_break(struct mem_cgroup *root,
 {
 }
 
-static inline void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+static inline void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 		int (*fn)(struct task_struct *, void *), void *arg)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6bc6dade60d8..3baf0a4e0674 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1164,7 +1164,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 }
 
 /**
- * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
+ * mem_cgroup_tree_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
  * @fn: function to call for each task
  * @arg: argument passed to @fn
@@ -1176,7 +1176,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
  *
  * This function must not be called for the root memory cgroup.
  */
-void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 			   int (*fn)(struct task_struct *, void *), void *arg)
 {
 	struct mem_cgroup *iter;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..af3b8407fb08 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -367,7 +367,7 @@ static void select_bad_process(struct oom_control *oc)
 	oc->chosen_points = LONG_MIN;
 
 	if (is_memcg_oom(oc))
-		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
+		mem_cgroup_tree_scan_tasks(oc->memcg, oom_evaluate_task, oc);
 	else {
 		struct task_struct *p;
 
@@ -428,7 +428,7 @@ static void dump_tasks(struct oom_control *oc)
 	pr_info("[  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name\n");
 
 	if (is_memcg_oom(oc))
-		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
+		mem_cgroup_tree_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
 		int i = 0;
@@ -1056,7 +1056,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	if (oom_group) {
 		memcg_memory_event(oom_group, MEMCG_OOM_GROUP_KILL);
 		mem_cgroup_print_oom_group(oom_group);
-		mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member,
+		mem_cgroup_tree_scan_tasks(oom_group, oom_kill_memcg_member,
 				      (void *)message);
 		mem_cgroup_put(oom_group);
 	}
-- 
2.39.3



