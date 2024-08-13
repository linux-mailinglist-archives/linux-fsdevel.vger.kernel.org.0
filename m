Return-Path: <linux-fsdevel+bounces-25736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61BF94FAB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D88B21C3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56814101F7;
	Tue, 13 Aug 2024 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSIuTR65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD64A23;
	Tue, 13 Aug 2024 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508998; cv=none; b=mHSzGtO9tdRDgomvfyPUABNP75hR3jT1hG8LDe7ACxsMWG6jpPjJiYwDlUDaUgS5wdhwrPFObUOlcGBCEEN0G8McJ+1TxQ0NWcMCkwBBrjPILG828VAo8Eb7Y7W1iyPjgeL2EWeSLZmx6hA6Jk0huMTay70P/DZ9FA9XKiFE9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508998; c=relaxed/simple;
	bh=/aF9doTSwVxK8vkPFzpWOWPf6Y2a+7ple020IwwLDSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9eMyZyfIIocGiV7n900YqcLegmHoFtxTIR5ainFGrTUMPsjkUuArOKDEze9UHXDTphQSQJPsE3yg4EPO0EDwcXSA0RYodDfjJHz3k2e2qoOd9AS+JHeqYhcDvzYDleXB/GVLx7KyxhKqqRpOeZj3HGos6PalNk2rSfWCTifZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSIuTR65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717F9C4AF10;
	Tue, 13 Aug 2024 00:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508998;
	bh=/aF9doTSwVxK8vkPFzpWOWPf6Y2a+7ple020IwwLDSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSIuTR65Xeh7z7t1hE2mLF8gqKL8SUrC6KKO1sp3imVjDaj7n1StQQTBeiTnQvvZ9
	 NE4meYoSfiKsHoRg6YKXW8JY975TdfKaD20mIzyYa6hDJbsDZo7xX8Hy9/J2WU3MN2
	 djc03c+xYkX8D0FFlUTuWFZHmqv0lN1ft3s4jf9l5nRDH/3JpIli5CqO38RPbb/9ec
	 YxBNNXOM9Q7SZSsk4CbDavbZFJVXLwWEvPctCtkoKv+uFbu1wwXSeFTe2DeDp1WzjR
	 qs8rR/YE4e1U3XqRd+rvjmyck26bukq9fLRKDiCqyP8u+nW+ll9zfmVn8Z0qOSeiiS
	 afMvKeW9QS8ow==
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
Subject: [PATCH v5 bpf-next 07/10] lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
Date: Mon, 12 Aug 2024 17:29:29 -0700
Message-ID: <20240813002932.3373935-8-andrii@kernel.org>
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

With freader we don't need to restrict ourselves to a single page, so
let's allow ELF notes to be at any valid position with the file.

We also merge parse_build_id() and parse_build_id_buf() as now the only
difference between them is note offset overflow, which makes sense to
check in all situations.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e78bef392cfd..3f7a588f7fd2 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -153,9 +153,8 @@ static void freader_cleanup(struct freader *r)
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
@@ -163,7 +162,9 @@ static int parse_build_id_buf(struct freader *r,
 	const Elf32_Nhdr *nhdr;
 	const char *data;
 
-	note_end = note_off + note_size;
+	if (check_add_overflow(note_off, note_size, &note_end))
+		return -EINVAL;
+
 	while (note_end - note_off > sizeof(Elf32_Nhdr) + note_name_sz) {
 		nhdr = freader_fetch(r, note_off, sizeof(Elf32_Nhdr) + note_name_sz);
 		if (!nhdr)
@@ -202,23 +203,6 @@ static int parse_build_id_buf(struct freader *r,
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


