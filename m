Return-Path: <linux-fsdevel+bounces-10792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D706084E65C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0703F1C20FC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EE912838A;
	Thu,  8 Feb 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8Bz7NX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C3128377
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412157; cv=none; b=p3rkxXq4ws3d9teu0THrxz5DVYrZr+0jM2XsJ7USGhYbh9qrCiK14gVeTrtIVGeXnTH1n6VwH3bsQLTxR0FMS0Vy57okf1XKhq3GnqK6iyjnFrrKQQYf5cPeu2axiDPFPdf+laKYimWU8ie9W2VprGEjVMNDo7IJuFc06r10yNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412157; c=relaxed/simple;
	bh=DIUml7QV66C+8SUY721A9DRE0pxiYt1wyaXp+mtMWPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qw5TIUHmMLvkBRrQfzbAmSVOQYIFI0dbHSeInbpyhpyHNMOHxqLkFCJF/hJn6+XBHyKYCKPvtAGrdSYCQff4VZGu/Mct1CKs4cLBU2MHwnpSlfvLk3ByI4LrjYqPdb2BzwZmrUhxM/ffNk6Kq5Z9OnoKEeAAYBM2lE165Tu3w30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8Bz7NX0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b4b121e28so1053287f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412154; x=1708016954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ip3crKuP8BZT8AKtMLlKfqtxALMych2d900zOwj8oog=;
        b=k8Bz7NX06kpZWwk5cJR3TrmgstLoBUY8yMQlY1+XoHleJ+Q4672tZAJEC6ClfioYsx
         QVj6F98bHOgR5++6ESMnLJRkf/T/jGPoF+O/MZnXJgSJHmD7BOszFsmmIBD6wjij1cq+
         pt+w6QjUW0CnWh4pSMiqccvaI0TVpyBVthPYFefU8F0wWW32e1ap4upGsrW0tURk1XJ5
         821VyCtwVquGPmXI29wYF6UiC2QoJ3xsz7jXIZF2HLu2INblbE4fNltSCQ6d1ZX8RlpW
         xLsIOoF9RvJDAyUv8wKx+18TCs7Vl5WgNfYy48wfQKlut7eAp0Wkwq6BqbauykZMEPla
         mYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412154; x=1708016954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ip3crKuP8BZT8AKtMLlKfqtxALMych2d900zOwj8oog=;
        b=NddPLElB7KE9041RW1eb35M1CtwRyrU4/H620OF9l5puUMEZ/phj9Gwl1RmDMLXTrD
         ci6TvyBLzTMIDGzqwMuBPi0PROb2D8NgLk+aSB8kWJWqrCyH6Si6b+emhHWmk1RpwX39
         uugGUA/XQMyINyrS8plHF8YRfy9VmJD2adhkTSqjtQvS2bzAkweefqAUdSRHVMHIl8qt
         yS2NGxdu91qSDPME5QFQxMpSTPXtDGcJNBs/GdEXjfflXZ4a8fD3WR1RJ8ZUpJlsCDUI
         EasUpCiAnaz9P3hyGsqAjwEw8G07lJ+PmFIzj10UN9IX4xfXzjCqYDrZ0z2GE/kH5o0E
         jMyg==
X-Gm-Message-State: AOJu0YwpCc0WnJB//UF1m+Hev7jo9mIgOyOLblzDyEHRCT9JyVjC1BUB
	TpXvhJZ4oFKo6lPz8xlJsxML8C7SUVgHyUWOqgLeih9jzHcG2Y/R
X-Google-Smtp-Source: AGHT+IGYkoK2+wE2AexJanrpPAvNbwOcInZmP5p9kFWXrOphXPvsNQIfpDF//xUSAAHGnoIx+HAteA==
X-Received: by 2002:a5d:5589:0:b0:33b:10de:59a2 with SMTP id i9-20020a5d5589000000b0033b10de59a2mr66508wrv.15.1707412153656;
        Thu, 08 Feb 2024 09:09:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXB+axvAUxmuC7pQMiI6EngnCJxRIlnKsxinwcEjZBjRfiyE5YuPEqNIyytvoivIOpG+WnpxRpEo/CcCtXHlM1SaZVD554FVllRKKXbtA==
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:09:11 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 7/9] fuse: prepare for failing open response
Date: Thu,  8 Feb 2024 19:06:01 +0200
Message-Id: <20240208170603.2078871-8-amir73il@gmail.com>
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

In preparation for inode io modes, a server open response could fail
due to conflicting inode io modes.

Allow returning an error from fuse_finish_open() and handle the error
in the callers.

fuse_finish_open() is used as the callback of finish_open(), so that
FMODE_OPENED will not be set if fuse_finish_open() fails.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dir.c    |  8 +++++---
 fs/fuse/file.c   | 15 ++++++++++-----
 fs/fuse/fuse_i.h |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ff324be72abd..ea635c17572a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -692,13 +692,15 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	d_instantiate(entry, inode);
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
-	err = finish_open(file, entry, generic_file_open);
+	err = generic_file_open(inode, file);
+	if (!err) {
+		file->private_data = ff;
+		err = finish_open(file, entry, fuse_finish_open);
+	}
 	if (err) {
 		fi = get_fuse_inode(inode);
 		fuse_sync_release(fi, ff, flags);
 	} else {
-		file->private_data = ff;
-		fuse_finish_open(inode, file);
 		if (fm->fc->atomic_o_trunc && trunc)
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 84b35bbf22ac..52181c69a527 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -200,7 +200,7 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fi->lock);
 }
 
-void fuse_finish_open(struct inode *inode, struct file *file)
+int fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -212,6 +212,8 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 
 	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
 		fuse_link_write_file(file);
+
+	return 0;
 }
 
 static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
@@ -230,7 +232,9 @@ static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
 static int fuse_open(struct inode *inode, struct file *file)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = fm->fc;
+	struct fuse_file *ff;
 	int err;
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
 	bool is_wb_truncate = is_truncate && fc->writeback_cache;
@@ -258,16 +262,17 @@ static int fuse_open(struct inode *inode, struct file *file)
 
 	err = fuse_do_open(fm, get_node_id(inode), file, false);
 	if (!err) {
-		fuse_finish_open(inode, file);
-		if (is_truncate)
+		ff = file->private_data;
+		err = fuse_finish_open(inode, file);
+		if (err)
+			fuse_sync_release(fi, ff, file->f_flags);
+		else if (is_truncate)
 			fuse_truncate_update_attr(inode, file);
 	}
 
 	if (is_wb_truncate || dax_truncate)
 		fuse_release_nowrite(inode);
 	if (!err) {
-		struct fuse_file *ff = file->private_data;
-
 		if (is_truncate)
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5fe096820e97..9ad5f882bd0a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1036,7 +1036,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
  */
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
-void fuse_finish_open(struct inode *inode, struct file *file);
+int fuse_finish_open(struct inode *inode, struct file *file);
 
 void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags);
-- 
2.34.1


