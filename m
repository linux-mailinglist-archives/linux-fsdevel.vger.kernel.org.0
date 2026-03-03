Return-Path: <linux-fsdevel+bounces-79224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDCDFKrnpmlWZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:52:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3361F0C74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C7C3305C26A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA9E35BDCF;
	Tue,  3 Mar 2026 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MarP8QcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DE35D5E2;
	Tue,  3 Mar 2026 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545771; cv=none; b=aMv8OyluWDEv8Y2nRl3Avte5p7Og93qThGwYvRXBtrQ7XbwU7GSH5oiUPgqftHLkKudxZLwP4rGaRXT4dA5vd5QOEei/DP6qUHNPeD/UAu2+p+Ue4o5FupUou8mNFDkOH+BhuyOK/1tBBaAxQ3Lp0SIa8eIpQ58KxOuQoeyeT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545771; c=relaxed/simple;
	bh=2s3ijDSMxoTDVKzFWvkN9Jlo/jKZ0E04ThBDqqjO0fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxhTFQurZZ+eGCp2B7ip+2KxYpQ/hgRNG+4kN5S81VF3OT+DSO1FSOER1nQR6VfkTwmzddMHPksnx3U++pSS5Fvn8MG0mL8gUCWcqtzSWWm0X3Q6r491GC0FlLx65QQBHeKZk8naTJPrFZ9HJNg4pRfSdzWTTs7w+RappC4JgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MarP8QcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D41C2BC9E;
	Tue,  3 Mar 2026 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545771;
	bh=2s3ijDSMxoTDVKzFWvkN9Jlo/jKZ0E04ThBDqqjO0fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MarP8QcJaq/s30v4+pGU45MYOTVYQ3wyEUF7c6ZER2/qsRxCOzpbt2a1H+M2benVc
	 qrHFgPuGNuVZWK60moeglRdh/bFv6lFeuSqPlNGV+V9MaZdViGHpF1TqSmVYqIWo8l
	 9AKoysRyOjVN6cnTCe9ce/3/WicnakjwvONVLx8OZoU+FjbBDHXR4aRbaH86hhZ69w
	 V2p2wjDCeG4MOg8A9B3KBwHNUnDXt/OJs1fmekTYu5PoWHIbItkJARDAXWmQUU3WwV
	 i4VsA6pDljLJP6/60MkO+voPXVrzs8SWiqakD88gx8llbezypwAC5+coak7UVQEysz
	 6XhMfOtE38i6w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:15 +0100
Subject: [PATCH RFC DRAFT POC 04/11] fs: notice when init abandons fs
 sharing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-4-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3873; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2s3ijDSMxoTDVKzFWvkN9Jlo/jKZ0E04ThBDqqjO0fg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3Yv51LyFv6kZe16MvF5M8XupOq6R1+bdFrIZNOtP
 xn+c2yZO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby5ysjQ1O8FzO/uvyKtX9W
 7ZMwjml13Rp96kJrQ/wtqQ+7nT8JzmZkuOMr8HvDp5U8vxh6xPKCf53Z+3P5kb/mD9auZV7nte3
 YFC4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: DB3361F0C74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79224-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

PID 1 may choose to stop sharing fs_struct state with us. Either via
unshare(CLONE_FS) or unshare(CLONE_NEWNS). Of course, PID 1 could have
chosen to create arbitrary process trees that all share fs_struct state
via CLONE_FS. This is a strong statement: We only care about PID 1 aka
the thread-group leader so ubthread's fs_struct state doesn't matter.

PID 1 unsharing fs_struct state is a bug. PID 1 relies on various
kthreads to be able to perform work based on its fs_struct state.
Breaking that contract sucks for both sides. So just don't bother with
extra work for this. No sane init system should ever do this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c            | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs_struct.h |  2 ++
 kernel/fork.c             | 14 +++-----------
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 394875d06fd6..ab6826d7a6a9 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -147,6 +147,49 @@ int unshare_fs_struct(void)
 }
 EXPORT_SYMBOL_GPL(unshare_fs_struct);
 
+/*
+ * PID 1 may choose to stop sharing fs_struct state with us.
+ * Either via unshare(CLONE_FS) or unshare(CLONE_NEWNS). Of
+ * course, PID 1 could have chosen to create arbitrary process
+ * trees that all share fs_struct state via CLONE_FS. This is a
+ * strong statement: We only care about PID 1 aka the thread-group
+ * leader so ubthread's fs_struct state doesn't matter.
+ *
+ * PID 1 unsharing fs_struct state is a bug. PID 1 relies on
+ * various kthreads to be able to perform work based on its
+ * fs_struct state. Breaking that contract sucks for both sides.
+ * So just don't bother with extra work for this. No sane init
+ * system should ever do this.
+ */
+static inline bool nullfs_userspace_init(void)
+{
+	struct fs_struct *fs = current->fs;
+
+	if (unlikely(current->pid == 1) && fs != &init_fs) {
+		pr_warn("VFS: Pid 1 stopped sharing filesystem state\n");
+		return true;
+	}
+
+	return false;
+}
+
+struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
+{
+	struct fs_struct *fs;
+
+	fs = current->fs;
+	read_seqlock_excl(&fs->seq);
+	current->fs = new_fs;
+	if (--fs->users)
+		new_fs = NULL;
+	else
+		new_fs = fs;
+	read_sequnlock_excl(&fs->seq);
+
+	nullfs_userspace_init();
+	return new_fs;
+}
+
 /* to be mentioned only in INIT_TASK */
 struct fs_struct init_fs = {
 	.users		= 1,
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..ade459383f92 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -40,6 +40,8 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
+struct fs_struct *switch_fs_struct(struct fs_struct *new_fs);
+
 extern bool current_chrooted(void);
 
 static inline int current_umask(void)
diff --git a/kernel/fork.c b/kernel/fork.c
index 65113a304518..583078c69bbd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3123,7 +3123,7 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
  */
 int ksys_unshare(unsigned long unshare_flags)
 {
-	struct fs_struct *fs, *new_fs = NULL;
+	struct fs_struct *new_fs = NULL;
 	struct files_struct *new_fd = NULL;
 	struct cred *new_cred = NULL;
 	struct nsproxy *new_nsproxy = NULL;
@@ -3200,16 +3200,8 @@ int ksys_unshare(unsigned long unshare_flags)
 
 		task_lock(current);
 
-		if (new_fs) {
-			fs = current->fs;
-			read_seqlock_excl(&fs->seq);
-			current->fs = new_fs;
-			if (--fs->users)
-				new_fs = NULL;
-			else
-				new_fs = fs;
-			read_sequnlock_excl(&fs->seq);
-		}
+		if (new_fs)
+			new_fs = switch_fs_struct(new_fs);
 
 		if (new_fd)
 			swap(current->files, new_fd);

-- 
2.47.3


