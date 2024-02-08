Return-Path: <linux-fsdevel+bounces-10789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516584E659
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1ED2900EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E563127B4D;
	Thu,  8 Feb 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9gB+HxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0E1272C6
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412139; cv=none; b=V3Wh8tARKz04YnAvztBBlPOvMjDp45OnWWgpSFkM6WQQFgGYS9UtgRXL1vyVwByic8xwgRMTtsQPmGf1jOiOROVri0xXpCLMrsMdq0i0oX63yHdy/mNfhM+B0TWABs3v0BHU6LTOWeyTm1NZgfbHNDMCCRNKmm2YTytqqgtblzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412139; c=relaxed/simple;
	bh=AuJuTN5U6LkOcqbdKZlJlNY3/JJH2KHDTt7v///G1aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiwpMlTAS6ekhPM2zKuUdMDO0abIB8KagPG7E58iPl2YzMEjOoCtzkf42ieB0eWJlpkfQaASVmqYZFozFk9Qnam43qduPC8WX7I4qsBKngVfc+C/y4Bb815vfS49EwpK15tH4qQzCeti/P2c7OXVDgwJUStnZTl9yMUIQjUtO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9gB+HxK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso591315e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412136; x=1708016936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH2YHrPpv4Hq77oYrc6PJn/BI6xqq52fQMweNgI1544=;
        b=G9gB+HxKMxEoVe0tyLzShz2mAeR4k8m+VuR2OmAyeGuxa00osBE5/OfmOZ5lV8XK+m
         +A5m+7NsYHy1qVt7xxnAkXAau9C/B22FUNkFtl12aBvy9cxMovM8BnC2qkOi5be5/6PM
         d1XS1qJonH0pcXkBBqUZ7I+Ile59a1nAc/Lda4SJX6ieGuNhjaUppa1dOZTrm1xaASU9
         tbq6PEl++P+aSDqffYZiMDQJ50FVuOeE+IbYh2gcZH8lo0brCsd2M4aoSLkHwoISh3bd
         ykLWim8U3xgaePwrV2Ncrn53MHNunLApAcBRGcoKQKGW0PihtfGbtvDnMw3Lr7XAX8Si
         8J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412136; x=1708016936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH2YHrPpv4Hq77oYrc6PJn/BI6xqq52fQMweNgI1544=;
        b=ERWLEW4oqJFiT1tMKkmyYcACpIiHyCM0WwlB4dIf+Pj1cAO87kqkMjf/Z/MSiGF0hC
         jpoM2LVrYYcpt0Xt+1ZuzwTTamfm/L8hTKt6wFSD4Il0r3MH9F2aN7Evbi4MMaoq13Eq
         3NT7Lqn+QQOdJqU1tpYB05PvuWISkm3S/+6cXVS42XlquO1EiOJQdDBVvATHPZk1Dqkc
         mNxnGCB/YwdlVlU5t8xmCIC5BPoBf+z2L375/Jx8gNLsGu7I3fE8fP/XwgbrXL3UiAPf
         bAYZW5JNpKC8mX31VW0HMig+GXsb7A2dLgjSPduWl7D3bllCI4MsIYKpKa1Hg0X4FjSk
         RY4g==
X-Forwarded-Encrypted: i=1; AJvYcCUNEzmpx5hDlRoFf2v7y1hHVMuIb8Gc1T/M1Sw21OBYiIiEoWUamyOFdXVTU2xBpn9i288p8nxEgWrzw7IAE7HVpf4d0HM5WuhqWAXh0A==
X-Gm-Message-State: AOJu0YzA70Uyrl0LCwX5amN55AfqL2Xni0YxsHCivp9uWA7cETMenivM
	dWOM17JA8po3a1dUhD4yOe3oLAwDhymRQQ5w3CqvIGlai7owhYhiue/STwM9
X-Google-Smtp-Source: AGHT+IFNG0hvo3OcVCo4mqnuHhxTGsp3+6ZOh85k3ItH8vUshkyM8o9FuxFp4WZUuC7qoo8Lj/emOg==
X-Received: by 2002:a05:6000:1aca:b0:33b:2401:134e with SMTP id i10-20020a0560001aca00b0033b2401134emr73630wry.68.1707412136141;
        Thu, 08 Feb 2024 09:08:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLoCsKxTPGu8GXx6uSa7SatUEvKrtXbX2xF+jpCOzkjxZgEC7rv0E2TIyLlh05V9xIdUUkEvCrsKGgYieLwFLVyFubFSVUKfwzRJT4/Q==
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:08:50 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/9] fuse: factor out helper fuse_truncate_update_attr()
Date: Thu,  8 Feb 2024 19:05:58 +0200
Message-Id: <20240208170603.2078871-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170603.2078871-1-amir73il@gmail.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_finish_open() is called from fuse_open_common() and from
fuse_create_open().  In the latter case, the O_TRUNC flag is always
cleared in finish_open()m before calling into fuse_finish_open().

Move the bits that update attribute cache post O_TRUNC open into a
helper and call this helper from fuse_open_common() directly.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3062f4b5a34b..151658692eda 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -205,30 +205,31 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 	else if (ff->open_flags & FOPEN_NONSEEKABLE)
 		nonseekable_open(inode, file);
 
-	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
-
-		spin_lock(&fi->lock);
-		fi->attr_version = atomic64_inc_return(&fc->attr_version);
-		i_size_write(inode, 0);
-		spin_unlock(&fi->lock);
-		file_update_time(file);
-		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
-	}
 	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
 		fuse_link_write_file(file);
 }
 
+static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	spin_lock(&fi->lock);
+	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	i_size_write(inode, 0);
+	spin_unlock(&fi->lock);
+	file_update_time(file);
+	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
+}
+
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_conn *fc = fm->fc;
 	int err;
-	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
-			  fc->atomic_o_trunc &&
-			  fc->writeback_cache;
-	bool dax_truncate = (file->f_flags & O_TRUNC) &&
-			  fc->atomic_o_trunc && FUSE_IS_DAX(inode);
+	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
+	bool is_wb_truncate = is_truncate && fc->writeback_cache;
+	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -251,15 +252,18 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 		fuse_set_nowrite(inode);
 
 	err = fuse_do_open(fm, get_node_id(inode), file, isdir);
-	if (!err)
+	if (!err) {
 		fuse_finish_open(inode, file);
+		if (is_truncate)
+			fuse_truncate_update_attr(inode, file);
+	}
 
 	if (is_wb_truncate || dax_truncate)
 		fuse_release_nowrite(inode);
 	if (!err) {
 		struct fuse_file *ff = file->private_data;
 
-		if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC))
+		if (is_truncate)
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
-- 
2.34.1


