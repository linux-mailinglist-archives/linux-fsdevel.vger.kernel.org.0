Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B444CE5BE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiCEQFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiCEQFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:35 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6173878C;
        Sat,  5 Mar 2022 08:04:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so8323130wmj.2;
        Sat, 05 Mar 2022 08:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjOj0yhcyWryfJc/gOuiHfZG2qtTwyBqMdR1AX5xLrk=;
        b=UCn+J6nrhzZt8zrm8r8aImFZRh1ijH4mj7j8aZ0F7QvalXFAxk3XDUz8G2cLY/YX/g
         UsYwHXeahy2z7tPJSrcA2SPJzyqtE5ro0vD/zwxqNVLixwa7QzO9PbcX/Cdth95iMtM8
         9/MIXBoiEJ2cbbnthQYRuTk3ma3b389OecLsWKXYxHulhXscyLKw0K1UHXxI0wlNoGKo
         ytim/ODnJYll/DSzgSmuyoiK/R7R0RFlh7UAm/P3nz46LPgVlH5nMBbVBmOOJsxyDMFf
         KghHrr5CLUOm9yzE82plVIF2W7i7rG962CyyUedxKArZXo26QphGTp3aqTE6yzj9IPpc
         L0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjOj0yhcyWryfJc/gOuiHfZG2qtTwyBqMdR1AX5xLrk=;
        b=UUwgY/SXAj4vu5NpEbwFUMzqJxJsBGM6OA9++yoT/dZXHBd0zsYhuXxcH8vDSOQDpr
         Ngd+JfacwDqJ8ut99qWlASTmCBOcASpokey00XQPXWX08Xp5JLwFi1Ig4qS3OFOVJae4
         ncCU74h1m2RftDKq2bbCnAoxI2JKw8SevGF7iijetiKpr0CNN7FwdpnmJlxUXwBg877D
         ue6LHmlP79T94u171nGyJ+3eTTjJ09fZ9C+iDXVnaIWabW/GyX4y4XewB6aBgtdcBN4i
         HDi2x//BBR6SH5uv3wGc6NuUriaDNqWQMIn9eucSiHI77al4aQgM93oXj1QPaLM+bPa3
         0w8w==
X-Gm-Message-State: AOAM531G1DT3EZ589YqCSmEHoczQHFViFfrfD+ZC0QGR5DAqxjL6B0xP
        eNQZdpAA0XvFzuiW50lYYxKa/X5y8HU=
X-Google-Smtp-Source: ABdhPJzoafBUfwkUKcPtn01V4gK510mJCn220fcKXrpkTJk3pwAjQG55bDc5Ky4Up6fkOF8ElAmMIw==
X-Received: by 2002:a1c:ed18:0:b0:37e:7a1d:a507 with SMTP id l24-20020a1ced18000000b0037e7a1da507mr11974558wmh.187.1646496283830;
        Sat, 05 Mar 2022 08:04:43 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:43 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 2/9] lib/percpu_counter: add helpers for arrays of counters
Date:   Sat,  5 Mar 2022 18:04:17 +0200
Message-Id: <20220305160424.1040102-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305160424.1040102-1-amir73il@gmail.com>
References: <20220305160424.1040102-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hoist the helpers to init/destroy an array of counters from
nfsd_stats to percpu_counter library.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/export.c               | 10 ++++++---
 fs/nfsd/nfscache.c             |  5 +++--
 fs/nfsd/stats.c                | 37 +++-------------------------------
 fs/nfsd/stats.h                |  3 ---
 include/linux/percpu_counter.h | 19 +++++++++++++++++
 lib/percpu_counter.c           | 27 +++++++++++++++++++++++++
 6 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 668c7527b17e..ec97a086077a 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -334,17 +334,21 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
 static int export_stats_init(struct export_stats *stats)
 {
 	stats->start_time = ktime_get_seconds();
-	return nfsd_percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM);
+	return percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM, 0,
+				    GFP_KERNEL);
 }
 
 static void export_stats_reset(struct export_stats *stats)
 {
-	nfsd_percpu_counters_reset(stats->counter, EXP_STATS_COUNTERS_NUM);
+	int i;
+
+	for (i = 0; i < EXP_STATS_COUNTERS_NUM; i++)
+		percpu_counter_set(&stats->counter[i], 0);
 }
 
 static void export_stats_destroy(struct export_stats *stats)
 {
-	nfsd_percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
+	percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
 }
 
 static void svc_export_put(struct kref *ref)
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 0b3f12aa37ff..d93bb4866d07 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -150,12 +150,13 @@ void nfsd_drc_slab_free(void)
 
 static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
 {
-	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
+	return percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM, 0,
+				    GFP_KERNEL);
 }
 
 static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
 {
-	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
+	percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
 
 int nfsd_reply_cache_init(struct nfsd_net *nn)
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index a8c5a02a84f0..933e703cbb3b 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -84,46 +84,15 @@ static const struct proc_ops nfsd_proc_ops = {
 	.proc_release	= single_release,
 };
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
-{
-	int i, err = 0;
-
-	for (i = 0; !err && i < num; i++)
-		err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
-
-	if (!err)
-		return 0;
-
-	for (; i > 0; i--)
-		percpu_counter_destroy(&counters[i-1]);
-
-	return err;
-}
-
-void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
-{
-	int i;
-
-	for (i = 0; i < num; i++)
-		percpu_counter_set(&counters[i], 0);
-}
-
-void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
-{
-	int i;
-
-	for (i = 0; i < num; i++)
-		percpu_counter_destroy(&counters[i]);
-}
-
 static int nfsd_stat_counters_init(void)
 {
-	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+	return percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM,
+				    0, GFP_KERNEL);
 }
 
 static void nfsd_stat_counters_destroy(void)
 {
-	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+	percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
 }
 
 int nfsd_stat_init(void)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 9b43dc3d9991..61840f9035a9 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -36,9 +36,6 @@ extern struct nfsd_stats	nfsdstats;
 
 extern struct svc_stat		nfsd_svcstats;
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
 int nfsd_stat_init(void);
 void nfsd_stat_shutdown(void);
 
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 7f01f2e41304..37dd81c85411 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -46,6 +46,10 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc);
 int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
 void percpu_counter_sync(struct percpu_counter *fbc);
 
+int percpu_counters_init(struct percpu_counter counters[], int num, s64 amount,
+			 gfp_t gfp);
+void percpu_counters_destroy(struct percpu_counter counters[], int num);
+
 static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
 {
 	return __percpu_counter_compare(fbc, rhs, percpu_counter_batch);
@@ -109,6 +113,21 @@ static inline void percpu_counter_destroy(struct percpu_counter *fbc)
 {
 }
 
+static inline int percpu_counters_init(struct percpu_counter counters[],
+				       int num, s64 amount, gfp_t gfp)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		counters[i] = amount;
+	return 0;
+}
+
+static inline void percpu_counters_destroy(struct percpu_counter counters[],
+					   int num)
+{
+}
+
 static inline void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 {
 	fbc->count = amount;
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index ed610b75dc32..f75a45c63c18 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -181,6 +181,33 @@ void percpu_counter_destroy(struct percpu_counter *fbc)
 }
 EXPORT_SYMBOL(percpu_counter_destroy);
 
+int percpu_counters_init(struct percpu_counter counters[], int num, s64 amount,
+			 gfp_t gfp)
+{
+	int i, err = 0;
+
+	for (i = 0; !err && i < num; i++)
+		err = percpu_counter_init(&counters[i], amount, gfp);
+
+	if (!err)
+		return 0;
+
+	for (; i > 0; i--)
+		percpu_counter_destroy(&counters[i-1]);
+
+	return err;
+}
+EXPORT_SYMBOL(percpu_counters_init);
+
+void percpu_counters_destroy(struct percpu_counter counters[], int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		percpu_counter_destroy(&counters[i]);
+}
+EXPORT_SYMBOL(percpu_counters_destroy);
+
 int percpu_counter_batch __read_mostly = 32;
 EXPORT_SYMBOL(percpu_counter_batch);
 
-- 
2.25.1

