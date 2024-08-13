Return-Path: <linux-fsdevel+bounces-25732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E852A94FAAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740C9B22390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978B4A3C;
	Tue, 13 Aug 2024 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFz3Oa0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8098ED8;
	Tue, 13 Aug 2024 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508986; cv=none; b=MDDOphXcfKnIC6oNFHqtoRmBamL8v+6TE0MQy9FBfEwqBh+Aq+QdS4GNpzosLoHHC/8OH+rNOmCrWBqvkDj+opi67xXtpi1+KpN7LMr7IcJu207o4PQ7a026X4RVgc+6gE5EWOj3twvml03ElK0BqNvpoYz1h9EsFdLTIhzFwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508986; c=relaxed/simple;
	bh=qaMr9V+HCCVlztizCv4KeksSMYe9fzp24XbALik8ZKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJMTQgd+OMixnxGkZvtgWBjFEfBevS8gtYgkp7QclKf+Q+C5Hay4fF8Y4VHf9jcyGrNGDFPeZcBFde4g6xlAXqUmrZwvWugqMOK0MTH8ZDkOY2DwcT4QATSGlyGlLwS0S9xtpn0lqtkt6AFNW5Qg59t3/qr+Z30sHd9+14P+zhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFz3Oa0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F10EC4AF12;
	Tue, 13 Aug 2024 00:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508985;
	bh=qaMr9V+HCCVlztizCv4KeksSMYe9fzp24XbALik8ZKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFz3Oa0JPzBYydr1B1rTYWL12SMjsvjDU39bYLcGFfOiGOoxokLHaRnxa8hbl70nM
	 l+2MC47iNIGLaO9kz9+WPs4VLDTb9opO4u8c/slc41g4vXqB+vDJL17siRX3wUdJcn
	 F8NISui0ctqh8H5M44FfyVc+G1fsNRQYudQ8F5oqLgCBI6JKdBFrtWQ7Tkrm2ioUhG
	 7TjX5RTf/e8Q5Bie/ACJAaNF7hUPgrtCzgoBtAvl8A9ycOqkR+fEHse3vtrkMbqraB
	 HwKWKxHQzKXaGGEer9lNGbY1biagmt06xQ8wJb0sqIDgojpUm8hpWC2rW01MirJlNO
	 bY0JdWZT2LOkw==
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
Subject: [PATCH v5 bpf-next 03/10] lib/buildid: take into account e_phoff when fetching program headers
Date: Mon, 12 Aug 2024 17:29:25 -0700
Message-ID: <20240813002932.3373935-4-andrii@kernel.org>
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
index 2b1050e99576..abf5d1c7eb47 100644
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


