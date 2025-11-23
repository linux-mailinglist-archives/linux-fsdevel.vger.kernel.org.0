Return-Path: <linux-fsdevel+bounces-69565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D3C7E40E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D9994E3A17
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9DE19F40A;
	Sun, 23 Nov 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIAPNROc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA32D7DE2
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915708; cv=none; b=A2RklF8TgXEOWN+jstL66KCFSBXGskHugGzRC1CYqJAyVdlyZc2WcdAosRpFs0O16su/4mvW3hAmG78x02ot6wSCw3/j2Zlpt1SuEgCrsV+Co+wF8ew/a9i4/niVy9/R2eY6BzTBISGeR+jt/W0p8XO89WlCgDKuZOU0Fvv+0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915708; c=relaxed/simple;
	bh=ZjF7eX02ra0cqU+1/WTWxQLupNjHYOilBNfCKQyNlY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvS4WHjieErW0saE18DpGT8MxpDbNzK/7XRrEZ3X+yj/Lma+LBjm9dXV11sSwAO8vJyqr8sLuidC9KXVP9eYbaZrT9IpQM6V2d/t+pUrGcKWq7KFEPISf7LRo3X6vAoUbPzIy97vQxsm9aHsunYwyGUHSyDWfo1ol9bQZAvSFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIAPNROc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0CBC113D0;
	Sun, 23 Nov 2025 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915708;
	bh=ZjF7eX02ra0cqU+1/WTWxQLupNjHYOilBNfCKQyNlY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QIAPNROccFBv7hyKvLTzcmuFA2E7hbJLqA90enOefVs6fPmU2YkXJzW+XOlcmA4uI
	 +lOSs185d2iv1SAOR6vFtK/Je3EDls6Iv8QN/hc6K38TrlA4Z1tqLN/4kJAIq2z+SU
	 a7aYNCBUINLnAsyxEV31lxfsnBA5bOHqFRNz1wUEsIaU+gXerP/ZWFaAFKZrvf+nuS
	 1HymcRHfKLGRiMG6Al/SuMRmN9KpZkr3HM0S7IzStYquS3+7a0iYXHPZRB50uegBLv
	 dn8z5HQPC1mn3vrRxfxD7e0SnjronQMlIXi+OwaI6ANtvwRfwX9hLi9tRzD2MI+q5G
	 XsdePV3gluyoA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:34:01 +0100
Subject: [PATCH v4 43/47] vfio: convert vfio_group_ioctl_get_device_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-43-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZjF7eX02ra0cqU+1/WTWxQLupNjHYOilBNfCKQyNlY0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0cv/fQzw4n91IVzQW9mLlGuCXLSuun3ge1uYtuj9
 HCrzFf/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyTYuR4fFMY1375ebdjx0z
 RTacWFRoeKbJ5cqydVNiZ6VreP4IW8/wh1vXsS7wuMsvzkc3e6v9pvzXqgsPOM949OWSH1sSt02
 U5AQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/vfio/group.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c376a6279de0..d47ffada6912 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -299,10 +299,8 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 					  char __user *arg)
 {
 	struct vfio_device *device;
-	struct file *filep;
 	char *buf;
-	int fdno;
-	int ret;
+	int fd;
 
 	buf = strndup_user(arg, PAGE_SIZE);
 	if (IS_ERR(buf))
@@ -313,26 +311,10 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
-	fdno = get_unused_fd_flags(O_CLOEXEC);
-	if (fdno < 0) {
-		ret = fdno;
-		goto err_put_device;
-	}
-
-	filep = vfio_device_open_file(device);
-	if (IS_ERR(filep)) {
-		ret = PTR_ERR(filep);
-		goto err_put_fdno;
-	}
-
-	fd_install(fdno, filep);
-	return fdno;
-
-err_put_fdno:
-	put_unused_fd(fdno);
-err_put_device:
-	vfio_device_put_registration(device);
-	return ret;
+	fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
+	if (fd < 0)
+		vfio_device_put_registration(device);
+	return fd;
 }
 
 static int vfio_group_ioctl_get_status(struct vfio_group *group,

-- 
2.47.3


