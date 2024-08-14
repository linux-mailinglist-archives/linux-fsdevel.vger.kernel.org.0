Return-Path: <linux-fsdevel+bounces-25949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2166595224B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB95C1F227DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1601BE862;
	Wed, 14 Aug 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEZuyU/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A81BD4FD;
	Wed, 14 Aug 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661674; cv=none; b=cGyd60+NnXoBh++XcNBFal+RH4u8HVLh450/5uYOeaOepLJ2oVxYXNFi4aBcwgxBugZ9pR9kq2RTh4ARSi7rTNnDTBNml8z8+ETsQbkYSFE2wL/Uip6Kg5UqQTtv39UfSNTuPqYflza3GKNR4R0uXqDe/jf1UPzFe7DaJqN6n94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661674; c=relaxed/simple;
	bh=EKylHdmMyJh/v4m6K+s9kOSONMY3dxjgOdsYFysplh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st6ogJOPNi6foVlV0TQx7tnapQh24LS0Y2yd08Ph0HdI4YCsuFlqHS6036SnBovcD51xT9ars5My1xnvJ3cC8wciapBnFsmKphCv6CwcyoD37z0P+rLPHNBl6XTR+82WxRBWka9jDjIXbpzHKIXMAjxvaB6o1Or1HosEVnyUVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEZuyU/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDEDC4AF0E;
	Wed, 14 Aug 2024 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723661674;
	bh=EKylHdmMyJh/v4m6K+s9kOSONMY3dxjgOdsYFysplh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEZuyU/1rAcAXZiVqWCU1ZGahkQkGHNe1bUgVRj9L2g1e1y9NIUi4KQwh0he+/y3i
	 2nwUHlOoNOlOLD0tuOYrkwv5GqJht2gscy2mqQHppF69YaOiMmeea/39g1oiAVY5St
	 3/ANUyoG6PXVM3PloR0GBOmHx3vAZmHzLz3eLz1TfXmEyQQNV7mNLlS6wuD9merH7u
	 L+yBFHUGf6w/ErARe+gyGaK8sfCAdz3v64xUWN4VAExkHhPsb3YYIemUM17EQbvmUT
	 E2tn0fnxASqDsb8kMS4JrSBmmWrHZ5fRDfpMq00n1t9bzTtHJoe7dXyVQqPW15O4N4
	 KPavrNLcdnQYg==
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
Subject: [PATCH v6 bpf-next 04/10] lib/buildid: remove single-page limit for PHDR search
Date: Wed, 14 Aug 2024 11:54:11 -0700
Message-ID: <20240814185417.1171430-5-andrii@kernel.org>
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

Now that freader allows to access multiple pages transparently, there is
no need to limit program headers to the very first ELF file page. Remove
this limitation, but still put some sane limit on amount of program
headers that we are willing to iterate over (set arbitrarily to 256).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 7fb08a1d98bd..e8fc4aeb01f2 100644
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


