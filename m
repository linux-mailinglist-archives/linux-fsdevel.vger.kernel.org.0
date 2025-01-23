Return-Path: <linux-fsdevel+bounces-39895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE1A19C37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FB27A52C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF693595B;
	Thu, 23 Jan 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBhF+CS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60821BC4E
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595695; cv=none; b=fykWceCdjdhKRnzIczk98KzVWzmQlZb+AUnoHujwZQ4YEURRUwXze+uo/mKHV+61A3PHEq4lcoUOGz0S7bD8af0QPf6gQxn0QLH9JMg6SG0uaZPbtqizGAxaUrmXxRgJhuYGiWvSsc8W3YXcMa2o9k826eAkHN+ORnJg0EaerUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595695; c=relaxed/simple;
	bh=xNOjj4765HHox3xnS4REXKWK8gtCszZrIIZV+3Fbo9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjwk0i78UKP+OrDmRY1WGp1UZbv6IIzoSWEvPVhlNnabs3Wt5yy//n+20rQGQQm0Efk2+avxWM0lkYf/BGlMk2X4/iau3QaINDoLc6VfwwWIVnJGE6jRhORiwU/C2oLnsBKrDorxVSvq6slx3oZpde+l/HP+HPclmy1hiv9+yjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBhF+CS0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e549a71dd3dso723347276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595693; x=1738200493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHdvyTGLwlhQnHBF0Des0rmeoCfjlOs4jlwdSIFkjCQ=;
        b=JBhF+CS0QlYIY7EIsBJGOfchFMWxopETiD2qNiBu4F8660vckAOCPB/ok3g/8BB6NS
         9bmDHSwhjddLEEMp/r2HOChRtQr+GCgBLbNMDH4nQ7Rza4tapGmCKSWjGptKxY+W1knV
         POZ6gZ+Yi3j9P9ggS7K1NlwPaOcEbOhbgaMlIS1+AZGfSUzb5Y1A07IGzJkvPG6Uk63P
         rtgUuXAbKUjHOMkiXLuO0Rc81TQ9wFb1FpB9fcdSd/bc2TFLc8nUz4PazOoFzdNvV1Wk
         2rRLhxQVaSIRVDiNtz4P1BLsayA2SvBbI8H8U3d1t/q7B2fARAQy03RqnjnWnLrRrcYP
         Tutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595693; x=1738200493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHdvyTGLwlhQnHBF0Des0rmeoCfjlOs4jlwdSIFkjCQ=;
        b=Ef/zVKDFM2Jq3vCgQf1hIn/M3px5DZqHNLKg5UGU8vfvEQKokm8obpTZQ9A5oVDWlv
         3Jh6k5CA5XYyA5pM+vdKoywtN/rXst1wrfxmP8DDmtbUoBT1x9+smuP4kqUvie6y8lBq
         8GrStUscJaDPC14LYQAjr62k673AU/ZR9tTsmkoXyzwPhTvONDcfGl4BPxftv2YBx/Dl
         rkdYJhmV4BSiWQnK7H6SA5W3WGL7rRxjfRdk3BnhMko+h+1ObsIkVeid0+Vys/HZRUPZ
         Fm/Niu7djLR5D/Ky+Xz5YszakI7GvYv1X+LfaaRceP1WjzVy+vIDl7NvqMKbYNEyPvor
         KUwA==
X-Forwarded-Encrypted: i=1; AJvYcCVfxb4XiF7PIWQg5ogbhf4jZ3hOCgct0aUDQas6bfKb3aRsIHOaQxAW8sm5d4he1i3s2mHxsrekIJhwlrg/@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAo4eK+2VH5c3C0Avf+Fgpzb5UuMA2sHuh6budRgvDj+RWzH4
	Lkw8iVQ2zSobVe2kKhL1Lp47su1QgVpczm1HTECVZndJbxTM5Rao
X-Gm-Gg: ASbGncswq3zoAd3Zwpy8qrQSsSa+Zwy+Vd3vntO58J5FIj3Lp4s0Nj63tra9DQNLe0Y
	WzhgZ0hus40ILdYDtIKtCwBVKk4UiK7RSIsU1ArvnX0Kzl/osGroFs6IDQXWtoP4YuBKTyoS+zk
	hv8U5GcG3L8zShxgY9fOj6O5hnhXu+qxj0WUP4wnYeWrUgFNHKuWNav9XmK7XvbOVzYq7RHfqYR
	TKfpQSz35ix1Ni5JsmmRNJoUc4w3xa9lV4gZ4w5JeGlomZVhP80KUYJzjYtBl+2HFhPVKcZ9tSS
	WEs=
X-Google-Smtp-Source: AGHT+IFyGC4LRvi1ZylMO4Uj8OREnnNOKqlfgLai19ncOKKXgP98N1O0jbbHdoCdAwsJF3vU//P3rQ==
X-Received: by 2002:a05:6902:2b0e:b0:e47:f4e3:8802 with SMTP id 3f1490d57ef6-e57b1051e1bmr16936037276.12.1737595692697;
        Wed, 22 Jan 2025 17:28:12 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e581633244asm402299276.29.2025.01.22.17.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:12 -0800 (PST)
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
Subject: [PATCH v4 06/10] fuse: support large folios for symlinks
Date: Wed, 22 Jan 2025 17:24:44 -0800
Message-ID: <20250123012448.2479372-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2ecdb8f14d46..95b516c664a3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1590,10 +1590,10 @@ static int fuse_permission(struct mnt_idmap *idmap,
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
@@ -1648,7 +1648,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (!folio)
 		goto out_err;
 
-	err = fuse_readlink_page(inode, folio);
+	err = fuse_readlink_folio(inode, folio);
 	if (err) {
 		folio_put(folio);
 		goto out_err;
@@ -2238,7 +2238,7 @@ void fuse_init_dir(struct inode *inode)
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(folio->mapping->host, folio);
+	int err = fuse_readlink_folio(folio->mapping->host, folio);
 
 	if (!err)
 		folio_mark_uptodate(folio);
-- 
2.43.5


