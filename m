Return-Path: <linux-fsdevel+bounces-25733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57294FAB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB61528282F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE6A933;
	Tue, 13 Aug 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YI/np7Sr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3CED8;
	Tue, 13 Aug 2024 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508989; cv=none; b=nob7hpCjujagM+cln5iH64wfaKHawZ00ket+yMo6EJQ6EZ77UzmbaxrkgJMnmYQeF5kpe3zw+SYGjBtexrNBRxzRxcau3Z6Bc3gucuiLWC6ea9NW+8ZX5dCKV1ANVBqslw1p1qBu4eZTza0mB7Xef9oKDvp2tMk1b8HAWmPd72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508989; c=relaxed/simple;
	bh=nj7ojDVOgz/yh4I+l3hU9jrVg8UwzU+SfIEUQDZjSOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTD8bg05mTGPenGcxrbXqO0D3NHQaVowKzo95ZR+42ryasM6O9n/SXGuhbt937H0Su6vW++j48yXrpUdwINA2Rq1rSqe9a8PUGIKNAgxln4tZXtA1unUc4JAgfFebt0Oe3WjrAh8OMAi8v0WXaGSUt8SsWslEUR+7MEzdIKoXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YI/np7Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AC9C4AF0D;
	Tue, 13 Aug 2024 00:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508988;
	bh=nj7ojDVOgz/yh4I+l3hU9jrVg8UwzU+SfIEUQDZjSOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YI/np7Src3nYBmxFhL4ZN6d1xO6aRcrT3FAsB4drJAL3RoGLmHTRvPDsAS4XA08HU
	 Xhgf+d10QVJzZK//pm3vdl9boA+e1z2Hq9y7LLd++fCP6WH6nAswdmJwzOnW+cGa0r
	 yI/1UK7N3142yRwE6Q9DmQHGr9pbHrBkCITnprxtuitLIxseAMBn+9/DF4ur6I4zQy
	 ju+7cvhH+5Nybrk84ux9Wr0zlbNDhdL3wii1SW216oH2pIgI9iz0RhIfJtudv+MOH0
	 NsA+MGh9R3G6h2jsjPnWoQsiuL+lJS2EmhA+FKu75crSt8AmW4bHOLH3tjZzxJq5Rt
	 s7w7jFFxwILyw==
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
Subject: [PATCH v5 bpf-next 04/10] lib/buildid: remove single-page limit for PHDR search
Date: Mon, 12 Aug 2024 17:29:26 -0700
Message-ID: <20240813002932.3373935-5-andrii@kernel.org>
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

Now that freader allows to access multiple pages transparently, there is
no need to limit program headers to the very first ELF file page. Remove
this limitation, but still put some sane limit on amount of program
headers that we are willing to iterate over (set arbitrarily to 256).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index abf5d1c7eb47..8296428ff82f 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -8,6 +8,8 @@
 
 #define BUILD_ID 3
 
+#define MAX_PHDR_CNT 256
+
 struct freader {
 	void *buf;
 	u32 buf_sz;
@@ -223,9 +225,9 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 	phnum = READ_ONCE(ehdr->e_phnum);
 	phoff = READ_ONCE(ehdr->e_phoff);
 
-	/* only supports phdr that fits in one page */
-	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
-		return -EINVAL;
+	/* set upper bound on amount of segments (phdrs) we iterate */
+	if (phnum > MAX_PHDR_CNT)
+		phnum = MAX_PHDR_CNT;
 
 	/* check that phoff is not large enough to cause an overflow */
 	if (phoff + phnum * sizeof(Elf32_Phdr) < phoff)
@@ -260,9 +262,9 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 	phnum = READ_ONCE(ehdr->e_phnum);
 	phoff = READ_ONCE(ehdr->e_phoff);
 
-	/* only supports phdr that fits in one page */
-	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
-		return -EINVAL;
+	/* set upper bound on amount of segments (phdrs) we iterate */
+	if (phnum > MAX_PHDR_CNT)
+		phnum = MAX_PHDR_CNT;
 
 	/* check that phoff is not large enough to cause an overflow */
 	if (phoff + phnum * sizeof(Elf64_Phdr) < phoff)
-- 
2.43.5


