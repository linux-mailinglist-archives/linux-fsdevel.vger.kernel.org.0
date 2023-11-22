Return-Path: <linux-fsdevel+bounces-3480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB257F522E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1381C20C4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7871BDCB;
	Wed, 22 Nov 2023 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxBXfKUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF3D50;
	Wed, 22 Nov 2023 13:12:14 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab56so252387b3a.3;
        Wed, 22 Nov 2023 13:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687534; x=1701292334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L0St/1imG1/+PsAaTcIH+nuU4Zq2K1uLUk+VNFsJhE=;
        b=VxBXfKUr0p9owk/MJbxDb7e1iMfbu+RMK+ZJbudD5zpHPt5XIEoft/4oqCtj9EULsh
         z8fZ9S+GJ11daAXjlB2/OJEJYvC+R43vcCYIwk4OG9hl6aTGS0aocUN/uCpBBrZ8eU0R
         xiWF8u1KiFPBsoUdxgUUV6Hf5y7zTuFb2NQ4Uo15/3koJzLqyhLzIAyflZ5y6Tec9QnK
         dr9Ttoq8S/Bh2FtBvZIuGGgjT7w44QBnqOgkLMkyi+h73DD45/347Z+Jm+PF4ba5n4RV
         AwKi8YXstl5zLHT1h3G/3+QRfniWGE0W0IlMOHFQ7/YApZsRpnH2Seb5BGi8fubOaBIO
         tlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687534; x=1701292334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1L0St/1imG1/+PsAaTcIH+nuU4Zq2K1uLUk+VNFsJhE=;
        b=qiLduj52lutKV9SO00tW66uZ5DQ2S9L4mW9SGBBcwYdFBj1nyWw/KcEN9ZsKLsk9e8
         dd6Kpgza/yYKNJAM3XoKM9Ms5uQbZkNrix84yLNiWJWLWbTdY5QofW8hcTehL693NEcu
         9Pj3OboOXEN0D9ZOQT8ZBSy/3KAp56AMXeBsPv5XwO8nFX5Umv5ld3UMjBLaPBRN7ak7
         UfBf15We4hsHZsEis5kyzt3MhtIltPLd9Hwz5d8Mp/gyexC900nBRwPGFochy4H43rva
         BA03492QIfrA6VZXnnh7LabHxa8WCAUq5TtQyQTZzGZe74vA619ILB7wUIbuHOp1X0sZ
         83Ig==
X-Gm-Message-State: AOJu0YwNMuleQ3xPWKx8TlE5Wb7CmUabDyTFBgXrxRCwr6PFwpIYhyeb
	XR/OJm/XbTyx/1FOqtUnEQ==
X-Google-Smtp-Source: AGHT+IG6Q6k/J46fkuHI+vHQ3UkB56d4pIUNrjj7twNbdRajXKBsjZF+C9yC+5OfzogHrLEo5QCK1w==
X-Received: by 2002:a05:6a20:7f94:b0:18b:2dc6:7e18 with SMTP id d20-20020a056a207f9400b0018b2dc67e18mr3989169pzj.61.1700687534128;
        Wed, 22 Nov 2023 13:12:14 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:13 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 03/11] mm/mempolicy: refactor set_mempolicy stack to take a task argument
Date: Wed, 22 Nov 2023 16:11:52 -0500
Message-Id: <20231122211200.31620-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make mempolicy modifiable by external tasks, we must refactor
the callstack to take a task as an argument.

Modify the following functions to require a task argument:
	mpol_set_nodemask
	replace_mempolicy
	do_set_mempolicy

Since replace_mempolicy already acquired the task lock, there
is no need to change any locking behaviors.

All other callers (as of this patch) to mpol_set_nodemask
call either in the context of current with the task or mmap
lock held, so no other changes are required.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 51 +++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 37da712259d7..9ea3e1bfc002 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -226,8 +226,10 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
  * Must be called holding task's alloc_lock to protect task's mems_allowed
  * and mempolicy.  May also be called holding the mmap_lock for write.
  */
-static int mpol_set_nodemask(struct mempolicy *pol,
-		     const nodemask_t *nodes, struct nodemask_scratch *nsc)
+static int mpol_set_nodemask(struct task_struct *tsk,
+			     struct mempolicy *pol,
+			     const nodemask_t *nodes,
+			     struct nodemask_scratch *nsc)
 {
 	int ret;
 
@@ -240,8 +242,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 		return 0;
 
 	/* Check N_MEMORY */
-	nodes_and(nsc->mask1,
-		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+	nodes_and(nsc->mask1, tsk->mems_allowed, node_states[N_MEMORY]);
 
 	VM_BUG_ON(!nodes);
 
@@ -253,7 +254,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (mpol_store_user_nodemask(pol))
 		pol->w.user_nodemask = *nodes;
 	else
-		pol->w.cpuset_mems_allowed = cpuset_current_mems_allowed;
+		pol->w.cpuset_mems_allowed = tsk->mems_allowed;
 
 	ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
 	return ret;
@@ -810,7 +811,9 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /* Attempt to replace mempolicy, release the old one if successful */
-static long replace_mempolicy(struct mempolicy *new, nodemask_t *nodes)
+static long replace_mempolicy(struct task_struct *task,
+			      struct mempolicy *new,
+			      nodemask_t *nodes)
 {
 	struct mempolicy *old = NULL;
 	NODEMASK_SCRATCH(scratch);
@@ -819,19 +822,19 @@ static long replace_mempolicy(struct mempolicy *new, nodemask_t *nodes)
 	if (!scratch)
 		return -ENOMEM;
 
-	task_lock(current);
-	ret = mpol_set_nodemask(new, nodes, scratch);
+	task_lock(task);
+	ret = mpol_set_nodemask(task, new, nodes, scratch);
 	if (ret) {
-		task_unlock(current);
+		task_unlock(task);
 		goto out;
 	}
 
-	old = current->mempolicy;
-	current->mempolicy = new;
+	old = task->mempolicy;
+	task->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
-		current->il_prev = MAX_NUMNODES-1;
+		task->il_prev = MAX_NUMNODES-1;
 out:
-	task_unlock(current);
+	task_unlock(task);
 	mpol_put(old);
 
 	NODEMASK_SCRATCH_FREE(scratch);
@@ -839,8 +842,8 @@ static long replace_mempolicy(struct mempolicy *new, nodemask_t *nodes)
 }
 
 /* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+static long do_set_mempolicy(struct task_struct *task, unsigned short mode,
+			     unsigned short flags, nodemask_t *nodes)
 {
 	struct mempolicy *new;
 	int ret;
@@ -849,7 +852,7 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
-	ret = replace_mempolicy(new, nodes);
+	ret = replace_mempolicy(task, new, nodes);
 	if (ret)
 		mpol_put(new);
 
@@ -1284,7 +1287,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
 			mmap_write_lock(mm);
-			err = mpol_set_nodemask(new, nmask, scratch);
+			err = mpol_set_nodemask(current, new, nmask, scratch);
 			if (err)
 				mmap_write_unlock(mm);
 		} else
@@ -1580,7 +1583,8 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 }
 
 /* Set the process memory policy */
-static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
+static long kernel_set_mempolicy(struct task_struct *task, int mode,
+				 const unsigned long __user *nmask,
 				 unsigned long maxnode)
 {
 	unsigned short mode_flags;
@@ -1596,13 +1600,13 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
-	return do_set_mempolicy(lmode, mode_flags, &nodes);
+	return do_set_mempolicy(task, lmode, mode_flags, &nodes);
 }
 
 SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 		unsigned long, maxnode)
 {
-	return kernel_set_mempolicy(mode, nmask, maxnode);
+	return kernel_set_mempolicy(current, mode, nmask, maxnode);
 }
 
 static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
@@ -2722,7 +2726,8 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 			goto free_scratch; /* no valid nodemask intersection */
 
 		task_lock(current);
-		ret = mpol_set_nodemask(npol, &mpol->w.user_nodemask, scratch);
+		ret = mpol_set_nodemask(current, npol, &mpol->w.user_nodemask,
+					scratch);
 		task_unlock(current);
 		if (ret)
 			goto put_npol;
@@ -2870,7 +2875,7 @@ void __init numa_policy_init(void)
 	if (unlikely(nodes_empty(interleave_nodes)))
 		node_set(prefer, interleave_nodes);
 
-	if (do_set_mempolicy(MPOL_INTERLEAVE, 0, &interleave_nodes))
+	if (do_set_mempolicy(current, MPOL_INTERLEAVE, 0, &interleave_nodes))
 		pr_err("%s: interleaving failed\n", __func__);
 
 	check_numabalancing_enable();
@@ -2879,7 +2884,7 @@ void __init numa_policy_init(void)
 /* Reset policy of current process to default */
 void numa_default_policy(void)
 {
-	do_set_mempolicy(MPOL_DEFAULT, 0, NULL);
+	do_set_mempolicy(current, MPOL_DEFAULT, 0, NULL);
 }
 
 /*
-- 
2.39.1


