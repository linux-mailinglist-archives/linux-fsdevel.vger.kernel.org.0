Return-Path: <linux-fsdevel+bounces-73114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B37D0CE80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B0173048EEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622F27FD68;
	Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I22B2mc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD523EAB8;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017664; cv=none; b=PP0XUkxccz4lelAn3/NZVC+5OtcCQlJcazy4z6cZH3IjnvBopPo+pqqTv3LTxwa2veEF6P13MhyeEv48GbckYrBTNIrBFUe6+Kv/BTLQ3XY+/foCdFhk0iWygm+/DP9O9CjTIEnq90Tp+00qOsbQV+zjbppFi0/gzhIJjUkT3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017664; c=relaxed/simple;
	bh=NJm9T4Xvc9CNzStnNdFdP+G6pT0rhJsSFSegC9dhyfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvPPDga4gJXRjB/dmwAXkZazVHO7OrkAFTYY9h9hlmNbVHlggMVesHvZX0qI7dZcDvipWW6gpFenvN8ndL4Aupue+SSCq38pls7V06hJp9MjBg1Sw2gOQdRA8/WXIGNfAOZVe1E1hAoFydPbUT4s/8nGxdl5//JYwIsUQDd6B1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I22B2mc1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FG22dGTQn9arEKy7RAkcNwMcoAOPOCF9+5yic6HqZ3A=; b=I22B2mc10P0NblsrYHwgUXsHoq
	P4jKS1TQaWbO2FMIiN5/ZAIZmASvGnV19AMyUa8iI4VzAEqXXPphq+j4n9oQeiAXrGNTK1pvOhDcG
	p7lVVYdoS6mtT/4voowpR1gV2Iz0TSYnRJVfchF8xtAXwmjE+ztiVDckGM8IVMhWf0mv2EIc6r9mB
	dqEqFa1gohVw3az/3xdOpWauCJxDD5w5hPdTCBeE+seEu0PG+zbkBB4+Or+Yrdqm431zzV/1BOBTH
	5VHuSn11VGESC/F007GJdw5QeeKg/CdiwVvqxvkMeO1uu3wFkGYjjEU+SU4DdbyZwICnrCpWnkbs+
	Af9eiCzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB8-000000085ZO-3DkR;
	Sat, 10 Jan 2026 04:02:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/15] turn thread_cache static-duration
Date: Sat, 10 Jan 2026 04:02:06 +0000
Message-ID: <20260110040217.1927971-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and make is SLAB_PANIC instead of simulating it with BUG_ON() -
the boot is not going to get to kernel threads, nevermind userland...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/fork.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8e..ddd2558f9431 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -108,6 +108,7 @@
 #include <linux/unwind_deferred.h>
 #include <linux/pgalloc.h>
 #include <linux/uaccess.h>
+#include <linux/slab-static.h>
 
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -422,7 +423,8 @@ static void free_thread_stack(struct task_struct *tsk)
 
 #else /* !(THREAD_SIZE >= PAGE_SIZE) */
 
-static struct kmem_cache *thread_stack_cache;
+static struct kmem_cache_opaque __thread_stack_cache;
+#define thread_stack_cache to_kmem_cache(&__thread_stack_cache)
 
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
@@ -453,10 +455,10 @@ static void free_thread_stack(struct task_struct *tsk)
 
 void thread_stack_cache_init(void)
 {
-	thread_stack_cache = kmem_cache_create_usercopy("thread_stack",
-					THREAD_SIZE, THREAD_SIZE, 0, 0,
+	kmem_cache_setup_usercopy(thread_stack_cache, "thread_stack",
+					THREAD_SIZE, THREAD_SIZE,
+					SLAB_PANIC, 0,
 					THREAD_SIZE, NULL);
-	BUG_ON(thread_stack_cache == NULL);
 }
 
 #endif /* THREAD_SIZE >= PAGE_SIZE */
-- 
2.47.3


