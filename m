Return-Path: <linux-fsdevel+bounces-6010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FBE8121BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FC31C21410
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B624D83AE8;
	Wed, 13 Dec 2023 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl05bh+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE2DB7;
	Wed, 13 Dec 2023 14:41:30 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-dbcd348f64cso1054517276.2;
        Wed, 13 Dec 2023 14:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507289; x=1703112089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfMI3UqrzvxDBeW3bOr4THS2M0DwKsJGjO9SMlrMd7s=;
        b=Wl05bh+IDEYwJRmOAkHE6lSvm50AwyNiuIgQgv4HuQydvwAD8c9MiB9XeM5NDxdHCt
         OqK8sfcpAgvqkdk5yh6c3uamQNwL31od1zlCT2YPcDAe2/hXmfTla80nRva/LMCL5qlv
         kLr56gG7JDDQwCRXeJ/zCMJeEBcIhHV/VNqOtAsARV1r+E31qOdkQYVVLPO39F6BpYUL
         p4iN477goSn0shjtJ9vnnDH2ffO1HDduwEI8O3anQwVglp4RChCLyiI9DUGIsAZXRNR+
         7p87nAM/7vclkIJtVJ9dInZ/0kZfdaCxdUa1hO3jDI0rfNEagxHYw9Jxmc79XZ7QNOPw
         Fxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507289; x=1703112089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfMI3UqrzvxDBeW3bOr4THS2M0DwKsJGjO9SMlrMd7s=;
        b=osNe2G/ZsMa1soxUwfwxOGEd5kdaZHiL1zoaYQaNx5WysjDlQPkfDTTr5IiWnGp+mS
         ic2RyoL5OOgKJlGY91dS5ro4Boq17JwZrV6LIZO9YlfH8M08Xqb8SwR+4q5qCYCiB5BV
         B2yaEjDkrxazbY9U+ged9JN9sZDrYmJeuF+cExUGKH8xqeHm3R/N4syzofdib9y3c2mR
         UKPX9KIKovFwd2P9hLH9/S1uIwpUTyqBZLyXzbJbbSKk6vl1h7uZ6Fj0x/oc0/QM1fkI
         RkEFb65Msdh/eXWJ1fxyzvunkLLBRcauW3e97QMFsWQWJRgsyU/BVHdiqicuJrJ9ALh3
         MOGg==
X-Gm-Message-State: AOJu0YzO1htpPVi1k/NFqaEWo8qMUZ4jz7ZDZEKn4Ri2Dc3m4tgDPcGN
	xBE63JHMWAK16gi+SykUpw==
X-Google-Smtp-Source: AGHT+IEeiYqRkCpvsh7P5zbItpNhinYXbnUS63AGBfoUq2wsL39AuGtF4e1SxTf0yHFCZp6l4gt4CA==
X-Received: by 2002:a81:914d:0:b0:5e1:e4a6:db95 with SMTP id i74-20020a81914d000000b005e1e4a6db95mr3450276ywg.40.1702507289410;
        Wed, 13 Dec 2023 14:41:29 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm5050583ywf.42.2023.12.13.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:29 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v3 04/11] mm/mempolicy: create struct mempolicy_args for creating new mempolicies
Date: Wed, 13 Dec 2023 17:41:11 -0500
Message-Id: <20231213224118.1949-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231213224118.1949-1-gregory.price@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new kernel structure `struct mempolicy_args`,
intended to be used for an extensible get/set_mempolicy interface.

This implements the fields required to support the existing syscall
interfaces interfaces, but does not expose any user-facing arg
structure.

mpol_new is refactored to take the argument structure so that future
mempolicy extensions can all be managed in the mempolicy constructor.

The get_mempolicy and mbind syscalls are refactored to utilize the
new argument structure, as are all the callers of mpol_new() and
do_set_mempolicy.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h | 12 +++++++
 mm/mempolicy.c            | 69 +++++++++++++++++++++++++++++----------
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ba09167e80f7..aeac19dfc2b6 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -61,6 +61,18 @@ struct mempolicy {
 	} wil;
 };
 
+/*
+ * Describes settings of a mempolicy during set/get syscalls and
+ * kernel internal calls to do_set_mempolicy()
+ */
+struct mempolicy_args {
+	unsigned short mode;		/* policy mode */
+	unsigned short mode_flags;	/* policy mode flags */
+	int home_node;			/* mbind: use MPOL_MF_HOME_NODE */
+	nodemask_t *policy_nodes;	/* get/set/mbind */
+	int policy_node;		/* get: policy node information */
+};
+
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e55a8fa13e45..a2353b208af7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -265,10 +265,12 @@ static int mpol_set_nodemask(struct mempolicy *pol,
  * This function just creates a new policy, does some check and simple
  * initialization. You must invoke mpol_set_nodemask() to set nodes.
  */
-static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
-				  nodemask_t *nodes)
+static struct mempolicy *mpol_new(struct mempolicy_args *args)
 {
 	struct mempolicy *policy;
+	unsigned short mode = args->mode;
+	unsigned short flags = args->mode_flags;
+	nodemask_t *nodes = args->policy_nodes;
 
 	if (mode == MPOL_DEFAULT) {
 		if (nodes && !nodes_empty(*nodes))
@@ -817,8 +819,7 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+static long do_set_mempolicy(struct mempolicy_args *args)
 {
 	struct mempolicy *new, *old;
 	NODEMASK_SCRATCH(scratch);
@@ -827,14 +828,14 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	if (!scratch)
 		return -ENOMEM;
 
-	new = mpol_new(mode, flags, nodes);
+	new = mpol_new(args);
 	if (IS_ERR(new)) {
 		ret = PTR_ERR(new);
 		goto out;
 	}
 
 	task_lock(current);
-	ret = mpol_set_nodemask(new, nodes, scratch);
+	ret = mpol_set_nodemask(new, args->policy_nodes, scratch);
 	if (ret) {
 		task_unlock(current);
 		mpol_put(new);
@@ -1232,8 +1233,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 #endif
 
 static long do_mbind(unsigned long start, unsigned long len,
-		     unsigned short mode, unsigned short mode_flags,
-		     nodemask_t *nmask, unsigned long flags)
+		     struct mempolicy_args *margs, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
@@ -1253,7 +1253,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
 
-	if (mode == MPOL_DEFAULT)
+	if (margs->mode == MPOL_DEFAULT)
 		flags &= ~MPOL_MF_STRICT;
 
 	len = PAGE_ALIGN(len);
@@ -1264,7 +1264,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (end == start)
 		return 0;
 
-	new = mpol_new(mode, mode_flags, nmask);
+	new = mpol_new(margs);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
@@ -1281,7 +1281,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
 			mmap_write_lock(mm);
-			err = mpol_set_nodemask(new, nmask, scratch);
+			err = mpol_set_nodemask(new, margs->policy_nodes,
+						scratch);
 			if (err)
 				mmap_write_unlock(mm);
 		} else
@@ -1295,7 +1296,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	 * Lock the VMAs before scanning for pages to migrate,
 	 * to ensure we don't miss a concurrently inserted page.
 	 */
-	nr_failed = queue_pages_range(mm, start, end, nmask,
+	nr_failed = queue_pages_range(mm, start, end, margs->policy_nodes,
 			flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelist);
 
 	if (nr_failed < 0) {
@@ -1500,6 +1501,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
 {
+	struct mempolicy_args margs;
 	unsigned short mode_flags;
 	nodemask_t nodes;
 	int lmode = mode;
@@ -1514,7 +1516,12 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
-	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
+	memset(&margs, 0, sizeof(margs));
+	margs.mode = lmode;
+	margs.mode_flags = mode_flags;
+	margs.policy_nodes = &nodes;
+
+	return do_mbind(start, len, &margs, flags);
 }
 
 SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
@@ -1595,6 +1602,7 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 				 unsigned long maxnode)
 {
+	struct mempolicy_args args;
 	unsigned short mode_flags;
 	nodemask_t nodes;
 	int lmode = mode;
@@ -1608,7 +1616,12 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
-	return do_set_mempolicy(lmode, mode_flags, &nodes);
+	memset(&args, 0, sizeof(args));
+	args.mode = lmode;
+	args.mode_flags = mode_flags;
+	args.policy_nodes = &nodes;
+
+	return do_set_mempolicy(&args);
 }
 
 SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
@@ -2890,6 +2903,7 @@ static int shared_policy_replace(struct shared_policy *sp, pgoff_t start,
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 {
 	int ret;
+	struct mempolicy_args margs;
 
 	sp->root = RB_ROOT;		/* empty tree == default mempolicy */
 	rwlock_init(&sp->lock);
@@ -2902,8 +2916,12 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		if (!scratch)
 			goto put_mpol;
 
+		memset(&margs, 0, sizeof(margs));
+		margs.mode = mpol->mode;
+		margs.mode_flags = mpol->flags;
+		margs.policy_nodes = &mpol->w.user_nodemask;
 		/* contextualize the tmpfs mount point mempolicy to this file */
-		npol = mpol_new(mpol->mode, mpol->flags, &mpol->w.user_nodemask);
+		npol = mpol_new(&margs);
 		if (IS_ERR(npol))
 			goto free_scratch; /* no valid nodemask intersection */
 
@@ -3011,6 +3029,7 @@ static inline void __init check_numabalancing_enable(void)
 
 void __init numa_policy_init(void)
 {
+	struct mempolicy_args args;
 	nodemask_t interleave_nodes;
 	unsigned long largest = 0;
 	int nid, prefer = 0;
@@ -3056,7 +3075,11 @@ void __init numa_policy_init(void)
 	if (unlikely(nodes_empty(interleave_nodes)))
 		node_set(prefer, interleave_nodes);
 
-	if (do_set_mempolicy(MPOL_INTERLEAVE, 0, &interleave_nodes))
+	memset(&args, 0, sizeof(args));
+	args.mode = MPOL_INTERLEAVE;
+	args.policy_nodes = &interleave_nodes;
+
+	if (do_set_mempolicy(&args))
 		pr_err("%s: interleaving failed\n", __func__);
 
 	check_numabalancing_enable();
@@ -3065,7 +3088,12 @@ void __init numa_policy_init(void)
 /* Reset policy of current process to default */
 void numa_default_policy(void)
 {
-	do_set_mempolicy(MPOL_DEFAULT, 0, NULL);
+	struct mempolicy_args args;
+
+	memset(&args, 0, sizeof(args));
+	args.mode = MPOL_DEFAULT;
+
+	do_set_mempolicy(&args);
 }
 
 /*
@@ -3095,6 +3123,7 @@ static const char * const policy_modes[] =
  */
 int mpol_parse_str(char *str, struct mempolicy **mpol)
 {
+	struct mempolicy_args margs;
 	struct mempolicy *new = NULL;
 	unsigned short mode_flags;
 	nodemask_t nodes;
@@ -3181,7 +3210,11 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 			goto out;
 	}
 
-	new = mpol_new(mode, mode_flags, &nodes);
+	memset(&margs, 0, sizeof(margs));
+	margs.mode = mode;
+	margs.mode_flags = mode_flags;
+	margs.policy_nodes = &nodes;
+	new = mpol_new(&margs);
 	if (IS_ERR(new))
 		goto out;
 
-- 
2.39.1


