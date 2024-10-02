Return-Path: <linux-fsdevel+bounces-30747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B4598E13E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835521C23755
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B018F1D151B;
	Wed,  2 Oct 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnko0o0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4381D1511
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888127; cv=none; b=EQJWaJLzaRzeskjw60yfsHxRwn+WUTfQH3Xrn1o8YC2LyHddKa1xvTlBriq/IgqYiwFwgvaWLzZyx5cMZHcnh8yozec/3+HjkZYxEEgRttxmL8bvXo8s1CNv8qOQFaobYG+pRu94i7sD+GgL1JICjuBoi94Dxaib6KkGtbAFkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888127; c=relaxed/simple;
	bh=LlxygvPb64LbLRGdesH0o8BMqn9NhYcJuYCOJeo7h4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hj2c/COdYMrwTPt8/7RBm0NvMWf7b8OGxsRg4AqqSPbOy+cIb+liiTON9Glw2F20nsC/gleCzovzGwwB+1LX4LbgmPKp06EXwmvzBzwXkRt6+CMsKmPK3Uzcz6hok7RFN6z/EQSsiBVT1idDR4jBdWXo9FywH87T30FEenlkysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnko0o0W; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e22f10cc11so54580257b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888124; x=1728492924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ldm77ralTngvKGT9ivHSp4XcFmcs7y3I7OPXiXbAQXk=;
        b=Bnko0o0WWjPkmw4WMlLaqXqdphs12CuNLzd7ESGFYrbNZOToheeAj5JX+fGjHrXGYE
         amwPj363jqhO5jUGlU3qMP0VdKWP6fBTd2kEJpSICmqX5dGs7ET9baIUxj98y1ZCePQP
         6czs1rhYcI0AldqOpJ4cYSCP4t0nHo/ZdcWE5JY0g0H7kQnSowgOjIwMTxZ5NTFmGK+/
         6kRq8ZuWGS6TLr2tuvam46X8TRFe405C+Vkv1MYqVp5VYvNWj1y/NI1yMdLmHt6/mrku
         ZeSqOk3BFuLaEeFnX+tyEHlTzPSysp0/AeA1yBtSnlysZjGLiutlpreOpbXwOzpOJLiX
         bDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888124; x=1728492924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ldm77ralTngvKGT9ivHSp4XcFmcs7y3I7OPXiXbAQXk=;
        b=Ye/GMGv22iN/qNJ3nWHMLUS1yl4CKbaGuu7AG6sF6q7gOzMv90ZPa2dSaQyhsy+vfp
         pgsxA6PmIwDayUaq45YjS/zk3gnDdDA8fk1Cu2YltLE+7OTg+i14F05LilkYi7WFlaMM
         d6Iwbx9SoycMBTzY4fd82tUdDhzzpl3pVfjw113/pncrdK2lvNnQ2i+8ZTvjfbOqSClK
         +cNGSFctJobU2K13B2hc2JfGEZk+wQGgjDhYu/z+4NxyRlotdLnpev1RoTDCEPhrqMSg
         2E6TZLoCnOeZmvKmjXLtwxWoGk8HEDy+wkwa7GQvvcZLTBlvlhsiJRk/9HZJkbbP2nJx
         8zCg==
X-Forwarded-Encrypted: i=1; AJvYcCXOAz24aH+bdfQI93RRr336MjBqQq5jMqTcl8UU8fgRqQUXdwGA+pokWWsKaTssJFM0GeCuW8gTGYxMr+Iz@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRAyasm32ICuLLWUDIuxShpTb6QMk+rDvJyuwvC/GgfmlVPBf
	mhtGVahrYeDIrp2VJzhwOaUjSBo6Xa2CP4mad131iPDzf+r3ee7xMOb7xg==
X-Google-Smtp-Source: AGHT+IFzh/OBNYITHbx6X+HX5Fv+w99tuzV0sdrtxXccYWMjY6C0D36xseslW1g3AHGQB57721Hkcg==
X-Received: by 2002:a05:690c:f95:b0:6e2:b263:1054 with SMTP id 00721157ae682-6e2b26365cemr12538017b3.4.1727888124666;
        Wed, 02 Oct 2024 09:55:24 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e28823a73esm12870227b3.100.2024.10.02.09.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:24 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 09/13] fuse: convert retrieves to use folios
Date: Wed,  2 Oct 2024 09:52:49 -0700
Message-ID: <20241002165253.3872513-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
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
---
 fs/fuse/dev.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cd9c5e0eefca..2f59af6a8c22 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1727,7 +1727,7 @@ static void fuse_retrieve_end(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_retrieve_args *ra =
 		container_of(args, typeof(*ra), ap.args);
 
-	release_pages(ra->ap.pages, ra->ap.num_pages);
+	release_pages(ra->ap.folios, ra->ap.num_folios);
 	kfree(ra);
 }
 
@@ -1741,7 +1741,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages;
+	unsigned int num_folios;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1757,18 +1757,19 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	else if (outarg->offset + num > file_size)
 		num = file_size - outarg->offset;
 
-	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	num_pages = min(num_pages, fc->max_pages);
+	num_folios = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	num_folios = min(num_folios, fc->max_pages);
 
-	args_size += num_pages * (sizeof(ap->pages[0]) + sizeof(ap->descs[0]));
+	args_size += num_folios * (sizeof(ap->folios[0]) + sizeof(ap->folio_descs[0]));
 
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
@@ -1779,7 +1780,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num && ap->num_pages < num_pages) {
+	while (num && ap->num_folios < num_folios) {
 		struct folio *folio;
 		unsigned int this_num;
 
@@ -1788,10 +1789,10 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
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
 
 		offset = 0;
 		num -= this_num;
-- 
2.43.5


