Return-Path: <linux-fsdevel+bounces-69561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A5C7E423
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB9CD349CD3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9D2DAFB5;
	Sun, 23 Nov 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApwkccZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD72D3218
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915700; cv=none; b=tEK9X0FTHiIRFkzRxojSytudN/YCaAWHWKyu5KSSTQco5alzO1CK1ip3Iqgb6bDzYISKvHiHZP6ho8q9T6CfbdXpryqoIp+a4hK7ATdCSKghrJ7ntm0ksNRjrOeQSLJ8CFwDWZA+hYKITmqnYrXmZcKSQjYxCQwBcg6FcdfSxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915700; c=relaxed/simple;
	bh=Q1X9gOBk5/i4JCbNOdyusZtw8JFoYrf34rH1gsrqPeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=edZNDqYbeoC0izOiHq3nsh0BHiCBZscl8q+dwumZM6CYhPPCEELrswVUCvHcAdYvT7NnE0CHRskYi7nwahvACXhp3CxBvTIhE8MA8W8lNL87JOZ4QKv/31Y0y6dDr0l/f9qfm9qxGhe+j0vOh5huPhoHPfbDZO5dta9SgXcnLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApwkccZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAF5C113D0;
	Sun, 23 Nov 2025 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915699;
	bh=Q1X9gOBk5/i4JCbNOdyusZtw8JFoYrf34rH1gsrqPeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ApwkccZgRIgfyy1SN6yvwWdafM/WC3rAlCOJvnl4t/T8g7hZQP0kb5LZmutzP8LrH
	 qWimecNX4O+9LTTKB0eK5A8N+VZiIIAxE3qOCe4nI5+4z9KkszJZJnVa7TBPc/c1LD
	 jz7zFXCp7+lijSzNDfQgk4ZBbvjGJ/k719issjYPds8CgvLFTGjO6C8IDXJXKMmGOh
	 57VHwafFutiFGHHinEHS+3tZzzENSGw/93zjywb+Iu/gDMtaIcOwC/TW0mxr56tnfl
	 Q5+oZ356WI7tf43B5Ol8GfJz+Q70Obu3fLKQbmHYN0iDvSfRVSgGCpGKAL4ubCgH8V
	 vdkT25g/mV+mQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:57 +0100
Subject: [PATCH v4 39/47] hv: convert mshv_ioctl_create_partition() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-39-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Q1X9gOBk5/i4JCbNOdyusZtw8JFoYrf34rH1gsrqPeY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0fHVj/YLm3q5bIk5fjFQOEAOc5UP6upcXd5+ueff
 7J0Ko9XRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES+nmNkeN4/4U/U/qX2TPqS
 T160JU5gD+xcpVxzeK//g8At23dOzWP4Z/F2LfumpWefBjM/2jZ9SfJT+YUmoeoX5X2jl+XF9zY
 94QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/hv/mshv_root_main.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e3b2bd417c46..8f99be5b54ad 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1871,7 +1871,6 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	union hv_partition_isolation_properties isolation_properties = {};
 	struct mshv_partition *partition;
 	struct file *file;
-	int fd;
 	long ret;
 
 	if (copy_from_user(&args, user_arg, sizeof(args)))
@@ -1938,29 +1937,13 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 		goto delete_partition;
 
 	ret = mshv_init_async_handler(partition);
-	if (ret)
-		goto remove_partition;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto remove_partition;
-	}
-
-	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
-				  partition, O_RDWR);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto put_fd;
+	if (!ret) {
+		ret = FD_ADD(O_CLOEXEC, anon_inode_getfile("mshv_partition",
+							   &mshv_partition_fops,
+							   partition, O_RDWR));
+		if (ret >= 0)
+			return ret;
 	}
-
-	fd_install(fd, file);
-
-	return fd;
-
-put_fd:
-	put_unused_fd(fd);
-remove_partition:
 	remove_partition(partition);
 delete_partition:
 	hv_call_delete_partition(partition->pt_id);

-- 
2.47.3


