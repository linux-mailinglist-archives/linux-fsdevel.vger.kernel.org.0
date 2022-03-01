Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF44C936D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiCASnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiCASnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:43:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC232AF7;
        Tue,  1 Mar 2022 10:42:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e10so4372054wro.13;
        Tue, 01 Mar 2022 10:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TeI3507d5I5d8sWL74UFsXzTsRFXaxxogRMN3EfcUL4=;
        b=LdPOTjLabkU7/zIbdn4VCIMZIZSQmgc/235r+2YPMdMLkgtJQPyfdbd4GGyv4hlQZS
         pM1ND31djeboUtpn1X6x8W1byk96BvjXgoLTDitUr22i8GSWUU/XEyilySXcWH7iKI4l
         31YwD9la9+7dFpcuqWMY4l0eZ5B7DGG0ieFf0O7zKza87+uyAjKNcxsA/gFOfU7HK/5L
         iECbgV1oDH6xGrEEdqm5rwDjxxrHpPOCUn6y2PP7gKwiversNtHqqF/P/pCbNVXOQ0GM
         ancZ0g5rb3pgs0uYJRLUF1Ge32xPzS8Gq5/qLAJoorb+JGZApJMkGGb86H+zDn7KPkU2
         E/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TeI3507d5I5d8sWL74UFsXzTsRFXaxxogRMN3EfcUL4=;
        b=nejVseYhq1RpVIP0NL2NW8Iu6fTcEihus9L7l4/oS3JGGHN3O0vx1Oyn6EZca3GJju
         t6VeBBZ4fuoQuykzut253vJvSratIMMPyIx3YQg+NMVpZuV4CxloN2Vt5bNRIP99x5gp
         XyT4ecMvGw+Q0eMAz5U9TS1Q/LF7mBQDNh0+wY/JuM/AYjkw7SrPnMDk8ufZnexiIxRV
         Jp6jerxeJxPiJODKMe0qw2k9dijYi+yJiUPJOmE0JvWhDVrgTgLldqMZXSOHThYSxxds
         zW+m93YZ8pa2AMdweURbPaUv6fD1xu3L6rPhBHR+rK+IKbdv5dBiUSaaXbN5TfVC/1Gs
         IP5Q==
X-Gm-Message-State: AOAM5324XfgLZbbgN7N/k9mcHYUjddxUnq9f7x42zFA5ETFv1HOqfob6
        N4FpFzw0J8rBbzu7aNDSyTWn27V/Ioc=
X-Google-Smtp-Source: ABdhPJwvOfqdifTu/vH4ubef+Gb3fwAG2PvRcSmLbaoCBE/5m8ycUhfkkm26oT2LHe/uZBAuoKSQtQ==
X-Received: by 2002:a05:6000:1ac5:b0:1ea:7870:d7eb with SMTP id i5-20020a0560001ac500b001ea7870d7ebmr20983413wry.171.1646160157788;
        Tue, 01 Mar 2022 10:42:37 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm14020381wru.101.2022.03.01.10.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:42:37 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/6] lib/percpu_counter: add helpers for arrays of counters
Date:   Tue,  1 Mar 2022 20:42:16 +0200
Message-Id: <20220301184221.371853-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301184221.371853-1-amir73il@gmail.com>
References: <20220301184221.371853-1-amir73il@gmail.com>
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

Hoist the helpers to init/reset/destroy an array of counters from
nfsd_stats to percpu_counter library.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/export.c               |  7 ++++---
 fs/nfsd/nfscache.c             |  5 +++--
 fs/nfsd/stats.c                | 37 +++-------------------------------
 fs/nfsd/stats.h                |  3 ---
 include/linux/percpu_counter.h | 28 +++++++++++++++++++++++++
 lib/percpu_counter.c           | 27 +++++++++++++++++++++++++
 6 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 668c7527b17e..20770f049ac3 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -334,17 +334,18 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
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
+	percpu_counters_set(stats->counter, EXP_STATS_COUNTERS_NUM, 0);
 }
 
 static void export_stats_destroy(struct export_stats *stats)
 {
-	nfsd_percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
+	percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
 }
 
 static void svc_export_put(struct kref *ref)
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index a4a69ab6ab28..78e3820ea423 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -156,12 +156,13 @@ void nfsd_drc_slab_free(void)
 
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
index 01861eebed79..2051aab02d5d 100644
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
@@ -105,10 +109,25 @@ static inline int percpu_counter_init(struct percpu_counter *fbc, s64 amount,
 	return 0;
 }
 
+static inline int percpu_counters_init(struct percpu_counter counters[],
+				       int num, s64 amount, gfp_t gfp)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		percpu_counter_init(&counters[i], amount, gfp);
+	return 0;
+}
+
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
 {
 }
 
+static inline void percpu_counters_destroy(struct percpu_counter counters[],
+					   int num)
+{
+}
+
 static inline void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 {
 	fbc->count = amount;
@@ -193,4 +212,13 @@ static inline void percpu_counter_sub(struct percpu_counter *fbc, s64 amount)
 	percpu_counter_add(fbc, -amount);
 }
 
+static inline void percpu_counters_set(struct percpu_counter counters[],
+				       int num, s64 amount)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		percpu_counter_set(&counters[i], amount);
+}
+
 #endif /* _LINUX_PERCPU_COUNTER_H */
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

