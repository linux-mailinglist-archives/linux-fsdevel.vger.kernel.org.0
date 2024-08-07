Return-Path: <linux-fsdevel+bounces-25376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0821594B3C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89D31F22B7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9115687C;
	Wed,  7 Aug 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPXt2317"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7D156256;
	Wed,  7 Aug 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074053; cv=none; b=OF89sXLn26VMPpisn1T8K9oOSGihke4iNmxdTOjrKGcMnD8nsekMWIjQ3rFudRimPL5YoXe4GRe3s0U8saUrstH0AcXtH9X9DrMyM1pIiJoas/0ZiFM440FwiPjVpMVhGYiPej3k/ePobVozeQZ+dXakqK9gg/RLVGnTTttb7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074053; c=relaxed/simple;
	bh=+8Hu2Iz9iRzq1KNxxotksrVecx/GyqwlDp+5IEhz7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgxOLTSVFjfKiGMI4nSWzhqnZmBucFUBI27FXPDNBXgEuOnLf2GB9NxRpwJYZ5aUbzG5ow+FPPhnc1e35YrNuRxpHg3olZDrECIm/U3LtDLt03LC0Bp3u61RdQ7e5axmrsLRz9yIc0bQMKByh10Ar4n8IFRfz/UBJFRsu6ZIt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPXt2317; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF407C32781;
	Wed,  7 Aug 2024 23:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074052;
	bh=+8Hu2Iz9iRzq1KNxxotksrVecx/GyqwlDp+5IEhz7ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPXt2317cQpWAWI1lH5J+oAPQ9GqGIuT+iioboZTK9RtQftH407BJZiIosJ+Z7wIh
	 AIqgETkiBxO9Qaoz3KxiRKFwDn7C9nPVyphdW+sUuoK1ihUxx8k46dQPiixaLRjbBV
	 DjAKBIPSWkhvdCLVef9mahinrns1TrSieilqQfTOdVcnXQhgvKMWYue1yM/dyrcIT9
	 SDH4w8BiIMhhQw2UKU6G+4bpfnkmcfmSSzoPs5YtIhhveo9Us/r2Zo9tkm/YX/2/Oc
	 B2mhbyBPmSLWRdBZoO5LpvqeEXDewOt8uQCL+kQECTXJVXVDqetiuzUDgYKj9lBLcr
	 FRZlZgCH3j+Ww==
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
	Andrii Nakryiko <andrii@kernel.org>,
	Omar Sandoval <osandov@fb.com>
Subject: [PATCH v4 bpf-next 06/10] lib/buildid: implement sleepable build_id_parse() API
Date: Wed,  7 Aug 2024 16:40:25 -0700
Message-ID: <20240807234029.456316-7-andrii@kernel.org>
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

Extend freader with a flag specifying whether it's OK to cause page
fault to fetch file data that is not already physically present in
memory. With this, it's now easy to wait for data if the caller is
running in sleepable (faultable) context.

We utilize read_cache_folio() to bring the desired folio into page
cache, after which the rest of the logic works just the same at folio level.

Suggested-by: Omar Sandoval <osandov@fb.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 5e6f842f56f0..e1c01b23efd8 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -20,6 +20,7 @@ struct freader {
 			struct folio *folio;
 			void *addr;
 			loff_t folio_off;
+			bool may_fault;
 		};
 		struct {
 			const char *data;
@@ -29,12 +30,13 @@ struct freader {
 };
 
 static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
-				   struct address_space *mapping)
+				   struct address_space *mapping, bool may_fault)
 {
 	memset(r, 0, sizeof(*r));
 	r->buf = buf;
 	r->buf_sz = buf_sz;
 	r->mapping = mapping;
+	r->may_fault = may_fault;
 }
 
 static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
@@ -63,6 +65,11 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 	freader_put_folio(r);
 
 	r->folio = filemap_get_folio(r->mapping, file_off >> PAGE_SHIFT);
+
+	/* if sleeping is allowed, wait for the page, if necessary */
+	if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)))
+		r->folio = read_cache_folio(r->mapping, file_off >> PAGE_SHIFT, NULL, NULL);
+
 	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
 		if (!IS_ERR(r->folio))
 			folio_put(r->folio);
@@ -284,18 +291,8 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
 #define MAX_FREADER_BUF_SZ 64
 
-/*
- * Parse build ID of ELF file mapped to vma
- * @vma:      vma object
- * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
- * @size:     returns actual build id size in case of success
- *
- * Assumes no page fault can be taken, so if relevant portions of ELF file are
- * not already paged in, fetching of build ID fails.
- *
- * Return: 0 on success; negative error, otherwise
- */
-int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
+static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
+			    __u32 *size, bool may_fault)
 {
 	const Elf32_Ehdr *ehdr;
 	struct freader r;
@@ -306,7 +303,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
-	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping);
+	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping, may_fault);
 
 	/* fetch first 18 bytes of ELF header for checks */
 	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
@@ -334,6 +331,22 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
 	return ret;
 }
 
+/*
+ * Parse build ID of ELF file mapped to vma
+ * @vma:      vma object
+ * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
+ * @size:     returns actual build id size in case of success
+ *
+ * Assumes no page fault can be taken, so if relevant portions of ELF file are
+ * not already paged in, fetching of build ID fails.
+ *
+ * Return: 0 on success; negative error, otherwise
+ */
+int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
+{
+	return __build_id_parse(vma, build_id, size, false /* !may_fault */);
+}
+
 /*
  * Parse build ID of ELF file mapped to VMA
  * @vma:      vma object
@@ -347,8 +360,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
-	/* fallback to non-faultable version for now */
-	return build_id_parse_nofault(vma, build_id, size);
+	return __build_id_parse(vma, build_id, size, true /* may_fault */);
 }
 
 /**
-- 
2.43.5


