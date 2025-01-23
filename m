Return-Path: <linux-fsdevel+bounces-39898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBACFA19C38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4101887BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0473B2BB;
	Thu, 23 Jan 2025 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF5tRjIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F735972
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595698; cv=none; b=iE94DcPT1MAhpAD74Q4KRtN4BVEm1lxxYPLddTGr387nY6f+4aNP/Wmffo8PiZh304YrY9X0mLf8mertDPEBwO1kSbiHpTGLTYDxGkMk6yxjCAC2vMfEsSeWfllcFO3q4eYE4GzkgIw3/hpokNaik0oKiaqNiYvJFzdCtoqtMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595698; c=relaxed/simple;
	bh=JVnBbdhW5IEvdzifZb7VHJ8cUODCFbZaV83Ier64qbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmfhDa0QD4/u+U/+EqVMQJd5kuKY9hesX5TcM+Kt1P0Q3viji4V8JE7Hu1URjOw9l/YZHzLu6ywkhxLSymAJvS/Mc6R4izpLoJsY0zoZFQ/T7pp3VL25jTRy5PimU/7rDslWEP/1sijucyrU8Kjt9gDXTt8A1POR6rVn/YDM16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF5tRjIf; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so529537276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595696; x=1738200496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e59gm+n1MlmMwsVC6vAnT4shX5z2tDH3wMJva9Pwb5Q=;
        b=VF5tRjIfEP88/X2khIaGxNveO/ZmyKIZUKSlKSR8Uv4Av8QOIs1AXgJJM8jCJpmsa6
         NOdGQXL5klsM1R0wzT5XJnsLP1PUwVAttH5nwSTXWEvAQiQSS9C50GH60AnQbc6hxIFY
         +i4IDyJr0pGEjdr3izwDZqqDxNL257oBdy5QO5VhwMluR0fV29UiMtLj7PxPAIDNIAhT
         BpaivJmGxTnIuYrw+HGmwa3zNltL3IkAnNdiI/JVH7q9Ok67FOUOLs5wA6PKd9kDRi/q
         m0kvNYHTln+zZ11Qs4BDjj4L92+SB+VyIOs9vLJV4red1ePw1dS9uCcmO6lUnLu9mRTm
         kFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595696; x=1738200496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e59gm+n1MlmMwsVC6vAnT4shX5z2tDH3wMJva9Pwb5Q=;
        b=D2PM9++kQqjSQXZ/7S23qAz0AxDBXyBPSGJG+WJTF+GpuB1B1j4mPuN5d3wRyCmyRY
         qoWCQqVX2Krpd7S1MYoiQNrmQbJoM+C1IiiHPsvP4um0RdthMQJA2CmXgO+G72QKHoGP
         74py9DO13r/KTaZIxm1m6XVfh63htrEi+mrDpdgemZxiObIpBcld0OTQcCNMc6ootHIX
         KfiRSabGuPQEN9nKXmBEeBW/CZwPc7qNqMzm3GxCBMiUmSRSqkC6RLtgH7quMqnrZINq
         ppWn14G7Q5/r1U9mtlbz+mr2XTIRRT8jZrgzcEZDDwUZD6DNO9KnKHeAVo2FqRlp+7yJ
         E8dw==
X-Forwarded-Encrypted: i=1; AJvYcCUGoiL6cSn9tNPF2GGii7stoJd4Qwe760vlX5TV7/rjrWxhVCBNViJhytob5kZg+IVcWkd6zNZ27IPYpN8F@vger.kernel.org
X-Gm-Message-State: AOJu0YwUn1qLEz3/KMUmVb2qxvAcw5UoH/OQGmGuBRGoVqCBr/q7D25K
	SZdKfAkETrAsAlZaJfX61PMcy/+r+Gc8QTFoyxnimP5j2Ivg0cel
X-Gm-Gg: ASbGncsXFFRDnzs1ooM4v1WsA1aS1e9vdqq7dCNaQHVSUW3CSuySolViSAALlF8Ys+F
	sOR6lmR0D4xrzoWpXnUSco14dkWGwXu1CRbP+4yL9lo6EGldJbJy9D3azgSjbyoJPYujdSm5oXE
	zCVRC3Zr9xY7c2QUdz21CxxqfxrVCItLpys+7i6ySDRU19flTQ2nf/VJK7NVVS2dg4SGv9tjM2r
	LvSunsGWA4nRvcV29tampVyE0gimn5m2YWl7GKHcny4kYb74jQXtvZAiZCCtVBE3FlZnYRHzJPI
	GQ==
X-Google-Smtp-Source: AGHT+IEx6aXle53+s69YXSTd6ZND34pzfKiUNA4jINVH+m55C/6UmV40C+FmhSiJC+P/PzY6lPDQLA==
X-Received: by 2002:a05:690c:6e03:b0:6e9:e097:718c with SMTP id 00721157ae682-6f6eb658a4emr200809807b3.6.1737595696299;
        Wed, 22 Jan 2025 17:28:16 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66d1fa2sm22618927b3.75.2025.01.22.17.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:16 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 09/10] fuse: support large folios for readahead
Date: Wed, 22 Jan 2025 17:24:47 -0800
Message-ID: <20250123012448.2479372-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a178aee87e74..5c98dcc337d4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -963,14 +963,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	fuse_io_free(ia);
 }
 
-static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
+static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
+				unsigned int count)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
 	struct fuse_args_pages *ap = &ia->ap;
 	loff_t pos = folio_pos(ap->folios[0]);
-	/* Currently, all folios in FUSE are one page */
-	size_t count = ap->num_folios << PAGE_SHIFT;
 	ssize_t res;
 	int err;
 
@@ -1008,6 +1007,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	unsigned int max_pages, nr_pages;
 	pgoff_t first = readahead_index(rac);
 	pgoff_t last = first + readahead_count(rac) - 1;
+	struct folio *folio = NULL;
 
 	if (fuse_is_bad(inode))
 		return;
@@ -1031,8 +1031,8 @@ static void fuse_readahead(struct readahead_control *rac)
 	while (nr_pages) {
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
-		struct folio *folio;
 		unsigned cur_pages = min(max_pages, nr_pages);
+		unsigned int pages = 0;
 
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
@@ -1047,14 +1047,27 @@ static void fuse_readahead(struct readahead_control *rac)
 			return;
 		ap = &ia->ap;
 
-		while (ap->num_folios < cur_pages) {
-			folio = readahead_folio(rac);
+		while (pages < cur_pages) {
+			unsigned int folio_pages;
+
+			if (!folio)
+				folio = readahead_folio(rac);
+
+			folio_pages = folio_nr_pages(folio);
+			if (folio_pages > cur_pages - pages) {
+				if (!pages)
+					return;
+				break;
+			}
+
 			ap->folios[ap->num_folios] = folio;
 			ap->descs[ap->num_folios].length = folio_size(folio);
 			ap->num_folios++;
+			pages += folio_pages;
+			folio = NULL;
 		}
-		fuse_send_readpages(ia, rac->file);
-		nr_pages -= cur_pages;
+		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
+		nr_pages -= pages;
 	}
 }
 
-- 
2.43.5


