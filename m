Return-Path: <linux-fsdevel+bounces-32806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D704D9AEDCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C18D1F24AB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D71FEFB6;
	Thu, 24 Oct 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEOkkdj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE21F76B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790497; cv=none; b=ia+wyTf0866Ue/lulcCZ1Qs1gpxCDKYGZQBVzCP3XXsRG0QVl7oXOoHJZ7Y3GquK3upVTYS02ct9IePYJsNL4MQxHYsl/vaR6+ARNEqyQDC4E8lSvSEzBkyx6NP5rK3u5pyVpOCLoPjnVj3evyomiClR+54kzYCSaTHBGQEjMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790497; c=relaxed/simple;
	bh=u5QKa7U9Psgt6XNgOMf0yckRg7JO97OBkthD/xegzFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It6huwstJlk0sfEKvlTvkk4NXHxminyRqEUeNfvdvKkhBy1fwEUBC4YSDZUdUIQ0lKzYE8hB9VB3atNLypdRZ5mf8/1ogqVuPjg7a1s+Jma9fPyrdzxiOTodfid31uze2T2laacScI93YCsbu7le+JYSKGZqbm4DwQoyKL6W+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEOkkdj/; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so12122277b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790494; x=1730395294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzxtYdjhLYm7SpLm5LWselHwEnY7l1Z1CL7gsS4M7V4=;
        b=QEOkkdj/X/S6O7O4rXJ224lNhLE/JmGb48eUlu4LviFUMLlPmoO1vjL31+q40g4R7s
         GFvs4wbtsxBIPrKl5w5oZuIC4nTrd6CGJpGRXYsOOssgL2zxH0lJ1nJy3rX7ZEzZB59D
         tDOVU55qJtO0ibJp47S7HcebmD9nMlJqSKYJGB6vN/XYWjCVaTcPU9YubugZH33dJ5sw
         HuKNmGj7XVYtKISQnGst2L7SYjacttZFdtqjTWxylPuQORZ7495SUeWRZksEUNA7SmX1
         GNAiLRbuvxOnfp5982oQAh+JAU3jr5DG6o6y3ZNIKo5upaIws5aWHclxOaj8Fz8MTqvl
         DvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790494; x=1730395294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzxtYdjhLYm7SpLm5LWselHwEnY7l1Z1CL7gsS4M7V4=;
        b=kDv0YtsjjIkPGjxIA1K9goCWwnilb6LfqI1YbRwQAw6Zcmtuz6if7GMEbs+plhB8zO
         3LiGKHbKHWppc+au0kBhWB9F1e0td1uTKBp0K1Pao82Jz9X4e4SwXcMz2oouq2/ju8fK
         9HC3dPjKQ32ma8TL5G69p77EJgG3EhjV1PKUzIbfX7ROZ0MODpdFRRihe4mixD+eJfmR
         nUMtTb2rha/8NhdCLBjZ+Q7SqUFvgA2UzIwSQwRlYcbYGNDrqgEEG4r9ipWfMECIC7FF
         1BXBfgNjeuLqk7EjOTwisX27vPOx8utTNstojwkIydG3JHV6RKBjGsQJ6zKXnY4zFFQj
         O2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUEMTd3Jmkxy167FXXmK0VvHLMOWiiP6TSuu7wO0o0q7GWnEF6zyFYhxqIKHI1n0gThxR3a00lXCURWynjv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyytt89ijCUFiRIZAe5g5fk/oXldSCpTqXJVqyakV1H5ddcdE1R
	KruZy4kJ0kavt11cdGIVas2HXehA+idaYd12s/uSPutGovnblsIp4GX+WQ==
X-Google-Smtp-Source: AGHT+IE/FcJswtK6gc3+EPebDTs1qD8PW2VsYdTrNo1lj9Bwce4u8d3RnjHXJ+UMp4Rr/oPV46Ev9g==
X-Received: by 2002:a05:690c:6c0c:b0:6e3:1063:91ca with SMTP id 00721157ae682-6e86632cdd3mr34706437b3.40.1729790493551;
        Thu, 24 Oct 2024 10:21:33 -0700 (PDT)
Received: from localhost (fwdproxy-nha-004.fbsv.net. [2a03:2880:25ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5acfbb4sm20501867b3.65.2024.10.24.10.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:33 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 09/13] fuse: convert retrieves to use folios
Date: Thu, 24 Oct 2024 10:18:05 -0700
Message-ID: <20241024171809.3142801-10-joannelkoong@gmail.com>
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

Convert retrieve requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9f860bd655a4..9467b05d3d4a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1728,7 +1728,7 @@ static void fuse_retrieve_end(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_retrieve_args *ra =
 		container_of(args, typeof(*ra), ap.args);
 
-	release_pages(ra->ap.pages, ra->ap.num_pages);
+	release_pages(ra->ap.folios, ra->ap.num_folios);
 	kfree(ra);
 }
 
@@ -1742,7 +1742,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages;
+	unsigned int num_pages, cur_pages = 0;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1761,15 +1761,16 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
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
+	ap->folio_descs = (void *) (ap->folios + num_pages);
+	ap->uses_folios = true;
 
 	args = &ap->args;
 	args->nodeid = outarg->nodeid;
@@ -1780,7 +1781,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num && ap->num_pages < num_pages) {
+	while (num && cur_pages < num_pages) {
 		struct folio *folio;
 		unsigned int this_num;
 
@@ -1789,10 +1790,11 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
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


