Return-Path: <linux-fsdevel+bounces-27552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E905962556
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC18F1F23A6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C0916C698;
	Wed, 28 Aug 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0tkqFU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B8168C26
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842634; cv=none; b=XdRua3fg1ZQ5+zN02KPI/2aCAR7yItGZ8IkIO7r3LugB9dxpSqnXciBsH4Oa02IryERWYIIzORhfERfuChcZ/TngHIVcSm47+EBFATiz2XP9j9FKlHMNETV2M/Gkm9hnl+pKNYT1iLCldm61GAkcetZmJim2s6ND+dYpmhg3j1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842634; c=relaxed/simple;
	bh=sHidI5jLSIX8UVIkMjGOIDyMLbkLDe+hp8XvmRLq1Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SyifqN+xVcghKDxgu+x15KSHB6kkAB562qpQTnWdOnJT9UGD+OEes3j40oH9qNJkgUAsAatWMb9XSWFZJndu872Jj+rE+ysit3b7sDxS6QL/nhosbCmJd0wlO6IeAWxY+s8e5ZbmcBZX/hZ96ADMzClUHhgKh7QlhEt0/U5nQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0tkqFU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4835C4CADC;
	Wed, 28 Aug 2024 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724842633;
	bh=sHidI5jLSIX8UVIkMjGOIDyMLbkLDe+hp8XvmRLq1Os=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B0tkqFU0sJKz1kSgkSPagbo7d+km0HFluA7VxuYR7+178B+NrzPVKuoIwjxPWVUsz
	 dcJxIroODwog7d2FVspEVzk83T586CuOtp9L0hCCnHfKFf18fNmfUL27A8R024RQ4O
	 3/VusbKgIvFSJHDJskhfUwwK/sdmw/km9mN60NLr2WswhtqA2ATORIq8C922InicQU
	 Zds8j07G4y06GhWe06R6ZCWDoqOXttIIIbklmBjGuFRBCj2fsdE+2hiFTm9gtG9cAt
	 u1Bs7l+z3UmoSG3gZLLIgwMCTlKUeXl4ZvmtTCJ+ssUYt3B9ylPudtO8zL8xsXWrYs
	 9/R/IuBXINTyw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 28 Aug 2024 12:56:25 +0200
Subject: [PATCH v3 3/3] fs: use kmem_cache_create_rcu()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-work-kmem_cache-rcu-v3-3-5460bc1f09f6@kernel.org>
References: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
In-Reply-To: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sHidI5jLSIX8UVIkMjGOIDyMLbkLDe+hp8XvmRLq1Os=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdZ6q5v6hBTF6IM/HeIbPn2qWv6zQ+c8mU3Fr3+Nyv7
 h/fOkK/dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk6y6G/wmJtYGf3WQnBFvY
 dAa9CWXdZ+QdMM18h0Xbcp/c3TlaWowMPyq+bkycXNlYJG8hGpGceuWrTLR61vd67V+d27ZYfmv
 hBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Switch to the new kmem_cache_create_rcu() helper which allows us to use
a custom free pointer offset avoiding the need to have an external free
pointer which would grow struct file behind our backs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c    | 6 +++---
 include/linux/fs.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 694199a1a966..83d5ac1fadc0 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -514,9 +514,9 @@ EXPORT_SYMBOL(__fput_sync);
 
 void __init files_init(void)
 {
-	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-				SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
-				SLAB_PANIC | SLAB_ACCOUNT, NULL);
+	filp_cachep = kmem_cache_create_rcu("filp", sizeof(struct file),
+				offsetof(struct file, f_freeptr),
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 61097a9cf317..5ca83e87adef 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1026,6 +1026,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
  * @f_task_work: task work entry point
  * @f_llist: work queue entrypoint
  * @f_ra: file's readahead state
+ * @f_freeptr: Pointer used by SLAB_TYPESAFE_BY_RCU file cache (don't touch.)
  */
 struct file {
 	atomic_long_t			f_count;
@@ -1057,6 +1058,7 @@ struct file {
 		struct callback_head	f_task_work;
 		struct llist_node	f_llist;
 		struct file_ra_state	f_ra;
+		freeptr_t		f_freeptr;
 	};
 	/* --- cacheline 3 boundary (192 bytes) --- */
 } __randomize_layout

-- 
2.45.2


