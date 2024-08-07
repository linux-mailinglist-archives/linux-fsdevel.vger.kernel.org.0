Return-Path: <linux-fsdevel+bounces-25378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F31F94B3C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0215D28437E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967F15990E;
	Wed,  7 Aug 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLekOaj7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF0155CA0;
	Wed,  7 Aug 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074059; cv=none; b=uUW6XJdJj3PzG7tKvKh0xxqCBXgKIlwHWgyTWyMYNHucvQe9ZBg1gq0BdXNjBmf1Q3LGFLPpfBXeIFDmFXQ6quyGFsQXTaiViu2Csars9Nfgux7Yy4L8NgzbL2wJrqZgY4HMxnEhi8QMU0ZbaO1dzwaOlBxx+ILX/+NeWexivhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074059; c=relaxed/simple;
	bh=/6b0RVTf764MWC/B03hIXQHQ85gqStIXNWpPwHJJCmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqchXUxFeduFbQEOKf4wuP6ri7wQM9jQnR6S0rPWUY1R9bnC3EJL5z066k8v40/M+eUkkx6mMwVSJC5wpZ8ctMMci1Zb6k4w6Yy3+QrnKYH9NCEeHn/2pjqtIiJrfi7qoo6symzgoR2O5wqpTeEhqnnmsM8s09z2hSa9GHhYwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLekOaj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C07CC4AF0D;
	Wed,  7 Aug 2024 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074059;
	bh=/6b0RVTf764MWC/B03hIXQHQ85gqStIXNWpPwHJJCmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLekOaj7CDbD8EyecNyIBc8sjxQzRq7CXInvjerv548cEkiy2Ksdxm2A2zRedMgQh
	 qQe408hJ6cVzKtrjKadFI2IAGBiv1yUCS2hPb3hDV6z6k28hDBLufP9zaku0UyRdI3
	 VzCb9FOXfll84384UXyhZMw3nom1TDukXrLCO6rTIbFC26+HQYs9SRT3JxML+15WTg
	 iTMU9/vgH/NU9JP9Qj+dQ6iJeuGDVKkzBSJJ7MP/5ipkuAYZ5lxw+CokzI0POVBQv0
	 pW5xWgHk98pWXn9pQaXnVrDhmuQ2C+BbbE8IWv0ViV+jx24A4+veuIFXjlOQYhXu2/
	 ntBbsTN87KRng==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	jannh@google.com,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next 08/10] bpf: decouple stack_map_get_build_id_offset() from perf_callchain_entry
Date: Wed,  7 Aug 2024 16:40:27 -0700
Message-ID: <20240807234029.456316-9-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807234029.456316-1-andrii@kernel.org>
References: <20240807234029.456316-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change stack_map_get_build_id_offset() which is used to convert stack
trace IP addresses into build ID+offset pairs. Right now this function
accepts an array of u64s as an input, and uses array of
struct bpf_stack_build_id as an output.

This is problematic because u64 array is coming from
perf_callchain_entry, which is (non-sleepable) RCU protected, so once we
allows sleepable build ID fetching, this all breaks down.

But its actually pretty easy to make stack_map_get_build_id_offset()
works with array of struct bpf_stack_build_id as both input and output.
Which is what this patch is doing, eliminating the dependency on
perf_callchain_entry. We require caller to fill out
bpf_stack_build_id.ip fields (all other can be left uninitialized), and
update in place as we do build ID resolution.

We make sure to READ_ONCE() and cache locally current IP value as we
used it in a few places to find matching VMA and so on. Given this data
is directly accessible and modifiable by user's BPF code, we should make
sure to have a consistent view of it.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/stackmap.c | 49 +++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 770ae8e88016..6457222b0b46 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -124,8 +124,18 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
+/*
+ * Expects all id_offs[i].ip values to be set to correct initial IPs.
+ * They will be subsequently:
+ *   - either adjusted in place to a file offset, if build ID fetching
+ *     succeeds; in this case id_offs[i].build_id is set to correct build ID,
+ *     and id_offs[i].status is set to BPF_STACK_BUILD_ID_VALID;
+ *   - or IP will be kept intact, if build ID fetching failed; in this case
+ *     id_offs[i].build_id is zeroed out and id_offs[i].status is set to
+ *     BPF_STACK_BUILD_ID_IP.
+ */
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
-					  u64 *ips, u32 trace_nr, bool user)
+					  u32 trace_nr, bool user)
 {
 	int i;
 	struct mmap_unlock_irq_work *work = NULL;
@@ -142,30 +152,28 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 		/* cannot access current->mm, fall back to ips */
 		for (i = 0; i < trace_nr; i++) {
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 		}
 		return;
 	}
 
 	for (i = 0; i < trace_nr; i++) {
-		if (range_in_vma(prev_vma, ips[i], ips[i])) {
+		u64 ip = READ_ONCE(id_offs[i].ip);
+
+		if (range_in_vma(prev_vma, ip, ip)) {
 			vma = prev_vma;
-			memcpy(id_offs[i].build_id, prev_build_id,
-			       BUILD_ID_SIZE_MAX);
+			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
 			goto build_id_valid;
 		}
-		vma = find_vma(current->mm, ips[i]);
+		vma = find_vma(current->mm, ip);
 		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 			continue;
 		}
 build_id_valid:
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
-			- vma->vm_start;
+		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 		prev_vma = vma;
 		prev_build_id = id_offs[i].build_id;
@@ -216,7 +224,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len;
+	u32 hash, id, trace_nr, trace_len, i;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -238,15 +246,18 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		return id;
 
 	if (stack_map_use_build_id(map)) {
+		struct bpf_stack_build_id *id_offs;
+
 		/* for build_id+offset, pop a bucket before slow cmp */
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
 			return -ENOMEM;
 		new_bucket->nr = trace_nr;
-		stack_map_get_build_id_offset(
-			(struct bpf_stack_build_id *)new_bucket->data,
-			ips, trace_nr, user);
+		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
+		for (i = 0; i < trace_nr; i++)
+			id_offs[i].ip = ips[i];
+		stack_map_get_build_id_offset(id_offs, trace_nr, user);
 		trace_len = trace_nr * sizeof(struct bpf_stack_build_id);
 		if (hash_matches && bucket->nr == trace_nr &&
 		    memcmp(bucket->data, new_bucket->data, trace_len) == 0) {
@@ -445,10 +456,16 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-	if (user && user_build_id)
-		stack_map_get_build_id_offset(buf, ips, trace_nr, user);
-	else
+	if (user && user_build_id) {
+		struct bpf_stack_build_id *id_offs = buf;
+		u32 i;
+
+		for (i = 0; i < trace_nr; i++)
+			id_offs[i].ip = ips[i];
+		stack_map_get_build_id_offset(buf, trace_nr, user);
+	} else {
 		memcpy(buf, ips, copy_len);
+	}
 
 	if (size > copy_len)
 		memset(buf + copy_len, 0, size - copy_len);
-- 
2.43.5


