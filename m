Return-Path: <linux-fsdevel+bounces-25735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F352C94FAB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6028EB2260E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14775C156;
	Tue, 13 Aug 2024 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdGNIV37"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD0A3D;
	Tue, 13 Aug 2024 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508995; cv=none; b=lzPE4sOkF9lEshBOF+uOY6RC+c+oVvUNSwtJon1G2ds98CEA9bgYiVeHZ/tch3oKXjIlzevaoyTtd3kpKL8yOW4l4W9K5FmB8lhtOPeb56i5LSuuklDcDdggkfTYluvHBdx+UQp5rWvb6zUlUYLeMYGWMCxXIHcLr2jy+yKzoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508995; c=relaxed/simple;
	bh=SZpxNEh3KqXS8ONEzMbLb+AANAOpECockBiI1vWhQs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+v1niNWU3j4ExgbFKALsjXGCIJfY7nbDhBavYT4SYJ+Q7VLhgF10wmp7DkbMV8yegt7DLWSLwjoMnnyRX4HSR7ITTqYOrkOZ+bOtheHx4Eqg5KkW0bs2fT0T5Dgs//4gIJL6/nSW1qvRnjO1puk35XYeUVTissJPGFVQ8Ti3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdGNIV37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FAEC4AF0D;
	Tue, 13 Aug 2024 00:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508995;
	bh=SZpxNEh3KqXS8ONEzMbLb+AANAOpECockBiI1vWhQs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdGNIV37CglropA7SFCfluYhFC8BUiLMNPygvEGC2zqaaMPGZB0BtzSg1LPIi2VGH
	 77bE2OXKjQQDVby2J467VTbFxMYp0QGdG3dR46MvpSDXbjPSxP/NJI5tVLAC9xlRn6
	 3r0lgI1cFdeUkZi/Wg6gD8qFfJQ2Gqjj3i15Q1NyH5CjvEVyMdy3I+Bx9QhOHOygLw
	 UpA7TRL9VG3kWRyjG3Cioo/DBtnPT5alCopH2BkzZZUSukKBhl3Cx1NC8UyGI9bxaE
	 EUlaW+B8m1DHGynHAIKyi1tlBcfEEUcunTDglOQ77VNikLFPKFYWAnWYsVT2bbWVU7
	 e94TLmLKqUmmA==
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
Subject: [PATCH v5 bpf-next 06/10] lib/buildid: implement sleepable build_id_parse() API
Date: Mon, 12 Aug 2024 17:29:28 -0700
Message-ID: <20240813002932.3373935-7-andrii@kernel.org>
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
 lib/buildid.c | 52 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index b33d960f085d..e78bef392cfd 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -16,10 +16,11 @@ struct freader {
 	int err;
 	union {
 		struct {
-			struct address_space *mapping;
+			struct file *file;
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
+				   struct file *file, bool may_fault)
 {
 	memset(r, 0, sizeof(*r));
 	r->buf = buf;
 	r->buf_sz = buf_sz;
-	r->mapping = mapping;
+	r->file = file;
+	r->may_fault = may_fault;
 }
 
 static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
@@ -62,7 +64,14 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 
 	freader_put_folio(r);
 
-	r->folio = filemap_get_folio(r->mapping, file_off >> PAGE_SHIFT);
+	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
+
+	/* if sleeping is allowed, wait for the page, if necessary */
+	if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
+		r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
+					    NULL, r->file);
+	}
+
 	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
 		if (!IS_ERR(r->folio))
 			folio_put(r->folio);
@@ -287,18 +296,8 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
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
@@ -309,7 +308,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
-	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping);
+	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);
 
 	/* fetch first 18 bytes of ELF header for checks */
 	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
@@ -337,6 +336,22 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
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
@@ -350,8 +365,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
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


