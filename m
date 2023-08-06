Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA041771739
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 01:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHFXGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 19:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHFXGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 19:06:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B68170B;
        Sun,  6 Aug 2023 16:06:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5232bb5e47bso1538765a12.2;
        Sun, 06 Aug 2023 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691363195; x=1691967995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8J7F1SfsLEfOh6WPX5WiVP+3zeSXbPu22MisWTehAY=;
        b=p8xkpVlrnknOX+87xR9gI5+YHDKYnmAIKhj6ETtoRi79wcpnClkDtBc3CwRYecgZDJ
         VOJFVOoJ2XdYR6wz6DuzCBbTLZLhwvYtvMEH+Xrel2GejbDmjxrieioB1Faf9V0jyIpv
         YqHvx4Evye1rIgHrvc/4KkU23HUESqS7aWZL2qpzFMXs7UO+/5USbtPkkiz7dKRE7I9F
         iLskvR6QG62c4H2lXajdMBSjvMqPgL6yl0xAFYoQdlzFoY+VVqkbfkUx99Ce2NCuecIC
         ae0rZH7rcZo5x6+UhDLFKacCTZWb+qBNku3XngMadrgay2diZM5mlNoM2HfI7haASHav
         Mn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691363195; x=1691967995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8J7F1SfsLEfOh6WPX5WiVP+3zeSXbPu22MisWTehAY=;
        b=bQF2s1q58voa1EV/nXidToquDkwKfxIK+tlxRQdJZaLpPi7Be9cj/M0f5sSiIYfial
         xudRgovX5AYvJcKJV8LiGjwrPC9jyAliTNLivpFLNTWy40JWeAIV03/L7JoJHTAMx3Eq
         Uq2saHp+AKeVXmh7Us67TahrBAddaoEu5gkIrR8O755lqISt+K3MpbwIK2x1H3w1792d
         /jED8tF5X19b0NaJXYc0WcPH9x/DQCn0yUjSnAiUs0sZjmJ2OixjVdkz5hUDBQ356/ad
         T3oguJdMiQtL7PfkJQGgG4Ou0fag0UnDdg/SEvJQg6AY72CE7z+UJMib6Ihgh2c1VKDi
         LxwQ==
X-Gm-Message-State: AOJu0Yy6bGaK/PSMk0xygx+86VqSeopV3Nl2N67IU39pTE5hq9dwSNWn
        kvFpV498bNjTfC3Q5++gWm0=
X-Google-Smtp-Source: AGHT+IFVmOK2lJ8rZeCF0X7ktggRTxgho4SNARvwtY3ibO21kmSDTbHwsPzqbm+5V1i1vp1iZ6wO2Q==
X-Received: by 2002:aa7:d284:0:b0:51e:53eb:88a3 with SMTP id w4-20020aa7d284000000b0051e53eb88a3mr5604490edq.25.1691363195313;
        Sun, 06 Aug 2023 16:06:35 -0700 (PDT)
Received: from f.. (cst-prg-21-219.cust.vodafone.cz. [46.135.21.219])
        by smtp.gmail.com with ESMTPSA id x22-20020aa7cd96000000b0051e26c7a154sm4398501edv.18.2023.08.06.16.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 16:06:34 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: use __fput_sync in close(2)
Date:   Mon,  7 Aug 2023 01:06:27 +0200
Message-Id: <20230806230627.1394689-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Making close(2) delegate fput finalization with task_work_add() runs
into a slowdown (atomics needed to do it) which is artificially worsened
in presence of rseq, which glibc blindly uses if present (and it is
normally present) -- they added a user memory-touching handler into
resume_user_mode_work(), where the thread leaving the kernel lands after
issuing task_work_add() from fput(). Said touching requires a SMAP
round-trip which is quite expensive and it always executes when landing
in the resume routine.

I'm going to write a separate e-mail about the rseq problem later, but
even if it gets sorted out there is still perf to gain (or rather,
overhead to avoid).

Numbers are below in the proposed patch, but tl;dr without CONFIG_RSEQ
making things worse for the stock kernel I see about 7% increase in
ops/s with open+close.

Searching mailing lists for discussions explaining why close(2) was not
already doing this I found a patch with the easiest way out (call
__fput_sync() in filp_close()):
https://lore.kernel.org/all/20150831120525.GA31015@redhat.com/

There was no response to it though.

From poking around there is tons of filp_close() users (including from
close_fd()) and it is unclear to me if they are going to be fine with
such a change.

With the assumption this is not going to work, I wrote my own patch
which adds close_fd_sync() and filp_close_sync().  They are shipped as
dedicated func entry points, but perhaps inlines which internally add a
flag to to the underlying routine would be preferred? Also adding __ in
front would be in line with __fput_sync, but having __filp_close_sync
call  __filp_close looks weird to me.

All that said, if the simpler patch by Oleg Nestero works, then I'm
happy to drop this one. I just would like to see this sorted out,
whichever way.

Thoughts?

============================================================

fs: use __fput_sync in close(2)

close(2) is a special close which guarantees shallow kernel stack,
making delegation to task_work machinery unnecessary. Said delegation is
problematic as it involves atomic ops and interrupt masking trips, none
of which are cheap on x86-64. Forcing close(2) to do it looks like an
oversight in the original work.

Moreover presence of CONFIG_RSEQ adds an additional overhead as fput()
-> task_work_add(..., TWA_RESUME) -> set_notify_resume() makes the
thread returning to userspace land in resume_user_mode_work(), where
rseq_handle_notify_resume takes a SMAP round-trip if rseq is enabled for
the thread (and it is by default with contemporary glibc).

Sample result when benchmarking open1_processes -t 1 from will-it-scale
(that's a open + close loop) + tmpfs on /tmp, running on the Sapphire
Rapid CPU (ops/s):
stock+RSEQ:	1329857
stock-RSEQ:	1421667	(+7%)
patched:	1523521 (+14.5% / +7%) (with / without rseq)

Patched result is the same as it dodges rseq.

As there are numerous close_fd() and filp_close() consumers which may or
may not tolerate __fput_sync() behavior, dedicated routines are added
for close(2).

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file.c               | 20 +++++++++++++++++---
 fs/file_table.c         |  2 --
 fs/open.c               | 21 ++++++++++++++++++---
 include/linux/fdtable.h |  1 +
 include/linux/fs.h      |  1 +
 5 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3fd003a8604f..eedb8a9fb6d2 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -651,7 +651,7 @@ static struct file *pick_file(struct files_struct *files, unsigned fd)
 	return file;
 }
 
-int close_fd(unsigned fd)
+static __always_inline int __close_fd(unsigned fd, bool sync)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -662,9 +662,23 @@ int close_fd(unsigned fd)
 	if (!file)
 		return -EBADF;
 
-	return filp_close(file, files);
+	if (sync)
+		return filp_close_sync(file, files);
+	else
+		return filp_close(file, files);
+}
+
+int close_fd_sync(unsigned fd)
+{
+	return __close_fd(fd, true);
+}
+EXPORT_SYMBOL(close_fd_sync); /* for ksys_close() */
+
+int close_fd(unsigned fd)
+{
+	return __close_fd(fd, false);
 }
-EXPORT_SYMBOL(close_fd); /* for ksys_close() */
+EXPORT_SYMBOL(close_fd);
 
 /**
  * last_fd - return last valid index into fd table
diff --git a/fs/file_table.c b/fs/file_table.c
index fc7d677ff5ad..c7b7fcd7a8b5 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -462,8 +462,6 @@ void fput(struct file *file)
 void __fput_sync(struct file *file)
 {
 	if (atomic_long_dec_and_test(&file->f_count)) {
-		struct task_struct *task = current;
-		BUG_ON(!(task->flags & PF_KTHREAD));
 		__fput(file);
 	}
 }
diff --git a/fs/open.c b/fs/open.c
index e6ead0f19964..e5f03f891977 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1503,7 +1503,7 @@ SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
  * "id" is the POSIX thread ID. We use the
  * files pointer for this..
  */
-int filp_close(struct file *filp, fl_owner_t id)
+static __always_inline int __filp_close(struct file *filp, fl_owner_t id, bool sync)
 {
 	int retval = 0;
 
@@ -1520,12 +1520,27 @@ int filp_close(struct file *filp, fl_owner_t id)
 		dnotify_flush(filp, id);
 		locks_remove_posix(filp, id);
 	}
-	fput(filp);
+	if (sync)
+		__fput_sync(filp);
+	else
+		fput(filp);
 	return retval;
 }
 
+int filp_close_sync(struct file *filp, fl_owner_t id)
+{
+	return __filp_close(filp, id, true);
+}
+EXPORT_SYMBOL(filp_close_sync);
+
+int filp_close(struct file *filp, fl_owner_t id)
+{
+	return __filp_close(filp, id, false);
+}
 EXPORT_SYMBOL(filp_close);
 
+extern unsigned long sysctl_fput_sync;
+
 /*
  * Careful here! We test whether the file pointer is NULL before
  * releasing the fd. This ensures that one clone task can't release
@@ -1533,7 +1548,7 @@ EXPORT_SYMBOL(filp_close);
  */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
-	int retval = close_fd(fd);
+	int retval = close_fd_sync(fd);
 
 	/* can't restart close syscall because file table entry was cleared */
 	if (unlikely(retval == -ERESTARTSYS ||
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..dd3d0505d34b 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -123,6 +123,7 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
+extern int close_fd_sync(unsigned int fd);
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *close_fd_get_file(unsigned int fd);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 562f2623c9c9..300ce66eef0a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2388,6 +2388,7 @@ static inline struct file *file_clone_open(struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
 }
+extern int filp_close_sync(struct file *, fl_owner_t id);
 extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int, int *);
-- 
2.39.2

