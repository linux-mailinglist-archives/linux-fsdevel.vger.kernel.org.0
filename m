Return-Path: <linux-fsdevel+bounces-32802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4979AEDC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5291C23C4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC611FC7F1;
	Thu, 24 Oct 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeFj0SKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A71F76B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790493; cv=none; b=pqQy+TO6I+HkdLt8TQNGkCTOU7lNOcYPohGgKP19GiZyZdSy1X7yAm0xSUENNL9Kdzvjf3Xzu5C7HRu0vKVLEmTltsheGyFzRcJdGqx6+h1c2AGi1QhdUnFuoyyF28Yq9dRuB6eftP4mp69bkYWdYkHXjx6fK/O0xgITqKmSJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790493; c=relaxed/simple;
	bh=mXnBpqKiRVmhwxcDZZR85Sp7SEzxNvCFukeXW0p4gvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3kdVXrXnbc44E5skMblEj+Tzzt/3CZbPTYjX0LxWVuP48IaGne2E89m3IUG9ZZwBfUHKGtr4DuiXAT0EKZwhFa5txfVLEbWoVoeABk0F4qWnb/YNrZ2KFk8eBPA/4/qXNMWE1mFvZGqEQF4pc0IKn8XDarbdCjchR4zE6l4Bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeFj0SKx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e290554afb4so1411534276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790490; x=1730395290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc/+LRnlXGharux7jo9tP8eHIQUBzqZeR7LIDCREooQ=;
        b=IeFj0SKxWZKBl1GNwfi+2qhrc6o301sfXmVbtb/aorMiPI+nvY6PlHaEokC92e8xxr
         Lg0aHk7SVf3kVxXLE0Jomg1gTI0laZdwk/wZviYN5oY7ULHrn5SxMSwoMuMlk/DsN9/w
         KuJBY9Y4StTteB7+CcmCN2Q/lG14RMQJygIDE4DktVQVs5idI/ZLkZWeSdvZzx12nl8T
         BzRQM+ysl3fFn+iyAZsUSI0SarSR+oFeyYLk3OJHkwFomWJKKmnSrfHrnC5VHSCnD37w
         dOCYUrKAyR1k/cs3gAIy0Q2jgKkaUmmepgxHfiN8B+CYWu1hqvRxoOY7p0dAYKjbqmYc
         IAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790490; x=1730395290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc/+LRnlXGharux7jo9tP8eHIQUBzqZeR7LIDCREooQ=;
        b=ckObVFT+5HJJc7wFm1HGCmcXzqCVbKkHkTgilpSnVVejsDu4GSNZmU2h6K7SjJrB6O
         qSlmvbDTR9zUnwfBmXBIq1F3tg2y5CMCoGKlyz9GbRPueTOaTpMpj8u1e7S4F5LheM2Z
         CJcl4pNaf4wxe9rcs+YFzrllgZQnh7/vryxl29hkmFSalqFHUUIldRhypROT30GKOwkI
         dX1094HA3qNUXt7MSRVlm0KLkq++qxZ2VtUM6PqUePMcB3kvp5qiKeqKJcpwIIb6dycg
         Gryy4xgsXty5wf678T+REJQKXOB1VdlbEho/EOpYbbKUdHDeDfT3xirP5lio8z6Ow2uS
         GPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkbMlHkOlQjkkfuciASdigoijtoNIGsC27XpPpZ9GDiOB6efQCh10bERdw7SnYI1uCYzsqa4qKc4R9gJOO@vger.kernel.org
X-Gm-Message-State: AOJu0YxTP2JQsJqWy+KJhDyTeYKElu1WHI6/crlxmwcL1Db/FLWk6TOJ
	umqOjHmq6pYhgiR7DZoGeb70STsVa4cWp3PK1yZgg6hBH0mpff+h
X-Google-Smtp-Source: AGHT+IHrXmKF1FngBUoWBpHkT8ITWUJX4KUGji1xNOriD+fqIIkT21H6y8H16ted96zYAbHPaYXgOg==
X-Received: by 2002:a05:6902:1692:b0:e29:33d1:a3b7 with SMTP id 3f1490d57ef6-e2e3a626666mr7472930276.1.1729790490472;
        Thu, 24 Oct 2024 10:21:30 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2e2e67c6dfsm1055626276.50.2024.10.24.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:30 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 05/13] fuse: convert readdir to use folios
Date: Thu, 24 Oct 2024 10:18:01 -0700
Message-ID: <20241024171809.3142801-6-joannelkoong@gmail.com>
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

Convert readdir requests to use a folio instead of a page.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/readdir.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 0377b6dc24c8..fd0eff1b9f2d 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -331,24 +331,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 {
 	int plus;
 	ssize_t res;
-	struct page *page;
+	struct folio *folio;
 	struct inode *inode = file_inode(file);
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_io_args ia = {};
 	struct fuse_args_pages *ap = &ia.ap;
-	struct fuse_page_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
 	u64 attr_version = 0;
 	bool locked;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
+	folio = folio_alloc(GFP_KERNEL, 0);
+	if (!folio)
 		return -ENOMEM;
 
 	plus = fuse_use_readdirplus(inode, ctx);
 	ap->args.out_pages = true;
-	ap->num_pages = 1;
-	ap->pages = &page;
-	ap->descs = &desc;
+	ap->uses_folios = true;
+	ap->num_folios = 1;
+	ap->folios = &folio;
+	ap->folio_descs = &desc;
 	if (plus) {
 		attr_version = fuse_get_attr_version(fm->fc);
 		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
@@ -367,15 +368,15 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 			if (ff->open_flags & FOPEN_CACHE_DIR)
 				fuse_readdir_cache_end(file, ctx->pos);
 		} else if (plus) {
-			res = parse_dirplusfile(page_address(page), res,
+			res = parse_dirplusfile(folio_address(folio), res,
 						file, ctx, attr_version);
 		} else {
-			res = parse_dirfile(page_address(page), res, file,
+			res = parse_dirfile(folio_address(folio), res, file,
 					    ctx);
 		}
 	}
 
-	__free_page(page);
+	folio_put(folio);
 	fuse_invalidate_atime(inode);
 	return res;
 }
-- 
2.43.5


