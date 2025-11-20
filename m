Return-Path: <linux-fsdevel+bounces-69321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E6C76864
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D88C12A6B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650DE368E08;
	Thu, 20 Nov 2025 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSJjq71Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635E3019CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678022; cv=none; b=HPogARKE+b2pk2gOWKlGUSA7aswcGubOQFhZIO/X3cJe/ZGMVtaFPLz9EUY/CgF8lPQGkmpGhuem3qUu3OR3m9YGFuywo62cgjoh9zi81GcwRsXDxfGazaZFQsBts+jx2xI+1Gefq+tOKMOVJ4uLxVlGxV/SuRJZcIzgEQKjJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678022; c=relaxed/simple;
	bh=BOjuLp3/a5MVu/ZMv/1tbnjwxtB1Hq2EwALgIUjTkc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSxWp7EGXB0kRfO4NdVGETLNiwiTOeD5VZ2acn9jaYiGOFQKvfA9v7XzVXBS8fdPxcHQyroT6WXJa2vokxBvaF6K/RyOMRYJpQ97HSUG2bGa3qi7Z9ZMmhY4dCIqATAnH14E+bkhfttBNVhs5gBMSFR44Bc9QLRa1QGVvhIh9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSJjq71Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0515FC116B1;
	Thu, 20 Nov 2025 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678022;
	bh=BOjuLp3/a5MVu/ZMv/1tbnjwxtB1Hq2EwALgIUjTkc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gSJjq71Qlm+3kZpGP2Jz5uObSCOLWLz4cIbTO+vnGTqRZ/t34EyDACUdQ3+Ct5Hv2
	 JWpz5X1+A65RtJfhwx3mVIhWF+LutZWGTruDYPeiq5qJoW9ay1A7bdHMt3bysAsC13
	 eXExSUCwFyh94DwmI7vWBbJmFgvajWZ4g2RKKm4XYbb/+2UCkeXigYvpe3DirigELR
	 Hk2loXawIJle01ZgG1+Jkqq+zbH9GRXFdHSfSa91SmbnEottQTfuH4XprAOFYe0YlG
	 vmfmkXThhYMPUWf3IJJTdT3+d0lG64O1liHhNHHm4quun63IxGfFKumEx5H8NXrfO7
	 U9wLVl2YyMSPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:38 +0100
Subject: [PATCH RFC v2 41/48] media: convert media_request_alloc() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-41-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BOjuLp3/a5MVu/ZMv/1tbnjwxtB1Hq2EwALgIUjTkc4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3v30ueH/KwzdsHxxoes1N7Zn4rxPdYcH6DJKvHN+
 cebaSdPdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkQxsjQ8fcW17/XuzfUDv9
 0Iafh3ZOEk/4fPvgtKkLXZvvuU9awDeHkeHCQefIS+WG79vuLvvGcnLqnMYJzLftJ/iJ56n/EH7
 Bc5wZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/media/mc/mc-request.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index f66f728b1b43..2fa3bd9e5078 100644
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
@@ -320,18 +305,22 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 	req->updating_count = 0;
 	req->access_count = 0;
 
-	*alloc_fd = fd;
+	FD_PREPARE(fdf, O_CLOEXEC, anon_inode_getfile("request", &request_fops, NULL, O_CLOEXEC)) {
+		if (fd_prepare_failed(fdf)) {
+			ret = fd_prepare_error(fdf);
+			goto err_free_req;
+		}
 
-	snprintf(req->debug_str, sizeof(req->debug_str), "%u:%d",
-		 atomic_inc_return(&mdev->request_id), fd);
-	dev_dbg(mdev->dev, "request: allocated %s\n", req->debug_str);
+		fd_prepare_file(fdf)->private_data = req;
 
-	fd_install(fd, filp);
+		*alloc_fd = fd_publish(fdf);
 
-	return 0;
+		snprintf(req->debug_str, sizeof(req->debug_str), "%u:%d",
+			 atomic_inc_return(&mdev->request_id), *alloc_fd);
+		dev_dbg(mdev->dev, "request: allocated %s\n", req->debug_str);
 
-err_put_fd:
-	put_unused_fd(fd);
+		return 0;
+	}
 
 err_free_req:
 	if (mdev->ops->req_free)

-- 
2.47.3


