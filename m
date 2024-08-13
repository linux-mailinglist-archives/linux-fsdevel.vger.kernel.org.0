Return-Path: <linux-fsdevel+bounces-25730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D787694FAAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925982828A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6063A9;
	Tue, 13 Aug 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKQzHeWL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2854A23;
	Tue, 13 Aug 2024 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508978; cv=none; b=ZtE5TnhxLh5N+P+YQiQjaS/1fP2S5JndTGj5qb7qdKpoMD7YrHDLfB3hVJhXuNXAfu5Y0x5lc/GXSCZLnctzYFCqjlM5pejORcggs+Kt2go1ByUJLf5DpVAAVqjPnvIwB4j/OItdqAyaipQCTal/ekpAnTJLaX/BLUVAUT36ZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508978; c=relaxed/simple;
	bh=d6OgdgeHC+wk/lu9I8MQmLFJs8ltuhWEZxsTMlHyPcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOw+3k39L8q+2cS/2hKlo41ccbqjNpY2pmMqCbQHywwPBO2qYV2WTcgjg/jcp6kcQXj4FB+/wAfRzmG4F/Zll6JsC/ilRyr6XRQdcpf0yffxe7UqE3/PZpWOpR2tpw7dyFslptQtH6CqJ/2XzUId77iTypuPqL1uci7/ZuYQD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKQzHeWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE5EC4AF0D;
	Tue, 13 Aug 2024 00:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508978;
	bh=d6OgdgeHC+wk/lu9I8MQmLFJs8ltuhWEZxsTMlHyPcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKQzHeWLGEXSBj28UKOhogBjjfgKREy89e3zbQHdc2ymmXrDkkZ8QFoKEIxLfi08u
	 9jEXKq6AMG/wgO3jx720R9CpQKXK7rYYZMZnWYF7a6gocNP8PbvovNE2mtUbZtD08n
	 gXHs5QykOrm6BmEfFA7Y7vFYzbd8xYM14VnDtNgf/YkykOiy+lEvv2OLzj5Igo9TjD
	 kjC0VnPbEZboUpV83Pnzwvt17tMEAUvu8yDMMmkUbgmt9hdoRZk2aIzApO1MJ4rc8Y
	 dyWswqg+Bstkrrkw4GynQVlIwnwmKW2a8KKed3vMTPfb+u7CHjaWHpu1zd76r5wrkc
	 isglTPPnF42og==
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
	stable@vger.kernel.org
Subject: [PATCH v5 bpf-next 01/10] lib/buildid: harden build ID parsing logic
Date: Mon, 12 Aug 2024 17:29:23 -0700
Message-ID: <20240813002932.3373935-2-andrii@kernel.org>
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

Harden build ID parsing logic, adding explicit READ_ONCE() where it's
important to have a consistent value read and validated just once.

Also, as pointed out by Andi Kleen, we need to make sure that entire ELF
note is within a page bounds, so move the overflow check up and add an
extra note_size boundaries validation.

Fixes tag below points to the code that moved this code into
lib/buildid.c, and then subsequently was used in perf subsystem, making
this code exposed to perf_event_open() users in v5.12+.

Cc: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 74 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e02b5507418b..61bc5b767064 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *build_id,
 			      const void *note_start,
 			      Elf32_Word note_size)
 {
-	Elf32_Word note_offs = 0, new_offs;
-
-	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
-		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
+	const char note_name[] = "GNU";
+	const size_t note_name_sz = sizeof(note_name);
+	u64 note_off = 0, new_off, name_sz, desc_sz;
+	const char *data;
+
+	while (note_off + sizeof(Elf32_Nhdr) < note_size &&
+	       note_off + sizeof(Elf32_Nhdr) > note_off /* overflow */) {
+		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_off);
+
+		name_sz = READ_ONCE(nhdr->n_namesz);
+		desc_sz = READ_ONCE(nhdr->n_descsz);
+
+		new_off = note_off + sizeof(Elf32_Nhdr);
+		if (check_add_overflow(new_off, ALIGN(name_sz, 4), &new_off) ||
+		    check_add_overflow(new_off, ALIGN(desc_sz, 4), &new_off) ||
+		    new_off > note_size)
+			break;
 
 		if (nhdr->n_type == BUILD_ID &&
-		    nhdr->n_namesz == sizeof("GNU") &&
-		    !strcmp((char *)(nhdr + 1), "GNU") &&
-		    nhdr->n_descsz > 0 &&
-		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
-			memcpy(build_id,
-			       note_start + note_offs +
-			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
-			       nhdr->n_descsz);
-			memset(build_id + nhdr->n_descsz, 0,
-			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
+		    name_sz == note_name_sz &&
+		    strcmp((char *)(nhdr + 1), note_name) == 0 &&
+		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
+			data = note_start + note_off + ALIGN(note_name_sz, 4);
+			memcpy(build_id, data, desc_sz);
+			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)
-				*size = nhdr->n_descsz;
+				*size = desc_sz;
 			return 0;
 		}
-		new_offs = note_offs + sizeof(Elf32_Nhdr) +
-			ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
-		if (new_offs <= note_offs)  /* overflow */
-			break;
-		note_offs = new_offs;
+
+		note_off = new_off;
 	}
 
 	return -EINVAL;
@@ -71,7 +77,7 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
 	Elf32_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
 
 	/*
 	 * FIXME
@@ -80,9 +86,10 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	 */
 	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
 		return -EINVAL;
+
+	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
@@ -90,8 +97,8 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	for (i = 0; i < ehdr->e_phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    page_addr + READ_ONCE(phdr[i].p_offset),
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -103,7 +110,7 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
 	Elf64_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
 
 	/*
 	 * FIXME
@@ -112,18 +119,19 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 	 */
 	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
 		return -EINVAL;
+
+	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    page_addr + READ_ONCE(phdr[i].p_offset),
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -152,6 +160,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
+	if (!PageUptodate(page)) {
+		put_page(page);
+		return -EFAULT;
+	}
 
 	ret = -EINVAL;
 	page_addr = kmap_local_page(page);
-- 
2.43.5


