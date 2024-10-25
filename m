Return-Path: <linux-fsdevel+bounces-32833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A29AF6B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F55A1C216A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CFD5733A;
	Fri, 25 Oct 2024 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BYHipPaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A994CB5B
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819414; cv=none; b=EbzazCnqt20FptX5wWOCXwkqvXTRWoT6HvtCJpoFWVSntUXt9VP0nTKIpye3vl3JncqiLIaO5WwRmY8i7et2kFyNxkSvR2hJM2jGKKLGzqAl7QbXkn1MF6DaeR7bNYVu93U07R1DNxk4lzpqr3CYeZEZMgXMz4SnBBihwb4e/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819414; c=relaxed/simple;
	bh=sQRRmbJokoCLViZCZ0YYPH5uWhydRXOCr+qV/eyTvSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9a/EWIVaL+3sk4z5eQySsOYMTMCOFRJeMM7yYrLnG8cxzNwMY981tPMs5Y7rmMJhIl05jbTrRs24znMwT7Nc9IHsq/0gvkOaja3m+RJB6j+1KEqu4v/DqqJmqvakrq/QpPDohAWtauKfXoiifRCmYIQIPlpRQZn30G6f1THt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BYHipPaw; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729819409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+J9jIglENq8jzu02bF8vylZNSZPLddTn6u8mh0nWUU=;
	b=BYHipPawJUMMW2Grb3IgGNBGyd/tCAEj58t9TYe6oWoiC8107S9853GwmSzHeSpldFUmVs
	0f1Xrr4JjMdvp9qn3yoUAkWW5btgPv7xCsKVEDAThJjkmP4IKr9HmyQMwtGeytNs1l9ZA2
	NN38hBDw18D1pA94B4nYiBsxI9LGTnA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v1 1/6] memcg-v1: fully deprecate move_charge_at_immigrate
Date: Thu, 24 Oct 2024 18:22:58 -0700
Message-ID: <20241025012304.2473312-2-shakeel.butt@linux.dev>
In-Reply-To: <20241025012304.2473312-1-shakeel.butt@linux.dev>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Proceed with the complete deprecation of memcg v1's charge moving
feature. The deprecation warning has been in the kernel for almost two
years and has been ported to all stable kernel since. Now is the time to
fully deprecate this feature.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---

Changes since RFC:
- Writing 0 to memory.move_charge_at_immigrate is allowed.

 .../admin-guide/cgroup-v1/memory.rst          | 82 +------------------
 mm/memcontrol-v1.c                            | 14 +---
 2 files changed, 5 insertions(+), 91 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 270501db9f4e..286d16fc22eb 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -90,9 +90,7 @@ Brief summary of control files.
                                      used.
  memory.swappiness		     set/show swappiness parameter of vmscan
 				     (See sysctl's vm.swappiness)
- memory.move_charge_at_immigrate     set/show controls of moving charges
-                                     This knob is deprecated and shouldn't be
-                                     used.
+ memory.move_charge_at_immigrate     This knob is deprecated.
  memory.oom_control		     set/show oom controls.
                                      This knob is deprecated and shouldn't be
                                      used.
@@ -243,10 +241,6 @@ behind this approach is that a cgroup that aggressively uses a shared
 page will eventually get charged for it (once it is uncharged from
 the cgroup that brought it in -- this will happen on memory pressure).
 
-But see :ref:`section 8.2 <cgroup-v1-memory-movable-charges>` when moving a
-task to another cgroup, its pages may be recharged to the new cgroup, if
-move_charge_at_immigrate has been chosen.
-
 2.4 Swap Extension
 --------------------------------------
 
@@ -756,78 +750,8 @@ If we want to change this to 1G, we can at any time use::
 
 THIS IS DEPRECATED!
 
-It's expensive and unreliable! It's better practice to launch workload
-tasks directly from inside their target cgroup. Use dedicated workload
-cgroups to allow fine-grained policy adjustments without having to
-move physical pages between control domains.
-
-Users can move charges associated with a task along with task migration, that
-is, uncharge task's pages from the old cgroup and charge them to the new cgroup.
-This feature is not supported in !CONFIG_MMU environments because of lack of
-page tables.
-
-8.1 Interface
--------------
-
-This feature is disabled by default. It can be enabled (and disabled again) by
-writing to memory.move_charge_at_immigrate of the destination cgroup.
-
-If you want to enable it::
-
-	# echo (some positive value) > memory.move_charge_at_immigrate
-
-.. note::
-      Each bits of move_charge_at_immigrate has its own meaning about what type
-      of charges should be moved. See :ref:`section 8.2
-      <cgroup-v1-memory-movable-charges>` for details.
-
-.. note::
-      Charges are moved only when you move mm->owner, in other words,
-      a leader of a thread group.
-
-.. note::
-      If we cannot find enough space for the task in the destination cgroup, we
-      try to make space by reclaiming memory. Task migration may fail if we
-      cannot make enough space.
-
-.. note::
-      It can take several seconds if you move charges much.
-
-And if you want disable it again::
-
-	# echo 0 > memory.move_charge_at_immigrate
-
-.. _cgroup-v1-memory-movable-charges:
-
-8.2 Type of charges which can be moved
---------------------------------------
-
-Each bit in move_charge_at_immigrate has its own meaning about what type of
-charges should be moved. But in any case, it must be noted that an account of
-a page or a swap can be moved only when it is charged to the task's current
-(old) memory cgroup.
-
-+---+--------------------------------------------------------------------------+
-|bit| what type of charges would be moved ?                                    |
-+===+==========================================================================+
-| 0 | A charge of an anonymous page (or swap of it) used by the target task.   |
-|   | You must enable Swap Extension (see 2.4) to enable move of swap charges. |
-+---+--------------------------------------------------------------------------+
-| 1 | A charge of file pages (normal file, tmpfs file (e.g. ipc shared memory) |
-|   | and swaps of tmpfs file) mmapped by the target task. Unlike the case of  |
-|   | anonymous pages, file pages (and swaps) in the range mmapped by the task |
-|   | will be moved even if the task hasn't done page fault, i.e. they might   |
-|   | not be the task's "RSS", but other task's "RSS" that maps the same file. |
-|   | The mapcount of the page is ignored (the page can be moved independent   |
-|   | of the mapcount). You must enable Swap Extension (see 2.4) to            |
-|   | enable move of swap charges.                                             |
-+---+--------------------------------------------------------------------------+
-
-8.3 TODO
---------
-
-- All of moving charge operations are done under cgroup_mutex. It's not good
-  behavior to hold the mutex too long, so we may need some trick.
+Reading memory.move_charge_at_immigrate will always return 0 and writing
+to it will always return -EINVAL.
 
 9. Memory thresholds
 ====================
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 81d8819f13cd..9b3b1a446c65 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -593,29 +593,19 @@ static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
 static u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
 				struct cftype *cft)
 {
-	return mem_cgroup_from_css(css)->move_charge_at_immigrate;
+	return 0;
 }
 
 #ifdef CONFIG_MMU
 static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 				 struct cftype *cft, u64 val)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-
 	pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
 		     "Please report your usecase to linux-mm@kvack.org if you "
 		     "depend on this functionality.\n");
 
-	if (val & ~MOVE_MASK)
+	if (val != 0)
 		return -EINVAL;
-
-	/*
-	 * No kind of locking is needed in here, because ->can_attach() will
-	 * check this value once in the beginning of the process, and then carry
-	 * on with stale data. This means that changes to this value will only
-	 * affect task migrations starting after the change.
-	 */
-	memcg->move_charge_at_immigrate = val;
 	return 0;
 }
 #else
-- 
2.43.5


