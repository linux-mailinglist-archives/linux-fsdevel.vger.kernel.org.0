Return-Path: <linux-fsdevel+bounces-79540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECXVIloUqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:40:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D321966C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4EE3174935
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4C636A03F;
	Thu,  5 Mar 2026 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxmOqqOZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518936A038;
	Thu,  5 Mar 2026 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753459; cv=none; b=dM3Vh4I65TsUm/BlOLXgDJKLJJrjAUw+MecPJ5ABZhNR+sXK46cdE9RJOlIAAf66Cx0KlapHmGTugxm2R7Hw4H4s8se6MVKd0gZZ045Ffgl+woSQmpdwjXGUQL4CQT542qo0v099fHq1PaCFWExhQuFDGX8DG4cmVbj3whcncm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753459; c=relaxed/simple;
	bh=CxiEn+MM2rptr8k5IIMhRN3g6s/m7W7DJGjcdX1OEQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX+NQI6hfngRRup2joXVwD2xbk7Pr21Fq79GOiVuFrnFVvbbAvpzVn0AdCvo5KPRvZUopORxykMiugWDwWDw8sI69bC+oe4NZTa4KXqCnMgkvLvmLWtDQuoWBpA82dwA9AAjq8oXqp9er7XpeU6U0RJVn0w3xWgbD7+u4qAriP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxmOqqOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F18AC116C6;
	Thu,  5 Mar 2026 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753459;
	bh=CxiEn+MM2rptr8k5IIMhRN3g6s/m7W7DJGjcdX1OEQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rxmOqqOZ6GQrUn7s5e3NZtxCugLyq2GvRsUZnP4PiywprWdu0jjT051qWEgUPCRa3
	 MV1FD+jdRxnL/QttQN7kewXb11iJm3jI8rruikyOfwa3Vy5Qa3yG/Zazr+GqZSn03m
	 JjueehfLOCDNL4lWujFsgMxl/rMHOmyXMOkyyc1roP5T9yd1lFHobvm0qTmFpN7Vf7
	 QUwniNX00hqR3I1OF/MpG65FrhndITaC7IcdfVEsSpwGPpEjNPn/rvhJedPS4GyO0O
	 iFHrKcnqVhcmBwCT27xzn0u0YTqp+CnCwKtnyQwWlRsV/KlTTc6VrCGwMZ8NkPXqVQ
	 MaFmMcAgUX6Kw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:18 +0100
Subject: [PATCH RFC v2 15/23] fs: add real_fs to track task's actual
 fs_struct
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-15-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4125; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CxiEn+MM2rptr8k5IIMhRN3g6s/m7W7DJGjcdX1OEQw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuLidPQ4ejrN5MBR/9upc3g7HNL3yHX83Phq7VxFD
 oOuso2vOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyXp6R4Tkfx7k9N0VD135M
 vszyolLGYvc9880bL/gaNva0TXvzdgojw8bzVc4N4k+0jrDp3VIWLYzYqnd6bkAPZ5eZpaH2s/9
 3eAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 158D321966C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79540-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a real_fs field to task_struct that always mirrors the fs field.
This lays the groundwork for distinguishing between a task's permanent
fs_struct and one that is temporarily overridden via scoped_with_init_fs().

When a kthread temporarily overrides current->fs for path lookup, we
need to know the original fs_struct for operations like exit_fs() and
unshare_fs_struct() that must operate on the real, permanent fs.

For now real_fs is always equal to fs. It is maintained alongside fs in
all the relevant paths: exit_fs(), unshare_fs_struct(),
switch_fs_struct(), and copy_fs().

Also fix the argument passed to nullfs_userspace_init() in
switch_fs_struct(): pass the old fs_struct itself rather than the
conditional return value which is NULL when other users still hold
a reference, ensuring the PID 1 unshare detection actually works.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c        | 10 +++++++---
 include/linux/sched.h |  1 +
 init/init_task.c      |  1 +
 kernel/fork.c         |  4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 3ff79fb894c1..b9b9a327f299 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -89,12 +89,13 @@ void free_fs_struct(struct fs_struct *fs)
 
 void exit_fs(struct task_struct *tsk)
 {
-	struct fs_struct *fs = tsk->fs;
+	struct fs_struct *fs = tsk->real_fs;
 
 	if (fs) {
 		int kill;
 		task_lock(tsk);
 		read_seqlock_excl(&fs->seq);
+		tsk->real_fs = NULL;
 		tsk->fs = NULL;
 		kill = !--fs->users;
 		read_sequnlock_excl(&fs->seq);
@@ -126,7 +127,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 
 int unshare_fs_struct(void)
 {
-	struct fs_struct *fs = current->fs;
+	struct fs_struct *fs = current->real_fs;
 	struct fs_struct *new_fs = copy_fs_struct(fs);
 	int kill;
 
@@ -135,8 +136,10 @@ int unshare_fs_struct(void)
 
 	task_lock(current);
 	read_seqlock_excl(&fs->seq);
+	VFS_WARN_ON_ONCE(fs != current->fs);
 	kill = !--fs->users;
 	current->fs = new_fs;
+	current->real_fs = new_fs;
 	read_sequnlock_excl(&fs->seq);
 	task_unlock(current);
 
@@ -177,13 +180,14 @@ struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
 
 	fs = current->fs;
 	read_seqlock_excl(&fs->seq);
+	VFS_WARN_ON_ONCE(current->fs != current->real_fs);
 	current->fs = new_fs;
+	current->real_fs = new_fs;
 	if (--fs->users)
 		new_fs = NULL;
 	else
 		new_fs = fs;
 	read_sequnlock_excl(&fs->seq);
-
 	nullfs_userspace_init(fs);
 	return new_fs;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a7b4a980eb2f..5c7b9df92ebb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1179,6 +1179,7 @@ struct task_struct {
 	unsigned long			last_switch_time;
 #endif
 	/* Filesystem information: */
+	struct fs_struct		*real_fs;
 	struct fs_struct		*fs;
 
 	/* Open file information: */
diff --git a/init/init_task.c b/init/init_task.c
index 5c838757fc10..7d0b4a5927eb 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -152,6 +152,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	RCU_POINTER_INITIALIZER(cred, &init_cred),
 	.comm		= INIT_TASK_COMM,
 	.thread		= INIT_THREAD,
+	.real_fs	= &init_fs,
 	.fs		= &init_fs,
 	.files		= &init_files,
 #ifdef CONFIG_IO_URING
diff --git a/kernel/fork.c b/kernel/fork.c
index 583078c69bbd..73f4ed82f656 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1593,6 +1593,8 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 {
 	struct fs_struct *fs = current->fs;
+
+	VFS_WARN_ON_ONCE(current->fs != current->real_fs);
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		read_seqlock_excl(&fs->seq);
@@ -1605,7 +1607,7 @@ static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 		read_sequnlock_excl(&fs->seq);
 		return 0;
 	}
-	tsk->fs = copy_fs_struct(fs);
+	tsk->real_fs = tsk->fs = copy_fs_struct(fs);
 	if (!tsk->fs)
 		return -ENOMEM;
 	return 0;

-- 
2.47.3


