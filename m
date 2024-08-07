Return-Path: <linux-fsdevel+bounces-25375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580094B3BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355651C20F5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE3158DA3;
	Wed,  7 Aug 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx+UQOup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5456156256;
	Wed,  7 Aug 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074049; cv=none; b=awoOkCR0zpKAogVyztkBnG2N1HbrLaH4Ab1RZeFa0BcvBKrOE8kibOr0cCW3SRGAdR8igVUzmZKAqdcdDqFfMMHuyXxY3fhlUWLl8dGoeteuEir4LLRNloV+ui14sRh2D4z7kIyfusatHFyqxmpV0DK+PXWG5hHCxsJO4yH/C8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074049; c=relaxed/simple;
	bh=+ANRC7egrGFeIZEWEmdLH7d3bsE3Eu3/XkjVX9QETJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptF5F0Or5XWEWduFlvvTFX71Hl9352ElPQ/xD0o5APYH34H6yM4kFt+E29Fk2vJ6go/yoikz32ptfL83WtN5p7Z+D9QbyAjQNpciR3gJHR5P7f5cum/pvwUldZyJGH/Wvewuu8EvvZxzrWErc7K3BADo3dXqSiG5JNyTTSTIlzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx+UQOup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C567C4AF0B;
	Wed,  7 Aug 2024 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074049;
	bh=+ANRC7egrGFeIZEWEmdLH7d3bsE3Eu3/XkjVX9QETJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mx+UQOupdGNkv5UUsOp5LSuDN2fAEp1rZpKY9FYvW6IuW0nOMeMoeB13Dhhg/huVe
	 g/Z8jAqwZL2Bd8MK4KkEaS+dPLQGkVk9KSdtGY3W1vu8u2X24tpSeE2eoHmbq8Lzju
	 qq9riwn5yaCLqspHHhvog7zzDraI75b/k6xxCL+UpZLA8XgoPOGkWGDJU00ehuXtLF
	 ek6bst5Q6R51q4o8XU0ClvmEKR9KAWCzaPIWxQuhMiDY+IDrvzhXbp4UBmfQiAXFyA
	 vpHWql6ZWaeJaVjnEgCdSBT7hNoYQRl8/zG/zPgKuw313eVP6suckAeSv28XDH+IMC
	 8SZxt82WtmZow==
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
Subject: [PATCH v4 bpf-next 05/10] lib/buildid: rename build_id_parse() into build_id_parse_nofault()
Date: Wed,  7 Aug 2024 16:40:24 -0700
Message-ID: <20240807234029.456316-6-andrii@kernel.org>
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
index f3a15d983444..5e6f842f56f0 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -290,10 +290,12 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
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
@@ -332,6 +334,23 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
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


