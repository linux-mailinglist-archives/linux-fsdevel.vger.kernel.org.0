Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0F2F2402
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbhALAcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbhALAbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:31:06 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA1C061795;
        Mon, 11 Jan 2021 16:30:25 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q1so1204218ilt.6;
        Mon, 11 Jan 2021 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QY4rVYyu6E/6EmhURp973qid4e3oR/DMlYXIb6itw4o=;
        b=mStwfFMTSroR0iUvcTwJfk75Ns0P5glJNuMQ7gNdd1l+9JHi6eLSGTNYKfZnX00W0H
         rcFIzjvSZ84Pddvt1IsOkucc8V6JY3qTQNw5S2vBDMWV9b8afJjrmR3oaZA1Q+KgvTbo
         ChVbuIlI5gCo0S04+xb4EACfAB/+dRgpOYJM0S6Zch0zQnjitjAa0Xm/SblcABaTidCo
         LF1mk8kRH8IGyog4xyVfyGH/tOf6NQkBh0nBpPFME7udWPOwLlNubXXWle7lA9q7R2op
         VVZ9kUk/R1EsB0Hdj6OM0bPOIkCLeMJ+v9+bz3hIM6Mq81cQbOnIN+Et7vlSSjgQc0Vb
         lVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QY4rVYyu6E/6EmhURp973qid4e3oR/DMlYXIb6itw4o=;
        b=J6Gciv+1HbkFNZi6QjgzUF1BUQfNCY5jv2Z14X3Vpwdrh2VVsuEPo/GsQOAVxjhPXv
         CCfPd09WlLQs7mVWYxhk3fMZGCDp9pkm9nPMxBiEZsoL8tdXO2fzJXm1sItIlk1HznXs
         zz4YBHShlkeYn0hvXjddhvpu6YcpDWgn/q6nkyUVkEnUyG7diUI7olkijs9OKeQcjxSZ
         9Wrc3eqsJQI59OMR88h4qKdlEw0ghgPSZKoGaT6MKWYwH0MSa0nFyaKxnzcAPW6NrZq7
         oX/WCfMIaZigRc8bMO1sEPLyf+bpajeUiopVlM1GAjSjK3rGh8vilPc/Fi8PQNMeQcRq
         AfJg==
X-Gm-Message-State: AOAM5322qN/oqo7kTSlSU9K0tkr5cunbUvjYA1bZz268yynm5tfITpGD
        g4EujtlXivxzRZcyd36eaETtsU9T/Ps=
X-Google-Smtp-Source: ABdhPJzxIYBWZ6+a+hxa0seYD4rhHzW43p+pTBvYyEkGzr7DYBIlKnO4Whu1QOFqEB2L6cnS6z+V0A==
X-Received: by 2002:a05:6e02:b2e:: with SMTP id e14mr1558354ilu.164.1610411425002;
        Mon, 11 Jan 2021 16:30:25 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id z10sm741723ioi.47.2021.01.11.16.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:30:24 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH 3/6] ppoll: deduplicate compat logic
Date:   Mon, 11 Jan 2021 19:30:14 -0500
Message-Id: <20210112003017.4010304-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
References: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Apply the same compat deduplication strategy to ppoll that was
previously applied to select and pselect.

Like pselect, ppoll has timespec and sigmask arguments, which have
compat variants. poll has neither, so is not modified.

Convert the ppoll syscall to a do_ppoll() helper that branches on
timespec and sigmask variants internally.

This allows calling the same implementation for all syscall variants:
standard, time32, compat, compat + time32.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 fs/select.c | 91 ++++++++++++++++++-----------------------------------
 1 file changed, 30 insertions(+), 61 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index dee7dfc5217b..27567795a892 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1120,28 +1120,48 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 	return ret;
 }
 
-SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
-		struct __kernel_timespec __user *, tsp, const sigset_t __user *, sigmask,
-		size_t, sigsetsize)
+static int do_ppoll(struct pollfd __user *ufds, unsigned int nfds,
+		    void __user *tsp, const void __user *sigmask,
+		    size_t sigsetsize, enum poll_time_type type)
 {
 	struct timespec64 ts, end_time, *to = NULL;
 	int ret;
 
 	if (tsp) {
-		if (get_timespec64(&ts, tsp))
-			return -EFAULT;
+		switch (type) {
+		case PT_TIMESPEC:
+			if (get_timespec64(&ts, tsp))
+				return -EFAULT;
+			break;
+		case PT_OLD_TIMESPEC:
+			if (get_old_timespec32(&ts, tsp))
+				return -EFAULT;
+			break;
+		default:
+			BUG();
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
 	if (ret)
 		return ret;
 
 	ret = do_sys_poll(ufds, nfds, to);
-	return poll_select_finish(&end_time, tsp, PT_TIMESPEC, ret);
+	return poll_select_finish(&end_time, tsp, type, ret);
+}
+
+SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
+		struct __kernel_timespec __user *, tsp, const sigset_t __user *, sigmask,
+		size_t, sigsetsize)
+{
+	return do_ppoll(ufds, nfds, tsp, sigmask, sigsetsize, PT_TIMESPEC);
 }
 
 #if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
@@ -1150,24 +1170,7 @@ SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds, unsigned int, nfds,
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
+	return do_ppoll(ufds, nfds, tsp, sigmask, sigsetsize, PT_OLD_TIMESPEC);
 }
 #endif
 
@@ -1258,24 +1261,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds,
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
+	return do_ppoll(ufds, nfds, tsp, sigmask, sigsetsize, PT_OLD_TIMESPEC);
 }
 #endif
 
@@ -1284,24 +1270,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct pollfd __user *, ufds,
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
+	return do_ppoll(ufds, nfds, tsp, sigmask, sigsetsize, PT_TIMESPEC);
 }
 
 #endif
-- 
2.30.0.284.gd98b1dd5eaa7-goog

