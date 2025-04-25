Return-Path: <linux-fsdevel+bounces-47325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D353A9C085
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DA416CE11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAE1235348;
	Fri, 25 Apr 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgCxwnr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25DF23278D;
	Fri, 25 Apr 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568703; cv=none; b=d3/0NGOzXNRzS+tJkNoVbIO1eKSiC5kTUcwlyFaWGX3nfk6umDORpjU7M7qWlYiv/r0QlNtE2h7MtL3R3PdoGoh5a2G3UL3izFMn7zZ3WEMWY8HE72Abueyf1qvDA2HRRO1aqAVb39kU+7hTcOi6UWgeLUM9ntrorfuWLEOz87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568703; c=relaxed/simple;
	bh=52iuwbmVFpSuQ7ggO80gZdYLZgDigukVwIvtQCtZJWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTkqYN3j4SjkNd59mieI94/0kXqW71ltxFFrZbH+5D24LYDqQjtgQ6n6g3RgnYgezXplW3+dau6TzkU9G+ucOvnzRYZ1j2ItzINNKuhuLUsxIwMG/51cXR0bH05wbNUxbK/fKRWYbqNGwqwgjt9omodDVM8eRQdPPlGnSfgNme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgCxwnr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA46C4CEEA;
	Fri, 25 Apr 2025 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568702;
	bh=52iuwbmVFpSuQ7ggO80gZdYLZgDigukVwIvtQCtZJWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DgCxwnr0vupw3+H3Ra/Cv6a/rzjqg5J9H9XqOL8qKehpmBUrNhLq/NX3xLVeJPRnE
	 367cx/7f+Y+UNDLz/Mk417VDzte/KLDipaD/xYUDmy7klL7cg2sPwW5K79LIJlqTvu
	 gdk3JhkXN4Wc0Hm99gz6I2noJUsojBJrLS/LPCz+pw+ZQ5U9CETGKI0UFUOQ3J5tfP
	 gApVE/YI45R85EMfDkx8MqLLhD0i4nGq78yyup8trS7+yMpGHTHyEBqg35PMGKs21+
	 u/o/FjTaoeal4uDuY+yEFIHdnLozWNlC7dtrwmgeUy4B8sZsTd0cbaHWGOLz/z5VKv
	 DKfsAKtJ7mxCw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Apr 2025 10:11:30 +0200
Subject: [PATCH v2 1/4] pidfs: register pid in pidfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-work-pidfs-net-v2-1-450a19461e75@kernel.org>
References: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
In-Reply-To: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, David Rheinsberg <david@readahead.eu>, 
 Jan Kara <jack@suse.cz>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Luca Boccassi <bluca@debian.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3009; i=brauner@kernel.org;
 h=from:subject:message-id; bh=52iuwbmVFpSuQ7ggO80gZdYLZgDigukVwIvtQCtZJWI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRwO29V7vkhfvjKybiJjdN4FvzkWvuy1vpSZrfmhR+7v
 sgHFAh/6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIZk9Ghuti6cbJKnPmWXix
 zOdtV12XFh/4sefO2i0nZ0+vYtxX4MLI8EHWb1ddrlVPiiCzX7JnYdRu6ym3RFmTXnP9LLg1d3k
 ZBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add simple helpers that allow a struct pid to be pinned via a pidfs
dentry/inode. If no pidfs dentry exists a new one will be allocated for
it. A reference is taken by pidfs on @pid. The reference must be
released via pidfs_put_pid().

This will allow AF_UNIX sockets to allocate a dentry for the peer
credentials pid at the time they are recorded where we know the task is
still alive. When the task gets reaped its exit status is guaranteed to
be recorded and a pidfd can be handed out for the reaped task.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c            | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h |  3 +++
 2 files changed, 61 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index d64a4cbeb0da..308792d4b11a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -896,6 +896,64 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	return pidfd_file;
 }
 
+/**
+ * pidfs_register_pid - register a struct pid in pidfs
+ * @pid: pid to pin
+ *
+ * Register a struct pid in pidfs. Needs to be paired with
+ * pidfs_put_pid() to not risk leaking the pidfs dentry and inode.
+ *
+ * Return: On success zero, on error a negative error code is returned.
+ */
+int pidfs_register_pid(struct pid *pid)
+{
+	struct path path __free(path_put) = {};
+	int ret;
+
+	might_sleep();
+
+	if (!pid)
+		return 0;
+
+	ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
+	if (unlikely(ret))
+		return ret;
+	/* Keep the dentry and only put the reference to the mount. */
+	path.dentry = NULL;
+	return 0;
+}
+
+/**
+ * pidfs_get_pid - pin a struct pid through pidfs
+ * @pid: pid to pin
+ *
+ * Similar to pidfs_register_pid() but only valid if the caller knows
+ * there's a reference to the @pid through a dentry already that can't
+ * go away.
+ */
+void pidfs_get_pid(struct pid *pid)
+{
+	if (!pid)
+		return;
+	WARN_ON_ONCE(!stashed_dentry_get(&pid->stashed));
+}
+
+/**
+ * pidfs_put_pid - drop a pidfs reference
+ * @pid: pid to drop
+ *
+ * Drop a reference to @pid via pidfs. This is only safe if the
+ * reference has been taken via pidfs_get_pid().
+ */
+void pidfs_put_pid(struct pid *pid)
+{
+	might_sleep();
+
+	if (!pid)
+		return;
+	dput(pid->stashed);
+}
+
 static void pidfs_inode_init_once(void *data)
 {
 	struct pidfs_inode *pi = data;
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 05e6f8f4a026..2676890c4d0d 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -8,5 +8,8 @@ void pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
 void pidfs_exit(struct task_struct *tsk);
 extern const struct dentry_operations pidfs_dentry_operations;
+int pidfs_register_pid(struct pid *pid);
+void pidfs_get_pid(struct pid *pid);
+void pidfs_put_pid(struct pid *pid);
 
 #endif /* _LINUX_PID_FS_H */

-- 
2.47.2


