Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF41732A506
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442256AbhCBLq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574750AbhCBDuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:50:21 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530FC061756
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 19:49:39 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id j25so9058791qtv.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 19:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ZbL7iDf69hlzwqkc6NzrMLoJvVkzyQ+FvI+vFzZ08d4=;
        b=o9LkyvGY/U8KxGWCyh84kUqsaR8sPxQuYGPQ7Mqef+aMG0/zzi6lCKyHUx5rlmdYIa
         MkLjWk9OGCEuzhdDhrEmNdlaAzkPINRFfZQQbGrAUeQtOJpc/lim2Z9pjqDTaQq4lV0k
         WxcHlmQYxMjzvHb0ggQxD7kM9OH7k6zGFi1FpWYna5oYq/b9u2WsvU5MZAccIRZY+cJL
         Mr+vSRjdYMbRKQZJDC1Msi2vInsX5M1Fv0/2bUuWOueQ0vYWFHXtXxX/6msLPspIQBjM
         y8I/H2d5mBbK5Xe/2T1gpNGKSgKyIdohTuMISC2ApVvfTMi+Z0zEngcG8oh1cO1+RMvj
         95rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ZbL7iDf69hlzwqkc6NzrMLoJvVkzyQ+FvI+vFzZ08d4=;
        b=BUAmHwJENBcINAc4ClhmPli4HQT238rpNJgP5DsY5QawI23ArGxzazUnEil3x4+ehz
         J4ZJKfnsf6tl/QmSkq5wETvrRT130jgbJKbklTgKjoIsccMZigqYdPUyh+7oVqRm2aae
         VbtqYOhSJVaiMWPFYAFmzf5RmrJZpikUtzLuDDsmpMsuHdo99TUIGrfDsRwwmjYxIp9N
         E8ps797acz40RUB1rCDVGx08XZ5sk9V6/AMrVDkYweneM8GvN+NVyXsEUgKIEG1/H8dQ
         QEorfTcdImEvmQmFRAyMde5T08tODrL4HvkBYco/G1Ug/FFHn4XEQsqNvFm96mp+c8gm
         iJrw==
X-Gm-Message-State: AOAM530ksPbMGJIFo4wO7G/9TwlJa4XQZzCMnO63wmrj6WTNnASZY63O
        36aR0lY2iIDOYRA2g6QyB052Q2rSWw8=
X-Google-Smtp-Source: ABdhPJxis0dwyugcQQ1kiO8VHH//AYPG/mIiLh14d/OFo2jEVb750b43cqWKjT1imH/ZcOkvb8EBnMVBXfU=
Sender: "varmam via sendgmr" <varmam@legoland2.mtv.corp.google.com>
X-Received: from legoland2.mtv.corp.google.com ([2620:15c:211:1:21ce:285b:ee78:5f93])
 (user=varmam job=sendgmr) by 2002:a0c:f7d1:: with SMTP id f17mr4150377qvo.38.1614656978519;
 Mon, 01 Mar 2021 19:49:38 -0800 (PST)
Date:   Mon,  1 Mar 2021 19:49:28 -0800
Message-Id: <20210302034928.3761098-1-varmam@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] fs: Improve eventpoll logging to stop indicting timerfd
From:   Manish Varma <varmam@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manish Varma <varmam@google.com>,
        Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
it names them after the underlying file descriptor, and since all
timerfd file descriptors are named "[timerfd]" (which saves memory on
systems like desktops with potentially many timerfd instances), all
wakesources created as a result of using the eventpoll-on-timerfd idiom
are called... "[timerfd]".

However, it becomes impossible to tell which "[timerfd]" wakesource is
affliated with which process and hence troubleshooting is difficult.

This change addresses this problem by changing the way eventpoll and
timerfd file descriptors (and thus the eventpoll-on-timerfd wakesources)
are named:

1) timerfd descriptors are now named "[timerfdN:P]", where N is a
monotonically increasing integer for each timerfd instance created and P
is the command string of the creating process.
2) the top-level per-process eventpoll wakesource is now named "epoll:P"
(instead of just "eventpoll"), where P, again, is the command string of
the creating process
3) individual per-underlying-filedescriptor eventpoll wakesources are
now named "epollitem:P.F", where P is the command string of the creating
process and F is the name of the underlying file descriptor.

All together, that will give us names like the following:

1) timerfd file descriptor: [timerfd14:system_server]
2) eventpoll top-level per-process wakesource: epoll:system_server
3) eventpoll-on-timerfd per-descriptor wakesource:
epollitem:system_server.[timerfd14:system_server]

Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Manish Varma <varmam@google.com>
---
 fs/eventpoll.c | 10 ++++++++--
 fs/timerfd.c   | 11 ++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 185252d8f4c7..af28be4285f8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1451,15 +1451,21 @@ static int ep_create_wakeup_source(struct epitem *epi)
 {
 	struct name_snapshot n;
 	struct wakeup_source *ws;
+	char task_comm_buf[sizeof(current->comm)];
+	char buf[64];
+
+	get_task_comm(task_comm_buf, current);
 
 	if (!epi->ep->ws) {
-		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
+		snprintf(buf, sizeof(buf), "epoll:%s", task_comm_buf);
+		epi->ep->ws = wakeup_source_register(NULL, buf);
 		if (!epi->ep->ws)
 			return -ENOMEM;
 	}
 
 	take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
-	ws = wakeup_source_register(NULL, n.name.name);
+	snprintf(buf, sizeof(buf), "epollitem:%s.%s", task_comm_buf, n.name.name);
+	ws = wakeup_source_register(NULL, buf);
 	release_dentry_name_snapshot(&n);
 
 	if (!ws)
diff --git a/fs/timerfd.c b/fs/timerfd.c
index c5509d2448e3..4249e8c9a38c 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -46,6 +46,8 @@ struct timerfd_ctx {
 	bool might_cancel;
 };
 
+static atomic_t instance_count = ATOMIC_INIT(0);
+
 static LIST_HEAD(cancel_list);
 static DEFINE_SPINLOCK(cancel_lock);
 
@@ -391,6 +393,9 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 {
 	int ufd;
 	struct timerfd_ctx *ctx;
+	char task_comm_buf[sizeof(current->comm)];
+	char file_name_buf[32];
+	int instance;
 
 	/* Check the TFD_* constants for consistency.  */
 	BUILD_BUG_ON(TFD_CLOEXEC != O_CLOEXEC);
@@ -427,7 +432,11 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 
 	ctx->moffs = ktime_mono_to_real(0);
 
-	ufd = anon_inode_getfd("[timerfd]", &timerfd_fops, ctx,
+	instance = atomic_inc_return(&instance_count);
+	get_task_comm(task_comm_buf, current);
+	snprintf(file_name_buf, sizeof(file_name_buf), "[timerfd%d:%s]",
+		 instance, task_comm_buf);
+	ufd = anon_inode_getfd(file_name_buf, &timerfd_fops, ctx,
 			       O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
 	if (ufd < 0)
 		kfree(ctx);
-- 
2.30.0.617.g56c4b15f3c-goog

