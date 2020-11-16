Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB52B4A57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgKPQKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 11:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbgKPQKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:10:06 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EFEC0613CF;
        Mon, 16 Nov 2020 08:10:06 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so17237156qke.8;
        Mon, 16 Nov 2020 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sxIs3F6y9Hap2HZWxwutrOTpApNQNkZ1qsXxhmaCrPs=;
        b=UtIRS1jMrYjTp3Ww+lPSxfYCrB7YqsIdXjgWDCcKpAJrVg35O5p74FKtBt1K9iI1ez
         voluKxDKevddBM7frnwcJdASuIA4JYiLo96KXXBP+KmM1Fi6sUWgkmPKMb38aWFAzwlc
         MVniBJdEVbDgTM9HBErS6bqcY5Jcon45Fkv9QoThCgIRpgy5LtVM09AhXcFhQ0TOdXk5
         QZftSQNRLTl2+2HGwiQZWBrnS/N1cXS5vUqpzThAhimLOSpxNhXjgGlhnoA+ZIl7jV6w
         2RwqyrBs4JgqX+SEHQ1egvo6LJdPm7dNU8vVIzWBUZHa2of7z/Wf90FtNu8+2zVdAaki
         Ncfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sxIs3F6y9Hap2HZWxwutrOTpApNQNkZ1qsXxhmaCrPs=;
        b=oRb3SVbu0YyYL8MF0twixoC/IgioJbqmBNsDk+ORkiiYeW7HE2vJg1CdnVkxk2RQof
         OzoqbzJ6JO27uzId7Uu+ocxgkJjDpHakn7t3T8enhERA11kb50gzzuW5qe2zsB88Y5j3
         GgN9s1/om64rWavQJUcpi7LPO55ZVSAvbe0Ex0il7m8vRLBf3BIQL7z3RCLwonLGCFXz
         L/pZTXhd0OIkM7bIxJmUzRq3tVc/FAEtkDlc8evLnFOdVmqNCzOSpSPuIg6n19Lw2uhU
         9U/ajeXYVoMfyBI+LP4uhDDV5L0qwbNn9SQ6HuSAxeAjmuKwHP/Nzk3lJFxGpNy8ds8D
         HgOA==
X-Gm-Message-State: AOAM532E+KmXEbQHSnltc/Y9eMzsPG+HMB10VASrJNXLc3Wfr9IzTbGb
        b6Z5HwCm10VDedjzL5PCkUfeJw25JIk=
X-Google-Smtp-Source: ABdhPJyN++A/s6LCL6iKAWeMfkeGycx8+XwjoAHuRcd+7RdNlFxXLdI2c5V6+tZBXbwig1yFCTiKLw==
X-Received: by 2002:a05:620a:554:: with SMTP id o20mr15053926qko.394.1605543004829;
        Mon, 16 Nov 2020 08:10:04 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id d19sm2458822qtd.32.2020.11.16.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:10:03 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com, arnd@arndb.de,
        shuochen@google.com, Willem de Bruijn <willemb@google.com>
Subject: [PATCH v2] epoll: add nsec timeout support
Date:   Mon, 16 Nov 2020 11:10:01 -0500
Message-Id: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
interpretation of argument timeout in epoll_wait from msec to nsec.

Use cases such as datacenter networking operate on timescales well
below milliseconds. Shorter timeouts bounds their tail latency.
The underlying hrtimer is already programmed with nsec resolution.

Changes (v2):
  - cast to s64: avoid overflow on 32-bit platforms (Shuo Chen)
  - minor commit message rewording

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Applies cleanly both to 5.10-rc4 and next-20201116.
In next, nstimeout no longer fills padding with new field refs.

Selftest for now at github. Can follow-up for kselftests.
https://github.com/wdebruij/kerneltools/blob/master/tests/epoll_nstimeo.c
---
 fs/eventpoll.c                 | 26 +++++++++++++++++++-------
 include/uapi/linux/eventpoll.h |  1 +
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4df61129566d..817d9cc5b8b8 100644
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
+static inline struct timespec64 ep_set_nstimeout(s64 ns)
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
+	return ep_set_nstimeout(ms * (s64)NSEC_PER_MSEC);
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
2.29.2.299.gdc1121823c-goog

