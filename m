Return-Path: <linux-fsdevel+bounces-56680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC085B1A8AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B2A181D1A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441628B4F3;
	Mon,  4 Aug 2025 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXSrFKbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D3227BB5
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328761; cv=none; b=ZHdrqs6vGnPhK3dzLmwNnV38RnwFCYu9tAj3hGTrnS74B6ippcyV3xfZDLhUHbTky7nzcbQTAhd6yZo0rXpcVvcvI67ceNMBGfGNs6G+I60/WjRfJo/xVuSl2GFmRCP+IxAT/VJuoTj6AUmOftHK0Xy/GR0QB2lqy+KYm8pldNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328761; c=relaxed/simple;
	bh=OAEQFqv3EswdYaHhtd7CEc9/2OEXW++O41GigbiMrXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKQcgbC3g+ARrvH/Oc8btcPrJf+0C4BOxqpNlZCxKhaG5PZMGNcJEpPiugQBvfUVNK5mcI8dBNuEntlEMqnWbfj149HdrTgG2Ge46NnI96dbeWipOxbUGprgluDbWDUKeR1XYaj+P25xy+KsRiOuNLBAV+ADUOga4YdDb3vxCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXSrFKbr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23fed1492f6so68092985ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754328759; x=1754933559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQMUmLKs3xh972hbtTuWn5Gb9KU0cVynXKrRv5wztKs=;
        b=hXSrFKbrnLbX1Kd7IPMNbQ+4qxaxljSJagPUtL8Ci+G8g2zA6kSA+hyPvDPbuoImOW
         FW6Ej0DidvEZp3iujLePGu49YtbbRwmeIvIHmZYlNWSn5OMnUomXKg/3Vf1SXN9hzvUz
         6bW4kd7pR8DjIM+QiclTI3amqnbwbInHYM7G0LKOtjMX7w0iuJIPFuApWPeIeMy3b+hV
         +AktnkIDfYYtrCBBRAgBskYC61jSmVdYwscAi8lcezH5eZxw+IWuoIkEdrIi2/avlf/W
         J5rkSaFyaEB03NrKOdHsqaR/OtBxPEWJKzTDrQJiEotHkubp3EkmjM+nsQf6QzIT985x
         BJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328759; x=1754933559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQMUmLKs3xh972hbtTuWn5Gb9KU0cVynXKrRv5wztKs=;
        b=rpxaLJaLjZnJFxcg6ak2OTgKdsDufd+Fjobbp+y9X8ZGCKTpAjFwnNTJtQGDz1Hl/J
         6VB/NrPmMvF/weH1+ZZhpknzKv/nZw7iv2Jw/DL4hP67xyiKl8WrqXKRewrnDSO3a7Fm
         K7xsDINPrriypt7tfK3wLAA/UJ/WD08QPjpjgcyGfrsaE2lT8LJy/oXCC+rfo4YzeLmb
         V3pFxxU/Bvio1/fyUJe6LDvn5jxo+2JDe8dmfVy0LPElvkLWKR4Lp7N3KmgbZxKzezuQ
         aKeLMvhzbi/nnFwpouljS83xkGPS/HHtJKAV/27/PoXbRFlLg8GH0ioKgwJHCEBfjmdn
         Y2vg==
X-Forwarded-Encrypted: i=1; AJvYcCW5AECnugfEgdz0edwhmhAq5/D6O6vo3HmAORNahhqA87GSwZSe3Ydi+fB4X2+QDbBces5iuhlUMt1Pbhsg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15qQx9RkPrfvwqcBWtNAKA5CH/U43onzyHsEsX6B9//3+gC2Y
	kFscaHugsmmbGDMSiHxcw5OK24oyGGUk9K4yHLBdrJWNc8C0741aWW+57hFghZHxP4lHGHm7J/Z
	Lcu327gBn4iUR5YYxAS0vpANF7zlEZw==
X-Google-Smtp-Source: AGHT+IEUISRCOUdvcdunQlfH7Ugn/MjFVzK+dOVNeTOe3EfG42PQ2i/eYIkKSU1xi7j49rI73Dh1hRhE+hEDRhcmABU=
X-Received: from plbma14.prod.google.com ([2002:a17:903:94e:b0:240:1867:a503])
 (user=paullawrence job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d486:b0:234:d778:13fa with SMTP id d9443c01a7336-24289c27db1mr293835ad.26.1754328758859;
 Mon, 04 Aug 2025 10:32:38 -0700 (PDT)
Date: Mon,  4 Aug 2025 10:32:28 -0700
In-Reply-To: <20250804173228.1990317-1-paullawrence@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
 <20250804173228.1990317-1-paullawrence@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804173228.1990317-3-paullawrence@google.com>
Subject: [PATCH 2/2] fuse: Add passthrough for mkdir and rmdir (WIP)
From: Paul Lawrence <paullawrence@google.com>
To: amir73il@gmail.com
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, paullawrence@google.com
Content-Type: text/plain; charset="UTF-8"

As proof of concept of setting a backing file at lookup, implement mkdir
and rmdir which work off the nodeid only and do not open the file.

Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/dir.c             |  8 +++++++-
 fs/fuse/fuse_i.h          | 11 +++++++++--
 fs/fuse/passthrough.c     | 38 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  2 ++
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c0bef93dd078..25d6929d600a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -129,7 +129,7 @@ void fuse_invalidate_attr(struct inode *inode)
 	fuse_invalidate_attr_mask(inode, STATX_BASIC_STATS);
 }
 
-static void fuse_dir_changed(struct inode *dir)
+void fuse_dir_changed(struct inode *dir)
 {
 	fuse_invalidate_attr(dir);
 	inode_maybe_inc_iversion(dir, false);
@@ -951,6 +951,9 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
 
+	if (fuse_inode_passthrough_op(dir, FUSE_MKDIR))
+		return fuse_passthrough_mkdir(idmap, dir, entry, mode);
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;
 	inarg.umask = current_umask();
@@ -1058,6 +1061,9 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (fuse_inode_passthrough_op(dir, FUSE_RMDIR))
+		return fuse_passthrough_rmdir(dir, entry);
+
 	args.opcode = FUSE_RMDIR;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 2;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index aebd338751f1..d8df2d5a73ac 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1279,6 +1279,7 @@ void fuse_check_timeout(struct work_struct *work);
 #define FUSE_STATX_MODSIZE	(FUSE_STATX_MODIFY | STATX_SIZE)
 
 void fuse_invalidate_attr(struct inode *inode);
+void fuse_dir_changed(struct inode *dir);
 void fuse_invalidate_attr_mask(struct inode *inode, u32 mask);
 
 void fuse_invalidate_entry_cache(struct dentry *entry);
@@ -1521,7 +1522,8 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 
 /* Passthrough operations for directories */
 #define FUSE_PASSTHROUGH_DIR_OPS \
-	(FUSE_PASSTHROUGH_OP_READDIR)
+	(FUSE_PASSTHROUGH_OP_READDIR | FUSE_PASSTHROUGH_OP_MKDIR | \
+	 FUSE_PASSTHROUGH_OP_RMDIR)
 
 /* Inode passthrough operations for backing file attached to inode */
 #define FUSE_PASSTHROUGH_INODE_OPS \
@@ -1532,7 +1534,8 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	((map)->ops_mask & FUSE_PASSTHROUGH_OP(op))
 
 #define FUSE_BACKING_MAP_VALID_OPS \
-	(FUSE_PASSTHROUGH_RW_OPS | FUSE_PASSTHROUGH_INODE_OPS)
+	(FUSE_PASSTHROUGH_RW_OPS | FUSE_PASSTHROUGH_INODE_OPS |\
+	 FUSE_PASSTHROUGH_DIR_OPS)
 
 static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
 {
@@ -1626,6 +1629,10 @@ ssize_t fuse_passthrough_getxattr(struct inode *inode, const char *name,
 				  void *value, size_t size);
 ssize_t fuse_passthrough_listxattr(struct dentry *entry, char *list,
 				   size_t size);
+struct dentry *fuse_passthrough_mkdir(struct mnt_idmap *idmap,
+				      struct inode *dir, struct dentry *entry,
+				      umode_t mode);
+int fuse_passthrough_rmdir(struct inode *dir, struct dentry *entry);
 
 #ifdef CONFIG_SYSCTL
 extern int fuse_sysctl_register(void);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index cee40e1c6e4a..acb06fbbd828 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -7,6 +7,7 @@
 
 #include "fuse_i.h"
 
+#include "linux/namei.h"
 #include <linux/file.h>
 #include <linux/backing-file.h>
 #include <linux/splice.h>
@@ -497,3 +498,40 @@ ssize_t fuse_passthrough_listxattr(struct dentry *entry, char *list,
 	revert_creds(old_cred);
 	return res;
 }
+
+struct dentry *fuse_passthrough_mkdir(struct mnt_idmap *idmap,
+				      struct inode *dir, struct dentry *entry,
+				      umode_t mode)
+{
+	struct fuse_backing *fb = fuse_inode_backing(get_fuse_inode(dir));
+	struct dentry *backing_entry, *new_entry;
+	const struct cred *old_cred;
+
+	old_cred = override_creds(fb->cred);
+	backing_entry = lookup_one_unlocked(idmap, &entry->d_name,
+		fb->file->f_path.dentry);
+	new_entry = vfs_mkdir(idmap, fb->file->f_inode, backing_entry, mode);
+	d_drop(entry);
+	revert_creds(old_cred);
+	fuse_dir_changed(dir);
+	return new_entry;
+}
+
+int fuse_passthrough_rmdir(struct inode *dir, struct dentry *entry)
+{
+	int err;
+	struct dentry *backing_entry;
+	struct fuse_backing *fb = fuse_inode_backing(get_fuse_inode(dir));
+	const struct cred *old_cred;
+
+	old_cred = override_creds(fb->cred);
+	backing_entry = lookup_one_unlocked(&nop_mnt_idmap, &entry->d_name,
+		fb->file->f_path.dentry);
+	err = vfs_rmdir(&nop_mnt_idmap, fb->file->f_inode, backing_entry);
+	dput(backing_entry);
+	if (!err)
+		d_drop(entry);
+	revert_creds(old_cred);
+	return err;
+}
+
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 6dbb045c794d..8181d07b7bf1 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1135,6 +1135,8 @@ struct fuse_backing_map {
 #define FUSE_PASSTHROUGH_OP_STATX	FUSE_PASSTHROUGH_OP(FUSE_STATX)
 #define FUSE_PASSTHROUGH_OP_GETXATTR	FUSE_PASSTHROUGH_OP(FUSE_GETXATTR)
 #define FUSE_PASSTHROUGH_OP_LISTXATTR	FUSE_PASSTHROUGH_OP(FUSE_LISTXATTR)
+#define FUSE_PASSTHROUGH_OP_MKDIR	FUSE_PASSTHROUGH_OP(FUSE_MKDIR)
+#define FUSE_PASSTHROUGH_OP_RMDIR	FUSE_PASSTHROUGH_OP(FUSE_RMDIR)
 
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
-- 
2.50.1.565.gc32cd1483b-goog


