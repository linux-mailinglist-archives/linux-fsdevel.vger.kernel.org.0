Return-Path: <linux-fsdevel+bounces-34119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A70029C28B3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E636B22066
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37C7C2FD;
	Sat,  9 Nov 2024 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip/nMdir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B15C2F2
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111234; cv=none; b=MHckUC4nP5Bi7OAvPhHQ0BFwk87DI3YSepxE+d7Pr+01CTJKuTLpLm+fY6aYC9o1mIkJ6p+yKXSIlRhYEcHOu+RZkvxK/peGwCst0a4pv2UTLfe+nPNNUYr0ig/DgkeHu+48g0OjSSD/mOaozW09fEt+Q70+mJ/J7dnH25OSGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111234; c=relaxed/simple;
	bh=+u6MlWqVIUPGucDDZ11gt1GWLiWVmel7l/A5JwwHaN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm7m1FkuYT8jplig1BrONDgmDtta6ny/2aI3g2oI7yhgTAwME5oXqcE1itXZFehaieVGZRk4yc2TljVzHni+HcuwVRYM4lHM0MajWlVnYjUIpu80Vq2vOteQr8HjC/fGMGcFpspm6Snv8BEnfdCDHW3FYHiMDN6xdRmptB/XLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip/nMdir; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2e2baf1087so2701658276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111231; x=1731716031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW1L6GLqIuWp0+LGyHyVAr9DCx7A/ZKZoCxcAOHkb3U=;
        b=Ip/nMdirpAIrtu+hr7lJjDGIoSnC5js6WxsaK9PeIhwui9LN7xpNb2Zlo1mA0AioDv
         GvSrjPuIs1sWXb5vSUyVZ4/iZnypFbgykC6iI0Z9i0CUxz7c3XCGYuMeESGPzi5QcqiN
         ALgomd6DXtWDVZOUXzPWkg06zppH7hE9ASeUUq9Z7hAp+sXisA3tqVeOOcMdWQGoLs8s
         dXdalKCBrlTs0DwUrlmLOh1WOI4gd7M5EKcuKId47QIsV/84R436DB1Z+iNwmAaEfm1q
         AHvuzBXGsNB6ZUCMP3XLUob/sBtT2jq9a6RZ7WJpoTRJJTmIcxVkB0PLrJqYz+I+/RaB
         26FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111231; x=1731716031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW1L6GLqIuWp0+LGyHyVAr9DCx7A/ZKZoCxcAOHkb3U=;
        b=rJad33+IrCOIt6LPGUoIbwjKrwAGI/S4sMxbxgO81rthxHGS0pXkUaw0nWdTpaJPvk
         RC/vMKE9V2+y4OhXE4nmSFn8CfIW8e4vFZUKLzIPOralpWceyoGS8JjXP1ZNjzycj/2r
         M9xDD1CoKMov/QIgYZXMUN5kwDuhZBYVi2Y6NBVO/clF8GK1GIv9ySBjFXc3BSDYtCNt
         aO7SBaoafi7zfZtAs8F87Ajip18hYsY5ocEU5SVlJ4KqWLp0orgt5udXFJ/AEup5ZK30
         NM4VpfhJuwS6RH6GFjg92o99ycLXlhJCG4PaRU1kpju0bdDXtO6sn5YXe0BD6y6tVEAw
         Jt5w==
X-Forwarded-Encrypted: i=1; AJvYcCUsBb5hSHuMteYWA+LcAAWwX80LrFkISoRn7pqzeYbYpdo+6auZlhAKvB7VGswzTmnk/ldM1TWeZLhoEmgT@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWTucKJaW8mZNXFflxcIyIue5V3hhYPb+N8WOrbvaInl58g5+
	5MOL9XSVWwrFITEEI45QgjrX1T7b6qGx6PaaujytZh5Iu3cIhHt/
X-Google-Smtp-Source: AGHT+IFWVPaUg7nYCfwX+mF7CK2zrGz5GmxwEdW/sCpW9NxzDBSXytK2YCdIHVxrRfZ+2XtT7dA7cw==
X-Received: by 2002:a05:690c:3609:b0:6e3:26dd:1bf5 with SMTP id 00721157ae682-6eadddac491mr57914787b3.20.1731111231686;
        Fri, 08 Nov 2024 16:13:51 -0800 (PST)
Received: from localhost (fwdproxy-nha-006.fbsv.net. [2a03:2880:25ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8d77e6sm9403887b3.17.2024.11.08.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:51 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 09/12] fuse: support large folios for readahead
Date: Fri,  8 Nov 2024 16:12:55 -0800
Message-ID: <20241109001258.2216604-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 44a65bdfe8fb..255c7f2f2ed4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -885,14 +885,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
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
 
@@ -929,6 +928,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	unsigned int max_pages, nr_pages;
 	loff_t first = readahead_pos(rac);
 	loff_t last = first + readahead_length(rac) - 1;
+	struct folio *folio = NULL;
 
 	if (fuse_is_bad(inode))
 		return;
@@ -952,8 +952,8 @@ static void fuse_readahead(struct readahead_control *rac)
 	while (nr_pages) {
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
-		struct folio *folio;
 		unsigned cur_pages = min(max_pages, nr_pages);
+		unsigned int pages = 0;
 
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
@@ -968,14 +968,24 @@ static void fuse_readahead(struct readahead_control *rac)
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
+			if (folio_pages > cur_pages - pages)
+				break;
+
 			ap->folios[ap->num_folios] = folio;
-			ap->descs[ap->num_folios].length = folio_size(folio);
+			ap->descs[ap->num_folios].length = folio_pages << PAGE_SHIFT;
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


