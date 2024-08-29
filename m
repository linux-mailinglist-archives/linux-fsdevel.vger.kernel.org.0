Return-Path: <linux-fsdevel+bounces-27930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E8964D17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341BC283D2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F31B86C7;
	Thu, 29 Aug 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWZIwYJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F51B78E7;
	Thu, 29 Aug 2024 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953374; cv=none; b=qwSgTLhvRcc/H4pYeNPMDjTNxYG1NxXIfnrO76tM/2yITfYGPduK/a/PdFEb3aOZhj2GY4gxLK9f/X8EmmjIwOVVo+sHHQdnXOwV5EZ9fD2umB1hjWBUJ5K1gnilLwD2lftZ9duYRPlOmxj8vc7Sqdy1LJU1J/msXgZni89DjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953374; c=relaxed/simple;
	bh=fCwSimqQps0x37cNpSBPuZZv0BI1f3GW/HwGWSK6VXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGwbqdt9LJnRdtOZHKUR6LJcmMJDRG/45i5XD70f112KZdSbV4CCXgWzDtWwpqGQ8iicwU9EJTpSmszahJjrnb/3hhPtLuV7EtyTccfnfPvV1lqotsdNJi8eG/xa41H/VVXOD+BqmE2awSbDOVjEtpL60Iz7GugTbPeExzhX5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWZIwYJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418F3C4CEC1;
	Thu, 29 Aug 2024 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953374;
	bh=fCwSimqQps0x37cNpSBPuZZv0BI1f3GW/HwGWSK6VXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWZIwYJtQmn+LkoSZ3Jlq0eKfKvTkd3g+cHFDhLEZBB3AhDDZl/QK43WNZgezjRmJ
	 yC+o+yHV4bFHUWPVkJWYnJfkS4h2EHVSyMIxwNiTbFiadPCMzgjwEqC5cgoUO7DtVT
	 dGeSrHgmQ7UDfHYUFl+j9bT1HlwnANmxZFm7+1HY/vljZaJq4gSftnP3gzJkN+GLfw
	 gY/pRCGUx7VHVKzG4kykFHkKRfy8E5wH/bpt5Aju2XNXAzfUq77/ZM6zaTPiqSkseK
	 XsPHvmQZ4YWofUaw4k9BBOgZCXeIaKfnnaJ2Ja2/7Ri7uPzQ68X2YF5RmdsA0UDySi
	 mvNcyn2zb/KIA==
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
	Omar Sandoval <osandov@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v7 bpf-next 06/10] lib/buildid: implement sleepable build_id_parse() API
Date: Thu, 29 Aug 2024 10:42:28 -0700
Message-ID: <20240829174232.3133883-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829174232.3133883-1-andrii@kernel.org>
References: <20240829174232.3133883-1-andrii@kernel.org>
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
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 54 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index c1cbd34f3685..18ef55812c64 100644
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
@@ -62,7 +64,16 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 
 	freader_put_folio(r);
 
-	r->folio = filemap_get_folio(r->mapping, file_off >> PAGE_SHIFT);
+	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
+
+	/* if sleeping is allowed, wait for the page, if necessary */
+	if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
+		filemap_invalidate_lock_shared(r->file->f_mapping);
+		r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
+					    NULL, r->file);
+		filemap_invalidate_unlock_shared(r->file->f_mapping);
+	}
+
 	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
 		if (!IS_ERR(r->folio))
 			folio_put(r->folio);
@@ -287,18 +298,8 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
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
@@ -309,7 +310,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
-	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping);
+	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);
 
 	/* fetch first 18 bytes of ELF header for checks */
 	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
@@ -337,6 +338,22 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
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
@@ -350,8 +367,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
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


