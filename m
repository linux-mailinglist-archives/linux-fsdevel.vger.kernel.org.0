Return-Path: <linux-fsdevel+bounces-48777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F4AB47BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00FC467318
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 22:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC529A9C9;
	Mon, 12 May 2025 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaTJQiBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4D18024
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090772; cv=none; b=ZneWDfGLaTXFoT+0sTenieW3jOIW4mjDUS8Y96EC2uBJdqzuLyZgZ3H1JhzX7ieh8fGFEH/R7ZXNCBsEYM4W/mo8z7j9diJc2LF7mpGDbRKIIg+ioMxRkJ3/sxJbrGqooHi8HSeCguSpV99JjUfIasKt+75xbiPzSOvQ3OW5H5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090772; c=relaxed/simple;
	bh=KvYdDk+fQk9Qb04T2okjyg5m6YADy37Qm7+5X3BNaqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qo33YYzd7Q61pPuPGD/izp4EcBA65XKBh4IdD/5pco/qPEasF2EXvZVrrhvqbRVg4KD7+IcclMqFJJUJ2wiHQdN9d8I4MRT+kr/LOKbAF+NDG7bqF9Ywmh240tm5WfioEKZoc4TIKyXB4LMy+93xzD5A4oEo8ux575rjc6kyY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaTJQiBe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e76850b80so35682925ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090770; x=1747695570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhDQefeC8rf5GUBa137DjaOzCHDePo1nVnSHqN44v8s=;
        b=WaTJQiBeW52cEyCeoPGA+uL52nxIhMyy2p1bgoVOsmkL2BJGDF8DF8/u0aB2tsV4HP
         8bpncR5l+pdxFV7vMGPxaYw/eiTOGmbUfAlmjFsVnR9RtsV4S+9FxSWs3M5C1PwKAJNy
         Z7yM+Ktb/Of9Zk0TUU9VU2wCAGv+WFSMWMfoo54KxrfCWr2yy1lhC6JAf5o+rMtLDi9O
         ++qkduTKwE5EntL8ko60E1B5dJ5NtmI+ePGNjubcN1Oy9MdTgrZB1v3yCSbCZo7OX+j+
         8YrhsCBU15sMO2mvtRbnMW+D+/1ksG9RymwYe62d6HmWT84PFIb2yuAucK/NCkzlYs99
         tczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090770; x=1747695570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhDQefeC8rf5GUBa137DjaOzCHDePo1nVnSHqN44v8s=;
        b=hXbjbP5ZY1RsfhURSpmCRNk/i6nhLekhv+3yIHAexFG2Iqp30v/gEnnZUBqXi6W81b
         WCgST+MwBfAKYPvjeySjCJcjeclMYslgWNf86u0vabEi8zOdzOEO/e10ZZ0NJlz9jhik
         xvZRfnoQ6jjySbGi85hlky10t6G0XllBVtr3Qw/XQtUdqY/PGVf0EDILsZ9YBlaDfdzw
         2end9jfG0hjKXrmCAHqqTwUCX4DciOo8v6KinwC/1YbY//DQv6UsYHMwjaw8A6BhFuu/
         aPZ+rFVcSH0f1YcIJEiAoYwCLqHxU/dokLxhQBua6V3jLfKZpDi8wXYFXx6KZitckia9
         4Ffg==
X-Gm-Message-State: AOJu0YwY+V7lPMXLZZv1XyGor0IQR5UYRsCr2l6XBjiWpipbfohxpZgu
	mWkQeIvgsS+EbcM/93lFXxeLOCnXoh7lJDwVzl/pkfHlNb0gCay0
X-Gm-Gg: ASbGncuqxawgPwrT0GIrnJo7msP2JtfyIluTIvv2Kn7l+ZuhjNWQ191dVqBtSDHShXb
	bmluEqOKMaiRdMZr+zWvOXVhdfl2FDYjZXrzY+5RpHJjpwcg+Hpg4Poo/rtBqPry2ujCfSgkxrR
	Lad66X8WCVy5ioJ5xRp3SH+u0aofrAIBNZnq2+35dCfyr9OE3fJ5991MnUyiBbjD9cXPlTxROLo
	20RgFh9xS6+RJFMeIUC1N7gYEGhZAh5hPoyYOrBj3cYiOAGjIKTNLUD3iAVo6PrstfazeNhaf0c
	rUmT2lTD27Q3sfxb+O914ysWQJDGQBwV9AlLqkf6UXUvUmQ=
X-Google-Smtp-Source: AGHT+IGb/NAFUkhDPN/dUg6PAbBJ8Tjj7hvPLAlk8FOG7qRmcN2aKuuFrYB2VwTZORN2fSYGcj2e9g==
X-Received: by 2002:a17:903:32d2:b0:224:10a2:cad9 with SMTP id d9443c01a7336-22fc91a201dmr243978395ad.41.1747090769642;
        Mon, 12 May 2025 15:59:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b183sm68296595ad.162.2025.05.12.15.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v6 02/11] fuse: support large folios for retrieves
Date: Mon, 12 May 2025 15:58:31 -0700
Message-ID: <20250512225840.826249-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for retrieves.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7b0e3a394480..fb81c0a1c6cd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1837,7 +1837,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages, cur_pages = 0;
+	unsigned int num_pages;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1855,6 +1855,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	num_pages = min(num_pages, fc->max_pages);
+	num = min(num, num_pages << PAGE_SHIFT);
 
 	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->descs[0]));
 
@@ -1875,25 +1876,29 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num && cur_pages < num_pages) {
+	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_get_folio(mapping, index);
 		if (IS_ERR(folio))
 			break;
 
-		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min(folio_size(folio) - folio_offset, num);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
 		ap->folios[ap->num_folios] = folio;
-		ap->descs[ap->num_folios].offset = offset;
-		ap->descs[ap->num_folios].length = this_num;
+		ap->descs[ap->num_folios].offset = folio_offset;
+		ap->descs[ap->num_folios].length = nr_bytes;
 		ap->num_folios++;
-		cur_pages++;
 
 		offset = 0;
-		num -= this_num;
-		total_len += this_num;
-		index++;
+		num -= nr_bytes;
+		total_len += nr_bytes;
+		index += nr_pages;
 	}
 	ra->inarg.offset = outarg->offset;
 	ra->inarg.size = total_len;
-- 
2.47.1


