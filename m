Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A622BC006
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgKUOoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgKUOoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:44:07 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBEC061A4A;
        Sat, 21 Nov 2020 06:44:07 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so9464507qtp.1;
        Sat, 21 Nov 2020 06:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnivqKM995v74n6+N9/33uqUJO7sgvH+rwl6B0bul/s=;
        b=Nu8NjHzKlR6uWSNBDLOiBnR+6aga4qlhX06qRAIM8V3nfNu7Q9EUxFSf0DtmuvRq6s
         Txb48ZbM7urd2AhwQnmoCBxDmrhilfzy3Mv2BqUmzp2IRZHOS+aQqkcPxN2q2IDzO+Ky
         t/h96jJYHq3cK0w6LbW5xsrCzngRlVziNr0ihUpf/f0BHJ/BHUv6DW7blNT5T15QM+HZ
         hW+h5nIWqCBe3HkhSZcGZLAy+IaHkl0GGhRWt1rn8qLZgskL1WGQUcn7x2Xk6fatoPov
         T5KUBd4GW8B39yaMeTriOFbr1YkaQi5ObN4u/G2c9/IkXe+TGDDV0NN8FGJuonzLBl7J
         50/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnivqKM995v74n6+N9/33uqUJO7sgvH+rwl6B0bul/s=;
        b=GeSdG3lAIfuzN+1Lba+fSGtrz5RHhCFsCG19MziFoDNoqw7X+4Qo6to6KQTUbuevVs
         X8TfLi/TjeqKbGlNft5JAT00hURykpSVcLhjhQHqd0TXKuIVcDKG6lgOO2ZzF3Vb20Vm
         34HKirxie9p67YXSDtG1IQ4LPAN18QEwcrYfk8eO9esp5sSNV93jp4al2BOdsZApwz1e
         w5Q526/d2A9/NwJcQC8QkU2lHPSPylbOBtphZlLdLV6VUV0AFzZXdC3ZOljl3en4GYPJ
         1aGt/FSq/xb1hAiDXanMx/0wk/1OeerTgITI+wnpHeeDf894V2HzHrJ9owcirWsz+QTd
         r4DA==
X-Gm-Message-State: AOAM533RfZ5qLxqS4ova6OQvmWc06GdBeDQY61e6VOjQcnDmaqLM4DyZ
        TJpVBtHAyq3P2iwlGiEWpLQwT8ofCu4=
X-Google-Smtp-Source: ABdhPJzlNeFsOxdVbNJjJb3TOUOGPcCGWFmp8NOXr5I4/0kAMFuJ+kiuH8Id7e5+ve6nnMQNV3JR7Q==
X-Received: by 2002:ac8:6906:: with SMTP id e6mr20430030qtr.327.1605969846059;
        Sat, 21 Nov 2020 06:44:06 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id q15sm4055137qki.13.2020.11.21.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 06:44:05 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com,
        willy@infradead.org, arnd@arndb.de, shuochen@google.com,
        linux-man@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH v4 2/4] epoll: add syscall epoll_pwait2
Date:   Sat, 21 Nov 2020 09:43:58 -0500
Message-Id: <20201121144401.3727659-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
References: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Add syscall epoll_pwait2, an epoll_wait variant with nsec resolution
that replaces int timeout with struct timespec. It is equivalent
otherwise.

    int epoll_pwait2(int fd, struct epoll_event *events,
                     int maxevents,
                     const struct timespec *timeout,
                     const sigset_t *sigset);

The underlying hrtimer is already programmed with nsec resolution.
pselect and ppoll also set nsec resolution timeout with timespec.

The sigset_t in epoll_pwait has a compat variant. epoll_pwait2 needs
the same.

For timespec, only support this new interface on 2038 aware platforms
that define __kernel_timespec_t. So no CONFIG_COMPAT_32BIT_TIME.

Changes
  v4:
  - on top of patch that converts eventpoll.c to pass timespec64
  - split off wiring up the syscall
  - fix alpha syscall number (Arnd)
  v3:
  - rewrite: add epoll_pwait2 syscall instead of epoll_create1 flag
  v2:
  - cast to s64: avoid overflow on 32-bit platforms (Shuo Chen)
  - minor commit message rewording

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 fs/eventpoll.c | 87 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7082dfbc3166..c6d0ab3aaff1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2239,11 +2239,10 @@ SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_pwait(2).
  */
-SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
-		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
-		size_t, sigsetsize)
+static int do_epoll_pwait(int epfd, struct epoll_event __user *events,
+			  int maxevents, struct timespec64 *to,
+			  const sigset_t __user *sigmask, size_t sigsetsize)
 {
-	struct timespec64 to;
 	int error;
 
 	/*
@@ -2254,22 +2253,48 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 	if (error)
 		return error;
 
-	error = do_epoll_wait(epfd, events, maxevents,
-			      ep_timeout_to_timespec(&to, timeout));
+	error = do_epoll_wait(epfd, events, maxevents, to);
 
 	restore_saved_sigmask_unless(error == -EINTR);
 
 	return error;
 }
 
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
-			struct epoll_event __user *, events,
-			int, maxevents, int, timeout,
-			const compat_sigset_t __user *, sigmask,
-			compat_size_t, sigsetsize)
+SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
+		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
+		size_t, sigsetsize)
 {
 	struct timespec64 to;
+
+	return do_epoll_pwait(epfd, events, maxevents,
+			      ep_timeout_to_timespec(&to, timeout),
+			      sigmask, sigsetsize);
+}
+
+SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, events,
+		int, maxevents, const struct __kernel_timespec __user *, timeout,
+		const sigset_t __user *, sigmask, size_t, sigsetsize)
+{
+	struct timespec64 ts, *to = NULL;
+
+	if (timeout) {
+		if (get_timespec64(&ts, timeout))
+			return -EFAULT;
+		to = &ts;
+		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
+			return -EINVAL;
+	}
+
+	return do_epoll_pwait(epfd, events, maxevents, to,
+			      sigmask, sigsetsize);
+}
+
+#ifdef CONFIG_COMPAT
+static int do_compat_epoll_pwait(int epfd, struct epoll_event __user *events,
+				 int maxevents, struct timespec64 *timeout,
+				 const compat_sigset_t __user *sigmask,
+				 compat_size_t sigsetsize)
+{
 	long err;
 
 	/*
@@ -2280,13 +2305,47 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 	if (err)
 		return err;
 
-	err = do_epoll_wait(epfd, events, maxevents,
-			    ep_timeout_to_timespec(&to, timeout));
+	err = do_epoll_wait(epfd, events, maxevents, timeout);
 
 	restore_saved_sigmask_unless(err == -EINTR);
 
 	return err;
 }
+
+COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
+		       struct epoll_event __user *, events,
+		       int, maxevents, int, timeout,
+		       const compat_sigset_t __user *, sigmask,
+		       compat_size_t, sigsetsize)
+{
+	struct timespec64 to;
+
+	return do_compat_epoll_pwait(epfd, events, maxevents,
+				     ep_timeout_to_timespec(&to, timeout),
+				     sigmask, sigsetsize);
+}
+
+COMPAT_SYSCALL_DEFINE6(epoll_pwait2, int, epfd,
+		       struct epoll_event __user *, events,
+		       int, maxevents,
+		       const struct __kernel_timespec __user *, timeout,
+		       const compat_sigset_t __user *, sigmask,
+		       compat_size_t, sigsetsize)
+{
+	struct timespec64 ts, *to = NULL;
+
+	if (timeout) {
+		if (get_timespec64(&ts, timeout))
+			return -EFAULT;
+		to = &ts;
+		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
+			return -EINVAL;
+	}
+
+	return do_compat_epoll_pwait(epfd, events, maxevents, to,
+				     sigmask, sigsetsize);
+}
+
 #endif
 
 static int __init eventpoll_init(void)
-- 
2.29.2.454.gaff20da3a2-goog

