Return-Path: <linux-fsdevel+bounces-25951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775195224F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF661C20DA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810B51BE879;
	Wed, 14 Aug 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFfhQ2kE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA51BB6BE;
	Wed, 14 Aug 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661681; cv=none; b=gP/kFyVG3fVQ6VhYAluWTGRF1SHs6e/wKMs10Me68VSeccfdYnYMjipbAiSXwtSoEF0cZ2ZeaQiLeOY46lvrKjnm/R1vnbZYHUGje+Dd8d7nru4JOzsi+bEZ/o0vW4+0JdYgqZI1oLM49IUWWz5LVUwVnGcM2tm6hp/cUgt71Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661681; c=relaxed/simple;
	bh=xupJ424Tw41nEe7GfCN7i5gyQGldYzv2WcV+UpjPy8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4tyA1KUtLtTVIuP+a/hosk74mLi9ecO3nUeZKgLd3cu+SFEVR+MGV7tYocZA37+RWSEGx+kZNEvoqld74HyTIeKWUFa4mLpeEahhZztIU8eR8DW5dohXmhQ7t/XWNS3RDk8cXWpKx2gGGH6X0hEmq4rVkp8rqwFffJmvNRbaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFfhQ2kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4D6C4AF09;
	Wed, 14 Aug 2024 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723661680;
	bh=xupJ424Tw41nEe7GfCN7i5gyQGldYzv2WcV+UpjPy8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFfhQ2kEKCp0C9ynVtGldcKgIAZORCu9yY50B70ZwdJFLN1XH6Lczqb+WFkflGP7z
	 5SNUAsF70zUrZXum57h2b5NxeExP70e16C/aR+inDFIRh6NRKUIz9SjbZBN23xc23C
	 QHRkYWf+Ab0BXna1CEnI/HVcO1lcWoQ7eyy0CQzYNZ/HvezGtw7WzeiUuaQ5m0h9OW
	 h6mKBpLDmBePTdb2o9PBOVcsTABzVEYJhnj+E7XSz/o0ssCjrIPbZZqIi+CGUrpGZw
	 Li7O9VNEYcqgXrOBvtZGgFbZ6c1f0dgchN8wGMU5R1ufxzBeiWLd9MDSdfUXZOi5yy
	 zn8Wg2oAThXqA==
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
Subject: [PATCH v6 bpf-next 06/10] lib/buildid: implement sleepable build_id_parse() API
Date: Wed, 14 Aug 2024 11:54:13 -0700
Message-ID: <20240814185417.1171430-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240814185417.1171430-1-andrii@kernel.org>
References: <20240814185417.1171430-1-andrii@kernel.org>
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
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 52 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index c1cbd34f3685..5da5a32a1af8 100644
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


