Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36FD4C6ACD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 12:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiB1LkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 06:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbiB1LkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:40:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD749546BD;
        Mon, 28 Feb 2022 03:39:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p9so14922283wra.12;
        Mon, 28 Feb 2022 03:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60gB9AriL6gaM3w175kpPdcTv3rvAhXleKe422vVwHk=;
        b=EvTIWH/jdIDhUHxDSrHTVPySVpj2HzWLxs4IAGQ6uHusQi/DeHlavy9hdipTShJr46
         bXG6JM1wfB1CBJg4afv/WnLrUC6r1cdifAmd0JxSUrJKrpolXWyhkgrb/s8nAVV6hl/q
         AWLy1C+HL10gXPNhMPsm3iWcmp9FLCNFJg/V6n/MphemPdZ364LIZWtnfpeo9Aw7IbPv
         Ps2vgLMKh0ZUpYXH0AMSjOyOI8ZimJBftHcrItAIKoWhyimRzX7pm7LLywxri6SeFOC1
         TUwLWdikWDDjjtmfoCxnVob+3x7+RyF7kW0/89y0ODx+/ZoaFwp0lnpETEzUoSvbZ2lM
         d3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60gB9AriL6gaM3w175kpPdcTv3rvAhXleKe422vVwHk=;
        b=m2vIW5VKyEkOiRTzfvSMJ5cwmxd2h+e1ps4jNFWiiKnFnQ9OQL/pUFoRb34+ZJDFW/
         92daXThG7dYVQ0byux9F52r7PpJkoLs1YPPSPwpzPUL6g4mtsQMhT+3oMZ5v2FPq8wQr
         H8EwO3sya2ddRtAQeW1SEwyR2RejvKaIBkaJRQvlOOzVVZ4hC7j2owfSOISeyaxgV5Hp
         Gah1EKD3lRZa4pEeWfLustJTu7ymbK5CJmr6gjo0cRHUutrCQ3u5Q0Y9ZHYni6FqNUj2
         OAgjvGuk4UefGdHdyIt+nOYdPpDrhdyLhxdNoIiyLKrWAz6iy6EzGJgF5xS1fpOdArR2
         IWMQ==
X-Gm-Message-State: AOAM533hr78PLgbQU3OgcvWF/SmepWBNnDu3nmcu+C5fMhQpt+pE3Zze
        BOcocsgqP5fghVtCSFn+Y6g=
X-Google-Smtp-Source: ABdhPJzZby2nYbVJIxtneu/jpoJkEFhyJnfzlLRuL5N3pry5CTAbnaTl3XixCUWJh3GkQQ3Ngx4yAw==
X-Received: by 2002:a05:6000:1786:b0:1ea:78aa:5e1b with SMTP id e6-20020a056000178600b001ea78aa5e1bmr15603487wrg.544.1646048366326;
        Mon, 28 Feb 2022 03:39:26 -0800 (PST)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id e22-20020adf9bd6000000b001eda1017861sm10584592wrc.64.2022.02.28.03.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:39:25 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        containers@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/6] fs: add iostats counters to struct mount
Date:   Mon, 28 Feb 2022 13:39:05 +0200
Message-Id: <20220228113910.1727819-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228113910.1727819-1-amir73il@gmail.com>
References: <20220228113910.1727819-1-amir73il@gmail.com>
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

With config MOUNT_IO_STATS, add an array of counters to struct mnt_pcp
that will be used to collect I/O statistics.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/Kconfig     |  9 +++++++++
 fs/mount.h     | 32 ++++++++++++++++++++++++++++++++
 fs/namespace.c | 17 +++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 6c7dc1387beb..60baa861b3e4 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -15,6 +15,15 @@ config VALIDATE_FS_PARSER
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.
 
+config FS_MOUNT_STATS
+	bool "Enable per-mount I/O statistics"
+	depends on SMP
+	help
+	  Enable this to allow collecting per-mount I/O statistics and display
+	  them in /proc/<pid>/mountstats.
+
+	  Say N if unsure.
+
 config FS_IOMAP
 	bool
 
diff --git a/fs/mount.h b/fs/mount.h
index 0b6e08cf8afb..b22169b4d24c 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -24,9 +24,25 @@ struct mnt_namespace {
 	unsigned int		pending_mounts;
 } __randomize_layout;
 
+/* Similar to task_io_accounting members */
+enum {
+	MNTIOS_CHARS_RD,	/* bytes read via syscalls */
+	MNTIOS_CHARS_WR,	/* bytes written via syscalls */
+	MNTIOS_SYSCALLS_RD,	/* # of read syscalls */
+	MNTIOS_SYSCALLS_WR,	/* # of write syscalls */
+	_MNTIOS_COUNTERS_NUM
+};
+
+struct mnt_iostats {
+	s64 counter[_MNTIOS_COUNTERS_NUM];
+};
+
 struct mnt_pcp {
 	int mnt_count;
 	int mnt_writers;
+#ifdef CONFIG_FS_MOUNT_STATS
+	struct mnt_iostats iostats;
+#endif
 };
 
 struct mountpoint {
@@ -148,3 +164,19 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 }
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
+
+static inline void mnt_iostats_counter_inc(struct mount *mnt, int id)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	this_cpu_inc(mnt->mnt_pcp->iostats.counter[id]);
+#endif
+}
+
+static inline void mnt_iostats_counter_add(struct mount *mnt, int id, s64 n)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	this_cpu_add(mnt->mnt_pcp->iostats.counter[id], n);
+#endif
+}
+
+extern s64 mnt_iostats_counter_read(struct mount *mnt, int id);
diff --git a/fs/namespace.c b/fs/namespace.c
index de6fae84f1a1..3fb8f11a42a1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -306,6 +306,23 @@ static unsigned int mnt_get_writers(struct mount *mnt)
 #endif
 }
 
+s64 mnt_iostats_counter_read(struct mount *mnt, int id)
+{
+	s64 count = 0;
+#ifdef CONFIG_FS_MOUNT_STATS
+	/*
+	 * MOUNT_STATS depends on SMP.
+	 * Should be trivial to implement for !SMP if anyone cares...
+	 */
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		count += per_cpu_ptr(mnt->mnt_pcp, cpu)->iostats.counter[id];
+	}
+#endif
+	return count;
+}
+
 static int mnt_is_readonly(struct vfsmount *mnt)
 {
 	if (mnt->mnt_sb->s_readonly_remount)
-- 
2.25.1

