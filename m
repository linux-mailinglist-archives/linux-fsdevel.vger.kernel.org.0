Return-Path: <linux-fsdevel+bounces-25373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725E94B3BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648F71C20F23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3711586FE;
	Wed,  7 Aug 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfRxHav2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831F155337;
	Wed,  7 Aug 2024 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074043; cv=none; b=m6PX5bV2hCn2+kz1FhpivVwe84hRemPKp6VqFYooIpfWd6SY++RCQpYEWYiFHmaFDYYgqOty5+jzxXWwQcI77DjFtsWQI+mmUWTrY/hDyuUWStqF/QqblkNOMKmt8vqwBSS3/ZLn+T2PVUrM5kNdflIC1wwg1MN+6md/PW+5UvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074043; c=relaxed/simple;
	bh=p0Hrh9D8jfWPnv3wRuqHv+z7HSONG3+t+yQ8X6UTtgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElUcU2y2Yjeo1owglrNeQGUAu2divj+TWGWjezFntjHmjTlY8a3+JWG6X5ow/ZTF8972fDi8EbnCCj2Bvu7dDcAFFn8+H/U+d4ztYcuzPuo2hngGYEJzwC11dZ/N0FROn/zVxg2uDqTlTjrfluyEJvU37y4PPL3bDH1akRV8ANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfRxHav2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A40EC32781;
	Wed,  7 Aug 2024 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074043;
	bh=p0Hrh9D8jfWPnv3wRuqHv+z7HSONG3+t+yQ8X6UTtgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfRxHav2I85dVDDJN63ZgXQ7nwgkQ9cZLs5WETdCaEYU55dh6HCLvroeJaJURWQ3q
	 6Ikc7F7Kij+g3EJxsxX2/qtS97KEN0rpKR/JtbqX7zgMGAZOyYECbOHYfVun3zvvUK
	 oLv+nEi5BQ4LwFQnJ//je5+/3gwqDorhgsGSJQruFX60891dVCjMLqagfXxTU+2WLk
	 GHWceKnOz8s0djK0yUW35pdoumGVlQiNwKSuLsVVrf9EGWmvuQ7wHp+4KfTxAq5A8k
	 3qKprgPxepGsbb3J2TFmT8kqmB/uvNhmQV8XA3ucMt2zWh8KuSUcK5PPu4Wd2T36Gh
	 HiLGsp2tNp9gw==
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
Subject: [PATCH v4 bpf-next 03/10] lib/buildid: take into account e_phoff when fetching program headers
Date: Wed,  7 Aug 2024 16:40:22 -0700
Message-ID: <20240807234029.456316-4-andrii@kernel.org>
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

Current code assumption is that program (segment) headers are following
ELF header immediately. This is a common case, but is not guaranteed. So
take into account e_phoff field of the ELF header when accessing program
headers.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index f5ffc3d9f786..0183f5ece75b 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -210,28 +210,26 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
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
 
@@ -249,27 +247,26 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
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


