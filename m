Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF025336ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 08:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbiEYGvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 02:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243504AbiEYGv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 02:51:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4913D240A8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 23:51:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so879051pju.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 23:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OInmO8rSFsmcKxeQtJzT8W8mmV7pww/rcBlhAxG24c=;
        b=NdeTwUAK0mIJ9uNUIXjugJjyZR97tAm7onnDGPVrDJNsamWTpq4soNelwQZbjHtcRb
         ZQ9mAiNXmu3v7+xljofd50MBlb6m2jqGRbj2YatGDryT8jrv3iVH8qrZrwN3mRMwvayp
         GWMDHQnS9WcSO3iu/aVnzo9JKAUtfPs2hUoq5yIWKXQA245O5+GK9ZsfrfibXiOc6Bk7
         Oz53qrPN5S26eAzH3DvPHZtaQoI5EodeJ9VdjYObZlxF4IBLgxGj8RFMSiFm588sZud0
         oAfpN5ZROawjFT+3JZMmBRgMDV4e2pwxl9QYgXEQYi3QMXdv4mI1V3OgFFw8WUimYGj/
         26DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OInmO8rSFsmcKxeQtJzT8W8mmV7pww/rcBlhAxG24c=;
        b=voiugwOK8YCguRd1hNKiK4Zo0RvnhXfA+uAqX1D137ZnxUjHhl6HFyj9QfhFxOrpAh
         QnwZU2SdMljY4xYZdUygZaTA1/PKgeGVi9eyVidLl/hCAsoi41qPa1N160ce5FeVwBkc
         Jwu5lrxlW3E/0pLtQkrZ7qH4a6/ztfnVzMyHEB0+T+OqZ75zHlOyNs+sXcfMMDK2qWKF
         DCuZZ6hHA3Jg1uLYsu9ZWEeLzws7JQy4ijlA0soEWUNuPmLgJtB4/a8H0jZEFyTh95TC
         3/R5rIpGTB+j+ycHMo8wErlJZlaBSYS+5v/D1e8/FvgStaSaJkI4VTOb4soaCuu12OWK
         3TXA==
X-Gm-Message-State: AOAM532jj0qLzZyvqkmn1py/dz6Xlfo6+XGWkkA9lzM/28yTvSWppyng
        bNNJozVuPeKqVwwQHuhGSJhc8w==
X-Google-Smtp-Source: ABdhPJzbE466iFdZbKYpe1PIot8CbHomaZN9j8/BKjulSVhO8bzwNzlsoAEUZLvS6bLYcMcSnRxbvg==
X-Received: by 2002:a17:902:e889:b0:163:4f15:8a11 with SMTP id w9-20020a170902e88900b001634f158a11mr3128660plg.11.1653461486817;
        Tue, 24 May 2022 23:51:26 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id y12-20020a62ce0c000000b0050dc762812esm10631922pfg.8.2022.05.24.23.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 23:51:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     willy@infradead.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [PATCH v3] sysctl: handle table->maxlen robustly for proc_dobool
Date:   Wed, 25 May 2022 14:50:50 +0800
Message-Id: <20220525065050.38905-1-songmuchun@bytedance.com>
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
to sizeof(int) is counter-intuitive, it is easy to make mistakes in the
future (When I first use proc_dobool() in my driver, I assign
sizeof(variable) to table->maxlen.  Then I found it was wrong, it should
be sizeof(int) which was very counter-intuitive).  For robustness,
rework proc_dobool() robustly.  So it is an improvement not a real bug
fix.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Iurii Zaikin <yzaikin@google.com>
---
v3:
 - Update commit log.

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

