Return-Path: <linux-fsdevel+bounces-30741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173B98E138
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BE71C234BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D11D14E9;
	Wed,  2 Oct 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ5h//Wh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958161D1314
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888120; cv=none; b=Gw8j4gbVTMlLOqjJb2ErALw1qYGmjjfYg32ACfGHRxpT7xZV5PAa+bE5gDGe/FN28YPM5H4YkIMnO/42zIhF+TBpAex3cf0dgRRAleImTJZt2HufZIhh6mWyRwXCeV43gS/I3yNVsWb+nS3UMVHcLVo6D/3Pk1lwgXCQdpRnW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888120; c=relaxed/simple;
	bh=wkXRmudIC1GICRJTsQyhX+cdfkDe+Wldt+fgZTQpVXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLLFi3bRnHj6Jv//cmMVc4MzTXnrjV6BO7vb6WwEdNL2Y0hsycKeMscTFMnNkTEW+gzg/jPQXOD1cNJSUqUWnMCoo0wqc1HVliQbsPpHzLpZsbnMQY3CcMql8dNARhO+mjNkAke+0EK/RmY5Idvb0RWlPA49D7unS7Ir4/pXUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ5h//Wh; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e2598a0070so101527b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888117; x=1728492917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RVhtoiIRcNEXtPCMAdwi/GkhOsFV4DoAkyx+bW+g1A=;
        b=LJ5h//WhWE6wtPlB1Wwa82dAFQfOQd5yBWqNBosfiSs91giXxi18UFlrdyNKgxhzEe
         lzLceQCa3ofyFvO6w5LjRtPfWtMJRrTIviHuS7YcU3xGg5IYT7xPFZh+NACY8+GUeiXu
         5Y9B/E2RJWklO9uLWmC1xlfg9rVRmQDjexOKdzloMsTEjlsA9x8Ua7DctE9cikhKJptQ
         erLyBHUAXE3FGy31/iFdSYZjQ6Fxs8ucZ6XupoGib4r0BgUc5Nr507+Zho/R4x2G3iUY
         +NFcgwpNHGHAo4tnCcqxuvOYAw7o05lAsXGfBlMvEioiECovNf9Vff7sWKXlllSQWbtz
         di/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888117; x=1728492917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RVhtoiIRcNEXtPCMAdwi/GkhOsFV4DoAkyx+bW+g1A=;
        b=niPxGjAGnPbT9tkIH58Rs9FeoSLqvoZpyYj11ouWDW460dbk8Xj7FUALs/xnH7gYh+
         FxlaPeYb6xquvNZ8TWCKemkrl30C7Vm0YQjAGjfHtHkaDibFtItsntATkY0tGe4VLqEm
         q8rL3i5UYYpEZc6IlJGzL8tETPF7iMX5ywaPpG/M3VsCNveWpI53exjmF7NTQRiy++JS
         1mnBAogOUE5bo7wT1kqRNEvgoVVk8z7Vq7vYRBP+K9wP1+3HxzvIduUAC2w75WUO6NLl
         h64Wrn3tsvfMzEKSs9z2vox2gxZpqA5zvk+vZ1kuh9kBRPCQQ1l+5AxN8i6WUQjaxx8t
         RbRg==
X-Forwarded-Encrypted: i=1; AJvYcCUEIrzeo7GHdx71v02DAHq7TE4zQRO+yIYrZNOd6pHwsqs2d8i19GQsb4bjQH0bRawlrnUvJ/FnLAMAS1od@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSg+Tt2M/Bqo4A+sAauigb75KuU+SR17zDVq3YX3KoaXlPq3g
	msW6pUK8K4Zs9MecFWY1AjpiZ5e/mOjExaMX2Fv06GokE4hp0TOa
X-Google-Smtp-Source: AGHT+IEDt9kPf9zIRjMyx6URMXZqPqBbFUI/UhOYg3EsDPbUD2b9DadNHzxzWD8rlpEArDjMXUrOvw==
X-Received: by 2002:a05:690c:ed6:b0:6de:c0e:20ef with SMTP id 00721157ae682-6e2a2ad9c71mr37058537b3.7.1727888117504;
        Wed, 02 Oct 2024 09:55:17 -0700 (PDT)
Received: from localhost (fwdproxy-nha-004.fbsv.net. [2a03:2880:25ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f7c26sm25352817b3.11.2024.10.02.09.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:17 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 03/13] fuse: convert cuse to use folios
Date: Wed,  2 Oct 2024 09:52:43 -0700
Message-ID: <20241002165253.3872513-4-joannelkoong@gmail.com>
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

Convert cuse requests to use a folio instead of a page.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/cuse.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 0b2da7b7e2ad..eed78e303139 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -303,8 +303,8 @@ struct cuse_init_args {
 	struct fuse_args_pages ap;
 	struct cuse_init_in in;
 	struct cuse_init_out out;
-	struct page *page;
-	struct fuse_page_desc desc;
+	struct folio *folio;
+	struct fuse_folio_desc desc;
 };
 
 /**
@@ -326,7 +326,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct cuse_conn *cc = fc_to_cc(fc), *pos;
 	struct cuse_init_out *arg = &ia->out;
-	struct page *page = ap->pages[0];
+	struct folio *folio = ap->folios[0];
 	struct cuse_devinfo devinfo = { };
 	struct device *dev;
 	struct cdev *cdev;
@@ -343,7 +343,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 	/* parse init reply */
 	cc->unrestricted_ioctl = arg->flags & CUSE_UNRESTRICTED_IOCTL;
 
-	rc = cuse_parse_devinfo(page_address(page), ap->args.out_args[1].size,
+	rc = cuse_parse_devinfo(folio_address(folio), ap->args.out_args[1].size,
 				&devinfo);
 	if (rc)
 		goto err;
@@ -411,7 +411,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 out:
 	kfree(ia);
-	__free_page(page);
+	folio_put(folio);
 	return;
 
 err_cdev:
@@ -429,7 +429,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 static int cuse_send_init(struct cuse_conn *cc)
 {
 	int rc;
-	struct page *page;
+	struct folio *folio;
 	struct fuse_mount *fm = &cc->fm;
 	struct cuse_init_args *ia;
 	struct fuse_args_pages *ap;
@@ -437,13 +437,14 @@ static int cuse_send_init(struct cuse_conn *cc)
 	BUILD_BUG_ON(CUSE_INIT_INFO_MAX > PAGE_SIZE);
 
 	rc = -ENOMEM;
-	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!folio)
 		goto err;
 
 	ia = kzalloc(sizeof(*ia), GFP_KERNEL);
 	if (!ia)
-		goto err_free_page;
+		goto err_free_folio;
 
 	ap = &ia->ap;
 	ia->in.major = FUSE_KERNEL_VERSION;
@@ -459,18 +460,19 @@ static int cuse_send_init(struct cuse_conn *cc)
 	ap->args.out_args[1].size = CUSE_INIT_INFO_MAX;
 	ap->args.out_argvar = true;
 	ap->args.out_pages = true;
-	ap->num_pages = 1;
-	ap->pages = &ia->page;
-	ap->descs = &ia->desc;
-	ia->page = page;
+	ap->uses_folios = true;
+	ap->num_folios = 1;
+	ap->folios = &ia->folio;
+	ap->folio_descs = &ia->desc;
+	ia->folio = folio;
 	ia->desc.length = ap->args.out_args[1].size;
 	ap->args.end = cuse_process_init_reply;
 
 	rc = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
 	if (rc) {
 		kfree(ia);
-err_free_page:
-		__free_page(page);
+err_free_folio:
+		folio_put(folio);
 	}
 err:
 	return rc;
-- 
2.43.5


