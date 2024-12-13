Return-Path: <linux-fsdevel+bounces-37381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED119F1909
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72254188F330
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C6F1B21B8;
	Fri, 13 Dec 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvH/qQqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956271AF0B8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128591; cv=none; b=QtRjDN45clXPYv/h0ZxiwT/JDI99Z+cQa+dFwQTFIi/nCZHEN3zI41Hvxge7BWXzubw+xtBTPfxaoU8Vc+pM48KTl2+R4iV8V6bl5jN5oVXfDh6J1Xo33UND14MTnstm3fnTjUMZXGSs/+YhyYuJHNrijPJ789yjkjQ4PHpATS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128591; c=relaxed/simple;
	bh=pgoxoMavFBK/kOBZMzPwVd11ogo0sCDvez7C9DM47kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4Q+6J5GzcGdFqIh5xru19S640IOCvBX/t51B8GDfARoKmf1bKmf+ZPDIjQ4Qy7dw5d7cEb+ktEUoBPfAH5BriLFBvTrw4fQDj9qrGsSXx0upv9TJvlTB9PGxalh3l5PrPmyGOnOJhskUdZ+aq/DOZJQdqVzSaBZZSbCpdrwMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvH/qQqh; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so1729301276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128588; x=1734733388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpHWRjVwKAY5R+ea2581JyCF/Io/I+I7TrLjNfwKeP0=;
        b=MvH/qQqhx9cwcoL/pVrlcTZB0MP796dBNj5mpOdVT+kq1dI7qjNl5IuVillP8tb8XS
         F2Z2J3l27m+JN7I8xlgpWvpDWLItODUwlYBknD3SnH4QUwnp1/kGUjTNZ1AX3P1EI9io
         7IdOMJlVC1RBcyaA2P5M6ogmouTVD3hhB0OfIuUm4wG0f27xOTxJQXMmY2GcowcryJEk
         cu9UF2SmX/FqgMj4mMRTe4OKf8eQDBk7LqKzYvM100mQsSOzqKX93GOjpGSaBkCHgWvH
         hpG9oo3DIiUSVuYCLJieZ9jDk0uBRd5E42adHOUVCIRocUTdagXHd169VJd5tRx+8PhK
         hDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128588; x=1734733388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpHWRjVwKAY5R+ea2581JyCF/Io/I+I7TrLjNfwKeP0=;
        b=AR9VjTrexc8Uzoz1EYNll1Wq4zry4znlHKmUXNQRYlnC9F4VKePBHuMdFDBk3kepHp
         df7qGTSSYE4E9aE+Q2Uxj8BQhoqrLsw9iDb0k72qO9VeXpQfKXPbDpZ2ZWU17UnsBZnB
         xjShsxQ1bfpaC8HgpBECz4rwkz8++vi4CpK76MvSxv2zPuaqNE+WlkHO3aBnRIR8tuoi
         bITIVb9HmFIjWU1XTQg+6h+mOJv5F5sqjXGnfPOakIZuxMEwgjw3FHpwDLBwb4AvVQND
         l6XMlBSgMuL7qOcR8o6hKN+/xOi76jX66tJH3YEdQThGKbJpE4cQztN8h3cYVue+8gd5
         bQng==
X-Forwarded-Encrypted: i=1; AJvYcCU6kTw9A7BKeUOadL+HO4rYq7CNSJyb/OgnVipmwXIJVtkEZ4VpZ8rJ0lpIbMGlRRxGTpsIaRQrtbVyq975@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxKZhLaBGU66Es6b1JgCKhvQTYH842IclvuKfmsxey2J/Inii
	gqoh/f8liw4nL5entDUOcQweQzDPIz9upGWNaUQqFl18gCo5tWKyHZY7+g==
X-Gm-Gg: ASbGncuw4n96+e6Hjvzkv+lGR7QIkqxie0cgLwT8aJr+3OyI6PMrW8P0uFX02QQrOu+
	ygURXRQksDE9IquCsjvaTgfIwQPRkrp4wu9wTzFVlMrigGsRZT8u9CsMbs0M2YBGNioi4MA7311
	zN3Htb0udRov7KUR9vI6yMgC+hmgMVcQ4yyI2pnAWIOvYmrE8QwwABvtFIlLQYhD4Z3LUAsznXk
	vthkRKnkc6KqOtrI2bpTYpUZ1aWFlm1gfuZwgMfoeXLMhhFSEL7j0BnP7aetDOLwtpfXrLmOAh9
	QbN/x5zK1a7j6RI=
X-Google-Smtp-Source: AGHT+IEX5G38sTEzu+EAaGdhwfNJRtL2wFyz6daf9Tn74EUuu6dws5muE0TjqHwc5615qYuRVfBXFw==
X-Received: by 2002:a05:6902:72c:b0:e2b:da6e:7100 with SMTP id 3f1490d57ef6-e434bf3dbf3mr3856102276.31.1734128588555;
        Fri, 13 Dec 2024 14:23:08 -0800 (PST)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e470d4f6ddbsm105585276.44.2024.12.13.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:08 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 02/12] fuse: support large folios for retrieves
Date: Fri, 13 Dec 2024 14:18:08 -0800
Message-ID: <20241213221818.322371-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
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
---
 fs/fuse/dev.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0a3dfb66c7cd..2a2a5e66412f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1716,7 +1716,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages, cur_pages = 0;
+	unsigned int num_pages;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1734,6 +1734,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	num_pages = min(num_pages, fc->max_pages);
+	num = min(num, num_pages << PAGE_SHIFT);
 
 	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->descs[0]));
 
@@ -1754,25 +1755,29 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
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
2.43.5


