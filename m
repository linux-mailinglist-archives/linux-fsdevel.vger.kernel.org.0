Return-Path: <linux-fsdevel+bounces-8563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58AD83900C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D79D1F22128
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B760DE3;
	Tue, 23 Jan 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWC+I5L5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4660DD6;
	Tue, 23 Jan 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016463; cv=none; b=ZZpjGQY6vYdXrVnMl7E34GDJviG84/DSlOUc1iWSoc9Z1je62eD57atv8Ct2WF17k7/LDuweocz7/Tdpu/l5zyV0h7uPF72jdaxcRN6YViPGBXCP6Jvm8+1mZllcltx1v7uHQArlq7gBgHyrcaLI8OKJq4hyIXjzqngAxTDoVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016463; c=relaxed/simple;
	bh=5rStFWnSYFgFxgGX5EDTCUZkpEErfWlWchC33pIDJo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNO3lp+KQ8ZE0kcBBMfEnSQ6WK9mAHEJvvRQd9Q6FA3wWrSURAMrrXr3cbv29qhqKh07qpL7Prh1lqJSICz6qq/EK26kBBlY0GpdkR/eCwNyjJny44a+H9MZzI7Y1wgLNUnE8sG3btrTT87yzgguAyBF3tgvyd05tfL0tM3YDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWC+I5L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A7C433A6;
	Tue, 23 Jan 2024 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016462;
	bh=5rStFWnSYFgFxgGX5EDTCUZkpEErfWlWchC33pIDJo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YWC+I5L50Ww7jPh47gEXqb6o7oSa4YdAaX+eR7vvjrIfK7CVV15mAn/yE288SoCmi
	 oC9JzwmkDNiqRnzt5Ax2q6+sllfVMp3OcGftcCUs9dkT86/SLq6uYYa/AUE4rPb7vy
	 Uea8wi4pnGBZhcGsGcK2LpJ2esFlUYb9Scw66FayJ3xujjJIXKtLBRduImT96Vl6Qw
	 Zfm9PjVm0brozu6B7HY+UycCwMXPreAO19+KWmfQMLXy6O95BJUQpRTLnpOllaJX1K
	 BkJnTwQC4Fjq8fhLt8b+GH0SOZj7ufvjst/zK5qhm7mH7rWrYa0V1nfn8KmVUWqTNC
	 rr7nXpA9r0Fwg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:35 +0100
Subject: [PATCH v2 18/34] bcachefs: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-18-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5rStFWnSYFgFxgGX5EDTCUZkpEErfWlWchC33pIDJo4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37fA9nv1x9s1tW2sFxRiPuzLcMiUOW9T2hz74diNS
 U1rTl280lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRD18Z/lmV3prybelzkZpD
 k+96n5QW678+86Rp5JksVQ0+jgwWhT5Ghh/31uxga5EWXrGJzS6QZfmrMP37rM+rGy8/b42r6pH
 tYwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/bcachefs/super-io.c    | 20 ++++++++++----------
 fs/bcachefs/super_types.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index d60c7d27a047..ce8cf2d91f84 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -142,8 +142,8 @@ void bch2_sb_field_delete(struct bch_sb_handle *sb,
 void bch2_free_super(struct bch_sb_handle *sb)
 {
 	kfree(sb->bio);
-	if (!IS_ERR_OR_NULL(sb->bdev_handle))
-		bdev_release(sb->bdev_handle);
+	if (!IS_ERR_OR_NULL(sb->s_bdev_file))
+		fput(sb->s_bdev_file);
 	kfree(sb->holder);
 	kfree(sb->sb_name);
 
@@ -704,22 +704,22 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
 	if (!opt_get(*opts, nochanges))
 		sb->mode |= BLK_OPEN_WRITE;
 
-	sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
-	if (IS_ERR(sb->bdev_handle) &&
-	    PTR_ERR(sb->bdev_handle) == -EACCES &&
+	sb->s_bdev_file = bdev_file_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
+	if (IS_ERR(sb->s_bdev_file) &&
+	    PTR_ERR(sb->s_bdev_file) == -EACCES &&
 	    opt_get(*opts, read_only)) {
 		sb->mode &= ~BLK_OPEN_WRITE;
 
-		sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
-		if (!IS_ERR(sb->bdev_handle))
+		sb->s_bdev_file = bdev_file_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
+		if (!IS_ERR(sb->s_bdev_file))
 			opt_set(*opts, nochanges, true);
 	}
 
-	if (IS_ERR(sb->bdev_handle)) {
-		ret = PTR_ERR(sb->bdev_handle);
+	if (IS_ERR(sb->s_bdev_file)) {
+		ret = PTR_ERR(sb->s_bdev_file);
 		goto out;
 	}
-	sb->bdev = sb->bdev_handle->bdev;
+	sb->bdev = file_bdev(sb->s_bdev_file);
 
 	ret = bch2_sb_realloc(sb, 0);
 	if (ret) {
diff --git a/fs/bcachefs/super_types.h b/fs/bcachefs/super_types.h
index 0e5a14fc8e7f..ec784d975f66 100644
--- a/fs/bcachefs/super_types.h
+++ b/fs/bcachefs/super_types.h
@@ -4,7 +4,7 @@
 
 struct bch_sb_handle {
 	struct bch_sb		*sb;
-	struct bdev_handle	*bdev_handle;
+	struct file		*s_bdev_file;
 	struct block_device	*bdev;
 	char			*sb_name;
 	struct bio		*bio;

-- 
2.43.0


