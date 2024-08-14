Return-Path: <linux-fsdevel+bounces-25952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5D952250
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB3B1C20FFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D21BF307;
	Wed, 14 Aug 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2oqJnxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271021BE24E;
	Wed, 14 Aug 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661684; cv=none; b=rHLbeB++3Rm4z5yc1VIXMsWQnBgGeOaPvyatrwMlf5bjADM8tmjSuyFuHJYgPPIYL2cvM5PJ3u0J3jYBEpYDkelKXYud5fFByJRNhUIrIzemlXeZYxGqDXLaRXbMk0Dywp+1H6gqQPwC6iyzetM1HB+Q/EMTpIaqyOEh0PY6xOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661684; c=relaxed/simple;
	bh=qWFr1Itiok941tgbEAKnQiv3NKSiQ5xxi7FLGt3tlz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJW0auUCybYpgP2X20w4JLhfjfoTeODocgGMzfvU3piz3ZfDRsGaKOKdFEsQ08jK6dkB9WNI5F9qjRDJMVMgZU3YijfN1Y0l3wsag8Ke2LSpFrtuLCW35V99qD8RsfZoBrukD1hJEwU6ofoKYR6AtKoUK/ckvqNG9WM3Pti/6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2oqJnxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7F2C116B1;
	Wed, 14 Aug 2024 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723661684;
	bh=qWFr1Itiok941tgbEAKnQiv3NKSiQ5xxi7FLGt3tlz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2oqJnxLIfziQGtAWipaX+42KrmgI7kmyiGn9lCHfQ7YV3hbZPyYqp1qrq0nJ7X4J
	 vu2YQPTDjpU8CpoWnwkvkyZAWwGTy44DuRUGgLazKDfdZroDOHFMuBgtlmoT9Pq65i
	 ltaSyU8EaRPg1S3AE6xw0mNfdUbufjlcwoYJtLc8UrEiv4mxakxwHH/B+W14kqzcFi
	 jBxGbO6vK12zWE6PV7P+e37JNhp/cl63EZ8saqPP3DJwHvbmVpB4F6D7WZt3nwhJRT
	 FJDhOUlK2ZI00qVZqfD/TQAWgdi7nVUz+b+2uKyg2KAfoEOgZ1UlCgVBYRVgd97KPR
	 erJOLImS3PZzg==
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
Subject: [PATCH v6 bpf-next 07/10] lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
Date: Wed, 14 Aug 2024 11:54:14 -0700
Message-ID: <20240814185417.1171430-8-andrii@kernel.org>
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
index 5da5a32a1af8..b404b89f61a3 100644
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


