Return-Path: <linux-fsdevel+bounces-65888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10228C13996
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 701694FB3A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D282E03F9;
	Tue, 28 Oct 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaG8r5Cw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DC2DAFA1;
	Tue, 28 Oct 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641197; cv=none; b=S8bHqFeWmAa43qNa8dx/gjIUUcJeSaW4+eMUpWDy0tgs2EnmAqwmq+FWjNzPgXqEC0IzxkR8HTy280qsp0Jp+ABP2fE2D8cZlNFNIEDlNxOb4hulNXHqJaG3rKq7i16Oh2oSv9lUqVpYwOa+TNJOLc5Bdmo6IcpZNiVkSTjx/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641197; c=relaxed/simple;
	bh=CqBLua7mC1jnX91nIzWy68mJTdDx9M0GCh7rqkQtFj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBcghZqQgixBjTUF/WIo79Kafwo8fRyuzdZ36zYgXES2RvqSNdOyuuzYJuz2WW3ZqCMCR7w2fFEHBiIyS4H5wpxLQR5hl4zWgfx99v3g2d93rfst5eFDsaBL3VZtIBUtmlBAZUXZVgVQFeG7yc1sGlJZMQT5/Icn3ukNMaqiqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaG8r5Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF5CC4CEE7;
	Tue, 28 Oct 2025 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641197;
	bh=CqBLua7mC1jnX91nIzWy68mJTdDx9M0GCh7rqkQtFj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TaG8r5CwImD2ut7WGFRwKxHNou55SZHOpBjSUdIZ1qoxM7vj+Zw6ZtByujlkjrgJM
	 K4EqIFWMfnEEhCk119s02QqkQtp3es0bRtBqn1rX2fyN/5/JrrR911UleSlspbGxR5
	 MsQgQYWSew3LfjajJ0M0qsnYF3pa+d3vbz/Ksl4poqk9s3CgGxSDVYwjVYfDC0yzoR
	 rE4cMMTB6tuZSeb/beL/RYUskJ7/hN+0dYSM8SxBTfgWznILE3sOpbq3VoYNylGlZ/
	 87thZk5+joxFEMjWNgXiyTjNQh+y0FfD23/SN3FnqYvsW42IitZGiSKM/RqhYOYGIl
	 0qZiRZa1mxUXA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:53 +0100
Subject: [PATCH 08/22] pidfs: expose coredump signal
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-8-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=4285; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CqBLua7mC1jnX91nIzWy68mJTdDx9M0GCh7rqkQtFj4=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkAgsGic1ncXqnT9faYYabTX80a5gw0OGbFlvIbAF3/0UPAc
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkAgsEACgkQkcYbwGV43KLUmAD+LqY5
 B0JB0lVYhW0lcAWiEY7RemBxIpe+xvr7Chw4uU8A/199f95a6vHxn2d5lcYXyfiBXSzsSxRc/Kb
 82zAHt2AM
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Userspace needs access to the signal that caused the coredump before the
coredumping process has been reaped. Expose it as part of the coredump
information in struct pidfd_info. After the process has been reaped that
info is also available as part of PIDFD_INFO_EXIT's exit_code field.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 30 +++++++++++++++++++-----------
 include/uapi/linux/pidfd.h |  7 +++++--
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a3b80be3b98b..354ceb2126e7 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -41,6 +41,7 @@ void pidfs_get_root(struct path *path)
 
 enum pidfs_attr_mask_bits {
 	PIDFS_ATTR_BIT_EXIT	= 0,
+	PIDFS_ATTR_BIT_COREDUMP	= 1,
 };
 
 struct pidfs_attr {
@@ -51,6 +52,7 @@ struct pidfs_attr {
 		__s32 exit_code;
 	};
 	__u32 coredump_mask;
+	__u32 coredump_signal;
 };
 
 static struct rb_root pidfs_ino_tree = RB_ROOT;
@@ -297,7 +299,8 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
 			      PIDFD_INFO_CGROUPID | \
 			      PIDFD_INFO_EXIT | \
 			      PIDFD_INFO_COREDUMP | \
-			      PIDFD_INFO_SUPPORTED_MASK)
+			      PIDFD_INFO_SUPPORTED_MASK | \
+			      PIDFD_INFO_COREDUMP_SIGNAL)
 
 static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -342,9 +345,12 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 
 	if (mask & PIDFD_INFO_COREDUMP) {
-		kinfo.coredump_mask = READ_ONCE(attr->coredump_mask);
-		if (kinfo.coredump_mask)
-			kinfo.mask |= PIDFD_INFO_COREDUMP;
+		if (test_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask)) {
+			smp_rmb();
+			kinfo.mask |= PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
+			kinfo.coredump_mask = attr->coredump_mask;
+			kinfo.coredump_signal = attr->coredump_signal;
+		}
 	}
 
 	task = get_pid_task(pid, PIDTYPE_PID);
@@ -370,6 +376,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 
 			kinfo.coredump_mask = pidfs_coredump_mask(flags);
 			kinfo.mask |= PIDFD_INFO_COREDUMP;
+			/* No coredump actually took place, so no coredump signal. */
 		}
 	}
 
@@ -666,20 +673,21 @@ void pidfs_coredump(const struct coredump_params *cprm)
 {
 	struct pid *pid = cprm->pid;
 	struct pidfs_attr *attr;
-	__u32 coredump_mask = 0;
 
 	attr = READ_ONCE(pid->attr);
 
 	VFS_WARN_ON_ONCE(!attr);
 	VFS_WARN_ON_ONCE(attr == PIDFS_PID_DEAD);
 
-	/* Note how we were coredumped. */
-	coredump_mask = pidfs_coredump_mask(cprm->mm_flags);
-	/* Note that we actually did coredump. */
-	coredump_mask |= PIDFD_COREDUMPED;
+	/* Note how we were coredumped and that we coredumped. */
+	attr->coredump_mask = pidfs_coredump_mask(cprm->mm_flags) |
+			      PIDFD_COREDUMPED;
 	/* If coredumping is set to skip we should never end up here. */
-	VFS_WARN_ON_ONCE(coredump_mask & PIDFD_COREDUMP_SKIP);
-	smp_store_release(&attr->coredump_mask, coredump_mask);
+	VFS_WARN_ON_ONCE(attr->coredump_mask & PIDFD_COREDUMP_SKIP);
+	/* Expose the signal number that caused the coredump. */
+	attr->coredump_signal = cprm->siginfo->si_signo;
+	smp_wmb();
+	set_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask);
 }
 #endif
 
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index e05caa0e00fe..ea9a6811fc76 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -27,6 +27,7 @@
 #define PIDFD_INFO_EXIT			(1UL << 3) /* Only returned if requested. */
 #define PIDFD_INFO_COREDUMP		(1UL << 4) /* Only returned if requested. */
 #define PIDFD_INFO_SUPPORTED_MASK	(1UL << 5) /* Want/got supported mask flags */
+#define PIDFD_INFO_COREDUMP_SIGNAL	(1UL << 6) /* Always returned if PIDFD_INFO_COREDUMP is requested. */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
 #define PIDFD_INFO_SIZE_VER1		72 /* sizeof second published struct */
@@ -94,8 +95,10 @@ struct pidfd_info {
 	__u32 fsuid;
 	__u32 fsgid;
 	__s32 exit_code;
-	__u32 coredump_mask;
-	__u32 __spare1;
+	struct /* coredump info */ {
+		__u32 coredump_mask;
+		__u32 coredump_signal;
+	};
 	__u64 supported_mask;	/* Mask flags that this kernel supports */
 };
 

-- 
2.47.3


