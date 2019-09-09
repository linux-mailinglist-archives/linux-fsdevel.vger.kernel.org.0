Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAECAD6BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390785AbfIIKYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:24:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38554 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390615AbfIIKXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so13969388wme.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yu1wCZdYIYP1jJvk74CcBZj8+AFMfC/Evvd513Cb5Yg=;
        b=Fb/PZC7J5LnCdiTui3OYvoq5ZKTb0KInKov6ma1riHbkF7BSEr80N1Sof6/BZkmYBd
         oujqoQ9ATVhk8MujF+smYlsQEdOJxS/FxRBYkkd5iRgiNfUoSZrn0ZP3NtnOmly47Ijg
         GfoFBCjsBnidcfeejZKwNFneFR4jfSIwCC+ndnVgzl3mz0HhrcuzKdzYpT92oFxz+JVI
         bQYSvhA1EYI8GsCYuh6uufVHQ2YQQzJeha2PkjOGKtPGNxAnzImagdhYVHAsfwbo9Kgp
         /iiVNAF/n8D5AUMHwEh5Kse3uhCpYRvpPRujBc+bxCmKdWcX4GqKQBfH+ZsVpNPp8Kt0
         cAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yu1wCZdYIYP1jJvk74CcBZj8+AFMfC/Evvd513Cb5Yg=;
        b=Qq29krpHLEECJwe98xJ/HlXTCMjUZ/LuAnj3bUYJ+VLQj90g/QVmc1BP8njgxYAFJ+
         /5Awoyw1ZE5vO5TsC0I+vHKdbBAJjCvME2xoAPAEIgnqm+6B1rSg5LCd0zN/8uWT7UOc
         xLaph6k6FCGGMKF/Je8iCF3ForEyY2bWy5dtuMJ2eh9YxlFUDG0wWyJuNw8OsK777Vvl
         OLe2ASPrNNBZ3tUqIbSe6+GG9/27qDSr7rGeSPwmltGzpTwnlVOxX795rd2ZsFtZGh0q
         Iri3BdV/94xcMto3/ll8UNaC2ch5H9751/NcUMI7oNvErf+DH4OVgslejDaPKtRxbsmU
         a0pQ==
X-Gm-Message-State: APjAAAWK8ANedLTn0NFGQ/Y1jIMkaLhuYZSeWNIvTJ41A3I9/8qYyTnP
        QfCQ0WxO+epf3AawuhluDrTyPQ==
X-Google-Smtp-Source: APXvYqzLItSWebfZaJEphGQJBKCLGY7oWmQJ8incowXbvPbkOUINKisuMYaDsgYg+9c37v7q+MManw==
X-Received: by 2002:a1c:be12:: with SMTP id o18mr8864792wmf.128.1568024633598;
        Mon, 09 Sep 2019 03:23:53 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:53 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] select: Use ktime_t in do_sys_poll() and do_poll()
Date:   Mon,  9 Sep 2019 11:23:38 +0100
Message-Id: <20190909102340.8592-8-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The plan is to store what's left of timeout in restart block as ktime_t
which will be used for futex() and nanosleep() timeouts too. That will
be a value to return with a new ptrace() request API.

Convert end_time argument of do_{sys_,}poll() functions to ktime_t as
a preparation ground for storing ktime_t inside restart_block.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/select.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 262300e58370..4af88feaa2fe 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -854,25 +854,22 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 }
 
 static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
-		   struct timespec64 *end_time)
+		   ktime_t end_time)
 {
 	poll_table* pt = &wait->pt;
-	ktime_t expire, *to = NULL;
+	ktime_t *to = NULL;
 	int timed_out = 0, count = 0;
 	u64 slack = 0;
 	__poll_t busy_flag = net_busy_loop_on() ? POLL_BUSY_LOOP : 0;
 	unsigned long busy_start = 0;
 
 	/* Optimise the no-wait case */
-	if (end_time && !end_time->tv_sec && !end_time->tv_nsec) {
+	if (ktime_compare(ktime_get(), end_time) >= 0) {
 		pt->_qproc = NULL;
 		timed_out = 1;
-	}
-
-	if (end_time && !timed_out) {
-		expire = timespec64_to_ktime(*end_time);
-		to = &expire;
-		slack = select_estimate_accuracy(expire);
+	} else {
+		to = &end_time;
+		slack = select_estimate_accuracy(end_time);
 	}
 
 	for (;;) {
@@ -936,7 +933,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			sizeof(struct pollfd))
 
 static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
-		struct timespec64 *end_time)
+		       ktime_t end_time)
 {
 	struct poll_wqueues table;
 	int err = -EFAULT, fdcount, len;
@@ -1004,16 +1001,15 @@ static long do_restart_poll(struct restart_block *restart_block)
 {
 	struct pollfd __user *ufds = restart_block->poll.ufds;
 	int nfds = restart_block->poll.nfds;
-	struct timespec64 *to = NULL, end_time;
+	ktime_t timeout = 0;
 	int ret;
 
 	if (restart_block->poll.has_timeout) {
-		end_time.tv_sec = restart_block->poll.tv_sec;
-		end_time.tv_nsec = restart_block->poll.tv_nsec;
-		to = &end_time;
+		timeout = ktime_set(restart_block->poll.tv_sec,
+				    restart_block->poll.tv_nsec);
 	}
 
-	ret = do_sys_poll(ufds, nfds, to);
+	ret = do_sys_poll(ufds, nfds, timeout);
 
 	if (ret == -ERESTARTNOHAND) {
 		restart_block->fn = do_restart_poll;
@@ -1025,16 +1021,17 @@ static long do_restart_poll(struct restart_block *restart_block)
 SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		int, timeout_msecs)
 {
-	struct timespec64 end_time, *to = NULL;
+	struct timespec64 end_time;
+	ktime_t timeout = 0;
 	int ret;
 
 	if (timeout_msecs >= 0) {
-		to = &end_time;
-		poll_select_set_timeout(to, timeout_msecs / MSEC_PER_SEC,
+		poll_select_set_timeout(&end_time, timeout_msecs / MSEC_PER_SEC,
 			NSEC_PER_MSEC * (timeout_msecs % MSEC_PER_SEC));
+		timeout = timespec64_to_ktime(end_time);
 	}
 
-	ret = do_sys_poll(ufds, nfds, to);
+	ret = do_sys_poll(ufds, nfds, timeout);
 
 	if (ret == -ERESTARTNOHAND) {
 		struct restart_block *restart_block;
@@ -1060,7 +1057,8 @@ static int do_sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
 			void __user *tsp, const void __user *sigmask,
 			size_t sigsetsize, enum poll_time_type pt_type)
 {
-	struct timespec64 ts, end_time, *to = NULL;
+	struct timespec64 ts, *to = NULL;
+	ktime_t timeout = 0;
 	int ret;
 
 	if (tsp) {
@@ -1078,9 +1076,10 @@ static int do_sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
 			return -ENOSYS;
 		}
 
-		to = &end_time;
-		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
+		to = &ts;
+		if (poll_select_set_timeout(&ts, ts.tv_sec, ts.tv_nsec))
 			return -EINVAL;
+		timeout = timespec64_to_ktime(ts);
 	}
 
 	if (!in_compat_syscall())
@@ -1091,8 +1090,8 @@ static int do_sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
 	if (ret)
 		return ret;
 
-	ret = do_sys_poll(ufds, nfds, to);
-	return poll_select_finish(&end_time, tsp, pt_type, ret);
+	ret = do_sys_poll(ufds, nfds, timeout);
+	return poll_select_finish(to, tsp, pt_type, ret);
 }
 
 SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
-- 
2.23.0

