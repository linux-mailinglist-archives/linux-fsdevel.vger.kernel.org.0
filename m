Return-Path: <linux-fsdevel+bounces-32607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522059AB650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE515B24B09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99591CCEF9;
	Tue, 22 Oct 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbyKE+ds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13731CB322
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623298; cv=none; b=CSJeaqLBmDY3NlBuxS3qay2O/tHDWF1pJYZPXm5di+7sNf3qFfJ8abTfgpAKiFB+dEwsTbthR4cXSU7iXFFBiAkaIuY0SMcP3LkNl1iGNs0y9/uCJDeetiBWupoM1CnBNwIIdyDldz7v8Rd5/1gI5hormFn5ZTIesOZOtQ76RmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623298; c=relaxed/simple;
	bh=hcL3+0RhcVI43HbxnLht5hou1eV5UtTxkn+gysx5l8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCLj1XudqR5BHrEXQT87aPGYD+ZajIg3Ym2hmSTMzsbwDwXVxcL3mT4Znu8r3n07HcBo6nEYvqphwuT6ZFin96NzBt+bIN6lMRC//9I5UkVjY3j/uYnrY/PSV25/4bdewHJfmuQgn+OmpSL2SHlU4tZtJsANNwWsjk5gbc5J/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbyKE+ds; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2972abc807so5513336276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623296; x=1730228096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgxWYiUYA9GbSWvPK49YvUVeUso8Jap551AxuZHlbSw=;
        b=cbyKE+dsY/52g2CmQt8YPA/Yy4xV01GjBFCvqKrWD2DSSZ/gtntCxSQK7VYyaUUReY
         ghCpgjiAayuFg4x4TJpqWONGuJlvaclYlciklsp1tGdZcAsbocpWww10k1Pl0w3AeeGl
         pcK0wjqs9BGBmvRqpErYJjzJRrtcSfEpE4nl8EdLICc1n136dOMbOBD3AmfLItexJw9l
         FWopvKKNa8o3AoOnvRvp7csoWpGPd1OMQkqtI00UW4f3WYQ/RjEA17tNACxokAnOfEyq
         h0y+M3OAUNdlRgl5ELrYeHbZRrAlvI/qanAfZit7Im9N9slPGFgzUcuN1OnDaPDvF9Kq
         XWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623296; x=1730228096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgxWYiUYA9GbSWvPK49YvUVeUso8Jap551AxuZHlbSw=;
        b=R8BRs88l3952vh/arDE3Qc84cek7vR/gp0sN4kebJyM4vBSesYHsYeUPnEbTFeFg1I
         Daa6pHUZIMqPhbXtQ4Fxvv/dxrpb0drm+W7K4JHovDn5YBVKewSn/s3fei1njJWRuDAE
         22ZTA+s+gUu7u2vTeyd5BNOBhxOWmUQKj5mwZINKBECjuXW9zcXPeHF4LAp6W+6Q+y4T
         p5zpMrAk36DXDBthnseZpwnw1ZYYH4odT/Ptx9M3sfqrK4QPuCMDefMknxNvNJ+xNsII
         UeHxEWTb9mOmo8b2dMuPnmpYDmCAISd0cW4yVetkrpKv9IZohYjN4w5gRR7W/FanOdOe
         Z3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAkiceT/9LuqPy6pTQcj4tMnXwuct89PcdGP3lJ9nOQsrPYunXUIb4qUefKWB6sNlznCn81PgXpdbYsEWa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9Byk7Utix84pwQ1SUTEjkKxhhPkXzkhiISwK2Xv0niTfGhE/
	MtF+lLnugTCHqHj4IxleO16JKnWgMbYBciJ4t09HlGoEizBn9kry
X-Google-Smtp-Source: AGHT+IHuh8ORBADRgQ1nyC3IEMPOK1NCvJLswVgLyqZ3kXrsx5Pi1uN/k4h2SEu9hoIDACFe5Qg+aQ==
X-Received: by 2002:a05:6902:2b0e:b0:e29:32fb:b4c with SMTP id 3f1490d57ef6-e2bb1440df9mr14687267276.32.1729623295622;
        Tue, 22 Oct 2024 11:54:55 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcb0358csm1159572276.59.2024.10.22.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:55 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 09/13] fuse: convert retrieves to use folios
Date: Tue, 22 Oct 2024 11:54:39 -0700
Message-ID: <20241022185443.1891563-10-joannelkoong@gmail.com>
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

Convert retrieve requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9f860bd655a4..220b1bddb74e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1728,7 +1728,7 @@ static void fuse_retrieve_end(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_retrieve_args *ra =
 		container_of(args, typeof(*ra), ap.args);
 
-	release_pages(ra->ap.pages, ra->ap.num_pages);
+	release_pages(ra->ap.folios, ra->ap.num_folios);
 	kfree(ra);
 }
 
@@ -1742,7 +1742,8 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages;
+	unsigned int num_folios;
+	unsigned int num_pages, cur_pages = 0;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1761,15 +1762,16 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	num_pages = min(num_pages, fc->max_pages);
 
-	args_size += num_pages * (sizeof(ap->pages[0]) + sizeof(ap->descs[0]));
+	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->folio_descs[0]));
 
 	ra = kzalloc(args_size, GFP_KERNEL);
 	if (!ra)
 		return -ENOMEM;
 
 	ap = &ra->ap;
-	ap->pages = (void *) (ra + 1);
-	ap->descs = (void *) (ap->pages + num_pages);
+	ap->folios = (void *) (ra + 1);
+	ap->folio_descs = (void *) (ap->folios + num_folios);
+	ap->uses_folios = true;
 
 	args = &ap->args;
 	args->nodeid = outarg->nodeid;
@@ -1780,7 +1782,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num && ap->num_pages < num_pages) {
+	while (num && cur_pages < num_pages) {
 		struct folio *folio;
 		unsigned int this_num;
 
@@ -1789,10 +1791,11 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 			break;
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
-		ap->pages[ap->num_pages] = &folio->page;
-		ap->descs[ap->num_pages].offset = offset;
-		ap->descs[ap->num_pages].length = this_num;
-		ap->num_pages++;
+		ap->folios[ap->num_folios] = folio;
+		ap->folio_descs[ap->num_folios].offset = offset;
+		ap->folio_descs[ap->num_folios].length = this_num;
+		ap->num_folios++;
+		cur_pages++;
 
 		offset = 0;
 		num -= this_num;
-- 
2.43.5


