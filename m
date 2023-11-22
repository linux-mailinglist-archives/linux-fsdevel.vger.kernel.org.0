Return-Path: <linux-fsdevel+bounces-3482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D97F523B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB398B2121B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69B1C683;
	Wed, 22 Nov 2023 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb0vDsYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BD2D40;
	Wed, 22 Nov 2023 13:12:20 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6c115026985so264223b3a.1;
        Wed, 22 Nov 2023 13:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687540; x=1701292340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVrRu5wbv05JVXCiU4W4p4q4IBiu16aLNt9pxHyDOm8=;
        b=Jb0vDsYDRkJlIf0Tw8qaMnVNgSJz3dbYeAhXrON2LFbDOUYDthhzBWLawt8M84BrdS
         ohm23n5Req7+V0xKcUShqijp723+AZiSaPL9+EQ6E9QD76SrALyVO5lKiJwYIriaDphf
         Ik/SDLSSGOBRBTCv0Ro7TmtAgufAI8LX5n5me6lSgv55AxpieK8d7wNIRifPKZc4azTS
         Pnw+tmSLIZSVX0Nt70m65O1un4tTpzEwDLf/RREzYQwrioYId8mppl7tcSbszD1Mea9D
         k2Es6xKdz6HfTmJx2vqNYKheSrtXZPfgyF0ELKgg/Q8gyAd2GzBUiemz3hIxuNi2PGpX
         1/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687540; x=1701292340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVrRu5wbv05JVXCiU4W4p4q4IBiu16aLNt9pxHyDOm8=;
        b=aQorblcMEeQ9cTVg8UpDCvY2VQqMrPflSPcxncnaDFKg5G6tsbkKALor0ijOH/aSjI
         zsu55cdvOAbzc+fJ6ZUKrJmF7YNJrSJVEW37ds5WbL2VyKT6RvptCeJUJ82mlgNLoU0n
         w7bTLUdqtkU+N9XCMHn7VyVnSPCJsYxIWfTiyjjJJFhEMDcj5k9b7zSgTCLHvgyJNhKt
         zWhM92hCdhj2U7qUQ0nheheXaXM/NibxrCBxCqUCOVkedQyapuYdUunPFYaJs5hyHUWH
         yQ2WawqVdDgvgznAsnNmfcmPz7orqdFROfW3K1qfsQ1m6a4+dP8FL1EGmzm+ow+YOa2F
         oN2g==
X-Gm-Message-State: AOJu0Yz3lV4pgz/DhHx4+LgBFUHPZsNc55r+oWq20/5SXRvHZ7RThHHh
	UHDILxyJ75yTnBu0VGtmig==
X-Google-Smtp-Source: AGHT+IEhhVXk/VdCpqlemyCiB0SWUWiIBbhHHB1UaPHoDn3xJW2QhnBhVaPfSnRII43jNAanPH6BAg==
X-Received: by 2002:a05:6a21:9706:b0:18a:f1f5:c4ae with SMTP id ub6-20020a056a21970600b0018af1f5c4aemr3137822pzb.42.1700687540034;
        Wed, 22 Nov 2023 13:12:20 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:19 -0800 (PST)
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
Subject: [RFC PATCH 05/11] mm/mempolicy: modify set_mempolicy_home_node to take a task argument
Date: Wed, 22 Nov 2023 16:11:54 -0500
Message-Id: <20231122211200.31620-6-gregory.price@memverge.com>
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
    set_mempolicy_home_node

First we refactor set_mempolicy_home_node to __set_mempolicy_home_node
which accepts a task argument, and change the syscall definition to pass
in (current).

The only functional change in this patch is related to the way task->mm
is acquired. Originally, set_mempolicy_home_node would acquire task->mm
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
get_task_mm to safely access the mm.  We always take a reference
to the mm to keep the cleanup semantics simple.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 62 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4519f39b1a07..540163f5d349 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1521,39 +1521,67 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
-SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
-		unsigned long, home_node, unsigned long, flags)
+static long __set_mempolicy_home_node(struct task_struct *task,
+				      unsigned long start,
+				      unsigned long len,
+				      unsigned long home_node,
+				      unsigned long flags)
 {
-	struct mm_struct *mm = current->mm;
+	struct mm_struct *mm;
 	struct vm_area_struct *vma, *prev;
 	struct mempolicy *new, *old;
 	unsigned long end;
 	int err = -ENOENT;
+
+	/*
+	 * Behavior when task == current allows a task modifying itself
+	 * to bypass the check in get_task_mm and acquire the mm directly
+	 */
+	if (task == current) {
+		mm = task->mm;
+		mmget(mm);
+	} else
+		mm = get_task_mm(task);
+
+	if (!mm)
+		return -ENODEV;
+
 	VMA_ITERATOR(vmi, mm, start);
 
 	start = untagged_addr(start);
-	if (start & ~PAGE_MASK)
-		return -EINVAL;
+	if (start & ~PAGE_MASK) {
+		err = -EINVAL;
+		goto mm_out;
+	}
 	/*
 	 * flags is used for future extension if any.
 	 */
-	if (flags != 0)
-		return -EINVAL;
+	if (flags != 0) {
+		err = -EINVAL;
+		goto mm_out;
+	}
 
 	/*
 	 * Check home_node is online to avoid accessing uninitialized
 	 * NODE_DATA.
 	 */
-	if (home_node >= MAX_NUMNODES || !node_online(home_node))
-		return -EINVAL;
+	if (home_node >= MAX_NUMNODES || !node_online(home_node)) {
+		err = -EINVAL;
+		goto mm_out;
+	}
 
 	len = PAGE_ALIGN(len);
 	end = start + len;
 
-	if (end < start)
-		return -EINVAL;
-	if (end == start)
-		return 0;
+	if (end < start) {
+		err = -EINVAL;
+		goto mm_out;
+	}
+	if (end == start) {
+		err = 0;
+		goto mm_out;
+	}
+
 	mmap_write_lock(mm);
 	prev = vma_prev(&vmi);
 	for_each_vma_range(vmi, vma, end) {
@@ -1585,9 +1613,17 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 			break;
 	}
 	mmap_write_unlock(mm);
+mm_out:
+	mmput(mm);
 	return err;
 }
 
+SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
+		unsigned long, home_node, unsigned long, flags)
+{
+	return __set_mempolicy_home_node(current, start, len, home_node, flags);
+}
+
 SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 		unsigned long, mode, const unsigned long __user *, nmask,
 		unsigned long, maxnode, unsigned int, flags)
-- 
2.39.1


