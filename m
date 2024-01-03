Return-Path: <linux-fsdevel+bounces-7199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60461822DBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C42285908
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1A1B272;
	Wed,  3 Jan 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcPK9l93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926D1A733;
	Wed,  3 Jan 2024 12:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D3CC433C7;
	Wed,  3 Jan 2024 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286566;
	bh=DGMPHqDOdVU2hPlZg/YQJTJ2I0ikPmmqIEvDLQ0peHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lcPK9l93kSioco0uhOyzlB65SqNqbhu1/BM+NjC9ojDE3rLskpVRvuvQ9IEDpnnct
	 rjFhHepApsZeov1dxct/jAnh3bJ87Auldmsw2An5lI+Z52Yuy9/lIEU/Wje20q0mcx
	 SuGWc8HX/gdzclWQ+/kDcTkt24UmdllUQIbkZDxTKKorMah/xYpPlWIZTcw45Z6M8U
	 DUjrUNmowRmAbBydnkF+xiN8e9+qdaCSIBt1XXD02k247I+l3ztZJKdP0SUS1C5r/U
	 k8dzK7in6IrapH6jlDRxqQYIKx3pTKoiM2RqPq56svpS04M2Op2ndzBui8rNwrSMJp
	 FalPAA/z6TNxg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:16 +0100
Subject: [PATCH RFC 18/34] bcachefs: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-18-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DGMPHqDOdVU2hPlZg/YQJTJ2I0ikPmmqIEvDLQ0peHM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbR5ych+dF94wtXlP8OmHmZufPpxzU5rwYmWTOI1I
 Vu+a2od6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjISy1Ghp2rL6oKrkzZOnEB
 k0e7//7Mldyzl51pun1rU+CXTadPFCYwMqw32qRaep7pxxeOFzeEv26fqqN7bm676w1WvX4/B60
 jx7gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/bcachefs/super-io.c    | 20 ++++++++++----------
 fs/bcachefs/super_types.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index 801590bbc68c..927b977dfbda 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -163,8 +163,8 @@ void bch2_sb_field_delete(struct bch_sb_handle *sb,
 void bch2_free_super(struct bch_sb_handle *sb)
 {
 	kfree(sb->bio);
-	if (!IS_ERR_OR_NULL(sb->bdev_handle))
-		bdev_release(sb->bdev_handle);
+	if (!IS_ERR_OR_NULL(sb->s_f_bdev))
+		fput(sb->s_f_bdev);
 	kfree(sb->holder);
 	kfree(sb->sb_name);
 
@@ -691,22 +691,22 @@ int bch2_read_super(const char *path, struct bch_opts *opts,
 	if (!opt_get(*opts, nochanges))
 		sb->mode |= BLK_OPEN_WRITE;
 
-	sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
-	if (IS_ERR(sb->bdev_handle) &&
-	    PTR_ERR(sb->bdev_handle) == -EACCES &&
+	sb->s_f_bdev = bdev_file_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
+	if (IS_ERR(sb->s_f_bdev) &&
+	    PTR_ERR(sb->s_f_bdev) == -EACCES &&
 	    opt_get(*opts, read_only)) {
 		sb->mode &= ~BLK_OPEN_WRITE;
 
-		sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
-		if (!IS_ERR(sb->bdev_handle))
+		sb->s_f_bdev = bdev_file_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
+		if (!IS_ERR(sb->s_f_bdev))
 			opt_set(*opts, nochanges, true);
 	}
 
-	if (IS_ERR(sb->bdev_handle)) {
-		ret = PTR_ERR(sb->bdev_handle);
+	if (IS_ERR(sb->s_f_bdev)) {
+		ret = PTR_ERR(sb->s_f_bdev);
 		goto out;
 	}
-	sb->bdev = sb->bdev_handle->bdev;
+	sb->bdev = F_BDEV(sb->s_f_bdev);
 
 	ret = bch2_sb_realloc(sb, 0);
 	if (ret) {
diff --git a/fs/bcachefs/super_types.h b/fs/bcachefs/super_types.h
index b2119686e2e1..e98df6428d38 100644
--- a/fs/bcachefs/super_types.h
+++ b/fs/bcachefs/super_types.h
@@ -4,7 +4,7 @@
 
 struct bch_sb_handle {
 	struct bch_sb		*sb;
-	struct bdev_handle	*bdev_handle;
+	struct file		*s_f_bdev;
 	struct block_device	*bdev;
 	char			*sb_name;
 	struct bio		*bio;

-- 
2.42.0


