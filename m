Return-Path: <linux-fsdevel+bounces-69562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 30448C7E429
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C702334A7BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4922D949F;
	Sun, 23 Nov 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTNB74Qg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892A19F40A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915702; cv=none; b=GUaTgTMySSNnBYlBG2E0wsP2kwpXbzEfo8jYBERMg4Ns9ZaQ1h7KIMANt5llUjmYP8ZD3eMmlvAsomsOOlOIpIU3vXKl+BNuZh0APtRH9yhTOqa8vp+McI09vJIuqnfKHbsNQINYG8+YIq9bOAEMu56spfiwggAIA+zL/qZrmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915702; c=relaxed/simple;
	bh=m918i/TWq12REjdhv4PoEkumB/IJ10KDwx9wMwrcja4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLUZjQ7Ij1Lx1Zeaja0ifIp3fWHtxPIhGv2r8yfjNiJ5Rxw7vkLE5VBUCN8D9GxRQjDGZTyN1l0aYOjNKURi7OwRLew7F5YzcsTJfdcKuCcKpbyW3rTb3OCd+hR1iMNz5zpIKLsMY/ApRnCj1pxJUPIVdXL8ZuDXZTZZSB2xuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTNB74Qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52259C19421;
	Sun, 23 Nov 2025 16:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915702;
	bh=m918i/TWq12REjdhv4PoEkumB/IJ10KDwx9wMwrcja4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DTNB74QgBTq0BSmgf7+lQ73eY7K7sGfkGE/HEqmj0cYPHovd4PK7CAtuETMsrl49f
	 LUueCuYFfN4M2gi/tNJ6kEvUmSHW1IaL3ht/to1cqqhn+Sv+fxxUtwMN1mskcvR+vZ
	 29xGxpcblTj1RqOFJdCmPJ5voxkkYXKoQV6dPJqJFpQfgxhTr7A1thF4ECJK97HbN+
	 G5yo8mygkRIWzvTc8vE87nwfdRuDDcPzQWGYyzF18tRfCeoyXU1UNnnczc0yEBVw5b
	 22aHX2dcSFXU4sx0a+e0DXPxOBmbEH6o+kKoQF43p1ESd0TZgD4DtFSlH7WzT0mbyz
	 C62wEiFOBEQGw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:58 +0100
Subject: [PATCH v4 40/47] media: convert media_request_alloc() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-40-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m918i/TWq12REjdhv4PoEkumB/IJ10KDwx9wMwrcja4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0ff/T9v0VQRtYBYz/LF1cb9txcKbhEQzFG+vHBP9
 Iy697KPO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSeouR4ffsg5//ca5kVchI
 iW92lX3/oro+y777h5JBDNdz1+opvAx/pRfomn6u49ZufLnhbdrNmDuRbK3HukWOSk832bWH9fh
 2RgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/media/mc/mc-request.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index f66f728b1b43..2ac9ac0a740b 100644
--- a/drivers/media/mc/mc-request.c
+++ b/drivers/media/mc/mc-request.c
@@ -282,8 +282,6 @@ EXPORT_SYMBOL_GPL(media_request_get_by_fd);
 int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 {
 	struct media_request *req;
-	struct file *filp;
-	int fd;
 	int ret;
 
 	/* Either both are NULL or both are non-NULL */
@@ -297,19 +295,6 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 	if (!req)
 		return -ENOMEM;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto err_free_req;
-	}
-
-	filp = anon_inode_getfile("request", &request_fops, NULL, O_CLOEXEC);
-	if (IS_ERR(filp)) {
-		ret = PTR_ERR(filp);
-		goto err_put_fd;
-	}
-
-	filp->private_data = req;
 	req->mdev = mdev;
 	req->state = MEDIA_REQUEST_STATE_IDLE;
 	req->num_incomplete_objects = 0;
@@ -320,19 +305,24 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 	req->updating_count = 0;
 	req->access_count = 0;
 
-	*alloc_fd = fd;
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("request", &request_fops, NULL,
+				      O_CLOEXEC));
+	if (fdf.err) {
+		ret = fdf.err;
+		goto err_free_req;
+	}
+
+	fd_prepare_file(fdf)->private_data = req;
+
+	*alloc_fd = fd_publish(fdf);
 
 	snprintf(req->debug_str, sizeof(req->debug_str), "%u:%d",
-		 atomic_inc_return(&mdev->request_id), fd);
+		 atomic_inc_return(&mdev->request_id), *alloc_fd);
 	dev_dbg(mdev->dev, "request: allocated %s\n", req->debug_str);
 
-	fd_install(fd, filp);
-
 	return 0;
 
-err_put_fd:
-	put_unused_fd(fd);
-
 err_free_req:
 	if (mdev->ops->req_free)
 		mdev->ops->req_free(req);

-- 
2.47.3


