Return-Path: <linux-fsdevel+bounces-47229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F31A9AD50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FBF462F38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E723225DAFC;
	Thu, 24 Apr 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsdinZro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424602580E7;
	Thu, 24 Apr 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497518; cv=none; b=M4MPcn35J+EVonSp/mZKU7MvXThxu6rPdDSzrzvsirVqb8shDNVBYRcTbB9Uki9evS+OwS+pZNBGP38eDBOJzphTCc9Sw6+ceqyY/hketzFH00aqj601yaucTaMSXnPIvm5aoJwDCgOAFv1l3eA57Q9nZhMDFEa1o8MzwbDk93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497518; c=relaxed/simple;
	bh=uwdHfF0zuWFaUykwHH51UXZIlsTqiDAedbt9br9ZKbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tj/lT3I1GJxY9PQuDg0RCHlWdEKD9LlHxPRgHYQCDDeqhneOQQ80r0uWLavsyT5ezrwqiZlKafEnDI3dDxelGhDjk6QXiPj9zaRcEBnmIiAsgFeCVigzpy13oMSxoDHLXICoTWvnYAplVOd8EQI/IZAkSP72JAw/uvf4OZ20R5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsdinZro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DD8C4CEE8;
	Thu, 24 Apr 2025 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745497517;
	bh=uwdHfF0zuWFaUykwHH51UXZIlsTqiDAedbt9br9ZKbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DsdinZroUGNomIbZ9rloX3tK/a+iW5QE8pZptL4/Xw1oNwApIwh1dmgna91hDSkMy
	 7DyccZquXYhG3g4mBJbXTs8CAxzp03r5FjgRunsZDovk2X9ZV7oiFrL0CN95WYCh8A
	 gSm8Oe3uXl0KzIk3F5cT9UBz2jhj2ZMAeEaBpui3qb1A0I7GM1NteaW/oVLz8Qg2aw
	 FR0aLbnU5Clm9Oz1pQD0c63GNdPMAHQ3Q0NbU08mvZjavw/aUYFKDFJHO1/W96AbHS
	 qT6RbEkWPeWRtKo1SFmFyr8z8xC+xQPdA1Wp0wfa7RMkUO24en8seVw0WZZHdNEC8D
	 d2aboEc9HV4mA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Apr 2025 14:24:34 +0200
Subject: [PATCH RFC 1/4] pidfs: register pid in pidfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-work-pidfs-net-v1-1-0dc97227d854@kernel.org>
References: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
In-Reply-To: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uwdHfF0zuWFaUykwHH51UXZIlsTqiDAedbt9br9ZKbo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw6S49vdXRXiXs7J+6w2lZj4su3D35KYB7f0j3/H0Od
 gfFBG6pdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk8ySGf4Z9oSterlQMbX7/
 jr/Q5t9lQ6Zbupts18a+OHZ/rZThh28M/+s6XZqVmyyk9gu8aBNrfdSQy7hxxvEJ3y9cttVjCaz
 w4QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add simple helpers that allow a struct pid to be pinned via a pidfs
dentry/inode. If no pidfs dentry exists a new one will be allocated for
it. A reference is taken by pidfs on @pid. The reference must be
released via pidfs_put_pid().

This will allow AF_UNIX sockets to allocate a dentry for the peer
credentials pid at the time they are recorded where we know the task is
still alive. When the task gets reaped its exit status is guaranteed to
be recorded and a pidfd can be handed for the reaped task.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c            | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h |  3 +++
 2 files changed, 61 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index d64a4cbeb0da..8e6c11774c60 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -896,6 +896,64 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	return pidfd_file;
 }
 
+/**
+ * pidfs_register_pid - pin a struct pid through pidfs
+ * @pid: pid to pin
+ *
+ * Pin a struct pid through pidfs. Needs to be paired with
+ * pidfds_put_put() to not risk leaking the pidfs dentry and inode.
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
+	path.dentry = NULL;
+	return 0;
+}
+
+/**
+ * pidfs_get_pid - pin a struct pid through pidfs
+ * @pid: pid to pin
+ *
+ * Similar to pidfs_register_pid() but only valid if the caller knows
+ * there's a reference to the @pid through its dentry already.
+ */
+void pidfs_get_pid(struct pid *pid)
+{
+	if (!pid)
+		return;
+
+	WARN_ON_ONCE(stashed_dentry_get(&pid->stashed) == NULL);
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
+
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


