Return-Path: <linux-fsdevel+bounces-27931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FD5964D19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA9A285BB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B61B7905;
	Thu, 29 Aug 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iij0aW8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73F1B78E0;
	Thu, 29 Aug 2024 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953377; cv=none; b=Ubv2iyjmfwXRkRyjjDHmx80paorM033SLU/alvcUwN6GDT/ir5TkQsJ7X3SBwjnKJHWTbEmAk6iy0G70BU5ySXzLqhTpqvl6jbl13Lhs6qj7JY7pLs+jrlsjHYbyxLnoys0tVB1N0XX1GoBDZbqVzEdlkrzRv2OmCrAlbF6Jj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953377; c=relaxed/simple;
	bh=2jVZvSaSmUP1eILbkNsVbAsPQzYYbYwqDjRGc+xq+N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9CsCSYNMMNgF1TCowhm25IWUrMpaQY13ROX8Wivd/E0pqZWnClGxYr2mlcQj9lhy27iDTNfE4qAJAkq6HPDzR/EXC2+m4RlZ7SE0oAtySxVznCyXzqRydOZeMkFsIH9m2LhAMNE2HWXVjjspKQGC0CwF+nkQrwnaCNyGTxX9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iij0aW8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E162C4CEC1;
	Thu, 29 Aug 2024 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953377;
	bh=2jVZvSaSmUP1eILbkNsVbAsPQzYYbYwqDjRGc+xq+N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iij0aW8jjwJqgQiw3EdbzhJ/zMX2hOtDDDPvqLD6dR//5hE2vlBaFNc1Zns9oO8Of
	 fbYp4hyEnZlujg6/CwOVGXypguIDPW8QB1Q8pOqX55ZuVvyzbejBkFqvg4eB//Bwkw
	 Ql2O4bvlqmgE5bDgmeHYob++eJop6Sq5bENwENUgVel5WIDH2dogQ19O97M+HxhjZa
	 4lR64OjtEtn+0wJOpHHvZdIHAa24eN8rv8AVfdm0rqsm5ow3yZGLedfPASdB+8xa3X
	 02bHyiJawK+xM63XbjtQExRwHZOnHvqLT6SRaeE63Rl0/R7SRQXbCPWVUbF1nsrfu6
	 RLwIVPacoRcsg==
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
Subject: [PATCH v7 bpf-next 07/10] lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
Date: Thu, 29 Aug 2024 10:42:29 -0700
Message-ID: <20240829174232.3133883-8-andrii@kernel.org>
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

With freader we don't need to restrict ourselves to a single page, so
let's allow ELF notes to be at any valid position with the file.

We also merge parse_build_id() and parse_build_id_buf() as now the only
difference between them is note offset overflow, which makes sense to
check in all situations.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 18ef55812c64..290641d92ac1 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -155,9 +155,8 @@ static void freader_cleanup(struct freader *r)
  * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
  * identical.
  */
-static int parse_build_id_buf(struct freader *r,
-			      unsigned char *build_id, __u32 *size,
-			      loff_t note_off, Elf32_Word note_size)
+static int parse_build_id(struct freader *r, unsigned char *build_id, __u32 *size,
+			  loff_t note_off, Elf32_Word note_size)
 {
 	const char note_name[] = "GNU";
 	const size_t note_name_sz = sizeof(note_name);
@@ -165,7 +164,9 @@ static int parse_build_id_buf(struct freader *r,
 	const Elf32_Nhdr *nhdr;
 	const char *data;
 
-	note_end = note_off + note_size;
+	if (check_add_overflow(note_off, note_size, &note_end))
+		return -EINVAL;
+
 	while (note_end - note_off > sizeof(Elf32_Nhdr) + note_name_sz) {
 		nhdr = freader_fetch(r, note_off, sizeof(Elf32_Nhdr) + note_name_sz);
 		if (!nhdr)
@@ -204,23 +205,6 @@ static int parse_build_id_buf(struct freader *r,
 	return -EINVAL;
 }
 
-static inline int parse_build_id(struct freader *r,
-				 unsigned char *build_id,
-				 __u32 *size,
-				 loff_t note_start_off,
-				 Elf32_Word note_size)
-{
-	/* check for overflow */
-	if (note_start_off + note_size < note_start_off)
-		return -EINVAL;
-
-	/* only supports note that fits in the first page */
-	if (note_start_off + note_size > PAGE_SIZE)
-		return -EINVAL;
-
-	return parse_build_id_buf(r, build_id, size, note_start_off, note_size);
-}
-
 /* Parse build ID from 32-bit ELF */
 static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *size)
 {
-- 
2.43.5


