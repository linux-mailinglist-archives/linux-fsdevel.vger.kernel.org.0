Return-Path: <linux-fsdevel+bounces-27928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB750964D11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4A41F215B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D601B81A1;
	Thu, 29 Aug 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y13JdG8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD21B6555;
	Thu, 29 Aug 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953368; cv=none; b=F/4glUtgGjWi++kUrvRJBNfD5xNJsW7JMpFso2bO0Wf8uJQxXcXdYaLHjvEo/VJePi4LU6ZwkZBuC8h3jL5vd5/uybMUt5t/qIggdWHqjJsbgHCWouqsCjSd52mgyn73M0FRRUhrJDrEObW1uoaQ3tST0gKaguxa4lUFR100S0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953368; c=relaxed/simple;
	bh=5CLcAmrYIJlnXm0mQvpn/y1HhZ+JoZho6ovLxlNSww4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot27Uc05hPLiqnz8l+5j3/SuBLZ/dwZltm0bp4wDBQUUDfAkvtszHdvhOpk08swfcrlur8DcTTq2e3uRTONSboG+M8NVwWOgFhQOZ7gAcxjgQHGrMwgv98QOon0UZdHKT0NkFNURZCM9nLu2IWw/q3RH88c5sAZQ+lqvqIeSt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y13JdG8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5C9C4CEC1;
	Thu, 29 Aug 2024 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953367;
	bh=5CLcAmrYIJlnXm0mQvpn/y1HhZ+JoZho6ovLxlNSww4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y13JdG8xb8iuDxI4s46rTFLZcD10pfqV7vza38UzKeRzQoCwxEVNo8hA2eTGhuETW
	 Hyaadvu2kZkMMtxCumBkixN0Xvv5Y9MbdYW8QWzqfeg8ltNMJoiz/vf94PsTyv8uAC
	 oneOA1xwnIxNnE+vQFX01ZZQjSWinI6oygsunq7alY+uWLbMljQTmMdnde3Edi4a1I
	 vYivD6IyJT7izocTWPg65srGF6Py9G66+mTfeexfdBLnjehN5cj+lktTmyamZTWuhU
	 /98hLgNJGq6USK0h7pkav5KZ6OCiM901bnwTnvOWgCbFm51BIy/pG8ht7rZrKJkbXk
	 EDBG8rM8TzYAA==
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
Subject: [PATCH v7 bpf-next 04/10] lib/buildid: remove single-page limit for PHDR search
Date: Thu, 29 Aug 2024 10:42:26 -0700
Message-ID: <20240829174232.3133883-5-andrii@kernel.org>
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

Now that freader allows to access multiple pages transparently, there is
no need to limit program headers to the very first ELF file page. Remove
this limitation, but still put some sane limit on amount of program
headers that we are willing to iterate over (set arbitrarily to 256).

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
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


