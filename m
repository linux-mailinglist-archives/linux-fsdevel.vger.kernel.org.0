Return-Path: <linux-fsdevel+bounces-25734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6194FAB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4971D282816
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2EB641;
	Tue, 13 Aug 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWmKvvbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A6AD31;
	Tue, 13 Aug 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508992; cv=none; b=a4wUGrg8Hp53VGzbPtdFrsBl8f+rROdwPr2HJgRR2b5Tg0F/o6D6KzEKm5qcsbD/AaD+INUhW4ORCikcypi/zu58f1jjax1NgEqcdZ7+dLkxDIP0MfGY00rGse0dYITVqK5GS6SHjm/71S++QO/za2NyMLOPPEWNEbw+jxxRJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508992; c=relaxed/simple;
	bh=avz7wz2KTZz1lZ8tpXBxD2kwVdHJhhzASQO4Ib+3tWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7h3yrgGPBenIXy5WLsQaDzMrF5W+5bqhbdoxWeG0t8D/g4BZU+CZJiHyMgfarew6VdyCXrqdDHlVAMbZ9UZ5fCnyUg927X3if7NaPg7bI9os3DesDwzXc5eE57ZfLGVOkAyPC/ierBKm92pPhNeMAfkwYVvwcN8EC2wbfBAc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWmKvvbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEFEC4AF0D;
	Tue, 13 Aug 2024 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508992;
	bh=avz7wz2KTZz1lZ8tpXBxD2kwVdHJhhzASQO4Ib+3tWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWmKvvbgOxSygVyyz6LOLRs1rQDdRzkKiw/2pGgzmwGIXdoM68F1FuwTrxVGijkwC
	 Bn0c4fYPsLY7fqUD2KQJyjrGnuMMt+JFTRyiJvvwQTO/Buc6qptLTOo7XhNDfOfZzs
	 J10bg3fkNHIXggVRwTGuYRSJdWWuNDd4IMGLHurhWDDbdgb6t2fA3LB6eGvwYXuIG+
	 dfY7ph7jLPD6EQcveh4BQyHaoSHTmPLpN8NxiJcljt7UOhuU3aVhpLNzr1EMvrlr7Q
	 mRWID2bIRNPpq7Q1AOqcmjrTlfgScdIIp2434KXjrRekbpEvWtX7XKOlK5+kF3veuW
	 iDGKZ4fUvCmnA==
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
Subject: [PATCH v5 bpf-next 05/10] lib/buildid: rename build_id_parse() into build_id_parse_nofault()
Date: Mon, 12 Aug 2024 17:29:27 -0700
Message-ID: <20240813002932.3373935-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813002932.3373935-1-andrii@kernel.org>
References: <20240813002932.3373935-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it clear that build_id_parse() assumes that it can take no page
fault by renaming it and current few users to build_id_parse_nofault().

Also add build_id_parse() stub which for now falls back to non-sleepable
implementation, but will be changed in subsequent patches to take
advantage of sleepable context. PROCMAP_QUERY ioctl() on
/proc/<pid>/maps file is using build_id_parse() and will automatically
take advantage of more reliable sleepable context implementation.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/buildid.h |  4 ++--
 kernel/bpf/stackmap.c   |  2 +-
 kernel/events/core.c    |  2 +-
 lib/buildid.c           | 25 ++++++++++++++++++++++---
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 20aa3c2d89f7..014a88c41073 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -7,8 +7,8 @@
 #define BUILD_ID_SIZE_MAX 20
 
 struct vm_area_struct;
-int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
-		   __u32 *size);
+int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
+int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index c99f8e5234ac..770ae8e88016 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -156,7 +156,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			goto build_id_valid;
 		}
 		vma = find_vma(current->mm, ips[i]);
-		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
+		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..c263a8b0ce54 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8851,7 +8851,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
 	if (atomic_read(&nr_build_id_events))
-		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_size);
 
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
diff --git a/lib/buildid.c b/lib/buildid.c
index 8296428ff82f..b33d960f085d 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -293,10 +293,12 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
  *
- * Return: 0 on success, -EINVAL otherwise
+ * Assumes no page fault can be taken, so if relevant portions of ELF file are
+ * not already paged in, fetching of build ID fails.
+ *
+ * Return: 0 on success; negative error, otherwise
  */
-int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
-		   __u32 *size)
+int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
 	const Elf32_Ehdr *ehdr;
 	struct freader r;
@@ -335,6 +337,23 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	return ret;
 }
 
+/*
+ * Parse build ID of ELF file mapped to VMA
+ * @vma:      vma object
+ * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
+ * @size:     returns actual build id size in case of success
+ *
+ * Assumes faultable context and can cause page faults to bring in file data
+ * into page cache.
+ *
+ * Return: 0 on success; negative error, otherwise
+ */
+int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
+{
+	/* fallback to non-faultable version for now */
+	return build_id_parse_nofault(vma, build_id, size);
+}
+
 /**
  * build_id_parse_buf - Get build ID from a buffer
  * @buf:      ELF note section(s) to parse
-- 
2.43.5


