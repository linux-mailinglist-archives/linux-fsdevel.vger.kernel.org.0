Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C538653010A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 07:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiEVF0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 01:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiEVF0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 01:26:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BBD377E3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 22:26:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso4039464pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 22:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nyIl7rq+5OzWaIZhzUK6oYT0qxVsI4l129gaLjPCMbw=;
        b=JN/tFyoh8pK3b0z547jn//8E5dBkP3lfiamf2L2Q4++pDnt9Z2pj+uauBLiCc4mthY
         8/EVXRycJvww3ATQRfWuKvuOmbQEXA6LAm7H43ETuvr94uQc89g1fYqeog1tCG0rw58X
         lQF5VUDM1UlasrF9lLJ8d0s95Xg6y541JHYYXgeydIY655Pxc1kTDuMAqpNsdgeYIOrA
         cq7XpXCXDiUOskCebkrd1tS9iCcSeFIDe73MU4MTTZ4iSED36UcXu2QHcuNWinRDAWOn
         TVu0/Blf9FIuSKoahKNX1BzAY0v0Qkwk9JKA28tER2Ce4+wTycxGb86g4XcgdG2rbt4D
         jNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nyIl7rq+5OzWaIZhzUK6oYT0qxVsI4l129gaLjPCMbw=;
        b=cuNlJOS46E7MjkgNQjnM8QqGjQV9cjrXVQ8XOITdtswejZim3du9wGoT3Kr8aiAgqT
         A2TjXS85akfpeNOVF8AeA0xmX1PBU4O8MdO6t7jlchlcqu3kwevN8fbxuTM10bfw35XN
         NJRQRbFkci1r61r3DpRkG6BjY6U0zKuT5uUbE5Q1QBrjDMbEvdljEtEFJzfMFsbYYO2T
         TF6bM4msIRmXr6/eQ4FGUS9nTow8WEnbCGSXSgKsZpInBqCs6Int9EzFAPGt7RanCPfu
         XpdQxQ7hxQzQsJrL0U8aNwgci6sG1UnDkexv3MYssoCCIXuW7TMMlXuwvIiWVGDnVHBy
         GOCw==
X-Gm-Message-State: AOAM530TNHWVo4J4RWk/UXLmE7/vVbA4FBxCJLJkZo7auFglzLDE0PVc
        Hsl6csMRpNMOvDpJvaYqok1iGLn2MGtO4g==
X-Google-Smtp-Source: ABdhPJzS8xrUQGH455H99C7NphFK6jeJo4W+92RyiPjSO8kIPzZY3v9f0mH8fSAvR6qhhOnYnGRgbA==
X-Received: by 2002:a17:903:120e:b0:15e:84d2:4bbb with SMTP id l14-20020a170903120e00b0015e84d24bbbmr16713769plh.165.1653197203800;
        Sat, 21 May 2022 22:26:43 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902f38900b0015e8d4eb29asm2429036ple.228.2022.05.21.22.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 22:26:43 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     willy@infradead.org, Muchun Song <songmuchun@bytedance.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [PATCH v2] sysctl: handle table->maxlen properly for proc_dobool
Date:   Sun, 22 May 2022 13:26:24 +0800
Message-Id: <20220522052624.21493-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
robustness, fix it by reimplementing proc_dobool() properly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Iurii Zaikin <yzaikin@google.com>
---
v2:
 - Reimplementing proc_dobool().

 fs/lockd/svc.c  |  2 +-
 kernel/sysctl.c | 38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 59ef8a1f843f..6e48ee787f49 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -496,7 +496,7 @@ static struct ctl_table nlm_sysctls[] = {
 	{
 		.procname	= "nsm_use_hostnames",
 		.data		= &nsm_use_hostnames,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(nsm_use_hostnames),
 		.mode		= 0644,
 		.proc_handler	= proc_dobool,
 	},
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e52b6e372c60..50a2c29efc94 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -423,21 +423,6 @@ static void proc_put_char(void **buf, size_t *size, char c)
 	}
 }
 
-static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
-				int *valp,
-				int write, void *data)
-{
-	if (write) {
-		*(bool *)valp = *lvalp;
-	} else {
-		int val = *(bool *)valp;
-
-		*lvalp = (unsigned long)val;
-		*negp = false;
-	}
-	return 0;
-}
-
 static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
 				 int *valp,
 				 int write, void *data)
@@ -708,16 +693,31 @@ int do_proc_douintvec(struct ctl_table *table, int write,
  * @lenp: the size of the user buffer
  * @ppos: file position
  *
- * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string.
+ * Reads/writes up to table->maxlen/sizeof(bool) bool values from/to
+ * the user buffer, treated as an ASCII string.
  *
  * Returns 0 on success.
  */
 int proc_dobool(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, write, buffer, lenp, ppos,
-				do_proc_dobool_conv, NULL);
+	struct ctl_table tmp = *table;
+	bool *data = table->data;
+	unsigned int val = READ_ONCE(*data);
+	int ret;
+
+	/* Do not support arrays yet. */
+	if (table->maxlen != sizeof(bool))
+		return -EINVAL;
+
+	tmp.maxlen = sizeof(val);
+	tmp.data = &val;
+	ret = do_proc_douintvec(&tmp, write, buffer, lenp, ppos, NULL, NULL);
+	if (ret)
+		return ret;
+	if (write)
+		WRITE_ONCE(*data, val ? true : false);
+	return 0;
 }
 
 /**
-- 
2.11.0

