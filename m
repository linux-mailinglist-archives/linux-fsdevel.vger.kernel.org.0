Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7285A352675
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 07:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhDBF5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 01:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhDBF5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 01:57:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557EC0613E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 22:57:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d1so8261578ybj.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LPDjYVsuuz78ydcsF2TccRXebl6RyftwNS4xQthlRJU=;
        b=AW7AFbFdCw9ZjpwVkLM9vCH4RzMUNjrWeyDwr+/rCz/5buvedH8Y8rVLgFmcvMSqLA
         dsX4p/CXRV3lsUYOi4SeM+902Qecnohw7Bl5hHCHzQLqnpxSu+SGSaAQ6yViYFqHPH9L
         kOdBq+pTBHTuI/1SFKZJtVT0t582Wqz/RNh3uQlO6XEDdRFkBK1fW3TGbgnW1B5cXnpL
         P2OV7pXyMA/Q/TnvS28INtn2OrRrbwOfh7cjke6EUG1Qmsh0n2aEBl7/0fmx0+4Qfk2r
         sU5BBfKHBYivpVDDPDCBj3rz0jpP90iNw5TpaMtJlwEsKfFizFTTTiTVjP4A+FwtAFwJ
         yOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LPDjYVsuuz78ydcsF2TccRXebl6RyftwNS4xQthlRJU=;
        b=Yit/GEyjJsvxIq25Y0d7KJAUoIrCVHGQYdqKrjBpg/XlH9siJ5ICvYWMjBq+XGrDHk
         ZsafXCzn2Q4oV8tNXeIh6n6nFcF41wGWz4OPerNdUOhlQUjvpeQe/s9Hl/UbOnzzMMZ/
         ulAXlRTIgBbflqwd/eZ77hLHtkZ4clNdwZWbObwVmofYweBvSM/k5Atrj3xUWmgkx2hq
         fOqNn0rTtRvyxfThvTpOmpppBoDDe04WDAqXHkqOFTAobQbzZ/6S1OqamSnYFd6Eoj4T
         kP+qWVOs1dx3/NvE5f56340byH/Aar4Tc8Dm1hiB0FYFHHR/Xuh7ZKUwIWbtZMbSdw1T
         +3Kw==
X-Gm-Message-State: AOAM533bt5/pE1QL/qPDiW5lKAlpgzvAIoic31JuQXFT/LQPfD3bo0Jc
        DsYM9jCcKVwayq9LdQMoHjh5Ht7riI4=
X-Google-Smtp-Source: ABdhPJwYotMzhZ8ORbnpzqZuNWOWQ37DFSMdjl0rEsL7ha5ML/+joadSegq1SKDrQJJxJiwlE3ViuaCMC/E=
X-Received: from legoland2.mtv.corp.google.com ([2620:15c:211:1:857d:472:1e7f:a7fe])
 (user=varmam job=sendgmr) by 2002:a25:34d2:: with SMTP id b201mr3432474yba.307.1617343068996;
 Thu, 01 Apr 2021 22:57:48 -0700 (PDT)
Date:   Thu,  1 Apr 2021 22:57:45 -0700
Message-Id: <20210402055745.3690281-1-varmam@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v3] fs: Improve eventpoll logging to stop indicting timerfd
From:   Manish Varma <varmam@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Manish Varma <varmam@google.com>,
        kernel test robot <lkp@intel.com>,
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

This change addresses this problem by changing the way eventpoll
wakesources are named:

1) the top-level per-process eventpoll wakesource is now named "epoll:P"
(instead of just "eventpoll"), where P, is the PID of the creating
process.
2) individual per-underlying-filedescriptor eventpoll wakesources are
now named "epollitemN:P.F", where N is a unique ID token and P is PID
of the creating process and F is the name of the underlying file
descriptor.

All together that should be splitted up into a change to eventpoll and
timerfd (or other file descriptors).

Reported-by: kernel test robot <lkp@intel.com>
Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Manish Varma <varmam@google.com>
---
 drivers/base/power/wakeup.c | 10 ++++++++--
 fs/eventpoll.c              | 10 ++++++++--
 include/linux/pm_wakeup.h   |  4 ++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 01057f640233..3628536c67a5 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -216,13 +216,19 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
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
index 7df8c0fa462b..7c35987a8887 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -312,6 +312,7 @@ struct ctl_table epoll_table[] = {
 };
 #endif /* CONFIG_SYSCTL */
 
+static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
 static const struct file_operations eventpoll_fops;
 
 static inline int is_file_epoll(struct file *f)
@@ -1451,15 +1452,20 @@ static int ep_create_wakeup_source(struct epitem *epi)
 {
 	struct name_snapshot n;
 	struct wakeup_source *ws;
+	pid_t task_pid;
+	int id;
+
+	task_pid = task_pid_nr(current);
 
 	if (!epi->ep->ws) {
-		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
+		epi->ep->ws = wakeup_source_register(NULL, "epoll:%d", task_pid);
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
index aa3da6611533..cb91c84f6f08 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -95,7 +95,7 @@ extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
 extern struct wakeup_source *wakeup_source_register(struct device *dev,
-						    const char *name);
+						    const char *fmt, ...);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
 extern int wakeup_sources_read_lock(void);
 extern void wakeup_sources_read_unlock(int idx);
@@ -137,7 +137,7 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
 static inline void wakeup_source_remove(struct wakeup_source *ws) {}
 
 static inline struct wakeup_source *wakeup_source_register(struct device *dev,
-							   const char *name)
+							   const char *fmt, ...)
 {
 	return NULL;
 }
-- 
2.31.0.208.g409f899ff0-goog

