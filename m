Return-Path: <linux-fsdevel+bounces-41529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E466A3128F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 18:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED0F18892BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6DF262D13;
	Tue, 11 Feb 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwXTjjPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879226BD8E;
	Tue, 11 Feb 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294202; cv=none; b=ukbe1swe+ldVosvCyAY4RQHrZ06NhBo7Z750+bw8FrimojqJVqZkCOLJugss9CyFuQ+J/VnUJWs/HBWSWANGJmRL8D+rv6ISmA096BnCN1nhaztnEXT1JctYkySN9nSTQgi5EbphKegRctkNe69tZAwn+0nJd/rSwEuh5kw0W7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294202; c=relaxed/simple;
	bh=pAPTgrfnXSoZKVcf/zXSlQv1TKZzGQsZUR0ixXhVpfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBwUsHdd9FEnGfHiShex3magriTqptD0aO0DcGKmP+mtrN3JkT65InWtuW9U1gWAHjlaCfI/jxo7RMiN0ViO2wNErwUC0EFP/jxzHrqbcSYl6ABhFBUwCga/GE6UR41lZljxdeFTAJKvuwDkkSf27EhNgMikbFhBatw1/JW8zzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwXTjjPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99D5C4CEE5;
	Tue, 11 Feb 2025 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739294201;
	bh=pAPTgrfnXSoZKVcf/zXSlQv1TKZzGQsZUR0ixXhVpfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwXTjjPgUc7O/DHGKUzaChlqmSBulVVa6saFiHzvvhVBGfoNjX/8h/gt0/XUkHzd1
	 ea7UAP/nKA+sNCFx/3TqWzU+m16EhUn73NK4y2TwH+jKXqiUgxrwNFekgYI2pY6PiO
	 aY1ANd/czmji/9wmOf+Ac2byZWifxEif49eWruLUk+DenVyFd5qOZ+h8qWCP4WrBXN
	 p9kpJ/EARRDqxLKIZ3WEFXvDuzSwoWezNbjpr9nFcvVoJZ/mIw1fmattr6AK5hsZ06
	 IFmIlWVWPguiIc8FbOOMJjGJL8ZJ4rRKJrhVYC24eh4BXJhWxOWmOsrOeZ/Vk6nqS3
	 IIo4eWONO5wwA==
From: Christian Brauner <brauner@kernel.org>
To: Zicheng Qu <quzicheng@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	jlayton@kernel.org,
	axboe@kernel.dk,
	joel.granados@kernel.org,
	tglx@linutronix.de,
	viro@zeniv.linux.org.uk,
	hch@lst.de,
	len.brown@intel.com,
	pavel@ucw.cz,
	pengfei.xu@intel.com,
	rafael@kernel.org,
	tanghui20@huawei.com,
	zhangqiao22@huawei.com,
	judy.chenhui@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] acct: perform last write from workqueue
Date: Tue, 11 Feb 2025 18:15:59 +0100
Message-ID: <20250211-work-acct-v1-1-1c16aecab8b3@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
References: <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=7575; i=brauner@kernel.org; h=from:subject:message-id; bh=pAPTgrfnXSoZKVcf/zXSlQv1TKZzGQsZUR0ixXhVpfg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSvbr34u7so/u/LJ4+633gX1dV2nf7icfuuhOp2LY+17 gufB6fId5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkeBsjw7nrLzqyku+3WsTu PqckKRlqtkTM7NJFubKZb7r6jly81M/wT83z98zHrIevXKz/52i1ytza9F9gVfu8x1/FNy1rWSc fwQgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

In [1] it was reported that the acct(2) system call can be used to
trigger NULL deref in cases where it is set to write to a file that
triggers an internal lookup. This can e.g., happen when pointing acc(2)
to /sys/power/resume. At the point the where the write to this file
happens the calling task has already exited and called exit_fs(). A
lookup will thus trigger a NULL-deref when accessing current->fs.

Reorganize the code so that the the final write happens from the
workqueue but with the caller's credentials. This preserves the
(strange) permission model and has almost no regression risk.

This api should stop to exist though.

Reported-by: Zicheng Qu <quzicheng@huawei.com>
Link: https://lore.kernel.org/r/20250127091811.3183623-1-quzicheng@huawei.com [1]
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/acct.c | 120 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 50 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 31222e8cd534..48283efe8a12 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -103,48 +103,50 @@ struct bsd_acct_struct {
 	atomic_long_t		count;
 	struct rcu_head		rcu;
 	struct mutex		lock;
-	int			active;
+	bool			active;
+	bool			check_space;
 	unsigned long		needcheck;
 	struct file		*file;
 	struct pid_namespace	*ns;
 	struct work_struct	work;
 	struct completion	done;
+	acct_t			ac;
 };
 
-static void do_acct_process(struct bsd_acct_struct *acct);
+static void fill_ac(struct bsd_acct_struct *acct);
+static void acct_write_process(struct bsd_acct_struct *acct);
 
 /*
  * Check the amount of free space and suspend/resume accordingly.
  */
-static int check_free_space(struct bsd_acct_struct *acct)
+static bool check_free_space(struct bsd_acct_struct *acct)
 {
 	struct kstatfs sbuf;
 
-	if (time_is_after_jiffies(acct->needcheck))
-		goto out;
+	if (!acct->check_space)
+		return acct->active;
 
 	/* May block */
 	if (vfs_statfs(&acct->file->f_path, &sbuf))
-		goto out;
+		return acct->active;
 
 	if (acct->active) {
 		u64 suspend = sbuf.f_blocks * SUSPEND;
 		do_div(suspend, 100);
 		if (sbuf.f_bavail <= suspend) {
-			acct->active = 0;
+			acct->active = false;
 			pr_info("Process accounting paused\n");
 		}
 	} else {
 		u64 resume = sbuf.f_blocks * RESUME;
 		do_div(resume, 100);
 		if (sbuf.f_bavail >= resume) {
-			acct->active = 1;
+			acct->active = true;
 			pr_info("Process accounting resumed\n");
 		}
 	}
 
 	acct->needcheck = jiffies + ACCT_TIMEOUT*HZ;
-out:
 	return acct->active;
 }
 
@@ -189,7 +191,11 @@ static void acct_pin_kill(struct fs_pin *pin)
 {
 	struct bsd_acct_struct *acct = to_acct(pin);
 	mutex_lock(&acct->lock);
-	do_acct_process(acct);
+	/*
+	 * Fill the accounting struct with the exiting task's info
+	 * before punting to the workqueue.
+	 */
+	fill_ac(acct);
 	schedule_work(&acct->work);
 	wait_for_completion(&acct->done);
 	cmpxchg(&acct->ns->bacct, pin, NULL);
@@ -202,6 +208,9 @@ static void close_work(struct work_struct *work)
 {
 	struct bsd_acct_struct *acct = container_of(work, struct bsd_acct_struct, work);
 	struct file *file = acct->file;
+
+	/* We were fired by acct_pin_kill() which holds acct->lock. */
+	acct_write_process(acct);
 	if (file->f_op->flush)
 		file->f_op->flush(file, NULL);
 	__fput_sync(file);
@@ -430,13 +439,27 @@ static u32 encode_float(u64 value)
  *  do_exit() or when switching to a different output file.
  */
 
-static void fill_ac(acct_t *ac)
+static void fill_ac(struct bsd_acct_struct *acct)
 {
 	struct pacct_struct *pacct = &current->signal->pacct;
+	struct file *file = acct->file;
+	acct_t *ac = &acct->ac;
 	u64 elapsed, run_time;
 	time64_t btime;
 	struct tty_struct *tty;
 
+	lockdep_assert_held(&acct->lock);
+
+	if (time_is_after_jiffies(acct->needcheck)) {
+		acct->check_space = false;
+
+		/* Don't fill in @ac if nothing will be written. */
+		if (!acct->active)
+			return;
+	} else {
+		acct->check_space = true;
+	}
+
 	/*
 	 * Fill the accounting struct with the needed info as recorded
 	 * by the different kernel functions.
@@ -484,64 +507,61 @@ static void fill_ac(acct_t *ac)
 	ac->ac_majflt = encode_comp_t(pacct->ac_majflt);
 	ac->ac_exitcode = pacct->ac_exitcode;
 	spin_unlock_irq(&current->sighand->siglock);
-}
-/*
- *  do_acct_process does all actual work. Caller holds the reference to file.
- */
-static void do_acct_process(struct bsd_acct_struct *acct)
-{
-	acct_t ac;
-	unsigned long flim;
-	const struct cred *orig_cred;
-	struct file *file = acct->file;
-
-	/*
-	 * Accounting records are not subject to resource limits.
-	 */
-	flim = rlimit(RLIMIT_FSIZE);
-	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
-	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds(file->f_cred);
 
-	/*
-	 * First check to see if there is enough free_space to continue
-	 * the process accounting system.
-	 */
-	if (!check_free_space(acct))
-		goto out;
-
-	fill_ac(&ac);
 	/* we really need to bite the bullet and change layout */
-	ac.ac_uid = from_kuid_munged(file->f_cred->user_ns, orig_cred->uid);
-	ac.ac_gid = from_kgid_munged(file->f_cred->user_ns, orig_cred->gid);
+	ac->ac_uid = from_kuid_munged(file->f_cred->user_ns, current_uid());
+	ac->ac_gid = from_kgid_munged(file->f_cred->user_ns, current_gid());
 #if ACCT_VERSION == 1 || ACCT_VERSION == 2
 	/* backward-compatible 16 bit fields */
-	ac.ac_uid16 = ac.ac_uid;
-	ac.ac_gid16 = ac.ac_gid;
+	ac->ac_uid16 = ac->ac_uid;
+	ac->ac_gid16 = ac->ac_gid;
 #elif ACCT_VERSION == 3
 	{
 		struct pid_namespace *ns = acct->ns;
 
-		ac.ac_pid = task_tgid_nr_ns(current, ns);
+		ac->ac_pid = task_tgid_nr_ns(current, ns);
 		rcu_read_lock();
-		ac.ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent),
-					     ns);
+		ac->ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent), ns);
 		rcu_read_unlock();
 	}
 #endif
+}
+
+static void acct_write_process(struct bsd_acct_struct *acct)
+{
+	struct file *file = acct->file;
+	const struct cred *cred;
+	acct_t *ac = &acct->ac;
+
+	/* Perform file operations on behalf of whoever enabled accounting */
+	cred = override_creds(file->f_cred);
+
 	/*
-	 * Get freeze protection. If the fs is frozen, just skip the write
-	 * as we could deadlock the system otherwise.
+	 * First check to see if there is enough free_space to continue
+	 * the process accounting system. Then get freeze protection. If
+	 * the fs is frozen, just skip the write as we could deadlock
+	 * the system otherwise.
 	 */
-	if (file_start_write_trylock(file)) {
+	if (check_free_space(acct) && file_start_write_trylock(file)) {
 		/* it's been opened O_APPEND, so position is irrelevant */
 		loff_t pos = 0;
-		__kernel_write(file, &ac, sizeof(acct_t), &pos);
+		__kernel_write(file, ac, sizeof(acct_t), &pos);
 		file_end_write(file);
 	}
-out:
+
+	revert_creds(cred);
+}
+
+static void do_acct_process(struct bsd_acct_struct *acct)
+{
+	unsigned long flim;
+
+	/* Accounting records are not subject to resource limits. */
+	flim = rlimit(RLIMIT_FSIZE);
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
+	fill_ac(acct);
+	acct_write_process(acct);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	revert_creds(orig_cred);
 }
 
 /**

-- 
2.47.2


