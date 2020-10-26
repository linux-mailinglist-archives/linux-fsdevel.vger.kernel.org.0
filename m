Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFBF2991E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 17:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784990AbgJZQIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 12:08:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37855 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784977AbgJZQIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:08:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id h19so7088418qtq.4;
        Mon, 26 Oct 2020 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQr6x/7/1SYLga1+qXciqsa1562jPSH3XJrwgKuYwqM=;
        b=HXALKjPFYKhtTfwWZRAKxYuDPLOnQ86C2s78fBKBGOVpdPiMbXAIL+eJF0WwNfLwkK
         Fk95P5jr0/yNl4TrkS6VPqz44NLApGShP0BOUcU0RzzcFHHxmXgRBq5qIps42dij0pWV
         YCGHrMeeF8bnj/PBAeBsETIMhdNJ/Y6ohn+aY1tcYy8WeZtT9UR1OHJLnOsGZNvvTJnm
         ufz9kuRTVdxoODLK4+D0NkgRZcsWqxqtH+84lzFdpClYOCNSG+Ez0dOJO5kv8xttIt8N
         zl0NPKHOK8I5alO7pesWnDonVDgBUSIBykDTsWqoQTt85bBaYgUCm9IALS1PC25Gz5j5
         INIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQr6x/7/1SYLga1+qXciqsa1562jPSH3XJrwgKuYwqM=;
        b=Z5lOvWYnK7EeyW4D1nz5gPHcH6gmI/397HQ/GYdDIHkROUefrqL+xyEbBo2t03iHTs
         jsUTUsDMgxkNaKinbYr1FVPL4Z6t7RLvifxBwYJQTzqNpgype8Tx+hZ4W2mncDo04FZV
         Bjgq8WELsPXOLCmpqPNhuRyAWBEs4/ZA38Ca2XsLZajNV/c7Bgpmr50RuA+iHsligflB
         HWfnMlAwQ62wOBQpMmNwlLOJFQ62d+02+yRtzGutfrpi/FLbs5FtWtlanpO/xUZ6KZxx
         rY+vEGqvahnMWIru8iY/nFc7KQyWBZa0+nZxz+JeuMCENWWh6M4BS9aV5KbvXY0L6v2n
         fxBg==
X-Gm-Message-State: AOAM5328BYMAKEoo5/Bnfai1mJG7L2Z+wkSj25eDrk/LxZ2YJXt5yFD7
        8WRSlou7CZE/3LeirpnMKaMiSCy+hKo=
X-Google-Smtp-Source: ABdhPJwwywD6QmXUkA21S8QU9L5URBOnwEVuIOoQ+kvJ19dJ2UHsA8tBfXBVbRXT8rc8a4ofDpjadg==
X-Received: by 2002:aed:22d9:: with SMTP id q25mr16192558qtc.59.1603728494459;
        Mon, 26 Oct 2020 09:08:14 -0700 (PDT)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id p23sm6703261qkm.126.2020.10.26.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:08:13 -0700 (PDT)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        soheil.kdev@gmail.com, arnd@arndb.de,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH] epoll: add nsec timeout support
Date:   Mon, 26 Oct 2020 12:08:10 -0400
Message-Id: <20201026160810.2503534-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

The underlying hrtimer is programmed with nanosecond resolution.

Use cases such as datacenter networking operate on timescales well
below milliseconds. Setting shorter timeouts bounds tail latency.

Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
interpretation of argument timeout in epoll_wait from msec to nsec.

The new eventpoll state fits in existing 4B of padding when busy poll
is compiled in (the default), and reads the same cacheline.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Selftest for now at github. Can follow-up for kselftests.
https://github.com/wdebruij/kerneltools/blob/master/tests/epoll_nstimeo.c
---
 fs/eventpoll.c                 | 26 +++++++++++++++++++-------
 include/uapi/linux/eventpoll.h |  1 +
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4df61129566d..1216b909d155 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -225,6 +225,9 @@ struct eventpoll {
 	unsigned int napi_id;
 #endif
 
+	/* Accept timeout in ns resolution (EPOLL_NSTIMEO) */
+	unsigned int nstimeout:1;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/* tracks wakeup nests for lockdep validation */
 	u8 nests;
@@ -1787,17 +1790,20 @@ static int ep_send_events(struct eventpoll *ep,
 	return esed.res;
 }
 
-static inline struct timespec64 ep_set_mstimeout(long ms)
+static inline struct timespec64 ep_set_nstimeout(long ns)
 {
-	struct timespec64 now, ts = {
-		.tv_sec = ms / MSEC_PER_SEC,
-		.tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
-	};
+	struct timespec64 now, ts;
 
+	ts = ns_to_timespec64(ns);
 	ktime_get_ts64(&now);
 	return timespec64_add_safe(now, ts);
 }
 
+static inline struct timespec64 ep_set_mstimeout(long ms)
+{
+	return ep_set_nstimeout(NSEC_PER_MSEC * ms);
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller supplied
  *           event buffer.
@@ -1826,7 +1832,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	lockdep_assert_irqs_enabled();
 
 	if (timeout > 0) {
-		struct timespec64 end_time = ep_set_mstimeout(timeout);
+		struct timespec64 end_time;
+
+		end_time = ep->nstimeout ? ep_set_nstimeout(timeout) :
+					   ep_set_mstimeout(timeout);
 
 		slack = select_estimate_accuracy(&end_time);
 		to = &expires;
@@ -2046,7 +2055,7 @@ static int do_epoll_create(int flags)
 	/* Check the EPOLL_* constant for consistency.  */
 	BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
 
-	if (flags & ~EPOLL_CLOEXEC)
+	if (flags & ~(EPOLL_CLOEXEC | EPOLL_NSTIMEO))
 		return -EINVAL;
 	/*
 	 * Create the internal data structure ("struct eventpoll").
@@ -2054,6 +2063,9 @@ static int do_epoll_create(int flags)
 	error = ep_alloc(&ep);
 	if (error < 0)
 		return error;
+
+	ep->nstimeout = !!(flags & EPOLL_NSTIMEO);
+
 	/*
 	 * Creates all the items needed to setup an eventpoll file. That is,
 	 * a file structure and a free file descriptor.
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 8a3432d0f0dc..f6ef9c9f8ac2 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -21,6 +21,7 @@
 
 /* Flags for epoll_create1.  */
 #define EPOLL_CLOEXEC O_CLOEXEC
+#define EPOLL_NSTIMEO 0x1
 
 /* Valid opcodes to issue to sys_epoll_ctl() */
 #define EPOLL_CTL_ADD 1
-- 
2.29.0.rc1.297.gfa9743e501-goog

