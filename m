Return-Path: <linux-fsdevel+bounces-69322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B389C7689D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5272635DDCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A0242D7D;
	Thu, 20 Nov 2025 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoK6x0bO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D430DD16
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678025; cv=none; b=CyFy9K+6wu6QlHaBrT59g7TD+Va72Km8SrhSdZ621Kf5ape0hal0tcoEMCn1o6v1oC0zuMO8+TVysNoUeJ8lQfPAjjNdFsaTU96JjmxLEfz2O+seJHfbB428ohvA5Ock/I6hI6+MF6C1v7k0oYY7QiMdJYNbve/qz/3lTL3PJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678025; c=relaxed/simple;
	bh=vMQks83fXNDTqVJzclPCcXl6tdd4UkVS1HpIFuIG+zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ft7Jy9Q9ghL3YlUmOh9qYyP8JmsynaqeFP9d2RO3k9WLWXSkV9+iChjTKk5P5KIgwZ2KyE/L+RENqkEVq2GaPyf0DZDsiOCSvozIlybxgDeC9mPJ1zbwFU9/HbGOIIK7aDc8hwDfgTpf1VQ+4l1rjHrPoW7p+8WMgOkddj28koo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoK6x0bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB03C4CEF1;
	Thu, 20 Nov 2025 22:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678024;
	bh=vMQks83fXNDTqVJzclPCcXl6tdd4UkVS1HpIFuIG+zA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uoK6x0bOGI6PRV1bgCzHXqLc0fMwfFwichB6/7+JsNvHyxu+CFitBjubnF/Cqlrjz
	 O66Df7Woe5aT8GtsWAGfSXjeEL60Abw0iGOdi25Mtd2BCL05b1EOqcGnG1ETCr1jVM
	 zGQ7j6SrXhBE1YVMoPzGLF1sx1xYi0ALgQfyyk+S2gpCu9nenefRZJ/liFqQzO075V
	 CTSsQG582WzCVxe34SFuZBNZopHfvc17RwjtoHZttoAE9rL+oeMsHZdPbboUWssvTH
	 FMIB/4I0G9txPF50l6Gjh/4KzrtUaxll+upP86lib8dr1241OMAWpGua7VQUPLZFlZ
	 5IrqXjhwozGng==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:39 +0100
Subject: [PATCH RFC v2 42/48] ntsync: convert ntsync_obj_get_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-42-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vMQks83fXNDTqVJzclPCcXl6tdd4UkVS1HpIFuIG+zA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vH+vPCFWZzyw5p/b22k1K12F3msRX95Jh0c80N6
 a2iO8zlOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbC+52RYbqktlzpa4PJ56W3
 q8u6ZHlsrV0vn+mnce9DW7mbYO/MhQz/U/9MuHHg2Ko+1S7df/wm++LdVfdEFEscfe7g9UPmSvd
 FBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/misc/ntsync.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 999026a1ae04..db13e6f39b70 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -721,21 +721,14 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 
 static int ntsync_obj_get_fd(struct ntsync_obj *obj)
 {
-	struct file *file;
-	int fd;
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("ntsync", &ntsync_obj_fops, obj, O_RDWR)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-	file = anon_inode_getfile("ntsync", &ntsync_obj_fops, obj, O_RDWR);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
+		obj->file = fd_prepare_file(fdf);
+		return fd_publish(fdf);
 	}
-	obj->file = file;
-	fd_install(fd, file);
-
-	return fd;
 }
 
 static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)

-- 
2.47.3


