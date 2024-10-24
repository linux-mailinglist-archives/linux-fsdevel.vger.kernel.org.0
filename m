Return-Path: <linux-fsdevel+bounces-32800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBB9AEDC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6651C23C14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A821F9EB1;
	Thu, 24 Oct 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBxZ4t25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9871FBF58
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790492; cv=none; b=MXSDZOugqL7nxZ5qP2iHGzZ4yZ5tZzH/JlNVVBmV7MCKBit32eVaN/B27FZktBHB4D2+gbHXiotqK6XaGeUajjtmeQ1TPCsq524OxHtBD6r7FSiSwAdJnFiGQ1/K8PpC8G5izypRIoN8PC5Zgjo4tAxw+1OjkfAinEIbZNoMoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790492; c=relaxed/simple;
	bh=F+ufyoJY3zog6/A38PhsTPOv6+lHASYgyIXe4rfC0b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2TKxZbK1zPiHLPtH0x5iPgaeQAYOLX73hz53SugcR8EfMBxSKcHyx1ackafQYzFeT0uQUofHnPrKHRdN4sq2ZZbKla1BTtYnTh+S+8QS8xPrzIf5QCwxlYmaiIw/E1Oeh7nDVrlRL3yXiOcEOSBMYNmNN5hFuv/3elo8KQfYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBxZ4t25; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2e508bd28so10560937b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790489; x=1730395289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCHdLUJmpgTM9PmoKNfhcDScWcGzgJ/xcsnMnuzV9+8=;
        b=DBxZ4t255niD4hUl+gqPpB7ldDzTarW1bmBmUSw0zsBW1wH+yCxEbVT6B2yQhcuVzP
         7tF6Bswhi6AU8NbhiF10nts4aKBToldqCTzRWIE0y6knsH2VvJduwuJAjqrK4uNSwEsc
         v8lj8Wfr00V+7P4smhQEKxXmKZzE5Z1PcQUr6zfo00wdmEK7QHjJVS2ofcsfSxwV75a7
         7hFx0HwrFBB9zAIbz8x8ML2u3w+JRDmdPaW43aDPg3bZp34DqNHPc4n4lRNROeI/Xmj9
         6bleIsXkaiYF0v8TO1B/ASInzyoXnGDeqxA7sOqm54AW7/gtflvQtg4Mlwx9Fhv+5z6K
         ag/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790489; x=1730395289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCHdLUJmpgTM9PmoKNfhcDScWcGzgJ/xcsnMnuzV9+8=;
        b=ArftLqXfSFlGV0j7YTohT03a9ZD/MkvUesZ//wbW7Q2Xy5AoctDY7FIoshYJtp/Xq/
         /caiLvGWWG8QVC5wXNkzotqAzuTDCcvNMlzDX8JgBFzCbd7oM+dXD7lJXBAPl3qbDUOS
         F+Tdbqknll7eBmjBSsDUOQ/zTDeykY8Mtv5Krz1hNd38EZAghdk1g69XKULERz9M9P97
         3htnjlOJNVLOj0mVEwtx+lHTkktkWdf/t+aSO/Fz7939ltRT+lQOlh84A07CAs/6PePZ
         eCCLDtGkCI1+cZk131Lww/IysGos1pWqQO+r29DzC8GihMvoTODfl5hSXr7IlUi8yfbP
         8pKA==
X-Forwarded-Encrypted: i=1; AJvYcCWmOh9dowE2cwiEDDw4POvHryoBmuhxnyqnjf8s28n1xt+bnoAkfkls3hBoMyP0PgYj6RR+PefwLN7L+ZK+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EU0RRocMTU/cIhGc0BWdXmP6b3062SV7n2cCPPtkcvDci3YZ
	Jj1YuqdH/NTt90hMJSfNRDSN505anllyEGUcveuNx+MpI0IIriyhpJKUrQ==
X-Google-Smtp-Source: AGHT+IG5t06mid9hu/V94sx0Poiw8Ijrpy/+t789I8rCDSrKoZzyIh9AZq2W4/yi/di/V9/kmJmczA==
X-Received: by 2002:a05:690c:9a88:b0:6e6:45b:5d0 with SMTP id 00721157ae682-6e86635006fmr29018277b3.45.1729790487460;
        Thu, 24 Oct 2024 10:21:27 -0700 (PDT)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a6199esm20631967b3.46.2024.10.24.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 01/13] fuse: support folios in struct fuse_args_pages and fuse_copy_pages()
Date: Thu, 24 Oct 2024 10:17:57 -0700
Message-ID: <20241024171809.3142801-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024171809.3142801-1-joannelkoong@gmail.com>
References: <20241024171809.3142801-1-joannelkoong@gmail.com>
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


