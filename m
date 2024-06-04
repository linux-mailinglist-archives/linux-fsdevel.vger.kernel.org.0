Return-Path: <linux-fsdevel+bounces-20976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D318FBA9B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9067A28AB8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD0314A4D8;
	Tue,  4 Jun 2024 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8k/+m3H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450E12CD98
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522573; cv=none; b=Dj5aLSkM3gIonieujMWUKZdiYMFkUATcIul1KlvgrqpLHjv1tlLShPvqY4HCm9ZNQ+m/Ma69A/AFFnXpTN7QA4Wu4moSC1rypDEGGY2bO/uCJSZhgPPArtQ3oJPDmu+Ol6nlmMj3et8rMFHkVOSx4p4jntx4f3FouGPTbXL0g4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522573; c=relaxed/simple;
	bh=r5L86LKo0SdTsCjI9YO8qd+i5Ww1vAx2jexZe2Csz04=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CjfwULq3CxTYM4hBl3qibLpD7cdUMOFV6fL+McvvsT/1B+L6Dh9pRAZzPd2EFOqY+WwxAfsALzthvlEjV6iuwqJX+2CWsv4bGgli7KQSEJNu71I7SGxXnARr9qsB4jqfdufeLq24DgSvXvKc+8J76ECvGS+dpqET9vKSa1Gl8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8k/+m3H; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df796aaa57dso6885432276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717522570; x=1718127370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jjwPD4TVq3EAmy5AS/FS3mLLstD1BC2BCaYeSVtKmJY=;
        b=B8k/+m3HrZONejieKsZWQTIvuiA2GYX0OiSCQOdEWy5er/+3ecDJgfvofr4v9L+m76
         vjLADnDX01cPND/IGcTWtlZIJ01gZHHWKEStekRWe75o8mCGmc5H4pRnSAQ6iXuFBU3f
         SGe4qSL/t5ey1G7K7j1mC5z/4yeF0UZcMuwoOVyUqKA88s6sm48nG8PQaBb2RR2w43cJ
         LSUB2H8PYHnPn+3YNGxNDJtnAsxmNmgXld0gsJASd+ZdcayG7+EgXLa3als8UWXKa403
         Xf3b5qrSREweyW8NF0DeZL24FNBjgthXiBze1amoEnAEYOPTFYN2Hnc+LuU7Whpt8TfF
         sFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522570; x=1718127370;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjwPD4TVq3EAmy5AS/FS3mLLstD1BC2BCaYeSVtKmJY=;
        b=nC1yxsXtPQg79x0iJOHYbdYwAJgRR0QNHFUobqewcltwUAbNEQBrGdEqbJ9gAC2NqB
         vN5S9pvKnuvrB6QJCgpRbz62zc5CkQPGiI8GAMCulbAWoqmi0QP+OnXKt1RW7iBtLp+A
         eEydSBJTHilOHHgJ93f18nXZQjrenA4f06vuetQ4MLJTIAWabnyxgNg1fFYahgqFs467
         IRRDLfJ+qT+Uok0Qb+TxVEJTJk/y+II6vFaLcxGWlLrS8wtOaa5RnhgwXaB8IfhJ6jb4
         7GUmt0NE7Dy1VaC1oOpEIcP56doXDH8R0o2zqQT9Y4godb5njU2lhy/H4X/MThbS8aSk
         M09Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7AU6+1u+c1NVqyIlqU0VAsC4J2oUWJ4PP/dd3jOhDeL/SSiinxfUkIru/cWrOz0XDeJ6GXmjnP6PtSlJdoLlapigxWu0ikQAD3t+zVQ==
X-Gm-Message-State: AOJu0YyDyndI7H2EjfKiJIHvQsheXemf/pm7kQ1nW4gTsi3X/KUavm1b
	iywoBd8Dcxkgcrw9m2qVNXGGZomsMuxMYfDJjNT+RhI0rR6gjezRZmSuCqCFZhDxLxltTib6N2g
	78aEuhmiTSxs3EvDTab+OFM/F3CysuMS2xA==
X-Google-Smtp-Source: AGHT+IGWZBCkb99CdZemgYb1TH9b4V00EvD9miGhNkE959QFgAV4ufaUIy9yZ7w8/4w6zld/raNyUl/+diRbsxR8fC//NQ==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:b345:5eb0:8af2:5eb0])
 (user=isaacmanjarres job=sendgmr) by 2002:a05:6902:1101:b0:dfa:48f9:186a with
 SMTP id 3f1490d57ef6-dfacab1eaf7mr472276.3.1717522570543; Tue, 04 Jun 2024
 10:36:10 -0700 (PDT)
Date: Tue,  4 Jun 2024 10:36:05 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604173606.998721-1-isaacmanjarres@google.com>
Subject: [PATCH v4] fs: Improve eventpoll logging to stop indicting timerfd
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: saravanak@google.com, Manish Varma <varmam@google.com>, 
	Kelly Rossmoyer <krossmo@google.com>, "Isaac J . Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Manish Varma <varmam@google.com>

timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
it names them after the underlying file descriptor, and since all
timerfd file descriptors are named "[timerfd]" (which saves memory on
systems like desktops with potentially many timerfd instances), all
wakesources created as a result of using the eventpoll-on-timerfd idiom
are called... "[timerfd]".

However, it becomes impossible to tell which "[timerfd]" wakesource is
affliated with which process and hence troubleshooting is difficult.

This change addresses this problem by changing the way eventpoll
wakesources are named:

1) the top-level per-process eventpoll wakesource is now named
"epollN:P" (instead of just "eventpoll"), where N is a unique ID token,
and P is the PID of the creating process.
2) individual per-underlying-file descriptor eventpoll wakesources are
now named "epollitemN:P.F", where N is a unique ID token and P is PID
of the creating process and F is the name of the underlying file
descriptor.

Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Manish Varma <varmam@google.com>
Co-developed-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/base/power/wakeup.c | 10 ++++++++--
 fs/eventpoll.c              | 11 +++++++++--
 include/linux/pm_wakeup.h   |  4 ++--
 3 files changed, 19 insertions(+), 6 deletions(-)

 v1 -> v2:
 - Renamed instance count to wakesource_create_id to better describe
   its purpose.
 - Changed the wakeup source naming convention for wakeup sources
   created by eventpoll to avoid changing the timerfd names.
 - Used the PID of the process instead of the process name for the
   sake of uniqueness when creating wakeup sources.

v2 -> v3:
 - Changed wakeup_source_register() to take in a format string
   and arguments to avoid duplicating code to construct wakeup
   source names.
 - Moved the definition of wakesource_create_id so that it is
   always defined to fix an compilation error.

v3 -> v4:
 - Changed the naming convention for the top-level epoll wakeup
   sources to include an ID for uniqueness. This is needed in
   cases where a process is using two epoll fds.
 - Edited commit log to reflect new changes and add new tags.

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 752b417e8129..86276f904be8 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -209,13 +209,19 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 /**
  * wakeup_source_register - Create wakeup source and add it to the list.
  * @dev: Device this wakeup source is associated with (or NULL if virtual).
- * @name: Name of the wakeup source to register.
+ * @fmt: format string for the wakeup source name
  */
 struct wakeup_source *wakeup_source_register(struct device *dev,
-					     const char *name)
+					     const char *fmt, ...)
 {
 	struct wakeup_source *ws;
 	int ret;
+	char name[128];
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(name, sizeof(name), fmt, args);
+	va_end(args);
 
 	ws = wakeup_source_create(name);
 	if (ws) {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..941df15208a4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -338,6 +338,7 @@ static void __init epoll_sysctls_init(void)
 #define epoll_sysctls_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
 static const struct file_operations eventpoll_fops;
 
 static inline int is_file_epoll(struct file *f)
@@ -1545,15 +1546,21 @@ static int ep_create_wakeup_source(struct epitem *epi)
 {
 	struct name_snapshot n;
 	struct wakeup_source *ws;
+	pid_t task_pid;
+	int id;
+
+	task_pid = task_pid_nr(current);
 
 	if (!epi->ep->ws) {
-		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
+		id = atomic_inc_return(&wakesource_create_id);
+		epi->ep->ws = wakeup_source_register(NULL, "epoll:%d:%d", id, task_pid);
 		if (!epi->ep->ws)
 			return -ENOMEM;
 	}
 
+	id = atomic_inc_return(&wakesource_create_id);
 	take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
-	ws = wakeup_source_register(NULL, n.name.name);
+	ws = wakeup_source_register(NULL, "epollitem%d:%d.%s", id, task_pid, n.name.name);
 	release_dentry_name_snapshot(&n);
 
 	if (!ws)
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 76cd1f9f1365..40972ca262cc 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -100,7 +100,7 @@ extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
 extern struct wakeup_source *wakeup_source_register(struct device *dev,
-						    const char *name);
+						    const char *fmt, ...);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
 extern int wakeup_sources_read_lock(void);
 extern void wakeup_sources_read_unlock(int idx);
@@ -141,7 +141,7 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
 static inline void wakeup_source_remove(struct wakeup_source *ws) {}
 
 static inline struct wakeup_source *wakeup_source_register(struct device *dev,
-							   const char *name)
+							   const char *fmt, ...)
 {
 	return NULL;
 }
-- 
2.45.1.288.g0e0cd299f1-goog


