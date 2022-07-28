Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23D3584274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiG1O7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiG1O7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:59:04 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABADEF75
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jul 2022 07:59:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c24so1610462qkm.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jul 2022 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5/tjPr6QG6frGjHfD5cFUY7n0xr+lehOx18t20B7bI=;
        b=6M1MGyT0JZCI3ep5oiwXY/o2YOAgICvED40hIK3y6zgNdw0bpmYMtlXW9IxdWq79P/
         RsPQEENCdp3uPwrcKarSAZ8A9/uF21G+tUHruEiprCOsLBhdJ6BrrTQTqacVnbhl25Xg
         7ld+FnmhkEl0/XC0iP63zjLcr92/l4aG1se9zjS1xyKNJmtqEX3f/QjWdCK144cVGnwa
         KIWCSIHjGj42flH2QOrxjKWIdxzwfuJazR8b+AS9cPIve8tPu7Y9oaXCM2vQf8tAeCyZ
         RMr/KVUCOG8ygAM9Tlryu/3fE9Dmnv+n1Rr7453wDm3m9jv4cez/0uey2XRuzTVxS0Ju
         Cv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5/tjPr6QG6frGjHfD5cFUY7n0xr+lehOx18t20B7bI=;
        b=QAdWeUJqNL7ayWoK8Eoc+Qo+rnPJixfHnqQvW3qkmpRa7HrgsFANH+A7N1rHSg5tao
         ChDtdePgjfiGs3Er5BK6/Bsbwp4aqokh64W5vfDIVC/PUCLABIe3+P2BfotdYxPZSaUs
         yEW5k32VSL3UiQComoA1fWOePZA580TEvHjEqETAxzeScs/KusQeFxULIZwD2bN2SZmG
         Buz7jDmLFbLuc51yotCgyEwczVqXBNdFvzxQtY/cAvFHoyB/5FxAI039f2BqDX3T24yf
         oeWhUNRdepGpIAXiuEC/fLFsLOmSCddP9lVNXHaZh5/UQLBnQopCzuY/EC+SQddB0709
         kB2g==
X-Gm-Message-State: AJIora+0VT8Y9ZtR0Vw3X1ZqR5cZOX+2krUIjVuGm235LSBsFEMen9kE
        iEpOI3FHRvABL7wPsE/FoQ7FpB+A8ibUwg==
X-Google-Smtp-Source: AGRyM1t4DkwKnAnFc0kfx/Gt2EUQ5qJqQfJcIgulv+SylVQonHQaHp57fMDss5NRbvjRTVONPN9/gg==
X-Received: by 2002:a05:620a:1907:b0:6a6:2fac:462f with SMTP id bj7-20020a05620a190700b006a62fac462fmr19703589qkb.213.1659020342806;
        Thu, 28 Jul 2022 07:59:02 -0700 (PDT)
Received: from hefring.. ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id g24-20020ac870d8000000b0031e9ff0c44fsm586860qtp.20.2022.07.28.07.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:59:02 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
X-Google-Original-From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Cc:     Andrew Morton <akpm@osdl.org>,
        Ben Wolsieffer <Ben.Wolsieffer@hefring.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: /proc/<pid>/maps: release mmap read lock
Date:   Thu, 28 Jul 2022 10:58:58 -0400
Message-Id: <20220728145859.497397-1-Ben.Wolsieffer@hefring.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The no-MMU implementation of /proc/<pid>/map doesn't normally release
the mmap read lock, since the !IS_ERR_OR_NULL(_vml) condition in m_stop
is false in most cases.

This patch syncs the relevant locking and error handling code from the
MMU implementation to reduce the divergence between the two
implementations and fix the locking bug.

Signed-off-by: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
---
 fs/proc/task_nommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..97f387d30e74 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -208,11 +208,16 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-ESRCH);
 
 	mm = priv->mm;
-	if (!mm || !mmget_not_zero(mm))
+	if (!mm || !mmget_not_zero(mm)) {
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return NULL;
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		mmput(mm);
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return ERR_PTR(-EINTR);
 	}
 
@@ -221,23 +226,21 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		if (n-- == 0)
 			return p;
 
-	mmap_read_unlock(mm);
-	mmput(mm);
 	return NULL;
 }
 
-static void m_stop(struct seq_file *m, void *_vml)
+static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
+	struct mm_struct *mm = priv->mm;
 
-	if (!IS_ERR_OR_NULL(_vml)) {
-		mmap_read_unlock(priv->mm);
-		mmput(priv->mm);
-	}
-	if (priv->task) {
-		put_task_struct(priv->task);
-		priv->task = NULL;
-	}
+	if (!priv->task)
+		return;
+
+	mmap_read_unlock(mm);
+	mmput(mm);
+	put_task_struct(priv->task);
+	priv->task = NULL;
 }
 
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
-- 
2.36.1

