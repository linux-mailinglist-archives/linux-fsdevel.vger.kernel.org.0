Return-Path: <linux-fsdevel+bounces-47798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EA2AA5A2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0070217F1D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A222FE06;
	Thu,  1 May 2025 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzS10+jx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9B1E5718;
	Thu,  1 May 2025 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072705; cv=none; b=SXybPoN+Ia+J7J24/81mjSMCU6J/ZUPeKf6oixSise5wMXIkik1VoxXUY8LkzSmUc0HOSVJSDsM7DZewhpdL63m7nzoSGM8/TUiWlnqrRs8nGWf71+kmCTypt/k1tS4tHIZSN9GuFEZ030WjbV2/bHHZTnjdDKMfafPiPTELn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072705; c=relaxed/simple;
	bh=7mMCNb67c5ihis7cYh/q8iG7Q8XEwTqHfzL1JbKgnPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=poQwJfQR0Cf2Nf/jcS7mI2jGhc0vTuInkS5sIkZgdMIMWmPxccYBX80rF+/6cFJb+xxs6aCS6XZO9M+EwFrA9MpyzsJX3MVltHwFtRCH9X5L7OssNcou4s/MOm3O5RiqVia7d4nRPgKo8nT/M5qbG5eFv6prWnn1N45nVH5X34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzS10+jx; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so785555a91.3;
        Wed, 30 Apr 2025 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746072701; x=1746677501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHIMhaHRLvw2RghH/IB5uM/em0iRZ35SCGJ4beGxlKA=;
        b=lzS10+jxZl325CMeQUh+ojHx3EoecjTwEN6TF6cm0R+eFHpnHk4MLbPFLrn0kN4Ez4
         WY7wjfnzOngrV7EDZ0/O2dQx0BgKr/UbIwWJw1QgKY326IU10gVYBFAwEZH81JvbJbYR
         fe4H53LKQwgHpndCk1a0+rq8gkg6qUj7X9ROCAY3/Iq25hSdDtj9dvbRgxmyIM9D1qoB
         SwUjuPFwPueY//AQpG0XZzuVTBNM3T1icNNmJpTcRc7uHNaldhNVaPbEbnqUUWAr34p8
         NV5qh/9u9lx15T0397FE3/0AeTa5oefF22FS7dLVZj6r2ncwAn4a8HIXcUlCwUBA2aHj
         RLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746072701; x=1746677501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHIMhaHRLvw2RghH/IB5uM/em0iRZ35SCGJ4beGxlKA=;
        b=MIB6uBduM6CYZ1cyDV4Q8gfrvpjntFaLTgNL4Uf+z8JsUGpeaFXHfYiYTPuhb8hy0D
         6HMmlOm0pyY+ZGIG5iiLS9yUSmj4LLshqg2CURolgpyDa36t00iqCWeeWtT4MzTF2tpf
         o4G03ifq3rPA/03B57IKFfiqZvJQ76UEltFD32EUu8aTX1Xez9IiPJz/PQsEh5UTJvwV
         H1u9JMDXsuhuCRrbKUlbJdYDEoKGHR7bbEMueEjRS3rOhnEF5lSXvRWK5FJBsWXdUEx1
         eO3YUXl4hh7l3xx0iFal4u1Wt54OJR5pHCIoQMuYpa0k3Y+BFqCU2NvrVh8Kb0gT+6Sx
         FGQg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Zs6/hlvliqWT+Odfdl33fgujM8l3fOPeo1mHosoQSxlp5+B3z09vsS3GGg3N79buu32mQImSRIzOoxSW@vger.kernel.org, AJvYcCXG86y23WFnzxh5Lg0C1zHvpf9AbVL4f+wnf8/6GZBbz3kjTN1S0Mevop5mVVIfAZHIm0oMKfmpsrOUNGl2@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTLjX2gjDF9SaJg/u1Gmzq4pZkMySS7akW9HQ6dN9OyCaZ0Iy
	6qAmi0+f4EdbyRSy6XqnNoiycX6ujSuDShnqZVKM5AKvY+9aTeHI
X-Gm-Gg: ASbGnctI9Qz5JeF8K2Uc+o25t1cI3gUBMALgJgkOvN6xLlnNW9iB1htC9REEU8P3C4u
	7uEGR0SLu9xs/YiMegIe+jfiFUMpvX96IsUoIzUuwmGZGGJk/MNoTbYxf3AG4i1mzUYRc6pSVKT
	re8AFPzDng3t95DdlLgNx0uODOO3e4wtK3NIVbAbYVs7VnWkiiqLECWSLzJ35LK7GidpmpIwhdM
	t2tcfGLH31eeSc8n0tp8hmRKVGwttA2hUny1zWTVXwVRdgWSg1vPAyIBLeCb4Eudgnr2VVBRjwV
	pJiz7GUG1UFKF9/9UCzJBxajo+9d8n2IfZcVbx1zInRLPqPvgXeszg==
X-Google-Smtp-Source: AGHT+IHqhofn4K/pgs3znTQZX1F5DniK/sLpCE6lLj5At9RS50DnqHAWsyd8CLPEel0uElii4xTipA==
X-Received: by 2002:a17:90b:2704:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-30a400bdae7mr2792257a91.14.1746072700887;
        Wed, 30 Apr 2025 21:11:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a11adcsm2549916a91.26.2025.04.30.21.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:11:40 -0700 (PDT)
From: xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: [PATCH v2 1/9] memcontrol: rename mem_cgroup_scan_tasks()
Date: Thu,  1 May 2025 04:11:34 +0000
Message-Id: <20250501041134.3324145-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
References: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xu xin <xu.xin16@zte.com.cn>

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
2.15.2



