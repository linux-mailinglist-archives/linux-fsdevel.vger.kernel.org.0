Return-Path: <linux-fsdevel+bounces-25946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C15952245
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E432835C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976C1BE246;
	Wed, 14 Aug 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPoYqr7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4D374FA;
	Wed, 14 Aug 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661666; cv=none; b=eUCIIuosRGJUsHJksYf482T5Egpj1fr4sdfkdzyibwTS2Wr+tHzxeN2ZsbLLSuxDMDQhY5JSKQkQKyJljiEGXGeKaHMRtXUOBZMSDKgvCiEXFCabxZknHSQavYsN6XyeVaEIY8zMSuwtguLjBllIkZeRW0Ns8GIeDRkqO+d/zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661666; c=relaxed/simple;
	bh=4ZoU25T3GpMNirAVJHlQgWCkIN0YdLxI0t6Ca/r0AuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iy9iBSXnvzWZCfNjSBgHumjln/Bzg2smUuWY6yVavSkLuPiYYNbpZ4kEydGuTuxQlZz/HLXPQNsSwwJosXZ3FofAfBOtDa6r3rnQ6GKgKcxwtP73X4bixWv4QggygVrFzKG/HH/D0n4EncV71sdGw7zSYBb3p8rtv3mrujzDkA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPoYqr7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B68C116B1;
	Wed, 14 Aug 2024 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723661664;
	bh=4ZoU25T3GpMNirAVJHlQgWCkIN0YdLxI0t6Ca/r0AuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPoYqr7WwOTP5txj5SYFCRBE8SuJYpuJMRe3ZuOQtmo0X3PfpnkMUI3CxgHwsL5+m
	 wTxGvqYxd2m0QkMedDWnbpzVeVjYU7xLr8dd8l4vMXeAgQz364ZL/XLilib0eoMS3C
	 i8FnGEYeM5DoOyWf+TMsbpvNt0WmZ1PDvmh6GJ20/K5627vCNnejizFAYA/4/Vucor
	 LeGBVYjOBHtdzqFm/z4u5jSAYIr+22TK5xYQAfo5NMPKVK1uoQCsj6QS+8XtZizWUX
	 xkxHxh1nxoJTNh65ZmHaOEJSKin2BTJGjrTxCHF4Qi2HdrOv0GeIeKji2b+73Mrare
	 WXOQ0Fk7xojEQ==
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
Subject: [PATCH v6 bpf-next 01/10] lib/buildid: harden build ID parsing logic
Date: Wed, 14 Aug 2024 11:54:08 -0700
Message-ID: <20240814185417.1171430-2-andrii@kernel.org>
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
Reviewed-by: Jann Horn <jannh@google.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 76 +++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e02b5507418b..26007cc99a38 100644
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
+		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
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
@@ -80,18 +86,19 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
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


