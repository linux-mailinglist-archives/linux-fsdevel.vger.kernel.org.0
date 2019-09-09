Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50D7AD6C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390812AbfIIKYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:24:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39835 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390597AbfIIKXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id q12so13994093wmj.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STLctuURefaE8eq55GBboHVj7+QXpVRUnAJsIE8QlMY=;
        b=XMwbu7B5OAgAIWw6N2LtryeCTvQ6z3+05hNQ741oPpGzrgd7tXuAkkU5zdc3X/eqlD
         yiG4Gmi4sTjgvThu5RQsAALJWUCRUekt+KXZnGUx3ELzgvvgcr2QaY/r7DGaasyT2tDw
         5qTGdnitBh3WFpeDyGDVP8LHsDpqHI+/GRyiiFZq0Li1sjubvjRX5RiioqxW1bJiEnXH
         Uy0OVpQKqUjqjQ31Me19gCjqn13KYbhrB1YPo2wHuo24N28g+cKTvYI7Zc1vvUGsAWmu
         QF1hzkYFCwmTBiO9omikKuQXD539nG96dOaFw4+JkHg//ePtrRAiF98KfEWUyoFnOKaG
         KmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STLctuURefaE8eq55GBboHVj7+QXpVRUnAJsIE8QlMY=;
        b=fP3JCmgwXxunDjvlubbnJ9kCbcQC1IvMWQJmePHloymGXVlQOr3QY6C3mH2zZHSTfN
         lB+6Cby8a0lXUgk8HLrKh8LJ6wzz9pDbb5QzOOQanAJzuOHDx97GyvPCI6NxqEmPCPC5
         AcSBG2/4VDfNRhgYqsvLdREjPHVUrGK3Y2vPwkYPhnKifqPjB+wdkRjlFhSDAGocoybG
         koNqHfIZ83ecl4kxzhxPdJe+EjjFYiFbTz4vW216PelH0hMa5caq0Ml5jH90SlFmx4mA
         bfPyuX00rRfOvNQP1E8rQtiz39ZwLuZNphwcJiAO6e0Awd3D2On7uwqtuEQFSYRtXKgy
         tUaw==
X-Gm-Message-State: APjAAAXohVens11n4jafNkvT0xqu5+tPCSOKrNXagq7IqOJPv9qTBOyI
        S/2cD2Dw4DVTLLeLf/F+Ing6SA==
X-Google-Smtp-Source: APXvYqwlnYxK/Ion+EpCVZ4VcHAZvyCrtmY/DDiUgd2oheMGu7g2FrmmWJ0F4QyACrXJgUyTC44ndA==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr17777639wmk.13.1568024627727;
        Mon, 09 Sep 2019 03:23:47 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:47 -0700 (PDT)
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
Subject: [PATCH 3/9] select: Convert __esimate_accuracy() to ktime_t
Date:   Mon,  9 Sep 2019 11:23:34 +0100
Message-Id: <20190909102340.8592-4-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__estimate_accuracy() divides 64-bit integers twice which is suboptimal.
Converting to ktime_t not only avoids that, but also simplifies the
logic on some extent.

The long-term goal is to convert poll() to leave timeout value in
ktime_t inside restart_block as it's the only user that leaves it in
timespec. That's a preparation ground for introducing a new ptrace()
request that will dump timeout for interrupted syscall.

Furthermore, do_select() and do_poll() actually both need time in
ktime_t for poll_schedule_timeout(), so there is this hack that converts
time on the first loop. It's not only a "hack", but also it's done every
time poll() syscall is restarted. After conversion it'll be removed.

While at it, rename parameters "slack" and "timeout" which describe
their purpose better.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/select.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 53a0c149f528..12cdefd3be2d 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -36,7 +36,7 @@
 
 
 /*
- * Estimate expected accuracy in ns from a timeval.
+ * Estimate expected accuracy in ns.
  *
  * After quite a bit of churning around, we've settled on
  * a simple thing of taking 0.1% of the timeout as the
@@ -49,22 +49,17 @@
 
 #define MAX_SLACK	(100 * NSEC_PER_MSEC)
 
-static long __estimate_accuracy(struct timespec64 *tv)
+static long __estimate_accuracy(ktime_t slack)
 {
-	long slack;
 	int divfactor = 1000;
 
-	if (tv->tv_sec < 0)
+	if (slack < 0)
 		return 0;
 
 	if (task_nice(current) > 0)
 		divfactor = divfactor / 5;
 
-	if (tv->tv_sec > MAX_SLACK / (NSEC_PER_SEC/divfactor))
-		return MAX_SLACK;
-
-	slack = tv->tv_nsec / divfactor;
-	slack += tv->tv_sec * (NSEC_PER_SEC/divfactor);
+	slack = ktime_divns(slack, divfactor);
 
 	if (slack > MAX_SLACK)
 		return MAX_SLACK;
@@ -72,27 +67,25 @@ static long __estimate_accuracy(struct timespec64 *tv)
 	return slack;
 }
 
-u64 select_estimate_accuracy(struct timespec64 *tv)
+u64 select_estimate_accuracy(struct timespec64 *timeout)
 {
-	u64 ret;
-	struct timespec64 now;
+	ktime_t now, slack;
 
 	/*
 	 * Realtime tasks get a slack of 0 for obvious reasons.
 	 */
-
 	if (rt_task(current))
 		return 0;
 
-	ktime_get_ts64(&now);
-	now = timespec64_sub(*tv, now);
-	ret = __estimate_accuracy(&now);
-	if (ret < current->timer_slack_ns)
-		return current->timer_slack_ns;
-	return ret;
-}
+	now = ktime_get();
+	slack = now - timespec64_to_ktime(*timeout);
 
+	slack = __estimate_accuracy(slack);
+	if (slack < current->timer_slack_ns)
+		return current->timer_slack_ns;
 
+	return slack;
+}
 
 struct poll_table_page {
 	struct poll_table_page * next;
-- 
2.23.0

