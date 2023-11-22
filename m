Return-Path: <linux-fsdevel+bounces-3481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F17F5233
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9557228180E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3385B1CA85;
	Wed, 22 Nov 2023 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbnpJgNj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A9D66;
	Wed, 22 Nov 2023 13:12:17 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so257892b3a.3;
        Wed, 22 Nov 2023 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687537; x=1701292337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GABulzaAiHjU3X3l/c8xxKNbyTu6XjRf70gPWHFnEeU=;
        b=ZbnpJgNjs4dBcrBJ0t4DDz+Qat2I9JACrZNqlr2ESg/gcT51vNGjOgZwn0oG/UVAZ7
         pJiA6uVge8W7h/gzkcmsR6DUHTetxIvGJqOSV47Rko3Ffwaft7y1svuz9csW8JOfKLst
         UeZ/WS/tSq8V78tl02Gk6rL9qCu/kFMK2EUH0x4Zk+vATlDcAh0bfjKAh4GTtlf/5Kl5
         /KnwIAdgGletqP3STCEdDb6Hm03stzzF778hqlA4qxhllUXSwW7Q3J30iAusEn8Iiukg
         gnvsKd1ElELo2OPc+yT9YeDbJhkbGxr7vJaf5B5HT3zxgBMGfytdZTdih7/tEsgqD1rU
         EFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687537; x=1701292337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GABulzaAiHjU3X3l/c8xxKNbyTu6XjRf70gPWHFnEeU=;
        b=Pqh01OrqJ8E5Z1Eo5OlaF5TmLPsujF1+jIEJyEqNE36+s6JI05fjmdM+RKQxw1pdpI
         uQkS/yL4lD4vvUqTHrhTGGQRn2IDNvV0NUs2Lxq5djPmrfqIB4Zjc+iHPgE0XTBjHiju
         IbTJEPsBNbxa1qUcaybcTb7/4Rn0ywjyb+kOBt66Q2v3C7tgitl7LAdiIEbXR9BM50qM
         IBblLLQ7PZIrZYTG4NL3K2H6is59JpTPnS+TQcdEKABfNt9uYm5g4wRMAfHlz3HeX+BW
         AOxTYATiVOcVQznA/gSiAH9l0nrFTXgOvvmNovLzGxelyFGxM/ZIMeR0/Fm0yzZQy8wR
         8y6g==
X-Gm-Message-State: AOJu0YwI0KPTngJ108aALE16euTT5pcyVT29EDFrk+nhkmoEGeqeD7Rs
	6XZ7mBivv6Fa0BuENetchs8v+EYAP9YS
X-Google-Smtp-Source: AGHT+IFXvdmudROHD0YlWi+YK0a7lcqiiD79ewyUHoexoGYHQI8f+8OjJBq0l9lLV64qzqt5Crv6dA==
X-Received: by 2002:a05:6a00:1916:b0:6cb:bc1a:dcff with SMTP id y22-20020a056a00191600b006cbbc1adcffmr3982392pfi.13.1700687536917;
        Wed, 22 Nov 2023 13:12:16 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:16 -0800 (PST)
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
Subject: [RFC PATCH 04/11] mm/mempolicy: modify get_mempolicy call stack to take a task argument
Date: Wed, 22 Nov 2023 16:11:53 -0500
Message-Id: <20231122211200.31620-5-gregory.price@memverge.com>
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

To make mempolicy fetchable by external tasks, we must first change
the callstack to take a task as an argument.

Modify the following functions to require a task argument:
	do_get_mempolicy
	kernel_get_mempolicy

The way the task->mm is acquired must change slightly to enable this
change.  Originally, do_get_mempolicy would acquire the task->mm
directly via (current->mm).  This is unsafe to do in a non-current
context.  However, utilizing get_task_mm would break the original
functionality of do_get_mempolicy due to the following check
in get_task_mm:

  if (mm) {
    if (task->flags & PF_KTHREAD)
      mm = NULL;
    else
      mmget(mm);
  }

To retain the original behavior, if (task == current) we access
the task->mm directly, but if (task != current) we will utilize
get_task_mm to safely access the mm.

We simplify the get/put mechanics by always taking a reference to
the mm, even if we are in the context of (task == current).

Additionally, since the mempolicy will become externally modifiable,
we need to take the task lock to acquire task->mempolicy safely,
regardless of whether we are operating on current or not.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9ea3e1bfc002..4519f39b1a07 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -899,8 +899,9 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
 }
 
 /* Retrieve NUMA policy */
-static long do_get_mempolicy(int *policy, nodemask_t *nmask,
-			     unsigned long addr, unsigned long flags)
+static long do_get_mempolicy(struct task_struct *task, int *policy,
+			     nodemask_t *nmask, unsigned long addr,
+			     unsigned long flags)
 {
 	int err;
 	struct mm_struct *mm;
@@ -915,9 +916,9 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		if (flags & (MPOL_F_NODE|MPOL_F_ADDR))
 			return -EINVAL;
 		*policy = 0;	/* just so it's initialized */
-		task_lock(current);
-		*nmask  = cpuset_current_mems_allowed;
-		task_unlock(current);
+		task_lock(task);
+		*nmask = task->mems_allowed;
+		task_unlock(task);
 		return 0;
 	}
 
@@ -928,7 +929,16 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		 * vma/shared policy at addr is NULL.  We
 		 * want to return MPOL_DEFAULT in this case.
 		 */
-		mm = current->mm;
+		if (task == current) {
+			/*
+			 * original behavior allows a kernel task changing its
+			 * own policy to avoid the condition in get_task_mm,
+			 * so we'll directly access
+			 */
+			mm = task->mm;
+			mmget(mm);
+		} else
+			mm = get_task_mm(task);
 		mmap_read_lock(mm);
 		vma = vma_lookup(mm, addr);
 		if (!vma) {
@@ -947,8 +957,10 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		return -EINVAL;
 	else {
 		/* take a reference of the task policy now */
-		pol = current->mempolicy;
+		task_lock(task);
+		pol = task->mempolicy;
 		mpol_get(pol);
+		task_unlock(task);
 	}
 
 	if (!pol) {
@@ -962,12 +974,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			vma = NULL;
 			mmap_read_unlock(mm);
 			err = lookup_node(mm, addr);
+			mmput(mm);
 			if (err < 0)
 				goto out;
 			*policy = err;
-		} else if (pol == current->mempolicy &&
+		} else if (pol == task->mempolicy &&
 				pol->mode == MPOL_INTERLEAVE) {
-			*policy = next_node_in(current->il_prev, pol->nodes);
+			*policy = next_node_in(task->il_prev, pol->nodes);
 		} else {
 			err = -EINVAL;
 			goto out;
@@ -987,9 +1000,9 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		if (mpol_store_user_nodemask(pol)) {
 			*nmask = pol->w.user_nodemask;
 		} else {
-			task_lock(current);
+			task_lock(task);
 			get_policy_nodemask(pol, nmask);
-			task_unlock(current);
+			task_unlock(task);
 		}
 	}
 
@@ -1704,7 +1717,8 @@ SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned long, maxnode,
 }
 
 /* Retrieve NUMA policy */
-static int kernel_get_mempolicy(int __user *policy,
+static int kernel_get_mempolicy(struct task_struct *task,
+				int __user *policy,
 				unsigned long __user *nmask,
 				unsigned long maxnode,
 				unsigned long addr,
@@ -1719,7 +1733,7 @@ static int kernel_get_mempolicy(int __user *policy,
 
 	addr = untagged_addr(addr);
 
-	err = do_get_mempolicy(&pval, &nodes, addr, flags);
+	err = do_get_mempolicy(task, &pval, &nodes, addr, flags);
 
 	if (err)
 		return err;
@@ -1737,7 +1751,8 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 		unsigned long __user *, nmask, unsigned long, maxnode,
 		unsigned long, addr, unsigned long, flags)
 {
-	return kernel_get_mempolicy(policy, nmask, maxnode, addr, flags);
+	return kernel_get_mempolicy(current, policy, nmask, maxnode, addr,
+				    flags);
 }
 
 bool vma_migratable(struct vm_area_struct *vma)
-- 
2.39.1


