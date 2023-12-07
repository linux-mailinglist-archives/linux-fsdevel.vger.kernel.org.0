Return-Path: <linux-fsdevel+bounces-5076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41C807D55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980D9B21018
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C810A2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0O8d2An"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968C137;
	Wed,  6 Dec 2023 16:28:18 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5cfc3a48ab2so1069587b3.0;
        Wed, 06 Dec 2023 16:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701908898; x=1702513698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1EahSaWjn587JobDPcMa6mmsjiJNiTkmxUoMqVlCE8=;
        b=U0O8d2AngkHBzzPDILGcFAw6p0HyTuXy7Efr2BfR2sUiADyAaxwfDzsITB7GVNxId3
         dbRxQIUh6yjdjbDxXu57ongUY6H4wngSTuAOLndlC/dqR5XGUSJQ+j2JDqYo4WzM6ZEu
         BU7q1lh0tm6W4T6sKHS82j0iwFP2i9KVyLahu68Y0j2J94DHF46lXpEQrcRl1MM+86cc
         NhmDI1XN0LNxAYxkzvWwO/TYwQFD5/G5fuTTkxxA1+pSOjF0DnKmM7bxJ/LfMWmqPAdz
         q8ViYM8U0CrAyLGxCPvoY6ZxtBTfL2OmLEee8tGsbsUzglF0GqeeYhaEXGSE1bNhvEej
         f6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701908898; x=1702513698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1EahSaWjn587JobDPcMa6mmsjiJNiTkmxUoMqVlCE8=;
        b=tlDGm+YkeFQpXvhA1tsZa5s94CW47cmRah6wHFJMuozX4ZTg4iPv466t2gb/UxoaLS
         WI9Zh7fOR256yUchlQKKQ7aijJRqPssdiz2rI6Yx0O0czb1+iGwImufprcQm5zX9SG6a
         052bNTAVfrPK5LP35QAfnyqc5s6I/GRjI7QaaGEL6ee01NjjLAYcMwJHvlubaRwGvr7b
         OQCkLKOs1oqzOWmvkdTyuEmYKjZSrV3XTgnMhkojb3E42LJykpmA9qpwHjvV4x/xWpHo
         Vd60RqRh1SRWUKhGQdJKsABuPSb1jDI9y6+CVwfOeVpVQiNf4Rr/cOzGhBes1p08gkzB
         CzIA==
X-Gm-Message-State: AOJu0YzdWj9RypDB7WsWcr3TiBxVl9f0cE2Hpy85j+GESZo6E4YSAmCh
	WqBDBSroUC6s2PkVbSVUpg==
X-Google-Smtp-Source: AGHT+IHBofphJxufL4ShCxUpV+C9+5nfvGyyqF//uUTQHcd+l9eDG4oZDhCnaYTSmI9K3LJ+jqSscA==
X-Received: by 2002:a81:aa0d:0:b0:5d3:d439:aabe with SMTP id i13-20020a81aa0d000000b005d3d439aabemr1632111ywh.26.1701908897789;
        Wed, 06 Dec 2023 16:28:17 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x145-20020a81a097000000b005d82fc8cc92sm19539ywg.105.2023.12.06.16.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:28:17 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com
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
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org
Subject: [RFC PATCH 04/11] mm/mempolicy: create struct mempolicy_args for creating new mempolicies
Date: Wed,  6 Dec 2023 19:27:52 -0500
Message-Id: <20231207002759.51418-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231207002759.51418-1-gregory.price@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
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
 include/linux/mempolicy.h | 14 ++++++++
 mm/mempolicy.c            | 69 +++++++++++++++++++++++++++++----------
 2 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ba09167e80f7..117c5395c6eb 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -61,6 +61,20 @@ struct mempolicy {
 	} wil;
 };
 
+/*
+ * Describes settings of a mempolicy during set/get syscalls and
+ * kernel internal calls to do_set_mempolicy()
+ */
+struct mempolicy_args {
+	unsigned short mode;		/* policy mode */
+	unsigned short mode_flags;	/* policy mode flags */
+	nodemask_t *policy_nodes;	/* get/set/mbind */
+	int policy_node;		/* get: policy node information */
+	unsigned long addr;		/* get: vma address */
+	int addr_node;			/* get: node the address belongs to */
+	int home_node;			/* mbind: use MPOL_MF_HOME_NODE */
+};
+
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eec807d0c6a1..4c343218c033 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -268,10 +268,12 @@ static int mpol_set_nodemask(struct mempolicy *pol,
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
@@ -820,8 +822,7 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+static long do_set_mempolicy(struct mempolicy_args *args)
 {
 	struct mempolicy *new, *old;
 	NODEMASK_SCRATCH(scratch);
@@ -830,14 +831,14 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
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
@@ -1235,8 +1236,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 #endif
 
 static long do_mbind(unsigned long start, unsigned long len,
-		     unsigned short mode, unsigned short mode_flags,
-		     nodemask_t *nmask, unsigned long flags)
+		     struct mempolicy_args *margs, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
@@ -1256,7 +1256,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
 
-	if (mode == MPOL_DEFAULT)
+	if (margs->mode == MPOL_DEFAULT)
 		flags &= ~MPOL_MF_STRICT;
 
 	len = PAGE_ALIGN(len);
@@ -1267,7 +1267,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (end == start)
 		return 0;
 
-	new = mpol_new(mode, mode_flags, nmask);
+	new = mpol_new(margs);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
@@ -1284,7 +1284,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
 			mmap_write_lock(mm);
-			err = mpol_set_nodemask(new, nmask, scratch);
+			err = mpol_set_nodemask(new, margs->policy_nodes,
+						scratch);
 			if (err)
 				mmap_write_unlock(mm);
 		} else
@@ -1298,7 +1299,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	 * Lock the VMAs before scanning for pages to migrate,
 	 * to ensure we don't miss a concurrently inserted page.
 	 */
-	nr_failed = queue_pages_range(mm, start, end, nmask,
+	nr_failed = queue_pages_range(mm, start, end, margs->policy_nodes,
 			flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelist);
 
 	if (nr_failed < 0) {
@@ -1503,6 +1504,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
 {
+	struct mempolicy_args margs;
 	unsigned short mode_flags;
 	nodemask_t nodes;
 	int lmode = mode;
@@ -1517,7 +1519,12 @@ static long kernel_mbind(unsigned long start, unsigned long len,
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
@@ -1598,6 +1605,7 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 				 unsigned long maxnode)
 {
+	struct mempolicy_args args;
 	unsigned short mode_flags;
 	nodemask_t nodes;
 	int lmode = mode;
@@ -1611,7 +1619,12 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
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
@@ -2877,6 +2890,7 @@ static int shared_policy_replace(struct shared_policy *sp, pgoff_t start,
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 {
 	int ret;
+	struct mempolicy_args margs;
 
 	sp->root = RB_ROOT;		/* empty tree == default mempolicy */
 	rwlock_init(&sp->lock);
@@ -2889,8 +2903,12 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
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
 
@@ -2998,6 +3016,7 @@ static inline void __init check_numabalancing_enable(void)
 
 void __init numa_policy_init(void)
 {
+	struct mempolicy_args args;
 	nodemask_t interleave_nodes;
 	unsigned long largest = 0;
 	int nid, prefer = 0;
@@ -3043,7 +3062,11 @@ void __init numa_policy_init(void)
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
@@ -3052,7 +3075,12 @@ void __init numa_policy_init(void)
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
@@ -3082,6 +3110,7 @@ static const char * const policy_modes[] =
  */
 int mpol_parse_str(char *str, struct mempolicy **mpol)
 {
+	struct mempolicy_args margs;
 	struct mempolicy *new = NULL;
 	unsigned short mode_flags;
 	nodemask_t nodes;
@@ -3168,7 +3197,11 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
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


