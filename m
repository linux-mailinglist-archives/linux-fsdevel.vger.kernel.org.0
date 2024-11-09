Return-Path: <linux-fsdevel+bounces-34116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AFB9C28B0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06867282AA7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4C4C9A;
	Sat,  9 Nov 2024 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7GF1DHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C663186A
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111230; cv=none; b=LQTMC3GWqoyh2VDiGRTU1bHMqS/ochjnOIM8YJpK7gWfAsauflG8dUtjKsm7FiBzNzpTzJzQdgZD88v5FmAZzsmixgA29TnHeA0qjQr7FmHw9Vg0fDKxX4BZkMlr5KDcYVv4OX+TTAbp8/Ij/vLwhDQLa6WU7zXYXgCBz0v6Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111230; c=relaxed/simple;
	bh=MdtYQnw2x6WOAlHKd1Uoc0M7fSxeSvJEU1eppAviayU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qqu5eycD7AcTev39FNzBTZ//dVI/MXccS/XfsrKqelO6aMNk7LT1t27GO7U9fDQ+CEtc+Ve6w2NQGIu6Lp/k39C9u4OcIKMrPf5dukS2X9eqEUFVDVKa89C6KBF2MGZV3hxF2iLBnvNicl5WLoJWUf41Cor0nuUDntu4/yciMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7GF1DHv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so2551745276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111228; x=1731716028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d17+Sv+ICg1qvVxhya12sVWPP7l6cyUpYgcAhzsE2FE=;
        b=P7GF1DHvRqILqzNtEYzKqToSNiGdyxRPbndHT9pj8LENgiUm0vEWUZ7h/Hwr4RAa3O
         i3pkeFTDN/ruYWIetWJGARBg9nm+eRrmLwfztiOVakYPvISfC8TwMe9HSs9sk80JODlc
         G+0APSTZbaT4GER34K0V2pm36IEIWE/4ABalHTc87cQ6UrVD7qb4XPE3ybG5NwLN3I6R
         ebFtLfBFqO/BUK4o8Zo54QTznO7tdnj3NaVwvXReLSOyAaOuq5ZUYCdyet14pFAQ8zM1
         bW3dbgTjd3OsMWsSXqzqI0Q/nyU6cQiXhC+MhRPWh4kP9t/fFyvHbEHZ6SFEK6Vrj6Gc
         qphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111228; x=1731716028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d17+Sv+ICg1qvVxhya12sVWPP7l6cyUpYgcAhzsE2FE=;
        b=MtmOJUa9RQmu2gIUsExEPD4B8wP+/fHwt2ehuW1YP0PUzj880FZhEYbceLqsRXlJyz
         DF741yJryEJNAxddi+Ta7zysuDXkk9Naj5VXFBR1jq/nC8mYems35VEr4pHzZlcMZ2Ly
         x4jAa/cS0XviMgGkFR6P7wOf7VISe8IvKUFxvQhnMzlK8cdqm1auBq0PTezkTd5AtRsF
         knVFe5CCs6Jke4Je1U1byw9T/yw41iPYe8zrIdHK33bj1IrisOsxWPubjJxs/0y9ptxa
         Kebh80XPJqwdY0IlW05ZAFsTFZVHjrDIfd6z3Vbv+VNliBaOrEMPMJgXyTXbxmn4Xscq
         929w==
X-Forwarded-Encrypted: i=1; AJvYcCWLvdWzYG6Pao8FqrvKMO3Th4NiyhMx8EPybqG6vDMTv1EwhxWbQ6u9IyL+91IWhVjGEfm7XndfoiCF0Qig@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgksBdjoA+N6q33dOYcQhsKyUQOMWri78jSWFyCWMzartIqX5
	R8wNjqyl6Es3oj4YGugg+NOIREQ7Oh2yX0pUuPxGWlo7clCfIf+A
X-Google-Smtp-Source: AGHT+IG3dAe2XrjOSrNMuX9PTyAdOh0g38/WCYEn7pSzKAYEjmVnHniZZicUnr8wJWKIK2ry/OSMxg==
X-Received: by 2002:a05:6902:18c2:b0:e28:30e3:eb97 with SMTP id 3f1490d57ef6-e337f81eef2mr5133186276.8.1731111227617;
        Fri, 08 Nov 2024 16:13:47 -0800 (PST)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1f9fb8sm897660276.57.2024.11.08.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:47 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 06/12] fuse: support large folios for symlinks
Date: Fri,  8 Nov 2024 16:12:52 -0800
Message-ID: <20241109001258.2216604-7-joannelkoong@gmail.com>
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

Support large folios for symlinks and change the name from
fuse_getlink_page() to fuse_getlink_folio().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b8a4608e31af..37c1e194909b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1585,10 +1585,10 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	return err;
 }
 
-static int fuse_readlink_page(struct inode *inode, struct folio *folio)
+static int fuse_readlink_folio(struct inode *inode, struct folio *folio)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE - 1 };
+	struct fuse_folio_desc desc = { .length = folio_size(folio) - 1 };
 	struct fuse_args_pages ap = {
 		.num_folios = 1,
 		.folios = &folio,
@@ -1643,7 +1643,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (!folio)
 		goto out_err;
 
-	err = fuse_readlink_page(inode, folio);
+	err = fuse_readlink_folio(inode, folio);
 	if (err) {
 		folio_put(folio);
 		goto out_err;
@@ -2231,7 +2231,7 @@ void fuse_init_dir(struct inode *inode)
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(folio->mapping->host, folio);
+	int err = fuse_readlink_folio(folio->mapping->host, folio);
 
 	if (!err)
 		folio_mark_uptodate(folio);
-- 
2.43.5


