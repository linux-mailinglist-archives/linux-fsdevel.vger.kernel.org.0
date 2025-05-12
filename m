Return-Path: <linux-fsdevel+bounces-48780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A08AB47BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AAF19E0812
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 23:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215529A9E1;
	Mon, 12 May 2025 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv9MEjc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C82609EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090776; cv=none; b=AVD5h0FJJyqK+sMPWtt7OYPIcxYKkHOiUGsREh5BY2K8C6tOUUaqyfXvv8Notxn19iuBr2TJTnuQ3R3I3wsC/k43mXMmUPw/zD/TyhXGiszDayCsE5eEjZJFoZrt7EB8ZnZGpKzu2pYE7DxEpVZaJRxljdXBq2nQlnbgh1UQk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090776; c=relaxed/simple;
	bh=iepCbHZ70L1YlcMuWj5176oOUbWnF98e5LOGTT2Qp0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgGnUAAfMsEt2tdzjik+K4G8mrSuhKqxMoLt4JnkHOynP7qqTsJDYNjTrYFSNG6IrJ/oECb9hOaUWkBUf7WM/a50exK5zNOTh+1zVD13MeHNH3N1c3H49hBkgLXyB6gSN7D9e8ikPX7mciJ17fguNtgSF0lIgk84SVy9fFSjHR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv9MEjc5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22fa47d6578so50579365ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090774; x=1747695574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH8Q1g7AKZp8l1mB+A2tI/BmJ6miEi3VZrX3LhB+46Q=;
        b=Xv9MEjc5s9lmZCWcpBrSywtXQUzppck0yS5+AG/2+VqKvHTPBQzlKc0vp0rXGeUx0M
         hV/NuV5OiwZYzupICHLFWBXGBWgr7a5paaxDEZ5ZiiIk2Tj6U0tzUEdPsifgrV9SGh+A
         lpASo9CN0pw9Rha0zOWO6O83+eDwq0uOLqpMOWTne81cdTZUjawNs5a76O+IOT+JCW/F
         /xtIyfMoSXOFUNfV0eBrZ7faixxDWRXKegcU6TWRgy3Izf7JbN+Tawjp+20qyVO+0/QV
         ID5qEcgcIQrhx73khGccrMW98n5EcuHmLi9X/+RZ123LTbDGFXLr+Bm4ZKeH4tjTU2E4
         cDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090774; x=1747695574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH8Q1g7AKZp8l1mB+A2tI/BmJ6miEi3VZrX3LhB+46Q=;
        b=aoj56o1cA8rHqbzIcwQsWWcehJ0pCKSiQVp757g0/eFShy0UgyZLrbKMRQcyJw1qwI
         v0cwMwvXI4gb4LDndJbeFYJKDnomLSU9uoZrWqZ653AfthUJm4CPLfOQL9NRALJTYruz
         N6Yt7wrJhJWoexmuvXf4jfRRkpv7xamqWymH80qZCM4Pu4JtdgWiZ8R7u6htco4G2YcF
         1Pz6kpK7tu4wIOhO5h4D5+e9HAU7QJatCewqzsNrbEz4O6M2mXsmIv/+kUiUr5t2pD6t
         ro3vIRFL86AunBAVCUol3ncFQJlXQ6dJUvJ6B8gQHkXecVqImUD4wZB90Nje99fMDIwZ
         YSBw==
X-Gm-Message-State: AOJu0YyU5pcUnOMNeLBB/rq0d3NYI3j231an5cKmO/ZfmoOskTquv9ux
	mLB+so0vmfuVZQQ/ZUCKLqurMyOAsjYOvp0rIUjwZx2cXQzBkR5/
X-Gm-Gg: ASbGnct+umHuJRx3O1jIZ/wjd5TI8gH19A59bCX0OctFRVU3JHIkNllXKNFL45VedXW
	0NH+2SaK5UXBpzGpSW9IUhy2Yre9WJiTJn+c04ibqGyLklK404e/6/vDALTg6fshQU4EmXz1tUd
	OySDnL/mYCyxmwYiYEYRJ7cFn6aqGtyxgz/U3e2Joa4m/NAV5wPj8chmjel9RuIhxCkHGC4aCd+
	7kG1gk5Xlr7mR2Dng4wolrnK0bh2ePt3Ql8WrrciFRqPiUqg2lHsJz227C9v89ZZn2smgziU0Pj
	wUoyYsraZ0uBLiPUeMAWoy/eIwdDP8s1xa2poyJ0Z7IQFQ==
X-Google-Smtp-Source: AGHT+IHaZo03QZs5Y5XJBsSV1roGdnG1CSU0CcpaILLC7igZtfSRDdGO1Q+YIcrwdAEjvAf3Vnc94g==
X-Received: by 2002:a17:902:d581:b0:224:910:23f6 with SMTP id d9443c01a7336-22fc91a8676mr203822465ad.45.1747090774677;
        Mon, 12 May 2025 15:59:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829d425sm68464335ad.202.2025.05.12.15.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:34 -0700 (PDT)
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
Subject: [PATCH v6 05/11] fuse: support large folios for folio reads
Date: Mon, 12 May 2025 15:58:34 -0700
Message-ID: <20250512225840.826249-6-joannelkoong@gmail.com>
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

Add support for folios larger than one page size for folio reads into
the page cache.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2d9bc484e87a..8efdca3ce566 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -793,7 +793,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	loff_t pos = folio_pos(folio);
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = folio_size(folio) };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-- 
2.47.1


