Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61849322C85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 15:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhBWOhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 09:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhBWOgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:36:21 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBECC06121F
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:34:56 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id k5so2379518wrw.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S0g1Gw0V8LQdKC7HpmWoNe9UXx0KjO/uwYjAYtfhLeU=;
        b=Fq2+eMK4jh0j/XFxErxBk8JeSfqqp/fu80bJNatnXBZ+At9fWTw+fV8REB7eXUtZp1
         ULO0nXNMb/4yD7npazKim9wSN+KhAZDvelhEE2VXOW04dDQNWpR2j4a8dhjUh7H8vdLk
         LdBD159jN26zXBuVa/9kmkk6hXeouARhByuMWxXgSfSal5Vajn6E0H/0xXc9M/FBGqDx
         71vEf/3qA2dcUZrsFdOJHXvfq/XGKNsVTheqxZJWbPoc0xiNH+vHxYQlKO6MY+NL0rTl
         U3Nazu+wdymC8xNyetJQHEzeaV/tg2wAU6FrWnoRr/J1/2/lOOZoEwX79LN/hewvBfCb
         vklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S0g1Gw0V8LQdKC7HpmWoNe9UXx0KjO/uwYjAYtfhLeU=;
        b=R9A7uNN2UIuJgV0+lybZIY3B+yw0Lsm23RWxv4LWr2A+BHyFdTzQGrb5aDK1qwWUBK
         KXL6BPUHu245Y1OUHLNd5+BVtYTh37Rz+5+4ZQxR3uqTyM8LZu0H56mTVRtB9DPtFA39
         stLaDI4vruR9uz89f/3AW88Mz3CEVmHdK81dFbSIL/k7gTsXWm/4vZMMvXj7YaTVSht0
         4zaKWc4UVwU8AwejDN6cuObXEFzQk0PzRBWXk8k4h7Y6dfF6JX0VahZY+xksEYs2UCuw
         C7OZDmFTiCTXegNr+3MsFRwuFxaIsBz8xOwTBNJj+IK4McqKxhvropqvnS988Mj6v7wh
         f3WQ==
X-Gm-Message-State: AOAM530pJtSQ5HUbWi0ibiRCFuT8Gwzp2vdZ1bC5lal0WaW7mkUGvDJn
        SP5KKOGFW1flRyaF3BnJpuD/R5U3Qw==
X-Google-Smtp-Source: ABdhPJzt6spWgjRPJkBK/IplFxSdnMgcPPQTnbG7I8X4jppm6p3wuv5JFcbCjpxvdDcCW9kqNB9SgjiX0A==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:855b:f924:6e71:3d5d])
 (user=elver job=sendgmr) by 2002:a1c:2e90:: with SMTP id u138mr587498wmu.0.1614090894574;
 Tue, 23 Feb 2021 06:34:54 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:34:26 +0100
In-Reply-To: <20210223143426.2412737-1-elver@google.com>
Message-Id: <20210223143426.2412737-5-elver@google.com>
Mime-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH RFC 4/4] perf/core: Add breakpoint information to siginfo on SIGTRAP
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Encode information from breakpoint attributes into siginfo_t, which
helps disambiguate which breakpoint fired.

Note, providing the event fd may be unreliable, since the event may have
been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
triggering and the signal being delivered to user space.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8718763045fd..d7908322d796 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6296,6 +6296,17 @@ static void perf_sigtrap(struct perf_event *event)
 	info.si_signo = SIGTRAP;
 	info.si_code = TRAP_PERF;
 	info.si_errno = event->attr.type;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_BREAKPOINT:
+		info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
+		info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
+		break;
+	default:
+		/* No additional info set. */
+		break;
+	}
+
 	force_sig_info(&info);
 }
 
-- 
2.30.0.617.g56c4b15f3c-goog

