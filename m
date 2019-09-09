Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0AAAD6C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbfIIKYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:24:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54315 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390614AbfIIKXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so1582750wmp.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=In6xjIv1qvZx6AHWSp+pYmS8Y+YcRx5T9VqtwgDDOao=;
        b=H2AxMfh6lZl28VuEpAig+Ks6VvS2c/2mZ96FjkKszabA6MyJP9kHbQ1KKprSKyFSmJ
         mN4OqbigiTeZ3SFvyoAWcicUp+ltfyiVQvI/5E+Fx8g5Lq1/q6CYklfhsHkBRI1QY/MU
         dETvL5Cke5dXWfEWU3vBj8E8Ij/JfReNOs3Yy/sxO8XIGlENDWstC5iB0Ttzggciw8CK
         qQ3SjJQjkpCNt+9wSAjQytMKAwbxIbfFWkxX+TPYPFag194n25iWz50I4ChcDlZEEPuv
         KMYnXYd3ae0OtxC/b7wnIClKjO4keCcC049HzFNRzUbrsnSwkpz05DTvgEmahBkZQunG
         FCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=In6xjIv1qvZx6AHWSp+pYmS8Y+YcRx5T9VqtwgDDOao=;
        b=kmqrUZURFP0gD/1DTA5N2+qLiNiXpTcM3650xIdLUyF3FMm6Fki+Oy9RhQHmZAIuky
         Bndfql1ujQyEKayf2GP46TGJHmICeN4amoZQkPMTmbt3CFpWK2rYN0wa/unFb4mwlwnf
         ZSOkBuPDgdoSJGhznP3ClVcB6gr9V+nJTkQR4RScoOX1V4mksTuKBRrB+9NVIWfycZXg
         m2vidZ5AEV2/t/cBZMybLI5Ng5+rhB/JMQIIjjtmSNk4ruHNPydLBonJANgccJHZ/HU+
         hJi+AD9q4a4+LjSa9ML5KIcRMDbXDb2UHcIU4xuRPSqM1KxfImwzrCaOas95TGeun0Dj
         s5Gg==
X-Gm-Message-State: APjAAAXyQGT/pN2lUFJoDt53Ivgt5hBEvra9pW0kWhnez07kyQ5axELB
        dohIGmLQltt2LfKt9cVdA1K8pg==
X-Google-Smtp-Source: APXvYqwodAb2hSbu1oBC3qnGuQjKRAYFo/bkD32ISS9HPSjmr8FMWLHhger1WxXkvavqQkINxe6skw==
X-Received: by 2002:a7b:c5ca:: with SMTP id n10mr18393828wmk.138.1568024629199;
        Mon, 09 Sep 2019 03:23:49 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:48 -0700 (PDT)
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
Subject: [PATCH 4/9] select: Micro-optimise __estimate_accuracy()
Date:   Mon,  9 Sep 2019 11:23:35 +0100
Message-Id: <20190909102340.8592-5-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shift on s64 is faster than division, use it instead.

As the result of the patch there is a hardly user-visible effect:
poll(), select(), etc syscalls will be a bit more precise on ~2.3%
than before because 1000 != 1024 :)

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/select.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 12cdefd3be2d..2477c202631e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -51,15 +51,14 @@
 
 static long __estimate_accuracy(ktime_t slack)
 {
-	int divfactor = 1000;
-
 	if (slack < 0)
 		return 0;
 
-	if (task_nice(current) > 0)
-		divfactor = divfactor / 5;
+	/* A bit more precise than 0.1% */
+	slack = slack >> 10;
 
-	slack = ktime_divns(slack, divfactor);
+	if (task_nice(current) > 0)
+		slack = slack * 5;
 
 	if (slack > MAX_SLACK)
 		return MAX_SLACK;
-- 
2.23.0

