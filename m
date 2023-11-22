Return-Path: <linux-fsdevel+bounces-3483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0D7F523D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705FE28193B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9751A581;
	Wed, 22 Nov 2023 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsO4emHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA5D4A;
	Wed, 22 Nov 2023 13:12:23 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so186329b3a.1;
        Wed, 22 Nov 2023 13:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687543; x=1701292343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGEV0GKEGIpaRLeFOk46VDdRd1VzAop7kM786wY6S5I=;
        b=OsO4emHSquVHxGgvcvtn+ucjFAHifEu8WKEQe0IchiGCgJO8k/veaisZcHp0YsiWVj
         eiazu7+mxGL2M/0Tm18N+fUfkNO+o2SHpL07D3OTp2d5QmKJgX+1mhrANZf+DP2KNrLq
         PXDlrDhg/x83hj0mGkd5u/hHRPz6R3HTW6uHg5PAn7SfdrRz+EDXhqV144m0YxJexLy2
         2ycTEpBKQEbWVQB+ALUR785vWnY5m4WV0aJylp0vbyN8AvxTA8IldyYFXyR5MxxmP1FT
         FcBAT50DZp9Fb3DA6gI1mTdFozKhud0/KSWxSsm72z+NrXDFV1lNgJVbGaIesAXky2WF
         DE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687543; x=1701292343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGEV0GKEGIpaRLeFOk46VDdRd1VzAop7kM786wY6S5I=;
        b=eSqSglXslNRInLS69y9fFikAXv74fLAbsh7ysOVCfimOrIap/fq0lZ+yTZ+sI/IPKa
         SyKjWwzB4ulEtHtnV/KXoli3fBIudEWXG7Ju+4WBRm97xNSmtEM6acH9EH7OPiEgu7ti
         zykImn8Z0cjeUlAYCftRAcdLQ8oJcyZx856gGzYs2ie7fH4dSG5yzk/Sz9gRo98mbTC+
         NVeQ9J0g/LFc00iO/uQUUWJeE4XQl8NgmRQgSg1FPGOmaX28RX+2J0Ea3/I1Jd/hzt4k
         jT/unCdOvbL3Spz4Q0yKEmLal/9Vf+tcp/LK8cIAB51xa8Mv/lASthRXdn0p/QsIyAGd
         3aXw==
X-Gm-Message-State: AOJu0YxpmlVRAOhzBuspG/NFaeWOomVLBrp3RwqcYhFpE5IzJNJGN6vA
	aKV9VFvtBnINb1HshqAX0w==
X-Google-Smtp-Source: AGHT+IEngkamQgS9JDDH0OMG5qcgYPn/R+C8BVPyrbVkNf+Ro78kVa/NtW1kXBp/Ws13QuBfIRwScg==
X-Received: by 2002:a05:6a20:8f06:b0:18a:df69:eabe with SMTP id b6-20020a056a208f0600b0018adf69eabemr969850pzk.11.1700687542801;
        Wed, 22 Nov 2023 13:12:22 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:22 -0800 (PST)
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
Subject: [RFC PATCH 06/11] mm/mempolicy: modify do_mbind to operate on task argument instead of current
Date: Wed, 22 Nov 2023 16:11:55 -0500
Message-Id: <20231122211200.31620-7-gregory.price@memverge.com>
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

To make mbind applied mempolicies modifable by external tasks, we must
first change the do_mbind callstack to take a task as an argument.

This patch includes changes to the following functions:
	do_mbind
	kernel_mbind
	get_vma_policy

And adds the following:
	get_task_vma_policy

get_vma_policy is changed into a wrapper of get_task_vma_policy which
passes current as an argument to retain the existing behavior for
callers of get_vma_policy.

do_mbind is modified as followed:

1) the way task->mm is acquired is changed to be safe for non-current
   tasks, but the original behavior of (task == current) is retained.
2) we take a reference to the mm so that the task lock can be dropped.
3) the task lock must now be acquired on call to get_task_policy to
   ensure we acquire and reference the policy safely.
4) get_task_vma_policy is called instead of get_vma_policy. This
   requires taking the task_lock because of the new semantics.

Change to acquiring task->mm:

When (task == curent), if we use get_task_mm, it would prevent a
kernel task from making modifications or accessing information
about its own vma's.  So in this scenario, we simply access and
reference the mm directly, since the mempolicy information is
being accessed in the context of the task itself.

  if (mm) {
    if (task->flags & PF_KTHREAD)
      mm = NULL;
    else
      mmget(mm);
  }

The retains the existing behavior.

Change to get_task_vma_policy locking behavior:

Since task->policy is no longer guaranteed to be stable, any time we
seek to acquire a policy via get_task_vma_policy, we must use the
task_lock and reference it accordingly, regardless of where it
ultimately came from.  A similar behvior can be seen in
do_get_mempolicy, where a reference is taken and a conditional release
is made to handle the situation where a shared policy is acquired.

In the case of do_mbind, we don't actually need to take a reference
to the policy, as we only call get_task_vma_policy to find the ilx.
In this case, we only need to call mpol_cond_put immediately to ensure
that if get_task_vma_policy returns a shared policy we decrement the
reference count since a shared mpol will return already referenced.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 92 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 23 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 540163f5d349..3d2171ac4098 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -422,6 +422,10 @@ static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags);
 static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 				pgoff_t ilx, int *nid);
+static struct mempolicy *get_task_vma_policy(struct task_struct *task,
+					     struct vm_area_struct *vma,
+					     unsigned long addr, int order,
+					     pgoff_t *ilx);
 
 static bool strictly_unmovable(unsigned long flags)
 {
@@ -1250,11 +1254,12 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 }
 #endif
 
-static long do_mbind(unsigned long start, unsigned long len,
-		     unsigned short mode, unsigned short mode_flags,
-		     nodemask_t *nmask, unsigned long flags)
+static long do_mbind(struct task_struct *task, unsigned long start,
+		     unsigned long len, unsigned short mode,
+		     unsigned short mode_flags, nodemask_t *nmask,
+		     unsigned long flags)
 {
-	struct mm_struct *mm = current->mm;
+	struct mm_struct *mm;
 	struct vm_area_struct *vma, *prev;
 	struct vma_iterator vmi;
 	struct migration_mpol mmpol;
@@ -1287,6 +1292,21 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
+	/*
+	 * original behavior allows a kernel task modifying itself to bypass
+	 * check in get_task_mm, so directly acquire mm in this case
+	 */
+	if (task == current) {
+		mm = task->mm;
+		mmget(mm);
+	} else
+		mm = get_task_mm(task);
+
+	if (!mm) {
+		err = -ENODEV;
+		goto mpol_out;
+	}
+
 	/*
 	 * If we are using the default policy then operation
 	 * on discontinuous address spaces is okay after all
@@ -1300,7 +1320,9 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
 			mmap_write_lock(mm);
-			err = mpol_set_nodemask(current, new, nmask, scratch);
+			task_lock(task);
+			err = mpol_set_nodemask(task, new, nmask, scratch);
+			task_unlock(task);
 			if (err)
 				mmap_write_unlock(mm);
 		} else
@@ -1308,7 +1330,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH_FREE(scratch);
 	}
 	if (err)
-		goto mpol_out;
+		goto mm_out;
 
 	/*
 	 * Lock the VMAs before scanning for pages to migrate,
@@ -1333,8 +1355,10 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (!err && !list_empty(&pagelist)) {
 		/* Convert MPOL_DEFAULT's NULL to task or default policy */
 		if (!new) {
-			new = get_task_policy(current);
+			task_lock(task);
+			new = get_task_policy(task);
 			mpol_get(new);
+			task_unlock(task);
 		}
 		mmpol.pol = new;
 		mmpol.ilx = 0;
@@ -1365,8 +1389,11 @@ static long do_mbind(unsigned long start, unsigned long len,
 			if (addr != -EFAULT) {
 				order = compound_order(page);
 				/* We already know the pol, but not the ilx */
-				mpol_cond_put(get_vma_policy(vma, addr, order,
-							     &mmpol.ilx));
+				task_lock(task);
+				mpol_cond_put(get_task_vma_policy(task, vma,
+								  addr, order,
+								  &mmpol.ilx));
+				task_unlock(task);
 				/* Set base from which to increment by index */
 				mmpol.ilx -= page->index >> order;
 			}
@@ -1386,6 +1413,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 		err = -EIO;
 	if (!list_empty(&pagelist))
 		putback_movable_pages(&pagelist);
+mm_out:
+	mmput(mm);
 mpol_out:
 	mpol_put(new);
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
@@ -1500,8 +1529,9 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 	return 0;
 }
 
-static long kernel_mbind(unsigned long start, unsigned long len,
-			 unsigned long mode, const unsigned long __user *nmask,
+static long kernel_mbind(struct task_struct *task, unsigned long start,
+			 unsigned long len, unsigned long mode,
+			 const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
 {
 	unsigned short mode_flags;
@@ -1518,7 +1548,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
-	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
+	return do_mbind(task, start, len, lmode, mode_flags, &nodes, flags);
 }
 
 static long __set_mempolicy_home_node(struct task_struct *task,
@@ -1628,7 +1658,7 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 		unsigned long, mode, const unsigned long __user *, nmask,
 		unsigned long, maxnode, unsigned int, flags)
 {
-	return kernel_mbind(start, len, mode, nmask, maxnode, flags);
+	return kernel_mbind(current, start, len, mode, nmask, maxnode, flags);
 }
 
 /* Set the process memory policy */
@@ -1827,6 +1857,31 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		vma->vm_ops->get_policy(vma, addr, ilx) : vma->vm_policy;
 }
 
+/*
+ * Task variant of get_vma_policy for use internally. Returns the task
+ * policy if the vma does not have a policy of its own. get_vma_policy
+ * will return current->mempolicy as a result.
+ *
+ * Like get_vma_policy and get_task_policy, must hold alloc/task_lock
+ * while calling this.
+ */
+static struct mempolicy *get_task_vma_policy(struct task_struct *task,
+					     struct vm_area_struct *vma,
+					     unsigned long addr, int order,
+					     pgoff_t *ilx)
+{
+	struct mempolicy *pol;
+
+	pol = __get_vma_policy(vma, addr, ilx);
+	if (!pol)
+		pol = get_task_policy(task);
+	if (pol->mode == MPOL_INTERLEAVE) {
+		*ilx += vma->vm_pgoff >> order;
+		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
+	}
+	return pol;
+}
+
 /*
  * get_vma_policy(@vma, @addr, @order, @ilx)
  * @vma: virtual memory area whose policy is sought
@@ -1844,16 +1899,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 				 unsigned long addr, int order, pgoff_t *ilx)
 {
-	struct mempolicy *pol;
-
-	pol = __get_vma_policy(vma, addr, ilx);
-	if (!pol)
-		pol = get_task_policy(current);
-	if (pol->mode == MPOL_INTERLEAVE) {
-		*ilx += vma->vm_pgoff >> order;
-		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
-	}
-	return pol;
+	return get_task_vma_policy(current, vma, addr, order, ilx);
 }
 
 bool vma_policy_mof(struct vm_area_struct *vma)
-- 
2.39.1


