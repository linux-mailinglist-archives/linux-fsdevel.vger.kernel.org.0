Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454D934773B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhCXL0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhCXLZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:25:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C7C0613DF
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:36 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m11so949819qtx.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yTQtN+ZnokJzpQVm2BawzGlkCzsy9LGpOuPbrdojTxI=;
        b=eB0ckdgLY/9Mw7+c6wAMy4us/PB/YzfvC+tjuW6EEFemR43arcp3phQ/zVb+Cjf3L6
         kaphLRablv22cVVyXqwnAgfsL9bHsNK/McsF8kXgkjWGDCkqlD2LviOVeeYxSD4Cgc7S
         N5QTatiiBWUzZRX1RBYVDomafcyIzAFl6YiABcQwfd9FKnW2tS+3QnWAsic68aFgZrwx
         Hp4jWqv0Sva60F0SWTWBJvvSt3G30DxVxVY67PD02YygcoZYEP3JvuOMz+L0sinSO/+5
         hf2OhTpcNPGhFyAwcHDpY3+eJjZ9fXfzrNcD5PY/7rtTrNahBK8qDRBr3OagakKe6U5A
         XoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yTQtN+ZnokJzpQVm2BawzGlkCzsy9LGpOuPbrdojTxI=;
        b=KjvuHLqaDWLlz77gEsvjewpDt5uOohrz/sJTPa9MWbz977PPG5sBJmU8o1Njib+h1W
         exnDwZQWGeltOlGXhjLRP31G+ERR+XWqiZlUwut9J9drY4OGEcd1zJS6tCPaZ+zt0y9u
         jmTPslHrfG5alG61a/bOSGRwByh7zowoFvSMu6dAsltEz7eHkhbo4cNwOmZbrvQ8Yg77
         VnqSe036uzkn/ssjSPcGwDMxyMFnBo15huG/rdQk0zGxrKgEM1MRHGrvQFd9YKgapFeK
         YLnZ0bHb6Pb1rY7SK0HEwYkT0IsYVjg7gilPni9b5Ynyz5n4Z0CEBXBO0VWu0BcdEIMm
         0/Jw==
X-Gm-Message-State: AOAM531NYfLYPf+x4i7bPECsWqO7RQEc9rewUFWpAzaGxNzRmhXur6JY
        QN3hfvVQ+vgJ/3p1K/VFHbYoARTqrw==
X-Google-Smtp-Source: ABdhPJzRVukCVxBGVmxIhQ60T0lTvl+h5lsKxkFEL8Sjs6BBC73DCi1y8PZi7hM+RtQxq4YiLP1oMmBNWg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:ad4:50d0:: with SMTP id e16mr2718629qvq.37.1616585136104;
 Wed, 24 Mar 2021 04:25:36 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:24:59 +0100
In-Reply-To: <20210324112503.623833-1-elver@google.com>
Message-Id: <20210324112503.623833-8-elver@google.com>
Mime-Version: 1.0
References: <20210324112503.623833-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on SIGTRAP
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
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
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
v2:
* Add comment about si_perf==0.
---
 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1e4c949bf75f..0316d39e8c8f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6399,6 +6399,22 @@ static void perf_sigtrap(struct perf_event *event)
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
+		/*
+		 * No additional info set (si_perf == 0).
+		 *
+		 * Adding new cases for event types to set si_perf to a
+		 * non-constant value must ensure that si_perf != 0.
+		 */
+		break;
+	}
+
 	force_sig_info(&info);
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

