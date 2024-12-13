Return-Path: <linux-fsdevel+bounces-37385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00E9F190D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508C51606E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F511EF0AA;
	Fri, 13 Dec 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb+HXd4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615A1EF092
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128595; cv=none; b=Kafy6pKNOQu8+kuMmoM3OiPI3JF/0pqo/7l1lSqXZRd+1J3HGxPweD8/3ZEHTUa4ZMOSoFKtH6cSrRElebJ2r23hI5dqXsvo5l2NzJ6RMUbCJwIxdrVZZtNjY15K58qRzgFyrFik4gN6AwzFcJTi+stwYjlBUVh654i/Kk434uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128595; c=relaxed/simple;
	bh=STJ+jTB0ysjQG5eWsG6JorBQSFlBaZXHczWK0kQl2yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJPSBX49l4yqZAWlu4PzA3k/Zd4JchL+e47ksdF8uhUYtFF+E91WZkVb98Uca7f2jiGOn5cDijQwVSZlneA/EFVd0N0SdsCh1sOgUWhMU2YigfRaHJI3dt+KIoji2czrJO7hJ9UJiz3QKr7vCVJ/cr+9owoS+1XUyYJBiSM1j9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb+HXd4h; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6eeca49d8baso20324187b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128593; x=1734733393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAx0HnRh9J+SpBKh01owxiPClsQFKRjtGFqFV4FHKJk=;
        b=nb+HXd4h+MbRib3FHyfrY+7JBNDuvHsUDmVdFzGJiy6r6+4QRKaxDmC5yP5Y1PXUVM
         IxYHye1eBgVyHb+Xm71CcEYqnrAn8x33SxSxvqvxdMmwQ5xg8k291SdpbfVvycr6VKry
         PsMTFd8s0zAQZc7pPI4dZixbDk9PqmuqEXSso7L2smnMUUvwtrscOyez1YPJtyBW2X2H
         OQlAdYvGJeHeekFFGhU4BamcAD5ef1sxfXFRFYKTOxYrAE5XIw9O1EoKczo3Bi3iouoT
         eDAuMvCcsyRnDfQv8AGca2hscgPtODVmVn2oxnpFU7jsyDJYi1L0f3kdRA+KqPQAVG+8
         QVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128593; x=1734733393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAx0HnRh9J+SpBKh01owxiPClsQFKRjtGFqFV4FHKJk=;
        b=hn/Kr4Zyrxn9GDULNrOxgUNpHWu+kxfgOmoR5DhW8lX6Bz/tkjEL1FBLbPEJbrySdH
         SHtzFeJNaiJfMcRK9GB1OWOTlWjpejAljJ9oC9vBvCjo05ghF7ZwiV5dAocCdctucmGh
         EmXT68UWmutRsDDlBQuLTwOuMgj7tsKhh+fCcPFcfWExGVkaAF+QPGh6qlnFBAewvi6d
         32XGb3wmH02OZfevs5VYULNK2FjL1d0qLMpJUNz1VTBsiaj0lidj5duDe9243ba33Tl0
         ZFnL15HEAOgtxaFjyXBTFHQMjpiffFt3Sk4SBOP+xBAZIsIBgV5PnUGdajkIh0Sk6Vjq
         /IPA==
X-Forwarded-Encrypted: i=1; AJvYcCUq60msN19CEEEKa1Ctbu7p8bPbYyo1TRtyLiVn7+h8WensH+0JK5KUTsOYgepwMnOt4Tbw2ND2mRBVZ+v9@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTQsHCtW2RfMfoBpsigcp5abvwo/fx+LRRHrTWlzfUCLL/9vj
	/eAm/JWAskuDC0weR9gHy4RMjzE0BAuz7pUbPK3rtGp7LcIzXayW
X-Gm-Gg: ASbGncuY0ycTAAKG9FgItSUJj3bgY/n/WhwZQV3fem3rvgL/8m7lgCI19F5FV+9X8v0
	dqVPaZ5PKhm0lq2iLFHOlGQ1P7anVMxa8vmBcLP0l/N/fLxZplbjU4dThqJdQ09jzFNEOopFR07
	SksXj6vx9qWRdnNfp+/0lCRwVbl5SWpGPSoue8yBvNCQxiWAERzc3OQ9TY9SX9a8PATcm++YiUz
	T83n9WdpxF0Y2ds3AWLn4ukIS1rQ+3az5N2nMn25xhT+RvWnaFSS9fB451+iX2+qO37Dn2t6rnl
	GUohA0A4DLJ70mnk
X-Google-Smtp-Source: AGHT+IHQEx2qyFTjXb5/qkENVZL+0YFeUpWJnAdCGZxi2Tes7+f8jEmQRiz6/f9CjGfdqoCKdhyzTA==
X-Received: by 2002:a05:690c:448c:b0:6ee:5104:f43a with SMTP id 00721157ae682-6f275efcd73mr63298397b3.20.1734128593233;
        Fri, 13 Dec 2024 14:23:13 -0800 (PST)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288fc5111sm1238667b3.4.2024.12.13.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:13 -0800 (PST)
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
Subject: [PATCH v3 06/12] fuse: support large folios for symlinks
Date: Fri, 13 Dec 2024 14:18:12 -0800
Message-ID: <20241213221818.322371-7-joannelkoong@gmail.com>
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

Support large folios for symlinks and change the name from
fuse_getlink_page() to fuse_getlink_folio().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 494ac372ace0..65f31bd3a8bb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1586,10 +1586,10 @@ static int fuse_permission(struct mnt_idmap *idmap,
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
@@ -1644,7 +1644,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (!folio)
 		goto out_err;
 
-	err = fuse_readlink_page(inode, folio);
+	err = fuse_readlink_folio(inode, folio);
 	if (err) {
 		folio_put(folio);
 		goto out_err;
@@ -2232,7 +2232,7 @@ void fuse_init_dir(struct inode *inode)
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(folio->mapping->host, folio);
+	int err = fuse_readlink_folio(folio->mapping->host, folio);
 
 	if (!err)
 		folio_mark_uptodate(folio);
-- 
2.43.5


