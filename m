Return-Path: <linux-fsdevel+bounces-25377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B413694B3C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA681F2299D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE481159582;
	Wed,  7 Aug 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb2pOhoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39391148FFF;
	Wed,  7 Aug 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074056; cv=none; b=mZwkqTzfkvJEn/lBc+ACKMxV/2VbfTVUpg6G0PdBUvpkT3FqGJ7l1WUT9a+yLQ6vXfn0OQH1LvC3NjBbuP46Jm/P1dcMMnwoH2DW1H16fp1X+mTHrNmPiXZ/U/Huv0BIGKQKbizvufxWlBcHJcl7+pJycXNiGvQDMXh4LOTDYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074056; c=relaxed/simple;
	bh=K9nlQ3xypFKHE/hNPFlwjaYOVtfWPN79DJ2hGIZWoj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khoZmp6Q+k5hl8mzXPXfIJNPAyi7bv8S+JVbbai95HeKvKFQBdNxEVC++E2jYJGl2KrwE7j0Yz4xLSpfcfZkALKcx5Btx3vnMYcD7L3vyGOeMqhoOzS4Ds5YBjhH6R2CaKmlTkv/TVndPdkUam0ukd5m975dWsAVDag3ZWEJDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb2pOhoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA931C32781;
	Wed,  7 Aug 2024 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074056;
	bh=K9nlQ3xypFKHE/hNPFlwjaYOVtfWPN79DJ2hGIZWoj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fb2pOhoEEpXNe1kwa5EEgKTHQKTfBozB0ldY1/2sH/KZJz4YGm0cL2eLVjnuL0FVQ
	 Bj7i3sXmzwGxy/lOjHcLQOPc/PrvXa/xFEAsG1QWYC8rHrerjIfmUBBrEDw/WhtgVk
	 g4u+dG7lZllEI97xq4vYyBWMNs7qpKi9nwGbAySxsfxXQuHkv5R6fv7NPUdFLbBQHs
	 UGdAFbnVAIE6Zow4puSnPfWTV3aXrSjMJr5ZgZ2MQqChepr9Z/erq8rlAFRCDU8kOK
	 zXGeiYK2VRIyUYND9vPm/QF80+9D6d1YA8tJB3yF+cIazjFWsAhOtb0jVqEJHMgY99
	 mgE1rKj8pzt9w==
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
Subject: [PATCH v4 bpf-next 07/10] lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
Date: Wed,  7 Aug 2024 16:40:26 -0700
Message-ID: <20240807234029.456316-8-andrii@kernel.org>
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

With freader we don't need to restrict ourselves to a single page, so
let's allow ELF notes to be at any valid position with the file.

We also merge parse_build_id() and parse_build_id_buf() as now the only
difference between them is note offset overflow, which makes sense to
check in all situations.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e1c01b23efd8..589c7fd5abf0 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -151,17 +151,19 @@ static void freader_cleanup(struct freader *r)
  * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
  * identical.
  */
-static int parse_build_id_buf(struct freader *r,
-			      unsigned char *build_id, __u32 *size,
-			      loff_t note_offs, Elf32_Word note_size)
+static int parse_build_id(struct freader *r, unsigned char *build_id, __u32 *size,
+			  loff_t note_offs, Elf32_Word note_size)
 {
 	const char note_name[] = "GNU";
 	const size_t note_name_sz = sizeof(note_name);
 	const Elf32_Nhdr *nhdr;
-	loff_t build_id_off, new_offs, note_end = note_offs + note_size;
+	loff_t build_id_off, new_offs, note_end;
 	u32 name_sz, desc_sz;
 	const char *data;
 
+	if (check_add_overflow(note_offs, note_size, &note_end))
+		return -EINVAL;
+
 	while (note_end - note_offs > sizeof(Elf32_Nhdr) + note_name_sz) {
 		nhdr = freader_fetch(r, note_offs, sizeof(Elf32_Nhdr) + note_name_sz);
 		if (!nhdr)
@@ -197,23 +199,6 @@ static int parse_build_id_buf(struct freader *r,
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


