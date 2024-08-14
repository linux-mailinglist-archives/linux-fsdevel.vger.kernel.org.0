Return-Path: <linux-fsdevel+bounces-25948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FACE952249
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDE9283673
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26CB1BE22E;
	Wed, 14 Aug 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5kdLwT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B91BD4FD;
	Wed, 14 Aug 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661673; cv=none; b=kFk0QeA3EsdR+0P7rC4sgKzQLBlRTM0xDQB4U3HpgthnhKtO/okcWuTVETxY2SFMncdeVrAn2mPIsVCfoa+j1GmEqSLhC2JelgXuQVxOy93OPZYxUMj/hOlOsARUdMA54t6kh7H+sDICNRM4mM95H8a4p26GzlU+7VIglinL5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661673; c=relaxed/simple;
	bh=Cd2n2547OKq5mRkrfmg4+0GI2njBDE3a4HVKwVRW1Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qibKtQ+pMKXXuMUtIw8SrOSjYobKTKavPyhbDg9GyKD3tyA30ntFPYvRtePvwvhdv/oYNqupdfX0g5n+nbA6jj5HGr/izK3/ZvPuq/Coxz1wA2PlsfYDn2zjR6IVAJ83CR6ZYtLjuLNE2y3vRFGDQkMzqrnII9b2PBegM6D9Utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5kdLwT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C3DC116B1;
	Wed, 14 Aug 2024 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723661671;
	bh=Cd2n2547OKq5mRkrfmg4+0GI2njBDE3a4HVKwVRW1Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5kdLwT9gA2Er33HcqKTTepe8GL7ks1Y5es208W568OdqKOL3ox++bE7UFOAACAzB
	 CUxWDxPJGWrx7wRYoyINg4itYmDmx51ZoHzdlx+PGmA3lqi+U6lPqfebVOT54DiGzt
	 EI3c4rSCmKZYLoDSpOMKaWcwboEx9m2P9QNpdL05dWJMMpTa93iyPil0tt4UUlG9Ts
	 nLhcROkWVErE9feL4dWVWdO4FkwuKM0XUwAsOQU4uwyexOa43etyi/OoBq4BVFdYx1
	 H4a/DFcTB26HWetQa4EcLBlKnrbm5N/Cl6WkVqsI0bOnCHG/6SHfHQwfGB/n3UZGof
	 ckkWVgr0yC2wg==
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
Subject: [PATCH v6 bpf-next 03/10] lib/buildid: take into account e_phoff when fetching program headers
Date: Wed, 14 Aug 2024 11:54:10 -0700
Message-ID: <20240814185417.1171430-4-andrii@kernel.org>
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


