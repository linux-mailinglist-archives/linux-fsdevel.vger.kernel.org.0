Return-Path: <linux-fsdevel+bounces-32599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D783B9AB63D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA79284AAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E0C1CC88F;
	Tue, 22 Oct 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0oOjBe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC441CC156
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623292; cv=none; b=U+o9uqIdUKsQWu8FCOs09Bp9onxwqSTzpqX01J4oh20xeuajBcnEPekJz5XxmhWE+3fGVYnkBtmICP6iaZ67BT2sLAvCF253/C0VCy2DMXWt8XN+xbbVyj8TpnQwD6ry7aHNGGfGNHeX6j+IvjFUDowQF9vJFFq3q13a1Xhbvnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623292; c=relaxed/simple;
	bh=F+ufyoJY3zog6/A38PhsTPOv6+lHASYgyIXe4rfC0b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHYs1FOMle7e8YpJDFWTCKRiBqRYty8npxHOeaWMbbrSgdClIgGlDJom4plYuIZyOws2/FSPoQvqZVfAAg+nOoRJY0wy7xQgBFV3Rn8oGo/Jm/bfJJdv0fZwBGZ4vj8SzmkBO2dR4iGnZ0flH2cq9jABgWOZYEVTJa+3Uq/xoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0oOjBe7; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so5994170276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623289; x=1730228089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCHdLUJmpgTM9PmoKNfhcDScWcGzgJ/xcsnMnuzV9+8=;
        b=S0oOjBe7nGyJkJ7zCWgx4WUT5j1i/BqLx+JIBj1qq0i1oiAyh+AlnG+diymUzFxbHX
         Yp3k0fP+LpnRcBVvVtdpyOBthIifta4wO4C/ii2h01SfisLnsCsiopF11NmwqTk7eO42
         51UF4yFR3NsYVXexeZVwFrbuWwnFsC1xv2IzY1dCmlYFEmMzvkKqEmPgRbaxjsKqUkkG
         MBdrgBhz3c8XnW7enSq5yNJ38ADGOay8hEKMUPfhuU+Jbk55pRIhU5vMAVJk4UyAaoYG
         PhsLFlQBDAnKkicsnaZSzNLHuOWWr4OJ/D1YE9F+qikdtizrmpIahLq+B/g08dxby39Z
         pDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623289; x=1730228089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCHdLUJmpgTM9PmoKNfhcDScWcGzgJ/xcsnMnuzV9+8=;
        b=ZLLQig3Kp3mENWXSM8/4jyFbgFOlcP5erU/sKQm6Z6VCoarh9smxAl9l5wmAvgvGDs
         5Zjdd1gqKE3tX0ti7YktbC50uOQg7vzYfua1yRveuhW5LxqSSgp0Nukj3/Q6/Z6qyZGx
         JcZUqO9Yrg3FZ21NgFNS7rdroLIiX5xQM7z6er7OMuCI0cn4LROnaTQe4CSJEKNgTvLq
         N3Bi2v3+Jpy7euX5gnWallKIkRUXQt3ESvHOgdmHERnWR8kJeFalYfB7h/G90yna5Uq7
         amLu5KLoNDW5s0ylP+TzAoQEPjlm4Ww6K0nrfOSohygxcSceTbkAdqim2YS7NmkZTC7v
         N/6g==
X-Forwarded-Encrypted: i=1; AJvYcCUHqLUfE9bAIbFCv9k2cy48Hja2Yxk5Rlj8YyXwTgDZvhTys3fRI6Aeed5kfxxbaG0gj36RfF6Cp7ShZ9aK@vger.kernel.org
X-Gm-Message-State: AOJu0YywEyUos2cQ/+RexmiNNLqeSEmAKU0yFpx/+Cb4EyOj4o9YNVTG
	xUOLDVB94KMHXeQUoeWxeFKWcNOmS0iq7c6L/TjNyzCd3UG9ag+N
X-Google-Smtp-Source: AGHT+IGlE8CaOqpzvTqpapoVslrX/xw+jMhcqaZ6FMqg8l7S4HBKizryv/wDNe9Qw58FijoHO72xRQ==
X-Received: by 2002:a05:6902:1b8e:b0:e29:6c21:20b2 with SMTP id 3f1490d57ef6-e2e3941b098mr424726276.47.1729623289565;
        Tue, 22 Oct 2024 11:54:49 -0700 (PDT)
Received: from localhost (fwdproxy-nha-013.fbsv.net. [2a03:2880:25ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2e312b9971sm260717276.34.2024.10.22.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:49 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 01/13] fuse: support folios in struct fuse_args_pages and fuse_copy_pages()
Date: Tue, 22 Oct 2024 11:54:31 -0700
Message-ID: <20241022185443.1891563-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022185443.1891563-1-joannelkoong@gmail.com>
References: <20241022185443.1891563-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support in struct fuse_args_pages and fuse_copy_pages() for
using folios instead of pages for transferring data. Both folios and
pages must be supported right now in struct fuse_args_pages and
fuse_copy_pages() until all request types have been converted to use
folios. Once all have been converted, then
struct fuse_args_pages and fuse_copy_pages() will only support folios.

Right now in fuse, all folios are one page (large folios are not yet
supported). As such, copying folio->page is sufficient for copying
the entire folio in fuse_copy_pages().

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c    | 40 ++++++++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h | 22 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5edad55750b0..9f860bd655a4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1028,17 +1028,41 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
 	struct fuse_req *req = cs->req;
 	struct fuse_args_pages *ap = container_of(req->args, typeof(*ap), args);
 
+	if (ap->uses_folios) {
+		for (i = 0; i < ap->num_folios && (nbytes || zeroing); i++) {
+			int err;
+			unsigned int offset = ap->folio_descs[i].offset;
+			unsigned int count = min(nbytes, ap->folio_descs[i].length);
+			struct page *orig, *pagep;
 
-	for (i = 0; i < ap->num_pages && (nbytes || zeroing); i++) {
-		int err;
-		unsigned int offset = ap->descs[i].offset;
-		unsigned int count = min(nbytes, ap->descs[i].length);
+			orig = pagep = &ap->folios[i]->page;
 
-		err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing);
-		if (err)
-			return err;
+			err = fuse_copy_page(cs, &pagep, offset, count, zeroing);
+			if (err)
+				return err;
+
+			nbytes -= count;
+
+			/*
+			 *  fuse_copy_page may have moved a page from a pipe
+			 *  instead of copying into our given page, so update
+			 *  the folios if it was replaced.
+			 */
+			if (pagep != orig)
+				ap->folios[i] = page_folio(pagep);
+		}
+	} else {
+		for (i = 0; i < ap->num_pages && (nbytes || zeroing); i++) {
+			int err;
+			unsigned int offset = ap->descs[i].offset;
+			unsigned int count = min(nbytes, ap->descs[i].length);
 
-		nbytes -= count;
+			err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing);
+			if (err)
+				return err;
+
+			nbytes -= count;
+		}
 	}
 	return 0;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 671daa4d07ad..24a3da8400d1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -291,6 +291,12 @@ struct fuse_page_desc {
 	unsigned int offset;
 };
 
+/** FUSE folio descriptor */
+struct fuse_folio_desc {
+	unsigned int length;
+	unsigned int offset;
+};
+
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
@@ -319,9 +325,19 @@ struct fuse_args {
 
 struct fuse_args_pages {
 	struct fuse_args args;
-	struct page **pages;
-	struct fuse_page_desc *descs;
-	unsigned int num_pages;
+	union {
+		struct {
+			struct page **pages;
+			struct fuse_page_desc *descs;
+			unsigned int num_pages;
+		};
+		struct {
+			struct folio **folios;
+			struct fuse_folio_desc *folio_descs;
+			unsigned int num_folios;
+		};
+	};
+	bool uses_folios;
 };
 
 struct fuse_release_args {
-- 
2.43.5


