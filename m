Return-Path: <linux-fsdevel+bounces-68968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B05AC6A667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 522CF2C7AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1905369962;
	Tue, 18 Nov 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axZl91wv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0936654F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480996; cv=none; b=KBYGNJzL+IlwfrbOq9jRWyPMVjZceyi+RKzNoEgMhexCdG3L/INraTReHBDZxWbhbkDvpj2y3I6QffdnKJHwS5W2KwwneOYJ6soTtSkAX40QcNerBtM5qAI1Mv0uGjznsE/AZHdlG/NRlb5ZaiOZ/6ClosEMMgcBdwrF9qledMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480996; c=relaxed/simple;
	bh=IC7vVzT8/Gtfc0EMEWKWxhAVjuv038vAgSuXRJXEj70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dn95i1j/vkNT6P+ZjBUKlQ4ZtmiP7jAeootF96gd2GOtXSNUAuMRlOqOYweQrLUHQZUatxHz7HASyuGVRyKc1fEnh4MknOKOzNizUZg70+Zfhyfcd4NiK0vs1xLnLsGpIUzY6Y1hoJCSEIdEG6yHqGhxdTZVWA1FOwxnJPATj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axZl91wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F97C4AF13;
	Tue, 18 Nov 2025 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480995;
	bh=IC7vVzT8/Gtfc0EMEWKWxhAVjuv038vAgSuXRJXEj70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=axZl91wvu51z8Bhgg6Thhqrhx34Q1g7rwcJjh/Z1ZBqJHrCabRgE+EIplewivmZ8p
	 Jpqi688lWRsdVLlKMfpTCSQ3TjupEwOnq2uo5GVkXTyYW+yGaS7eEhlz5zLN0WIQff
	 /7jAhzMODUYLgdlnMupShI7fnh2kYu/M9sqzCsR7Ah+YtbBrK5T4IlpjJnnlo+XaiU
	 kMrvGycG463fWE+pvTeBXkb71Q62LhuRrAS9cgEmv03vW5JtEZdMAj/0yQUOmN6aWu
	 PbEk5X3EApqdyREioEEHxZFMc2GnG91QFvFS1BhJMYpAXa6nqDsw2yF7gTuMQ/MSZ4
	 WCxW52hO7xcqg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:49 +0100
Subject: [PATCH DRAFT RFC UNTESTED 09/18] fs: autofs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-9-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IC7vVzT8/Gtfc0EMEWKWxhAVjuv038vAgSuXRJXEj70=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO3v3Hl1okVkz/VIiTsfv7OGPV+6u+jg1oBnt5Xb0
 j++XZNt2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRbecZ/go/32vG9lwwgZN/
 59eZUzymfPrwIufEpJolpSd0JlR9PnOKkeHkVe8+/TqDup/92RkPWg2aX4Z0OYW1TfdfeX3eOZs
 sBiYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/autofs/dev-ioctl.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index d8dd150cbd74..c93f0f5c537a 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -231,32 +231,18 @@ static int test_by_type(const struct path *path, void *p)
  */
 static int autofs_dev_ioctl_open_mountpoint(const char *name, dev_t devid)
 {
-	int err, fd;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (likely(fd >= 0)) {
-		struct file *filp;
-		struct path path;
-
-		err = find_autofs_mount(name, &path, test_by_dev, &devid);
-		if (err)
-			goto out;
-
-		filp = dentry_open(&path, O_RDONLY, current_cred());
-		path_put(&path);
-		if (IS_ERR(filp)) {
-			err = PTR_ERR(filp);
-			goto out;
-		}
+	struct path path __free(path_put) = {};
+	int err;
 
-		fd_install(fd, filp);
-	}
+	err = find_autofs_mount(name, &path, test_by_dev, &devid);
+	if (err)
+		return err;
 
-	return fd;
+	FD_PREPARE(fdprep, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
-out:
-	put_unused_fd(fd);
-	return err;
+	return fd_publish(fdprep);
 }
 
 /* Open a file descriptor on an autofs mount point */

-- 
2.47.3


