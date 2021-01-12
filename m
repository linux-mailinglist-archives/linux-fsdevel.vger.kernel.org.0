Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC42F23FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbhALAbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbhALAbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:31:43 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F944C0617A3;
        Mon, 11 Jan 2021 16:30:29 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id t3so1191602ilh.9;
        Mon, 11 Jan 2021 16:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bBzMydguUVXlJygZy+L+A0TLEvNxN16shoUGEugiOE=;
        b=cdKYCMkJT6j0/WukuM7xLyLMsjNCArvFlXBUi0hiSFZChaB45MAM9Ri6QUi21Xp13o
         6UzV87LjpOLviKXDAb4h75gGPH7RANkjJCTBbyVm/pj2RmkoLxZyIWV/XiMz71fj26he
         6JFjlFLqABDeltopFgQuG3+s1FPpXrusNJTE08eaRekZMmBrUUZNffn8GNuck4ukwZEP
         iXG6/kijx93tFQk4hs/XxW1W1mOBg0EJfkfsFL4oibKUxp9Nl9mlU+qPCjjmWrEqT0R8
         emT8laVy6Ksrvx3fYTTX+jxQGT4lscm2ZEt1JD6p9i+4K0vbZfj3EISy5w64IHoFcyl1
         zqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bBzMydguUVXlJygZy+L+A0TLEvNxN16shoUGEugiOE=;
        b=Ial7GatJZk/a5DidSZSpCosgW/kK8QXswsllOLtfoXTs7ygMtCBPTMmkQyDOFlJzgw
         tRGr804jqttm+9Dd3LgE+TV2bTIhL0tzUIFz/pAhtE3bu8cxsTDDis23skEf7LlSetiA
         IDjfBunwEr53WnlUd/RUGZPCXuIbrpvkMfg7eBUuxloorEvUlcAUIaj79aoYYbjSQ5Fu
         6IhP/6oRaYIOxXOgMEQG9cNUxup4ByrB1g53UnARp4OTxQd2Xoa4DIFWFEvxUC3fGN4l
         Lv2U4retB9IlKXsYXW1icoaMUfZqjR5QUMIcxpkANMuTETwOEjuuDt3qypqWCIU3SMhV
         RBTQ==
X-Gm-Message-State: AOAM530YQ/WJ4oKvQP9pCrhgQzWa38qVoKqM7iwjtimoGWFjrLIOfLaJ
        m18e07tF8ROjmcoX19wEF+ctqCx9mbs=
X-Google-Smtp-Source: ABdhPJxuG0iilI9x/mweoOX+8NEI3wrg+1n34TnEKT+2KJRo+cQ76mBHnUVeM2zoQyOQgxTUuXK3cg==
X-Received: by 2002:a92:d350:: with SMTP id a16mr1551482ilh.262.1610411428446;
        Mon, 11 Jan 2021 16:30:28 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id z10sm741723ioi.47.2021.01.11.16.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:30:27 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>
Subject: [PATCH 6/6] io_pgetevents: deduplicate compat logic
Date:   Mon, 11 Jan 2021 19:30:17 -0500
Message-Id: <20210112003017.4010304-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
References: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

io_pgetevents has four variants, including compat variants of both
timespec and sigmask.

With set_maybe_compat_user_sigmask helper, the latter can be
deduplicated. Move the shared logic to new do_io_pgetevents,
analogous to do_io_getevents.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>
---
 fs/aio.c | 94 ++++++++++++++++++++++----------------------------------
 1 file changed, 37 insertions(+), 57 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index d213be7b8a7e..56460ab47d64 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2101,6 +2101,31 @@ struct __aio_sigset {
 	size_t		sigsetsize;
 };
 
+static long do_io_pgetevents(aio_context_t ctx_id,
+		long min_nr,
+		long nr,
+		struct io_event __user *events,
+		struct timespec64 *ts,
+		const void __user *umask,
+		size_t sigsetsize)
+{
+	bool interrupted;
+	int ret;
+
+	ret = set_maybe_compat_user_sigmask(umask, sigsetsize);
+	if (ret)
+		return ret;
+
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, ts);
+
+	interrupted = signal_pending(current);
+	restore_saved_sigmask_unless(interrupted);
+	if (interrupted && !ret)
+		ret = -ERESTARTNOHAND;
+
+	return ret;
+}
+
 SYSCALL_DEFINE6(io_pgetevents,
 		aio_context_t, ctx_id,
 		long, min_nr,
@@ -2111,8 +2136,6 @@ SYSCALL_DEFINE6(io_pgetevents,
 {
 	struct __aio_sigset	ksig = { NULL, };
 	struct timespec64	ts;
-	bool interrupted;
-	int ret;
 
 	if (timeout && unlikely(get_timespec64(&ts, timeout)))
 		return -EFAULT;
@@ -2120,18 +2143,9 @@ SYSCALL_DEFINE6(io_pgetevents,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	ret = set_user_sigmask(ksig.sigmask, ksig.sigsetsize);
-	if (ret)
-		return ret;
-
-	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
-		ret = -ERESTARTNOHAND;
-
-	return ret;
+	return do_io_pgetevents(ctx_id, min_nr, nr, events,
+				timeout ? &ts : NULL,
+				ksig.sigmask, ksig.sigsetsize);
 }
 
 #if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
@@ -2146,8 +2160,6 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
 {
 	struct __aio_sigset	ksig = { NULL, };
 	struct timespec64	ts;
-	bool interrupted;
-	int ret;
 
 	if (timeout && unlikely(get_old_timespec32(&ts, timeout)))
 		return -EFAULT;
@@ -2155,19 +2167,9 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-
-	ret = set_user_sigmask(ksig.sigmask, ksig.sigsetsize);
-	if (ret)
-		return ret;
-
-	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
-		ret = -ERESTARTNOHAND;
-
-	return ret;
+	return do_io_pgetevents(ctx_id, min_nr, nr, events,
+				timeout ? &ts : NULL,
+				ksig.sigmask, ksig.sigsetsize);
 }
 
 #endif
@@ -2213,8 +2215,6 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 {
 	struct __compat_aio_sigset ksig = { 0, };
 	struct timespec64 t;
-	bool interrupted;
-	int ret;
 
 	if (timeout && get_old_timespec32(&t, timeout))
 		return -EFAULT;
@@ -2222,18 +2222,9 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	ret = set_compat_user_sigmask(compat_ptr(ksig.sigmask), ksig.sigsetsize);
-	if (ret)
-		return ret;
-
-	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
-		ret = -ERESTARTNOHAND;
-
-	return ret;
+	return do_io_pgetevents(ctx_id, min_nr, nr, events,
+				timeout ? &t : NULL,
+				compat_ptr(ksig.sigmask), ksig.sigsetsize);
 }
 
 #endif
@@ -2248,8 +2239,6 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
 {
 	struct __compat_aio_sigset ksig = { 0, };
 	struct timespec64 t;
-	bool interrupted;
-	int ret;
 
 	if (timeout && get_timespec64(&t, timeout))
 		return -EFAULT;
@@ -2257,17 +2246,8 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	ret = set_compat_user_sigmask(compat_ptr(ksig.sigmask), ksig.sigsetsize);
-	if (ret)
-		return ret;
-
-	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
-		ret = -ERESTARTNOHAND;
-
-	return ret;
+	return do_io_pgetevents(ctx_id, min_nr, nr, events,
+				timeout ? &t : NULL,
+				compat_ptr(ksig.sigmask), ksig.sigsetsize);
 }
 #endif
-- 
2.30.0.284.gd98b1dd5eaa7-goog

