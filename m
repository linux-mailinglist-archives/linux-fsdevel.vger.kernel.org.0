Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2066AD6B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbfIIKXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:23:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53247 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390651AbfIIKXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so13162057wmi.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IfO/aFsv9csBvAqLmxPrLHozIhVbgmsUP4z+fLvYLKk=;
        b=lJfo7jVni8HmxsSWeAG1c3uqO1KeWoVPi/W0TZ0bzK7R9ne6ihwnEbCY4QEV66GRyz
         /oklInIRK/cLDGhHPPMJjgG8aUlCQcMM4I4RXFMzEtrIjz7JjHpFdU5vr4NYtNmQ5r3j
         RsPiEgCJIUX6Nw7HnJSqmhNg0pMNlR9drvx9g1FbFs1RROI9s/VCJjS9D+NiaqW/phwJ
         XoTRJy47dlX018UraTK5GAPPLY7dy4rnAGZqip2nB5hJe1qiYoarfrmZ23hKYdqNJftT
         X4wAzBecTiPRZglrkXmWf7kMTeYaFVzXp7RQtW6n/L3UgAmuHhxjTTeihM7H70Snb5lJ
         QEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IfO/aFsv9csBvAqLmxPrLHozIhVbgmsUP4z+fLvYLKk=;
        b=QwDDTcizW0/iah00bKdnm8YrRu6No0Ly+yX7G1qKmyMZHLiVXWLSse8KOB/wU0UaoI
         5uH1nPaeF1jYS5QjhMziEK8dFOf1tma6cAb0U4pram+3R00huskkNyIiS8Mqp+/a0DJ5
         laLERUM3xHQjJvZsLCn5xyCWBi1rDHWXA0PJV9cFphex0mcvn0xomAbVKlK/Y5VoIhvd
         4A7d10GfnBBJhr7n3uqXYJZELEQTy/liOJckVCh5nXuccXIEaSqA0sj4KbFcMhamiFjg
         6wA6XItTwL6zki1A8UiSgYG2jVBUmyD/z2alsezP+F48pSFYVdqiVW0qOW55+50GH6hx
         2H1g==
X-Gm-Message-State: APjAAAUmzgpmuWqspJipI3FAjfSEv0b/phi3i4xlP/V9siTB/2H5IoLH
        zktu+NZB+gCpfVu3GkiVGQl6pQ==
X-Google-Smtp-Source: APXvYqxhTzZ1Fh8C7DgSzqRlLzBHLQAbXCfmJHK6OASTOE6O9Taf1A+yq/zvODVupkbxdtsIx3tznQ==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr17677294wmc.126.1568024632076;
        Mon, 09 Sep 2019 03:23:52 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:51 -0700 (PDT)
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
Subject: [PATCH 6/9] select: Extract common code into do_sys_ppoll()
Date:   Mon,  9 Sep 2019 11:23:37 +0100
Message-Id: <20190909102340.8592-7-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reduce the amount of code and shrink a .text section a bit:
[linux]$ ./scripts/bloat-o-meter -t /tmp/vmlinux.o.{old,new}
add/remove: 1/0 grow/shrink: 0/4 up/down: 284/-691 (-407)
Function                                     old     new   delta
do_sys_ppoll                                   -     284    +284
__x64_sys_ppoll                              214      42    -172
__ia32_sys_ppoll                             213      40    -173
__ia32_compat_sys_ppoll_time64               213      40    -173
__ia32_compat_sys_ppoll_time32               213      40    -173
Total: Before=13357557, After=13357150, chg -0.00%

The downside is that "tsp" and "sigmask" parameters gets (void *),
but it seems worth losing static type checking if there is only one
line in syscall definition.
Other way could be to add compat parameters in do_sys_ppoll(), but
that trashes 2 more registers..

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/select.c | 94 ++++++++++++++++++-----------------------------------
 1 file changed, 32 insertions(+), 62 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 458f2a944318..262300e58370 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1056,54 +1056,58 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 	return ret;
 }
 
-SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
-		struct __kernel_timespec __user *, tsp, const sigset_t __user *, sigmask,
-		size_t, sigsetsize)
+static int do_sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
+			void __user *tsp, const void __user *sigmask,
+			size_t sigsetsize, enum poll_time_type pt_type)
 {
 	struct timespec64 ts, end_time, *to = NULL;
 	int ret;
 
 	if (tsp) {
-		if (get_timespec64(&ts, tsp))
-			return -EFAULT;
+		switch (pt_type) {
+		case PT_TIMESPEC:
+			if (get_timespec64(&ts, tsp))
+				return -EFAULT;
+			break;
+		case PT_OLD_TIMESPEC:
+			if (get_old_timespec32(&ts, tsp))
+				return -EFAULT;
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return -ENOSYS;
+		}
 
 		to = &end_time;
 		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
 			return -EINVAL;
 	}
 
-	ret = set_user_sigmask(sigmask, sigsetsize);
+	if (!in_compat_syscall())
+		ret = set_user_sigmask(sigmask, sigsetsize);
+	else
+		ret = set_compat_user_sigmask(sigmask, sigsetsize);
+
 	if (ret)
 		return ret;
 
 	ret = do_sys_poll(ufds, nfds, to);
-	return poll_select_finish(&end_time, tsp, PT_TIMESPEC, ret);
+	return poll_select_finish(&end_time, tsp, pt_type, ret);
 }
 
-#if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
+SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
+		struct __kernel_timespec __user *, tsp, const sigset_t __user *, sigmask,
+		size_t, sigsetsize)
+{
+	return do_sys_ppoll(ufds, nfds, tsp, sigmask, sigsetsize, PT_TIMESPEC);
+}
 
+#if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
 SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds, unsigned int, nfds,
 		struct old_timespec32 __user *, tsp, const sigset_t __user *, sigmask,
 		size_t, sigsetsize)
 {
-	struct timespec64 ts, end_time, *to = NULL;
-	int ret;
-
-	if (tsp) {
-		if (get_old_timespec32(&ts, tsp))
-			return -EFAULT;
-
-		to = &end_time;
-		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
-			return -EINVAL;
-	}
-
-	ret = set_user_sigmask(sigmask, sigsetsize);
-	if (ret)
-		return ret;
-
-	ret = do_sys_poll(ufds, nfds, to);
-	return poll_select_finish(&end_time, tsp, PT_OLD_TIMESPEC, ret);
+	return do_sys_ppoll(ufds, nfds, tsp, sigmask, sigsetsize, PT_OLD_TIMESPEC);
 }
 #endif
 
@@ -1352,24 +1356,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds,
 	unsigned int,  nfds, struct old_timespec32 __user *, tsp,
 	const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
 {
-	struct timespec64 ts, end_time, *to = NULL;
-	int ret;
-
-	if (tsp) {
-		if (get_old_timespec32(&ts, tsp))
-			return -EFAULT;
-
-		to = &end_time;
-		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
-			return -EINVAL;
-	}
-
-	ret = set_compat_user_sigmask(sigmask, sigsetsize);
-	if (ret)
-		return ret;
-
-	ret = do_sys_poll(ufds, nfds, to);
-	return poll_select_finish(&end_time, tsp, PT_OLD_TIMESPEC, ret);
+	return do_sys_ppoll(ufds, nfds, tsp, sigmask, sigsetsize, PT_OLD_TIMESPEC);
 }
 #endif
 
@@ -1378,24 +1365,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct pollfd __user *, ufds,
 	unsigned int,  nfds, struct __kernel_timespec __user *, tsp,
 	const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
 {
-	struct timespec64 ts, end_time, *to = NULL;
-	int ret;
-
-	if (tsp) {
-		if (get_timespec64(&ts, tsp))
-			return -EFAULT;
-
-		to = &end_time;
-		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
-			return -EINVAL;
-	}
-
-	ret = set_compat_user_sigmask(sigmask, sigsetsize);
-	if (ret)
-		return ret;
-
-	ret = do_sys_poll(ufds, nfds, to);
-	return poll_select_finish(&end_time, tsp, PT_TIMESPEC, ret);
+	return do_sys_ppoll(ufds, nfds, tsp, sigmask, sigsetsize, PT_TIMESPEC);
 }
 
 #endif
-- 
2.23.0

