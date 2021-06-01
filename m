Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2D3974AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhFAN5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 09:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234021AbhFAN5T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EF4861376;
        Tue,  1 Jun 2021 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622555738;
        bh=Kx5QYuSnYqBrwWf7jWxZdvP8QvEMt2pIqOD/zEeWFs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBZTSbQEsH+G255n3uPI5HX1XJlzIRWsOhqe1n4KMKtTfoMj+xMmqU1NiywtZPJL0
         IPpfXlBSOnvvhC0I/Hul/P982KLotk+C0xPLJCvZQ+5myytnFVSa4+1q8QYrnBur9R
         2unuqF14Fr58gtFTSUXs6IyR8s2xnn6Kg833mRHJUe5kf9asrzNrNYymf9IM79kFMD
         IviGzPSGH9H7xt/e7zocnkhk1Rtx/FcxS6NWMVfrdvoAi5NDnw52VQ72n696CsB+6g
         nCZh9+vBF6PUBYA8yrNNxIzs9/3Tt30qoW2B9pt5UXOVQWOY3FjQE8vEe5VQAvpopX
         Ervoxakg0vrlw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Ross Zwisler <zwisler@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/2] mount: Support "nosymfollow" in new mount api
Date:   Tue,  1 Jun 2021 15:55:14 +0200
Message-Id: <20210601135515.126639-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210601135515.126639-1-brauner@kernel.org>
References: <20210601135515.126639-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2412; h=from:subject; bh=yXlHfY3QsqyEM74cEU2jkg9QTPpW4jIcdB2YxT4Se6o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRss7HPXHHtka39Ick3yS90/TPj8/Pnal+9qGEZsz75Xkkb F+/VjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMmsTwh2dKtfHN9+wX2i6btF/5fO 64+c8y4TNO7AtP62inFD3xW8XIcM2dd897C7OsmbzByi+n3nyuXJ9ltbj1Rqu2/9+Tq9X0uAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Commit dab741e0e02b ("Add a "nosymfollow" mount option.") added support
for the "nosymfollow" mount option allowing to block following symlinks
when resolving paths. The mount option so far was only available in the
old mount api. Make it available in the new mount api as well. Bonus is
that it can be applied to a whole subtree not just a single mount.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Mattias Nissler <mnissler@chromium.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ross Zwisler <zwisler@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namespace.c             | 9 ++++++---
 include/uapi/linux/mount.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c3f1a78ba369..ab4174a3c802 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3464,9 +3464,10 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	return ret;
 }
 
-#define FSMOUNT_VALID_FLAGS \
-	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV | \
-	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME)
+#define FSMOUNT_VALID_FLAGS                                                    \
+	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |            \
+	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME |       \
+	 MOUNT_ATTR_NOSYMFOLLOW)
 
 #define MOUNT_SETATTR_VALID_FLAGS (FSMOUNT_VALID_FLAGS | MOUNT_ATTR_IDMAP)
 
@@ -3487,6 +3488,8 @@ static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
 		mnt_flags |= MNT_NOEXEC;
 	if (attr_flags & MOUNT_ATTR_NODIRATIME)
 		mnt_flags |= MNT_NODIRATIME;
+	if (attr_flags & MOUNT_ATTR_NOSYMFOLLOW)
+		mnt_flags |= MNT_NOSYMFOLLOW;
 
 	return mnt_flags;
 }
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index e6524ead2b7b..dd7a166fdf9c 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -120,6 +120,7 @@ enum fsconfig_command {
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
 #define MOUNT_ATTR_IDMAP	0x00100000 /* Idmap mount to @userns_fd in struct mount_attr. */
+#define MOUNT_ATTR_NOSYMFOLLOW	0x00200000 /* Do not follow symlinks */
 
 /*
  * mount_setattr()
-- 
2.27.0

