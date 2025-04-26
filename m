Return-Path: <linux-fsdevel+bounces-47429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC50A9D691
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05D21BC79D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4427190674;
	Sat, 26 Apr 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAP2x7UZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB621189B8B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626218; cv=none; b=c08nvg52UTKEdgJm3cmlhsi0dEjjYTZ9OUxHB6wSaS57eySDr5XjzN8cDKCcX3yn1odM7tTUdQNPoQaz5lkOabCfFDzc06OXuTy2pcQP1AiB6b1t/n1CNByDWr1yqa7htJXmq7xeLjGNsYTCkn0gm0m8sRJG+afEFPVbx0hUCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626218; c=relaxed/simple;
	bh=01uqqDQsyELeexFkAGDIqUBoWef751I0TbuPT2nPvDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1S1iT2m1ytRhzcXKcC7Ppvm8wcBvx5HKZQb5zVLVhYREixZN7ltCBy+2gbvRB5LbX3nILUV5OB8Md26hOWzsEUr5rbiCa5tnh9wfoodqqDjCB5Wl8DZY+gjQPkqLPeTz7RLHB97caL8+OypH1Nu5tAc6JQ6T9yfyXUwaQ5nh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAP2x7UZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af6a315b491so2751174a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626216; x=1746231016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdtO4rDl9K4XtteQMsjt6jryHE1bopfKY9rgJJDdYvs=;
        b=GAP2x7UZQmnumtKcb+m0H6433e8gVsEFjxJyAJH/uZc09udb+JbF0dSK00FbA0KsLx
         eYK3e1GZNmXbsQxo1tqO0B/zN6qGAz43PCLFchBtMoejpf7lkh3NEdik0ijXTobxv9DX
         8PoEYWFFtk2B1S9wFkEkpnzhkO6s5sK2JRpB0j2M0jwqzpafIJqhyAMSr7qKF7Fq5Trd
         YlB6lRoeAhntZBzoRBKO/jOALidHWIeFzUM+2ei1E0ENwGCyH8yDYWTQXgt2R5IGbIG+
         g6wY5I4bpBvvjV2JSwSOUhAEuMmoyp6mQLlOxhiy86MajGTJBzvWJz5Q+donWLNd7V0i
         aQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626216; x=1746231016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdtO4rDl9K4XtteQMsjt6jryHE1bopfKY9rgJJDdYvs=;
        b=XGaOaONsWHiK/IUF9zQrtvUHu4beHw4ApBr7B1QK768w5QQfwlqCWfhFbgoItvEAs6
         WEVEJVMS+0R3hQMTGKxrCrJ39W0FJXAy+L6HZqfg1jqqZo8MmHvxY2DfdxsBmYAcvqgT
         1QI9IDJfPVLksa1cXa8fPJu+EQCzDfrWG7Hp5GtMTEAtUgGHAYAP5DnRA/aJLqy0Cmxx
         1Cu2qnCRBisffBH4LG+qwLEwnYOU/7SJndspQYleA9whi/UlgNJZODlPbyUQraUVazmV
         B4ueOaRa55n+fS6lry6W2xJjpUTgP7zB3zNZWxhdGBt8IhVvtWBTZWjLzMru4nbXc2Vx
         +paQ==
X-Gm-Message-State: AOJu0YzS07kNV9w+hB9zYpGmIllpk2zppTi8UmlU320loOMJ9EQU3ib8
	pS+lmeRoEFFWkWFiCVP5bMK5OufE3HQQfrgkEY9nK/iRLHRfoThi
X-Gm-Gg: ASbGncsGjWiiwgjzwdTd33WcNlH6JNsjtoDuEZ25Yh+AUDgpicS85yI/AQ4VRCUTUFS
	KONuMUtsiLv99z7ndzy6xkjjGz2o2ejT3pBayxMTeUEdsVAN7mCnr9M1CiT3XKXDBmJk6+sHDpm
	wu9HLUX4kmd466GedvrYHBWbsoXiyOUdp/YMA3MmHpX4Uh1aB7IpYM8b8OLmbL+4BjAaYRQRN42
	+/1Dl2jgmHdVmFyRcR4be/jJHbzsxEu458tCQXop1Q5OWYU/IXK6hwjAJ7gD4ZT+gUhv63RqRmg
	1FwUZUflnmees2oLxmFnt/XL2CAmkfSuxk8=
X-Google-Smtp-Source: AGHT+IFm5YwZOppqWOHLabHcGEfAQB77JLv3CDJfG0guBIcteaZby+53jfmHLzg2NiA01Q8ddceWVQ==
X-Received: by 2002:a17:903:2a86:b0:223:f639:69df with SMTP id d9443c01a7336-22dc6a685d6mr22003205ad.41.1745626216023;
        Fri, 25 Apr 2025 17:10:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76f8asm38814235ad.35.2025.04.25.17.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:15 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 06/11] fuse: support large folios for symlinks
Date: Fri, 25 Apr 2025 17:08:23 -0700
Message-ID: <20250426000828.3216220-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
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
index 1fb0b15a6088..3003119559e8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1629,10 +1629,10 @@ static int fuse_permission(struct mnt_idmap *idmap,
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
@@ -1687,7 +1687,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (!folio)
 		goto out_err;
 
-	err = fuse_readlink_page(inode, folio);
+	err = fuse_readlink_folio(inode, folio);
 	if (err) {
 		folio_put(folio);
 		goto out_err;
@@ -2277,7 +2277,7 @@ void fuse_init_dir(struct inode *inode)
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(folio->mapping->host, folio);
+	int err = fuse_readlink_folio(folio->mapping->host, folio);
 
 	if (!err)
 		folio_mark_uptodate(folio);
-- 
2.47.1


