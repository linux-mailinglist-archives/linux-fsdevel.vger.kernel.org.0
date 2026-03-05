Return-Path: <linux-fsdevel+bounces-79526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFm9LTASqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:30:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E86C21948A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A06305D1EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793BE36827E;
	Thu,  5 Mar 2026 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoUpDN7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE5367F5C;
	Thu,  5 Mar 2026 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753424; cv=none; b=bu+OgYo3csulndn/XrK1vzjk5JokevdflfmXlYIRPvMWLt1awCfudohT1FaxlTF68a7Ow6BCA5WOV7lIIF5Qu40bAHjNtE2+t1oH2ZMWSO5QjDtEsW1x7hJf8ecm0RL0R1Kic9XT0CeeLx6Zifbj9aziFrMcAqUR4/dqQVMCFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753424; c=relaxed/simple;
	bh=ihMLt71nK319mbuBMwuGH7uvgLVHRHqUMc328AWSJvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbchsArgLWQEm8YHzil073C3BJEiWjjpXUB21Q3AnKXpQ/TnDZTHn/yYDXAyDzY9PM6Zojv69Hu7QsTBrBgVc+DFaIF5G+M2dYD3FsINgY0P4QiNKBMWkyW2tjg/7uxQkljCF/itZN49ITM58S/whBKdBthKP+NUX7xErHZt4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoUpDN7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BC9C116C6;
	Thu,  5 Mar 2026 23:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753423;
	bh=ihMLt71nK319mbuBMwuGH7uvgLVHRHqUMc328AWSJvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MoUpDN7u+l9nXcomHZs3cPKTQpjOaxOurl0VAxMssPKEXp8LZiXaCRDNARwUdqVzh
	 kelNP1OZaE8NlzF9qyOgonlafJcY6367WOaBzihM0/nAxEdNLFUiTOoNZE7XQi04m4
	 XZFuzEhb8jjbny9OH0XgOSY69eHa46q+DeeMP0xC0eF1waDbTLvHDW6XanYPZapaf1
	 IOd3dfAinSnBwejiyV66TwcXW7dMH/LUvgLkkrsQq/RA1YZNuwmCQRp87oXupuz9f9
	 K7oeNO5ybFOVdVNQsg4MzwtmvWUFZW908FMisHRwdilLc9ZNUSFXwEVDQrjucjW7WA
	 RrlZg31/aUdvA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:04 +0100
Subject: [PATCH RFC v2 01/23] fs: notice when init abandons fs sharing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-1-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3901; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ihMLt71nK319mbuBMwuGH7uvgLVHRHqUMc328AWSJvE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuK0faOquWPVh63WomzFXz9a/X1Xmfn2z9eiO5HZS
 Rr/ujgvd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE6RjDP6vtr2rifqbJn9Ll
 kOnjcn6on2ayW+XIgrquPe+/pt7vW87wh9P0RfoElUhfL33XHfv9V8xd82r9Z9nCzZw77MJ+2C9
 yZgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 2E86C21948A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79526-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

PID 1 may choose to stop sharing fs_struct state with us. Either via
unshare(CLONE_FS) or unshare(CLONE_NEWNS). Of course, PID 1 could have
chosen to create arbitrary process trees that all share fs_struct state
via CLONE_FS. This is a strong statement: We only care about PID 1 aka
the thread-group leader so subthread's fs_struct state doesn't matter.

PID 1 unsharing fs_struct state is a bug. PID 1 relies on various
kthreads to be able to perform work based on its fs_struct state.
Breaking that contract sucks for both sides. So just don't bother with
extra work for this. No sane init system should ever do this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c            | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fs_struct.h |  2 ++
 kernel/fork.c             | 14 +++-----------
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 394875d06fd6..3ff79fb894c1 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -147,6 +147,47 @@ int unshare_fs_struct(void)
 }
 EXPORT_SYMBOL_GPL(unshare_fs_struct);
 
+/*
+ * PID 1 may choose to stop sharing fs_struct state with us.
+ * Either via unshare(CLONE_FS) or unshare(CLONE_NEWNS). Of
+ * course, PID 1 could have chosen to create arbitrary process
+ * trees that all share fs_struct state via CLONE_FS. This is a
+ * strong statement: We only care about PID 1 aka the thread-group
+ * leader so subthread's fs_struct state doesn't matter.
+ *
+ * PID 1 unsharing fs_struct state is a bug. PID 1 relies on
+ * various kthreads to be able to perform work based on its
+ * fs_struct state. Breaking that contract sucks for both sides.
+ * So just don't bother with extra work for this. No sane init
+ * system should ever do this.
+ */
+static inline void nullfs_userspace_init(struct fs_struct *old_fs)
+{
+	if (likely(current->pid != 1))
+		return;
+	/* @old_fs may be dangling but for comparison it's fine */
+	if (old_fs != &init_fs)
+		return;
+	pr_warn("VFS: Pid 1 stopped sharing filesystem state\n");
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
+	nullfs_userspace_init(fs);
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


