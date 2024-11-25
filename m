Return-Path: <linux-fsdevel+bounces-35851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F59D8E49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA840B227CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2D188724;
	Mon, 25 Nov 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCiZjRi4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C9190059
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572363; cv=none; b=JW5uIep2UdgfcBGNWwY3Aoax4LD4IJujXqjZwG1dMG2CFTMXK8EBIInCMSkhS7b3zM1LZq0R2SGPEX8qElFOELGTMU5Li1wPyP5tZrvCbiicEAxqnPob6LPzNFixPu5dULc4V4DPdEFoN+n56XuyNZMkAlICr31IiuFrI0OpryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572363; c=relaxed/simple;
	bh=+YeM8iIH5NcPdHeetGQIssou9QsdaFbvELU6yK5BWGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCIz5fEcyZpezalgfTgR7Q+kTtqI7EzKUJY+I7eMF61qqC4gOKNtJwJy+bnfiG3oqgWD80aCwQ0/dTdXKkCOkYKXLiVyYNKUHSUoe8WlNOgs1haUH62ZWcOnYZJxy7kp01Zk3nGDzSksO7tLWcfaq0pR2nSmc5m1krXpJOcYzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCiZjRi4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ee55cfa88cso44401847b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572360; x=1733177160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hosLWJYYCE7hLbltZCDIBtow2n3th4dqtPi982FR+nk=;
        b=KCiZjRi4JARR35S7lTBK3VX59sjc8ro2zBCShZqmWG1Q0y+YZ7M7EID8G8v3mdq1xA
         yEjbdxHpry24LzQqXSX7uNjXkzZEm6LDMv1Q93PkbCzkX45GNu5DZ2Iw9GNqyhE6Hd16
         iESydbspz8+rVKEjnR+o85NLR+34KrDC/FvKDghebyA6lWkBPHVZGdT7puTC46+o2Gqw
         Y4/ICmyzEIjjPbVOXDKAlsUxPDVHdAlzw7g4yTfNxRSZQ12USaxk8zelDKICcFhgz927
         etp8p42RHfSZjXOYmAgqI0Xr0mku4WpWsIhL+He3PuNDxUHAxQEYhOAsXiJ234/NrkHa
         2rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572360; x=1733177160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hosLWJYYCE7hLbltZCDIBtow2n3th4dqtPi982FR+nk=;
        b=GdIZ0111mh6/Mxhm/CnrPV/kqF5LgmTrw/Uv1sA2MCDzLCZLc7ljrRvYM1Vv2rQown
         t7pf0vqD3KJHTOV3k+1c29MfGXaAZcc6ESK8H9GjkZaSBZu8V4TgM4tPvERVK2xYCBqS
         r1TeTRrX/MWHUpaNO2GHGRUlXZ9rAxsvqSWmDqlKy3OwIzHXcUUGLbBTSB8UMqKfqhRp
         +Kvwg0PkKvhG7q7avBaR1CkMJIYAQf6k7689xmv/6mdWqlJ5QNuCLl61g81l0PfpNyGE
         ovnGvFqpm/pGuoGcRDXc6w1BG2DoWzU2AmzNs4HyDKwZw73OIBiMY2OVQYTb6nOlZa7b
         wHpw==
X-Forwarded-Encrypted: i=1; AJvYcCWiLDA8DWjG8sOzkWFqN0I8qYQyA0Ky3jQOIO8nZp2T/GD9+HUF3Df8rnG4xZazTzjcFcciigYxqY23tXxI@vger.kernel.org
X-Gm-Message-State: AOJu0YwnK2BiKZMNi1ts7ketBgpMOUe/Obg6UnBshmO6NYV3LWw7J0Le
	Em94Bwoh/R5SWC25i6gj4Bxuy33LhmW81OM2C7OdgaJ9BxKmiJ60
X-Gm-Gg: ASbGncsMFSCqu4A0KUBA9jN28+au46bYk5WbOob59T7Jsd146/l2XIUPSA431nyNG+f
	ytcuvAVnNlRo7juvZansRI3bhyZCBFW207u6w2FaAQyvNpBJ5yzMu3b8Ov1IokTllDSty/eKr36
	2PSACxGAe5Q8FljfdEt3/9/F/5deazBnWzo+9iCTXabO/Co23ensQvTpaZbGhs+fr+Q1sjF2exZ
	sCnKMmKgDl5VydHV3efpmojq+BS/yiQaAFCLtWa9DddqzG8pSLBZxZqoEOD0PMQ8LnFT7ny+WZs
	Yroq+4HO
X-Google-Smtp-Source: AGHT+IHK4flbJSWoODx+lb2nOyg3BAg3wd0lkm8mIIZbHsaGJPnf47SBc8jjq5p695qCVZJilK8mtQ==
X-Received: by 2002:a05:690c:700a:b0:6e5:bf26:574 with SMTP id 00721157ae682-6eee0a49959mr141292297b3.27.1732572360447;
        Mon, 25 Nov 2024 14:06:00 -0800 (PST)
Received: from localhost (fwdproxy-nha-013.fbsv.net. [2a03:2880:25ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe15295sm19992027b3.18.2024.11.25.14.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:00 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 03/12] fuse: refactor fuse_fill_write_pages()
Date: Mon, 25 Nov 2024 14:05:28 -0800
Message-ID: <20241125220537.3663725-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the logic in fuse_fill_write_pages() for copying out write
data. This will make the future change for supporting large folios for
writes easier. No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f8719d8c56ca..a89fdc55a40b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1138,21 +1138,21 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
-	unsigned int nr_pages = 0;
 	size_t count = 0;
+	unsigned int num;
 	int err;
 
+	num = min(iov_iter_count(ii), fc->max_write);
+	num = min(num, max_pages << PAGE_SHIFT);
+
 	ap->args.in_pages = true;
 	ap->descs[0].offset = offset;
 
-	do {
+	while (num) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
-				     iov_iter_count(ii));
-
-		bytes = min_t(size_t, bytes, fc->max_write - count);
+		unsigned int bytes = min(PAGE_SIZE - offset, num);
 
  again:
 		err = -EFAULT;
@@ -1182,10 +1182,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		ap->folios[ap->num_folios] = folio;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
-		nr_pages++;
 
 		count += tmp;
 		pos += tmp;
+		num -= tmp;
 		offset += tmp;
 		if (offset == PAGE_SIZE)
 			offset = 0;
@@ -1202,8 +1202,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		}
 		if (!fc->big_writes)
 			break;
-	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 nr_pages < max_pages && offset == 0);
+		if (offset != 0)
+			break;
+	}
 
 	return count > 0 ? count : err;
 }
-- 
2.43.5


