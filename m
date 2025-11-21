Return-Path: <linux-fsdevel+bounces-69439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F98C7B35B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4D753431F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBC3538B5;
	Fri, 21 Nov 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDsbiVk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED134B42C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748138; cv=none; b=mhYVG6D/l0SPm/dAvkSQx8IYZNwz2TT3qeRnc1PodAq1pzoaFr4nzv+xluO3CryJSq1GQEsR8NSic4U/B/7GfOU376ap3d8aKnom24YwRQnavxLoV/mV8VbeJg1bXyvx0phWxpvuMgzx7EhFvMjDjH36Yoiiv3lXFAVQQjzoDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748138; c=relaxed/simple;
	bh=Hn0L7RN7KlbRJiPiX1aY3qVnYuEfEOcFdtgpixFVSsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWH9AYPltCA0lRTVOsrWV7gdJyO/1OlFa9tkvjKSOGez1kBYmOWUFEM5sN4/tg9JPIUZrkHPJEivaxfRIlI26IKwurFiUXB2W3yYQC6YtymrhqZbo/uzhl5YTVpa8KspIBch7QI1bGeoCXp6nvSjrFs+BUx7PItxr9PyGCVRVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDsbiVk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D551C116C6;
	Fri, 21 Nov 2025 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748138;
	bh=Hn0L7RN7KlbRJiPiX1aY3qVnYuEfEOcFdtgpixFVSsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FDsbiVk6wNZej4HjQ37kGanRvBZde0DZ53W0Vxyfd8vDbB4F0C6i66mCsluNmeRe/
	 JaxdQ6OQU+gztKPSdRaE74JFEEEdopzLRqnPvcst2FB0p0HgdRagZp89h4hBpXUPdr
	 DZVka7gUxGl6swgM2k65rleABYCmTQ9finXuQasByYI1Et5OhpEfKtFN9jPlLtGfQz
	 at7B6QmkDAv+ohcSDF7ninXUqKRFAROBgLAa8Nkhdw1EqaN59uC8LmuQ/jYe4580UM
	 EZ29aRW4raBimHhEEasa6JVaMrcBeDhUuqJLoQ3fqPuwlmXPZk5Px1BlGEa6Ma9dbU
	 6j0toFig79dxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:20 +0100
Subject: [PATCH RFC v3 41/47] ntsync: convert ntsync_obj_get_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-41-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Hn0L7RN7KlbRJiPiX1aY3qVnYuEfEOcFdtgpixFVSsg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLiYd5I/Yf6ji3VS4asLTBxyWdkuPna1Fr7vv/tU7
 Pl1/J9fd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkchjDX5HZX7lOpfYdvhi4
 huliY9enmztCvK1myO053hHBG3udrYqR4elJRvtZz/P56158y1gXbrFiv0Tqcv51enzXJLvXe85
 yYQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/misc/ntsync.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 999026a1ae04..b7db1628cf26 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -721,21 +721,15 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 
 static int ntsync_obj_get_fd(struct ntsync_obj *obj)
 {
-	struct file *file;
-	int fd;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-	file = anon_inode_getfile("ntsync", &ntsync_obj_fops, obj, O_RDWR);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
-	obj->file = file;
-	fd_install(fd, file);
+	int ret;
 
-	return fd;
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("ntsync", &ntsync_obj_fops, obj, O_RDWR));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
+	obj->file = fd_prepare_file(fdf);
+	return fd_publish(fdf);
 }
 
 static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)

-- 
2.47.3


