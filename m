Return-Path: <linux-fsdevel+bounces-27926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D08964D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2183283BA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FD31B81BC;
	Thu, 29 Aug 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMhk+aEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036E1B6548;
	Thu, 29 Aug 2024 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953362; cv=none; b=oJ1NG/SMv2thI2ChqrSO4OKohzTYU6Z7yNtuo6f49BB2/3AytN4P0XL6NzxpBGF8s6YCrC2zBdOrlvlGDijprJFf9RBRARD3dv823USEXndRFZibneIrYDJ1n96IVXvSysMGL58x8vcwy/Cc1wstNBRld6KpMjig4Djx5TYGnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953362; c=relaxed/simple;
	bh=Z1WbIc+u/F3T63+9FQlx6/STGu7yunPqQEuluURvw7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk5xqcDWSxow5RU7PcoMhUneTFB1jGS+R6Fwj4Dy+/U7v9MiADaFINoPOM/hSDH9cV5fmD/uMn2/xJOzABm2gmmaygQybXWA8J9d4KosH8uEa6VG6ZvV6nQluEDgcFtb0L9IcZIpsx7Bu9I5jMYThZKCD+L/OW//eeLmYcGHG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMhk+aEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A68CC4CEC1;
	Thu, 29 Aug 2024 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953361;
	bh=Z1WbIc+u/F3T63+9FQlx6/STGu7yunPqQEuluURvw7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMhk+aEBKgMD3dOciiLBq0tvfvkASQSTgVydC2iWvRlfkobSqWw56M8ZXBjGUvunW
	 gX3Q4hOBnW1bw3tsjz9dUtJ5Dv6ZtajqVp3yPPlQLa75eRr1CVr4ROQC+xF6O6ORkp
	 EgpWDO97voSIwkAgGa6UDGOiejrLmqfh64Tz2ER47SclBLINxYUkyW+ze7LTyRgVsK
	 +Uj0P5mPc7Qjoi7iRX2PvwH7gMYMY85xbZASXv04RIE2wYevWpJ47SLEeGB62v7/m7
	 lg9/90VqyGsueUC1aB65/zQqvIvbwpTKCBg91k4G2/v5mBG7G3VsSadZkq9y69cFvf
	 WhEGF+H1BOC5g==
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
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v7 bpf-next 02/10] lib/buildid: add single folio-based file reader abstraction
Date: Thu, 29 Aug 2024 10:42:24 -0700
Message-ID: <20240829174232.3133883-3-andrii@kernel.org>
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

Add freader abstraction that transparently manages fetching and local
mapping of the underlying file page(s) and provides a simple direct data
access interface.

freader_fetch() is the only and single interface necessary. It accepts
file offset and desired number of bytes that should be accessed, and
will return a kernel mapped pointer that caller can use to dereference
data up to requested size. Requested size can't be bigger than the size
of the extra buffer provided during initialization (because, worst case,
all requested data has to be copied into it, so it's better to flag
wrongly sized buffer unconditionally, regardless if requested data range
is crossing page boundaries or not).

If folio is not paged in, or some of the conditions are not satisfied,
NULL is returned and more detailed error code can be accessed through
freader->err field. This approach makes the usage of freader_fetch()
cleaner.

To accommodate accessing file data that crosses folio boundaries, user
has to provide an extra buffer that will be used to make a local copy,
if necessary. This is done to maintain a simple linear pointer data
access interface.

We switch existing build ID parsing logic to it, without changing or
lifting any of the existing constraints, yet. This will be done
separately.

Given existing code was written with the assumption that it's always
working with a single (first) page of the underlying ELF file, logic
passes direct pointers around, which doesn't really work well with
freader approach and would be limiting when removing the single page (folio)
limitation. So we adjust all the logic to work in terms of file offsets.

There is also a memory buffer-based version (freader_init_from_mem())
for cases when desired data is already available in kernel memory. This
is used for parsing vmlinux's own build ID note. In this mode assumption
is that provided data starts at "file offset" zero, which works great
when parsing ELF notes sections, as all the parsing logic is relative to
note section's start.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 263 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 210 insertions(+), 53 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 26007cc99a38..bfe00b66b1e8 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -8,24 +8,155 @@
 
 #define BUILD_ID 3
 
+struct freader {
+	void *buf;
+	u32 buf_sz;
+	int err;
+	union {
+		struct {
+			struct address_space *mapping;
+			struct folio *folio;
+			void *addr;
+			loff_t folio_off;
+		};
+		struct {
+			const char *data;
+			u64 data_sz;
+		};
+	};
+};
+
+static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
+				   struct address_space *mapping)
+{
+	memset(r, 0, sizeof(*r));
+	r->buf = buf;
+	r->buf_sz = buf_sz;
+	r->mapping = mapping;
+}
+
+static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
+{
+	memset(r, 0, sizeof(*r));
+	r->data = data;
+	r->data_sz = data_sz;
+}
+
+static void freader_put_folio(struct freader *r)
+{
+	if (!r->folio)
+		return;
+	kunmap_local(r->addr);
+	folio_put(r->folio);
+	r->folio = NULL;
+}
+
+static int freader_get_folio(struct freader *r, loff_t file_off)
+{
+	/* check if we can just reuse current folio */
+	if (r->folio && file_off >= r->folio_off &&
+	    file_off < r->folio_off + folio_size(r->folio))
+		return 0;
+
+	freader_put_folio(r);
+
+	r->folio = filemap_get_folio(r->mapping, file_off >> PAGE_SHIFT);
+	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
+		if (!IS_ERR(r->folio))
+			folio_put(r->folio);
+		r->folio = NULL;
+		return -EFAULT;
+	}
+
+	r->folio_off = folio_pos(r->folio);
+	r->addr = kmap_local_folio(r->folio, 0);
+
+	return 0;
+}
+
+static const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
+{
+	size_t folio_sz;
+
+	/* provided internal temporary buffer should be sized correctly */
+	if (WARN_ON(r->buf && sz > r->buf_sz)) {
+		r->err = -E2BIG;
+		return NULL;
+	}
+
+	if (unlikely(file_off + sz < file_off)) {
+		r->err = -EOVERFLOW;
+		return NULL;
+	}
+
+	/* working with memory buffer is much more straightforward */
+	if (!r->buf) {
+		if (file_off + sz > r->data_sz) {
+			r->err = -ERANGE;
+			return NULL;
+		}
+		return r->data + file_off;
+	}
+
+	/* fetch or reuse folio for given file offset */
+	r->err = freader_get_folio(r, file_off);
+	if (r->err)
+		return NULL;
+
+	/* if requested data is crossing folio boundaries, we have to copy
+	 * everything into our local buffer to keep a simple linear memory
+	 * access interface
+	 */
+	folio_sz = folio_size(r->folio);
+	if (file_off + sz > r->folio_off + folio_sz) {
+		int part_sz = r->folio_off + folio_sz - file_off;
+
+		/* copy the part that resides in the current folio */
+		memcpy(r->buf, r->addr + (file_off - r->folio_off), part_sz);
+
+		/* fetch next folio */
+		r->err = freader_get_folio(r, r->folio_off + folio_sz);
+		if (r->err)
+			return NULL;
+
+		/* copy the rest of requested data */
+		memcpy(r->buf + part_sz, r->addr, sz - part_sz);
+
+		return r->buf;
+	}
+
+	/* if data fits in a single folio, just return direct pointer */
+	return r->addr + (file_off - r->folio_off);
+}
+
+static void freader_cleanup(struct freader *r)
+{
+	if (!r->buf)
+		return; /* non-file-backed mode */
+
+	freader_put_folio(r);
+}
+
 /*
  * Parse build id from the note segment. This logic can be shared between
  * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
  * identical.
  */
-static int parse_build_id_buf(unsigned char *build_id,
-			      __u32 *size,
-			      const void *note_start,
-			      Elf32_Word note_size)
+static int parse_build_id_buf(struct freader *r,
+			      unsigned char *build_id, __u32 *size,
+			      loff_t note_off, Elf32_Word note_size)
 {
 	const char note_name[] = "GNU";
 	const size_t note_name_sz = sizeof(note_name);
-	u64 note_off = 0, new_off, name_sz, desc_sz;
+	u32 build_id_off, new_off, note_end, name_sz, desc_sz;
+	const Elf32_Nhdr *nhdr;
 	const char *data;
 
-	while (note_off + sizeof(Elf32_Nhdr) < note_size &&
-	       note_off + sizeof(Elf32_Nhdr) > note_off /* overflow */) {
-		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_off);
+	note_end = note_off + note_size;
+	while (note_end - note_off > sizeof(Elf32_Nhdr) + note_name_sz) {
+		nhdr = freader_fetch(r, note_off, sizeof(Elf32_Nhdr) + note_name_sz);
+		if (!nhdr)
+			return r->err;
 
 		name_sz = READ_ONCE(nhdr->n_namesz);
 		desc_sz = READ_ONCE(nhdr->n_descsz);
@@ -33,14 +164,20 @@ static int parse_build_id_buf(unsigned char *build_id,
 		new_off = note_off + sizeof(Elf32_Nhdr);
 		if (check_add_overflow(new_off, ALIGN(name_sz, 4), &new_off) ||
 		    check_add_overflow(new_off, ALIGN(desc_sz, 4), &new_off) ||
-		    new_off > note_size)
+		    new_off > note_end)
 			break;
 
 		if (nhdr->n_type == BUILD_ID &&
 		    name_sz == note_name_sz &&
 		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
 		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
-			data = note_start + note_off + ALIGN(note_name_sz, 4);
+			build_id_off = note_off + sizeof(Elf32_Nhdr) + ALIGN(note_name_sz, 4);
+
+			/* freader_fetch() will invalidate nhdr pointer */
+			data = freader_fetch(r, build_id_off, desc_sz);
+			if (!data)
+				return r->err;
+
 			memcpy(build_id, data, desc_sz);
 			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)
@@ -54,30 +191,33 @@ static int parse_build_id_buf(unsigned char *build_id,
 	return -EINVAL;
 }
 
-static inline int parse_build_id(const void *page_addr,
+static inline int parse_build_id(struct freader *r,
 				 unsigned char *build_id,
 				 __u32 *size,
-				 const void *note_start,
+				 loff_t note_start_off,
 				 Elf32_Word note_size)
 {
 	/* check for overflow */
-	if (note_start < page_addr || note_start + note_size < note_start)
+	if (note_start_off + note_size < note_start_off)
 		return -EINVAL;
 
 	/* only supports note that fits in the first page */
-	if (note_start + note_size > page_addr + PAGE_SIZE)
+	if (note_start_off + note_size > PAGE_SIZE)
 		return -EINVAL;
 
-	return parse_build_id_buf(build_id, size, note_start, note_size);
+	return parse_build_id_buf(r, build_id, size, note_start_off, note_size);
 }
 
 /* Parse build ID from 32-bit ELF */
-static int get_build_id_32(const void *page_addr, unsigned char *build_id,
-			   __u32 *size)
+static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *size)
 {
-	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
-	Elf32_Phdr *phdr;
-	__u32 i, phnum;
+	const Elf32_Ehdr *ehdr;
+	const Elf32_Phdr *phdr;
+	__u32 phnum, i;
+
+	ehdr = freader_fetch(r, 0, sizeof(Elf32_Ehdr));
+	if (!ehdr)
+		return r->err;
 
 	/*
 	 * FIXME
@@ -87,30 +227,35 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
 		return -EINVAL;
 
+	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
 	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
 	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
-	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
-
 	for (i = 0; i < phnum; ++i) {
-		if (phdr[i].p_type == PT_NOTE &&
-		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + READ_ONCE(phdr[i].p_offset),
-				    READ_ONCE(phdr[i].p_filesz)))
+		phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
+		if (!phdr)
+			return r->err;
+
+		if (phdr->p_type == PT_NOTE &&
+		    !parse_build_id(r, build_id, size, READ_ONCE(phdr->p_offset),
+				    READ_ONCE(phdr->p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
 }
 
 /* Parse build ID from 64-bit ELF */
-static int get_build_id_64(const void *page_addr, unsigned char *build_id,
-			   __u32 *size)
+static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *size)
 {
-	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
-	Elf64_Phdr *phdr;
-	__u32 i, phnum;
+	const Elf64_Ehdr *ehdr;
+	const Elf64_Phdr *phdr;
+	__u32 phnum, i;
+
+	ehdr = freader_fetch(r, 0, sizeof(Elf64_Ehdr));
+	if (!ehdr)
+		return r->err;
 
 	/*
 	 * FIXME
@@ -120,23 +265,29 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
 		return -EINVAL;
 
+	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
 	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
 	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
-	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
-
 	for (i = 0; i < phnum; ++i) {
-		if (phdr[i].p_type == PT_NOTE &&
-		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + READ_ONCE(phdr[i].p_offset),
-				    READ_ONCE(phdr[i].p_filesz)))
+		phdr = freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
+		if (!phdr)
+			return r->err;
+
+		if (phdr->p_type == PT_NOTE &&
+		    !parse_build_id(r, build_id, size, READ_ONCE(phdr->p_offset),
+				    READ_ONCE(phdr->p_filesz)))
 			return 0;
 	}
+
 	return -EINVAL;
 }
 
+/* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
+#define MAX_FREADER_BUF_SZ 64
+
 /*
  * Parse build ID of ELF file mapped to vma
  * @vma:      vma object
@@ -148,26 +299,25 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size)
 {
-	Elf32_Ehdr *ehdr;
-	struct page *page;
-	void *page_addr;
+	const Elf32_Ehdr *ehdr;
+	struct freader r;
+	char buf[MAX_FREADER_BUF_SZ];
 	int ret;
 
 	/* only works for page backed storage  */
 	if (!vma->vm_file)
 		return -EINVAL;
 
-	page = find_get_page(vma->vm_file->f_mapping, 0);
-	if (!page)
-		return -EFAULT;	/* page not mapped */
-	if (!PageUptodate(page)) {
-		put_page(page);
-		return -EFAULT;
+	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping);
+
+	/* fetch first 18 bytes of ELF header for checks */
+	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
+	if (!ehdr) {
+		ret = r.err;
+		goto out;
 	}
 
 	ret = -EINVAL;
-	page_addr = kmap_local_page(page);
-	ehdr = (Elf32_Ehdr *)page_addr;
 
 	/* compare magic x7f "ELF" */
 	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0)
@@ -178,12 +328,11 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		goto out;
 
 	if (ehdr->e_ident[EI_CLASS] == ELFCLASS32)
-		ret = get_build_id_32(page_addr, build_id, size);
+		ret = get_build_id_32(&r, build_id, size);
 	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
-		ret = get_build_id_64(page_addr, build_id, size);
+		ret = get_build_id_64(&r, build_id, size);
 out:
-	kunmap_local(page_addr);
-	put_page(page);
+	freader_cleanup(&r);
 	return ret;
 }
 
@@ -197,7 +346,15 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 {
-	return parse_build_id_buf(build_id, NULL, buf, buf_size);
+	struct freader r;
+	int err;
+
+	freader_init_from_mem(&r, buf, buf_size);
+
+	err = parse_build_id(&r, build_id, NULL, 0, buf_size);
+
+	freader_cleanup(&r);
+	return err;
 }
 
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
-- 
2.43.5


