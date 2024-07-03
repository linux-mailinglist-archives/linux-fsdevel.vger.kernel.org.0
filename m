Return-Path: <linux-fsdevel+bounces-23077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABBF926A9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 23:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5685EB25AED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE359194AF4;
	Wed,  3 Jul 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRAWICxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7672194ACF
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043008; cv=none; b=Xo8iu2O05daZVIbG8kJZG9l/cDlCKMOLqHDG6VejYp8+xNHY6Zt+hkfaC7/PYX3xxCu3RCXnlQZtcIhvtwnhqLDwQjVVysuYUXuaQ1fojhyasWRBOw6HHEfja7XMLVAWLXJPXTTqOo/70gun8We4bVtgckJhBPgIcQXQxBtpgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043008; c=relaxed/simple;
	bh=QJZQw6ZSqVEwm0poAYhchzHWl5s8XhdyW6UMjmB9iCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mrqv9qJYNpbBG83GvKEN+LoXxR8fK5KycKywrCWiWvN34o8xv0YyW5UKOT8iVWO9Hna3PaqdM1bOUmn9h63feeZFj7BHo9T5cG17I0XfNN/6HHO0UtTqHw98UGeb8eJE3qKBj4tjEgo9pcchotVvPsg2/0O20dgH2CCke/GwsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRAWICxb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b7adfb95so10405429276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 14:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720043005; x=1720647805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0CQ1iV3belpw0oH1DMpFMrs2G0AVPQYW7Cuhe77CIo=;
        b=LRAWICxbDvnW5GMPiaHRH+x+4/aDo4qDpGLT9jBx3bJaPYiAD19w2+4/rXh7xfDuVL
         sEDWVFJUwR3tPFpRfz+li75ueLZrX0ecLcA9h0KUrAxvkvia2HrRtNZ1N1qZ6F1/hqLM
         YOVExTU2+F9dEcSl8MppyCd9GgzdjQpYTqDI8fZkoUBNgUvXiraWqvVyvKP4qvbD2rrR
         bMn1AnoXj9ZwxUJRe0ihK5uBpv3g8d3oqDf7Pp2zuoGQgu48x4SxwA1ISeU/gqiytgQF
         3HdGbR0n93dmCUNsyR+IQcELw8gpVKL3pKCmuTLprV8/EP4fMls1lqeUARpTVhGvw6de
         tZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043005; x=1720647805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0CQ1iV3belpw0oH1DMpFMrs2G0AVPQYW7Cuhe77CIo=;
        b=oiCMuUtR73UhlFK5F2fbCGFVBMwLoS367nqgQfCdyZhuvKUOW2+g1LVGnfl79OfoIH
         deud//u5mCf1XIiOkjSbbc0eh1hJQI5KCk4LqHFbv08PbpmAq+3AEq98gA/zMBWAm5NO
         u2mjj5xVurYeukEoeGxYElpAOMlyXU93ql9pyMAUyMwqgka0rr8X82rjYtBOB8gBM2im
         EwXx573qWDruRIdLGzND8uVp6EiksyAxNGiFiyTAYgJfs62DZlbbBCrovfmLsLCGQY+B
         r++36oNjgSEYPPFz1vR8F71Kjqk9SCNHizjMlgKrIrHQZzoBc6GYgoa/iPpQzmRpMEsg
         5V1w==
X-Forwarded-Encrypted: i=1; AJvYcCVk9MAA+qkGnDsYNNDmoVNDXwmkOiMVKWUJDGwewOrg1D9+mvpkQ5Kw20k/johIPAo7GPrNJ1nT64ibn7T/lOtcYu8yWH+uvLR0Bs7Zuw==
X-Gm-Message-State: AOJu0YzrRhWMSkmt5vw09lKBurGy+OpcOlB1yj9Ce3Ur4agxdwKivRlT
	HgNQ25b3lbEJPEuOTCg+m57jXR2tWfhTzpagGNS9XSutz4ZJRvju2+9HkGb3Q19Telew3URUCWL
	GgYF2RlxFiIZEGojrxHoOymgiLfIS7t4ANQ==
X-Google-Smtp-Source: AGHT+IGlouXT+V3VgHYBhXA4cL46EK+nZkHuzWNsJuzw+p8bw5wWNgJbTYGsLAFJrTxtDEFGd7zEPVzUdFB2927csOR1sw==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:77ce:79b0:1f72:f91])
 (user=isaacmanjarres job=sendgmr) by 2002:a25:2f82:0:b0:e03:a0dd:43c1 with
 SMTP id 3f1490d57ef6-e03a0dd47eemr292292276.0.1720043004944; Wed, 03 Jul 2024
 14:43:24 -0700 (PDT)
Date: Wed,  3 Jul 2024 14:43:14 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703214315.454407-1-isaacmanjarres@google.com>
Subject: [PATCH v6] fs: Improve eventpoll logging to stop indicting timerfd
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: tglx@linutronix.de, jstultz@google.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: saravanak@google.com, mjguzik@gmail.com, Manish Varma <varmam@google.com>, 
	Kelly Rossmoyer <krossmo@google.com>, "Isaac J . Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Manish Varma <varmam@google.com>

We'll often see aborted suspend operations that look like:

 PM: suspend entry 2024-07-03 15:55:15.372419634 UTC
 PM: PM: Pending Wakeup Sources: [timerfd]
 Abort: Pending Wakeup Sources: [timerfd]
 PM: suspend exit 2024-07-03 15:55:15.445281857 UTC

From this, it seems a timerfd caused the abort, but that can be
confusing, as timerfds don't create wakeup sources. However,
eventpoll can, and when it does, it names them after the underlying
file descriptor. Unfortunately, all the file descriptors are called
"[timerfd]", and a system may have many timerfds, so this isn't very
useful to debug what's going on to cause the suspend to abort.

To improve this, change the way eventpoll wakeup sources are named:

1) The top-level per-process eventpoll wakeup source is now named
"epollN:P" (instead of just "eventpoll"), where N is a unique ID token,
and P is the PID of the creating process.

2) Individual eventpoll item wakeup sources are now named
"epollitemN:P.F", where N is a unique ID token, P is PID of the creating
process, and F is the name of the underlying file descriptor.

Now, when the scenario described earlier is encountered, the following
kernel logs are emitted:

 PM: suspend entry 2024-07-03 15:39:24.945791824 UTC
 PM: PM: Pending Wakeup Sources: epollitem30:6375.[timerfd]
 Abort: Pending Wakeup Sources: epollitem30:6375.[timerfd]
 PM: suspend exit 2024-07-03 15:39:25.017775019 UTC

There are various benefits to this new naming convention:

1) It is clear that the wakeup source is linked to an eventpoll
item.

2) Now that the PID of the process associated with that timerfd
instance is known, it is easy to map the PID of the process to the
name of the process. With this information, it is easy to start
debugging which process is causing this issue to occur.

3) Even if process 6375 creates multiple timerfd instances, the
ID token is useful in identifying which timerfd instance associated
with the process is causing suspend to abort, as it is monotonically
increasing. So if the order in which the timerfd instances for the
process is known, then one can pinpoint which timerfd instance is
causing this issue.

Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Manish Varma <varmam@google.com>
Co-developed-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/base/power/wakeup.c | 12 +++++++++---
 fs/eventpoll.c              | 11 +++++++++--
 include/linux/pm_wakeup.h   |  8 ++++----
 3 files changed, 22 insertions(+), 9 deletions(-)

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

v4 -> v5:
 - Added the format attribute to the wakeup_source_register()
   function to address a warning from the kernel test robot:
   https://lore.kernel.org/all/202406050504.UvdlPAQ0-lkp@intel.com/

v5 -> v6:
 - Reworded the commit text to clarify the scenarios in which this
   patch is helpful, as per feedback from
   John Stultz <jstultz@google.com>

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 752b417e8129..04a808607b62 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -209,13 +209,19 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 /**
  * wakeup_source_register - Create wakeup source and add it to the list.
  * @dev: Device this wakeup source is associated with (or NULL if virtual).
- * @name: Name of the wakeup source to register.
+ * @fmt: format string for the wakeup source name
  */
-struct wakeup_source *wakeup_source_register(struct device *dev,
-					     const char *name)
+__printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
+							    const char *fmt, ...)
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
index 76cd1f9f1365..1fb6dca981c2 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -99,8 +99,8 @@ extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
-extern struct wakeup_source *wakeup_source_register(struct device *dev,
-						    const char *name);
+extern __printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
+								   const char *fmt, ...);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
 extern int wakeup_sources_read_lock(void);
 extern void wakeup_sources_read_unlock(int idx);
@@ -140,8 +140,8 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
 
 static inline void wakeup_source_remove(struct wakeup_source *ws) {}
 
-static inline struct wakeup_source *wakeup_source_register(struct device *dev,
-							   const char *name)
+static inline __printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
+									  const char *fmt, ...)
 {
 	return NULL;
 }
-- 
2.45.2.803.g4e1b14247a-goog


