Return-Path: <linux-fsdevel+bounces-25374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E4A94B3BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D821C20FAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E1158D6A;
	Wed,  7 Aug 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVS3fdeu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBD15534E;
	Wed,  7 Aug 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074047; cv=none; b=AendLJ6kHSV9U2cjpETl6WluFlZnf59KcM/v6dqbWnqx0WNw4h1Ds9cgtMu+1NHS96yB+naiIdGi9Vejx0vQCOQw9F6u5i7qaBssQk80jNupAwvtot9zP+IIYsJmpEHJ87jhTrw+N7bUM9ds5vK7PMUFZUf/QJxJ1JirtnCvNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074047; c=relaxed/simple;
	bh=TDEWOsOYTqCWmRy9nezQeNW62a5CE1iq9NssKuKQCAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lszj14Bm7jK8y+aXir6kfHKzuBUmi8BOCZzOnb5Ugfqx0poGes7w2yPgUFHyTv8r751QMQqVjL67KihDn6hrEW1wFF6+Clw7mTrJfbWqQemzkhtZ8i80O2zo1o0D0v4nDaGF8hw+O1zck8SCNal1LGGW5hHXBwCjaaJ9AVB7o00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVS3fdeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6FDC32781;
	Wed,  7 Aug 2024 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074046;
	bh=TDEWOsOYTqCWmRy9nezQeNW62a5CE1iq9NssKuKQCAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVS3fdeuk3RG9moYmD17rxZSP7z5Le2x3ufCBCVrt4Fj8oUHVuWyhCQgdaA1zLKc/
	 /SZUbMUqAp+4olN8wrFJIbNFZqWTZTV4ErqnM5gRRZwmV+hFgetIXtOfaFY+D2NoS/
	 A8ryFsFQJACVib1j4PnwYpC9tbvPOs1CwIIDa8rwd2XU8TedA8R0//jlmwcky0A6Nl
	 M2ddNzttVMg5bYpHN0dCkWNcktr26iiOQi8HVCucQ/hpNhs3VE5y+XWQx08DhjT3TA
	 tPOtJFhR5N3i65twUYEvdSqvkTap/JDJ38mM8g7RQniyUoEnVLFg/pnnNvkT2irtZ0
	 ME7z+FZ4Gm/CA==
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
Subject: [PATCH v4 bpf-next 04/10] lib/buildid: remove single-page limit for PHDR search
Date: Wed,  7 Aug 2024 16:40:23 -0700
Message-ID: <20240807234029.456316-5-andrii@kernel.org>
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

Now that freader allows to access multiple pages transparently, there is
no need to limit program headers to the very first ELF file page. Remove
this limitation, but still put some sane limit on amount of program
headers that we are willing to iterate over (set arbitrarily to 256).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 0183f5ece75b..f3a15d983444 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -8,6 +8,8 @@
 
 #define BUILD_ID 3
 
+#define MAX_PHDR_CNT 256
+
 struct freader {
 	void *buf;
 	u32 buf_sz;
@@ -220,9 +222,9 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
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
@@ -257,9 +259,9 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
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


