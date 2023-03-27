Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FD16CACEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjC0SXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjC0SXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E3C2D5F;
        Mon, 27 Mar 2023 11:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D0AA61472;
        Mon, 27 Mar 2023 18:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12ADC4339C;
        Mon, 27 Mar 2023 18:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679941381;
        bh=fQqYYZBl6thY1SMZV6P0vcEwNdRfXWrP08DeYYxt4Z4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XYk0XCa2T9KN0jiczq2OUcwgvM6ftE5qrh2oytwSHElilB5OysWGRNQKhQHR5+mGF
         26IEnVWANUwnUwUUejP3CJFuY9QY9KT18RUhxOrktdChTF3CrnGzt+Lst6xa1DhdTy
         TM5LaVPZtU7qYU7jDlEi+9tJImyIEi9zoT+I2fBgS+nf/p0gxY1aqip3MDNeGxZ1yl
         gRa+5VWI8JzSO2n7g8oLFaqiYW7KcfZxqhhWWI1TksZ+6WijfOrvJ5usf6Edm/Ovul
         yja1yO7e4XNCUcQLK8gEfx1GsohSQqkvRp4LF6W5wlgMPRqJx4e1susWo32zgXOLnk
         31onql7BRgMVA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 27 Mar 2023 20:22:51 +0200
Subject: [PATCH 1/3] pid: add pidfd_prepare()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-pidfd-file-api-v1-1-5c0e9a3158e4@kernel.org>
References: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
In-Reply-To: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=3959; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fQqYYZBl6thY1SMZV6P0vcEwNdRfXWrP08DeYYxt4Z4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQo3mcI5rrLdWapP9exJC/fi+w7D703fVQ7+eZc1mkeevNl
 TzZO7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIVz/D/6r9W1Vcm3acMmSvOrYq9N
 /bILdeDQf+fINXzUt5wlVfv2Nk+Dxdy89Uh29dOOchWe+XOyY8mTcnVsvdjJVzujJD/5XLHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new helper that allows to reserve a pidfd and allocates a new
pidfd file that stashes the provided struct pid. This will allow us to
remove places that either open code this function or that call
pidfd_create() but then have to call close_fd() because there are still
failure points after pidfd_create() has been called.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/pid.h |  1 +
 kernel/pid.c        | 69 +++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 343abf22092e..b75de288a8c2 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -80,6 +80,7 @@ extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_create(struct pid *pid, unsigned int flags);
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index 3fbc5e46b721..95e7e01574c8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -576,6 +576,56 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
 	return task;
 }
 
+/**
+ * pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
+ * @pid:   the struct pid for which to create a pidfd
+ * @flags: flags of the new @pidfd
+ * @pidfd: the pidfd to return
+ *
+ * Allocate a new file that stashes @pid and reserve a new pidfd number in the
+ * caller's file descriptor table. The pidfd is reserved but not installed yet.
+ *
+ * If this function returns successfully the caller is responsible to either
+ * call fd_install() passing the returned pidfd and pidfd file as arguments in
+ * order to install the pidfd into its file descriptor table or they must use
+ * put_unused_fd() and fput() on the returned pidfd and pidfd file
+ * respectively.
+ *
+ * This function is useful when a pidfd must already be reserved but there
+ * might still be points of failure afterwards and the caller wants to ensure
+ * that no pidfd is leaked into its file descriptor table.
+ *
+ * Return: On success, a reserved pidfd is returned from the function and a new
+ *         pidfd file is returned in the last argument to the function. On
+ *         error, a negative error code is returned from the function and the
+ *         last argument remains unchanged.
+ */
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
+{
+	int pidfd;
+	struct file *pidfd_file;
+
+	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+		return -EINVAL;
+
+	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
+		return -EINVAL;
+
+	pidfd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+	if (pidfd < 0)
+		return pidfd;
+
+	pidfd_file = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
+					flags | O_RDWR | O_CLOEXEC);
+	if (IS_ERR(pidfd_file)) {
+		put_unused_fd(pidfd);
+		return PTR_ERR(pidfd_file);
+	}
+	get_pid(pid); /* held by pidfd_file now */
+	*ret = pidfd_file;
+	return pidfd;
+}
+
 /**
  * pidfd_create() - Create a new pid file descriptor.
  *
@@ -594,20 +644,15 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
  */
 int pidfd_create(struct pid *pid, unsigned int flags)
 {
-	int fd;
+	int pidfd;
+	struct file *pidfd_file;
 
-	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
-		return -EINVAL;
-
-	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
-		return -EINVAL;
-
-	fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
-			      flags | O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		put_pid(pid);
+	pidfd = pidfd_prepare(pid, flags, &pidfd_file);
+	if (pidfd < 0)
+		return pidfd;
 
-	return fd;
+	fd_install(pidfd, pidfd_file);
+	return pidfd;
 }
 
 /**

-- 
2.34.1

