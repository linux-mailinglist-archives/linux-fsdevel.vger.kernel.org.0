Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C515F62A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 10:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiJFI23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJFI1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:27:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3942BE3A
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 01:27:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 10so1149291pli.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6chMDy7sdAp7fbcB3rx+WX3mNPHiNX0s/cFRhM3ieOg=;
        b=LEDgMUcWBRzmi9Mo0+9qOenVfeL77iuZJWbz/l6KBHO9OnXx6oo4g63CPC4mRrRTek
         VdFOJa1Yb5jMjiimaPf2n+eeRbuQO4DDWl5V+/M07tajLIckBZFpcXq+ubCsS3ZX/aht
         M8noy9tEF8k2Cvub9V50VkmCeEeuaJzybH8cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6chMDy7sdAp7fbcB3rx+WX3mNPHiNX0s/cFRhM3ieOg=;
        b=kp/H2w1TKqEnfYRGbq5JujZgL+txTcLVlSi9344rvtT8AoYBCa3QnkBbezMrq4yUdo
         jhDw3uDuyi62HEdBnKJKcS6/RbEjtm2Xwk233yLoSewJHdyLSaohh1jO0JuBKQoWJeKW
         Ml94/lotDcu3HVh9oMzKLge9qsXQDD+IURDnhPuafmb6Q5l0BXjdR8vwLwCCG15u/8ir
         TGaY/1uuqAWKl6rWH8LAbzMTwni+2Fu2kbSGwB1vefNWAd61M2gB/WY3ITY2635Ez9RL
         vrUu3GZB6kkmRftVFf3ytA5YEZVqzQ6WOHV10J9vanOGq9vPmZQUsINFvtv89HV9dVnW
         0jdg==
X-Gm-Message-State: ACrzQf1pjDpG6R4yidMxmf1Pp7soH5c4TXJDcU0rmdX/xjRFjdamSjaZ
        LVasU+fJxPpe2B4ExeP1c8j9nA==
X-Google-Smtp-Source: AMsMyM651YYuwVyNy7b2zv0p60OW0W4RrTSUf6wg1C/eAbw9LtHIICPLS8y24ano7++OQg+BAuWoUA==
X-Received: by 2002:a17:90b:4b03:b0:20a:c33f:ca47 with SMTP id lx3-20020a17090b4b0300b0020ac33fca47mr4129164pjb.10.1665044861286;
        Thu, 06 Oct 2022 01:27:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902c40600b0017f8094a52asm2330200plk.29.2022.10.06.01.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 01:27:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
Date:   Thu,  6 Oct 2022 01:27:34 -0700
Message-Id: <20221006082735.1321612-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006082735.1321612-1-keescook@chromium.org>
References: <20221006082735.1321612-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8132; h=from:subject; bh=pn442Q+K4NVJzK4Ogn1OJE0Kf/fr+fLN7d/sv7w7wIQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjPpF3G5PQJoJ0+WU4egcCbptwwSoJJwtYzGLz8/uw x6+wiOSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYz6RdwAKCRCJcvTf3G3AJjwwD/ 9AqmiFkR2fsSZYPEIflwSZT7OI5y0/NnvllzZijYCc4qJTyuATyZSV+rAw52JGZI+UqhwIWo7Rw3tL 0W6e8cdMFRts0lRnFAPBRbdCsvl/YhcO97MwHkXJiO8t7lYOJ49tSGrhJYFwb3zq1CihY8b5VjSGVK ynVnjgw0Aoj4C7QEy470dR/keFQc7ubnCJGalsUwSmj3oT/WleAcuy4/N4YretzlLd/s0OYeU7oGzc CP/TmfFOPNaB4UkhfILY+ZcowRsqvPz4GX1CF0syEVrwtJcmQd5H8N60VDdQfc4Ge2p07/ysSRog3W VSb84rDk8sqk3Vx3lj3cK2Z7Z60xZZ7cG9+PsJjD6EasD3k/3MQAOzFZLqlhMr72dSbuYf3V1M70xJ 8dliwMLT2aH74NOjxeLjMWsO+JJYjnmOabVIvFRzSTU3zlNwm0vu7JJX6W/MAfHjtVsDCDyDde4c3A Kqn9wIBt2UjMVZCorgxKTKEj8LHwC5OdxCNdtbIAnB4YqGdsNmQbWpwX45m4i6Yl3XLbFVbSzNT5xC 3939YiCArJArhAqIkw8Fk0jRBqH1ogvt1e6kNTuu94/O5w/TRidPhivZndR2gjgX4PTr5duo/9VGSq kciNr8P/ei//btCcC+4kU3tOLQ15QtK11gc5XyK8JReuFgDI99wTCnGabozQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The check_unsafe_exec() counting of n_fs would not add up under a heavily
threaded process trying to perform a suid exec, causing the suid portion
to fail. This counting error appears to be unneeded, but to catch any
possible conditions, explicitly unshare fs_struct on exec, if it ends up
needing to happen. This means fs->in_exec must be removed (since it would
never get cleared in the old copy), and is specifically no longer needed.

See also commit 498052bba55e ("New locking/refcounting for fs_struct").

This additionally allows the "in_exec" member to be dropped, showing an
8 bytes savings per fs_struct on 64-bit. Before:

struct fs_struct {
        int                        users;                /*     0     4 */
        spinlock_t                 lock;                 /*     4     4 */
        seqcount_spinlock_t        seq;                  /*     8     4 */
        int                        umask;                /*    12     4 */
        int                        in_exec;              /*    16     4 */

        /* XXX 4 bytes hole, try to pack */

        struct path                root;                 /*    24    16 */
        struct path                pwd;                  /*    40    16 */

        /* size: 56, cachelines: 1, members: 7 */
        /* sum members: 52, holes: 1, sum holes: 4 */
        /* last cacheline: 56 bytes */
};

After:

struct fs_struct {
        int                        users;                /*     0     4 */
        spinlock_t                 lock;                 /*     4     4 */
        seqcount_spinlock_t        seq;                  /*     8     4 */
        int                        umask;                /*    12     4 */
        struct path                root;                 /*    16    16 */
        struct path                pwd;                  /*    32    16 */

        /* size: 48, cachelines: 1, members: 6 */
        /* last cacheline: 48 bytes */
};

Reported-by: Jorge Merlino <jorge.merlino@canonical.com>
Link: https://lore.kernel.org/lkml/20220910211215.140270-1-jorge.merlino@canonical.com/
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner (Microsoft)" <brauner@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c                 |  9 +++---
 fs/fs_struct.c            |  1 -
 include/linux/fdtable.h   |  1 +
 include/linux/fs_struct.h |  1 -
 kernel/fork.c             | 62 ++++++++++++++++++++++++++-------------
 5 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 902bce45b116..7d5f63f03c58 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1272,6 +1272,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	/* Ensure the fs_struct is not shared. */
+	retval = unshare_fs();
+	if (retval)
+		goto out;
+
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
 	 * not visible until then. This also enables the update
@@ -1583,8 +1588,6 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 
 	if (p->fs->users > n_fs)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
-	else
-		p->fs->in_exec = 1;
 	spin_unlock(&p->fs->lock);
 }
 
@@ -1843,7 +1846,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 		goto out;
 
 	/* execve succeeded */
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
 	acct_update_integrals(current);
@@ -1861,7 +1863,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 		force_fatal_sig(SIGSEGV);
 
 out_unmark:
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
 	return retval;
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 04b3f5b9c629..c27c67023d01 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -115,7 +115,6 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 	/* We don't need to lock fs - think why ;-) */
 	if (fs) {
 		fs->users = 1;
-		fs->in_exec = 0;
 		spin_lock_init(&fs->lock);
 		seqcount_spinlock_init(&fs->seq, &fs->lock);
 		fs->umask = old->umask;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..fbfb89ee3bda 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -117,6 +117,7 @@ struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
 int unshare_files(void);
+int unshare_fs(void);
 struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 783b48dedb72..08b82a90ceae 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -11,7 +11,6 @@ struct fs_struct {
 	spinlock_t lock;
 	seqcount_spinlock_t seq;
 	int umask;
-	int in_exec;
 	struct path root, pwd;
 } __randomize_layout;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index b4a799d9c50f..53b7248f7a4b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1589,10 +1589,6 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
-		if (fs->in_exec) {
-			spin_unlock(&fs->lock);
-			return -EAGAIN;
-		}
 		fs->users++;
 		spin_unlock(&fs->lock);
 		return 0;
@@ -3070,10 +3066,9 @@ static int check_unshare_flags(unsigned long unshare_flags)
 	return 0;
 }
 
-/*
- * Unshare the filesystem structure if it is being shared
- */
-static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
+/* Allocate an fs_struct if it is currently shared and CLONE_FS requested. */
+static int unshare_fs_alloc(unsigned long unshare_flags,
+			    struct fs_struct **new_fsp)
 {
 	struct fs_struct *fs = current->fs;
 
@@ -3091,6 +3086,41 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 	return 0;
 }
 
+/* Swap out fs_struct, returning old fs if it needs freeing. */
+static void unshare_fs_finalize(struct fs_struct **new_fsp)
+{
+	struct task_struct *task = current;
+	struct fs_struct *fs = task->fs;
+
+	spin_lock(&fs->lock);
+	task->fs = *new_fsp;
+	if (--fs->users)
+		*new_fsp = NULL;
+	else
+		*new_fsp = fs;
+	spin_unlock(&fs->lock);
+}
+
+/*
+ * Unshare the filesystem structure if it is being shared
+ */
+int unshare_fs(void)
+{
+	struct fs_struct *new_fs = NULL;
+	int error;
+
+	error = unshare_fs_alloc(CLONE_FS, &new_fs);
+	if (error || !new_fs)
+		return error;
+
+	unshare_fs_finalize(&new_fs);
+
+	if (new_fs)
+		free_fs_struct(new_fs);
+
+	return 0;
+}
+
 /*
  * Unshare file descriptor table if it is being shared
  */
@@ -3120,7 +3150,7 @@ int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
  */
 int ksys_unshare(unsigned long unshare_flags)
 {
-	struct fs_struct *fs, *new_fs = NULL;
+	struct fs_struct *new_fs = NULL;
 	struct files_struct *new_fd = NULL;
 	struct cred *new_cred = NULL;
 	struct nsproxy *new_nsproxy = NULL;
@@ -3159,7 +3189,7 @@ int ksys_unshare(unsigned long unshare_flags)
 	 */
 	if (unshare_flags & (CLONE_NEWIPC|CLONE_SYSVSEM))
 		do_sysvsem = 1;
-	err = unshare_fs(unshare_flags, &new_fs);
+	err = unshare_fs_alloc(unshare_flags, &new_fs);
 	if (err)
 		goto bad_unshare_out;
 	err = unshare_fd(unshare_flags, NR_OPEN_MAX, &new_fd);
@@ -3197,16 +3227,8 @@ int ksys_unshare(unsigned long unshare_flags)
 
 		task_lock(current);
 
-		if (new_fs) {
-			fs = current->fs;
-			spin_lock(&fs->lock);
-			current->fs = new_fs;
-			if (--fs->users)
-				new_fs = NULL;
-			else
-				new_fs = fs;
-			spin_unlock(&fs->lock);
-		}
+		if (new_fs)
+			unshare_fs_finalize(&new_fs);
 
 		if (new_fd)
 			swap(current->files, new_fd);
-- 
2.34.1

