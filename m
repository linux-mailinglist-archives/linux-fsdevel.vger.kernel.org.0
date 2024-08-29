Return-Path: <linux-fsdevel+bounces-27927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8B9964D0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04FD1F22E68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD531B81C7;
	Thu, 29 Aug 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9S7C4y+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6641B7902;
	Thu, 29 Aug 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953365; cv=none; b=cddj6lw6NbSWN3qV6uIxAXcn7grrxPHMoMeIn5ou+SvcLM/FVKoG0Vhi58VG5XlUXj/TVI0AXobJlgD5lbwhkBDAaMYxnaQ18adgtJ8EA0vfb3DTQiN8+DnYvWmASrSSMcBp08QhEO6XQWVzQKrmhQ4gxT2BngepUzr6OHbofX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953365; c=relaxed/simple;
	bh=Rp6otyrq1s70AfuJSm1rv8h2cgFz+vWWyi+WpWNJo0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyQWoSrwFaDsjpqFj5w05+zb7uD0LDyYLab/KZaLWXdfrMwl/Lr8zL457KlIFin+XAn6pFAV9y6RmNROyI3+HZgUJqphLFNEIw+HWhakbyr01+fwWedzt1qCu7VOTeDncJd/EX7b5MKkkMCb3riRg7ty1RzPkNtHr1fioaNOVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9S7C4y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3DCC4CEC1;
	Thu, 29 Aug 2024 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953364;
	bh=Rp6otyrq1s70AfuJSm1rv8h2cgFz+vWWyi+WpWNJo0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9S7C4y+C06tQyD+Sl51neSMfzNbO3H7+XqTB+9IpLWNA5lP+7o39gvHMaHYMTSM1
	 NOme1U8VxqRTfLT9XS/9uBRx6l7NB72LK9SCN1+L+uvRjNIyIAZAFWeULC4Hz2BJm7
	 qfp5elwqfey2Rzwir5hsz1BcEG4n4MeOej78lpi6juzXR7URC5jNrQNEPXgOQ7fhif
	 rTKpnnCjGuyYxfLhZecA2brCZkio51MjpJbulavW8CtHl3fiwLCJxk1z/jqJgwJGEy
	 UXSe7/zUDwVUrveZGzktpl0G1JOYrU7B+QGYubKYXXQyOdSc6vsex6cDe+5LPPE7cw
	 ol9ipOaSf/sig==
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
Subject: [PATCH v7 bpf-next 03/10] lib/buildid: take into account e_phoff when fetching program headers
Date: Thu, 29 Aug 2024 10:42:25 -0700
Message-ID: <20240829174232.3133883-4-andrii@kernel.org>
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

Current code assumption is that program (segment) headers are following
ELF header immediately. This is a common case, but is not guaranteed. So
take into account e_phoff field of the ELF header when accessing program
headers.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index bfe00b66b1e8..7fb08a1d98bd 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -213,28 +213,26 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 {
 	const Elf32_Ehdr *ehdr;
 	const Elf32_Phdr *phdr;
-	__u32 phnum, i;
+	__u32 phnum, phoff, i;
 
 	ehdr = freader_fetch(r, 0, sizeof(Elf32_Ehdr));
 	if (!ehdr)
 		return r->err;
 
-	/*
-	 * FIXME
-	 * Neither ELF spec nor ELF loader require that program headers
-	 * start immediately after ELF header.
-	 */
-	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
-		return -EINVAL;
-
 	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
 	phnum = READ_ONCE(ehdr->e_phnum);
+	phoff = READ_ONCE(ehdr->e_phoff);
+
 	/* only supports phdr that fits in one page */
 	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
+	/* check that phoff is not large enough to cause an overflow */
+	if (phoff + phnum * sizeof(Elf32_Phdr) < phoff)
+		return -EINVAL;
+
 	for (i = 0; i < phnum; ++i) {
-		phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
+		phdr = freader_fetch(r, phoff + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
 		if (!phdr)
 			return r->err;
 
@@ -252,27 +250,26 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 	const Elf64_Ehdr *ehdr;
 	const Elf64_Phdr *phdr;
 	__u32 phnum, i;
+	__u64 phoff;
 
 	ehdr = freader_fetch(r, 0, sizeof(Elf64_Ehdr));
 	if (!ehdr)
 		return r->err;
 
-	/*
-	 * FIXME
-	 * Neither ELF spec nor ELF loader require that program headers
-	 * start immediately after ELF header.
-	 */
-	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
-		return -EINVAL;
-
 	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
 	phnum = READ_ONCE(ehdr->e_phnum);
+	phoff = READ_ONCE(ehdr->e_phoff);
+
 	/* only supports phdr that fits in one page */
 	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
+	/* check that phoff is not large enough to cause an overflow */
+	if (phoff + phnum * sizeof(Elf64_Phdr) < phoff)
+		return -EINVAL;
+
 	for (i = 0; i < phnum; ++i) {
-		phdr = freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
+		phdr = freader_fetch(r, phoff + i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
 		if (!phdr)
 			return r->err;
 
-- 
2.43.5


