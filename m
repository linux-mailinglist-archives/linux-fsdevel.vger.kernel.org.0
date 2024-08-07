Return-Path: <linux-fsdevel+bounces-25371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB894B3B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF82F283F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ABC156676;
	Wed,  7 Aug 2024 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKfPVXqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C104155CBF;
	Wed,  7 Aug 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074037; cv=none; b=EZ+VP/R4sBLqcJ0Yc+cvAnkHxBzqCNi+fkIxglLwUrWfzqSDYLQMzq78ipVlqiPjsxG5VsJ1gZYXBvcYeLHONdqpNzFjkrv9qcagm45/vIcLd+KIF/ANiY7ycnIenrTwkb0syo+u0CfRQo2/p0vz0Xb7EfJRukv93w0ZDK6Gcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074037; c=relaxed/simple;
	bh=OIZNMC780eTnt/ALo17lrfvXKslZ7E+0MoDC60zpa0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9M2EIg7SQ2Oft+o3kRbGivo9Lfv3B6Bq5vR/wOiUrGWvxUNB8rYyKs2X7j2Pihx/8cFWvTwJRosboKBiUcfkRVh0bLomnAEZ5r/P8xkgslBahaV5hlMSCIIVFoxbgRtT1x9VzSlWy8QRfOHfEU2D5Elfq0FqrF34D8resypfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKfPVXqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A96AC32781;
	Wed,  7 Aug 2024 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074036;
	bh=OIZNMC780eTnt/ALo17lrfvXKslZ7E+0MoDC60zpa0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKfPVXqdOpTDvQe8bEkEnw6k1SskXAyuJXFmHVECunh7+4WRySXid8TepTiZxEOrI
	 4ta1oihG+/jX+XJTREUpYn3a++s9nJWsYDMQkebX5129Y7lmjWEpkg7xJAqDH59o6O
	 AkK0mqMwU12ObOicbi+QmyEtHifrJrFTAv3kBoiLQQxQBXRXq08RdACM4gCeeyXMZr
	 kATzL7wr6oYjsXzqqGjuI2TQ8FO23RvrdlEGUlscrXTB548b+TGSB+ibT9Nm+485Lm
	 ixMLXv0AqArSPn8rtVXiysvROWB4zNqxDjNrGd78s+c78omnPEO/5YPhSAJZ3BsGBL
	 82m6puXC9Qc7w==
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
Subject: [PATCH v4 bpf-next 01/10] lib/buildid: harden build ID parsing logic
Date: Wed,  7 Aug 2024 16:40:20 -0700
Message-ID: <20240807234029.456316-2-andrii@kernel.org>
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
 lib/buildid.c | 60 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e02b5507418b..a3e229588c43 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -18,30 +18,34 @@ static int parse_build_id_buf(unsigned char *build_id,
 			      const void *note_start,
 			      Elf32_Word note_size)
 {
+	const char note_name[] = "GNU";
+	const size_t note_name_sz = sizeof(note_name);
 	Elf32_Word note_offs = 0, new_offs;
+	u32 name_sz, desc_sz;
+	const char *data;
 
-	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
+	while (note_offs + sizeof(Elf32_Nhdr) < note_size &&
+	       note_offs + sizeof(Elf32_Nhdr) > note_offs /* overflow */) {
 		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
 
+		name_sz = READ_ONCE(nhdr->n_namesz);
+		desc_sz = READ_ONCE(nhdr->n_descsz);
+		new_offs = note_offs + sizeof(Elf32_Nhdr) + ALIGN(name_sz, 4) + ALIGN(desc_sz, 4);
+		if (new_offs <= note_offs /* overflow */ || new_offs > note_size)
+			break;
+
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
+			data = note_start + note_offs + ALIGN(note_name_sz, 4);
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
+
 		note_offs = new_offs;
 	}
 
@@ -71,7 +75,7 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
 	Elf32_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
 
 	/*
 	 * FIXME
@@ -80,9 +84,10 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
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
@@ -90,8 +95,8 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
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
@@ -103,7 +108,7 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
 	Elf64_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
 
 	/*
 	 * FIXME
@@ -112,18 +117,19 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
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
-- 
2.43.5


