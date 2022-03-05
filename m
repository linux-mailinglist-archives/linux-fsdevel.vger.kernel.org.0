Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C994CE5C9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiCEQFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiCEQFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B5652CE;
        Sat,  5 Mar 2022 08:04:51 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c192so6671449wma.4;
        Sat, 05 Mar 2022 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gl15jVHDWqQUQcpXGK7b6MQUnuZpOd6NqFaENFI8dkU=;
        b=NGT+lmyuM3B8f/o23zzVpt18DkPE+YnPfDiBMv0xJX9yW28ILYB7HoN3niGKsRrvtS
         rupYn6Qa+RnL7rgz2qSaAxxtyM/q4y7G5zU7W1ZDiJZdqFXr54CM9uU+/+mxRBerPxlk
         xSswoIRT97p5+jZyf948JagexhFdnii1VDJbO34oZtjH/YdCHfKvXPkEhsZvDdotNrk+
         dk1rLZ+nX/FQuYcTGoTKf3a7nxvbpw35Qha8JdG1GYShBxuTjWf28qquWeqOGObwhgg8
         VyxX5WSviA6cXM+FBF7ehUyeA8kEPN3bmZemQdxr7KAo9/ns2V7mNUKxZNffLskd072V
         PoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gl15jVHDWqQUQcpXGK7b6MQUnuZpOd6NqFaENFI8dkU=;
        b=ojKPGUVC7SB+yrQT6DXM1/W3FwowjuaCA2/7MfVdwH6s1CmGutfwwdARC3L/pWQPhC
         oP34hLBWroUEZ5CpG1QESiM4bvbyLLR2ZTYYFR36w7whGkqdmgxAg57+lM/OiByCNoBr
         oMI+nKDJqgL6Vi4e80ErJSTvSH2/KyF7pB2fFnLf9VcaOBPTbuHno2M7Jd2zTc3QSh0s
         7uC4Gb5UNahGIg739KaxkUPy1rYxkfhr9kH02DhdFTYPr/HVmke50HFnBIpK5WIRD87T
         D6fWAdZ/74MPBCWdyFF8v19msBVL2UNcfeq/KWPQTO6IY09aAkqSeBtHF0/G+jW7qDXf
         PGyA==
X-Gm-Message-State: AOAM531dnebIgNNyfbI1kJVoqe01ulera7dFj1LpOf4e/E7cYFg7O8Gk
        xIZ0bMhzgf3LhTfIpvudM+FrRF7ftOM=
X-Google-Smtp-Source: ABdhPJwzSqC7SMuIZY0VYJ23xyzOpk5c2DMYmZ19g11IitMRBy+GdmJLnfLURcnoJt4dkB+T8rvYfA==
X-Received: by 2002:a05:600c:3d99:b0:381:546c:8195 with SMTP id bi25-20020a05600c3d9900b00381546c8195mr12006349wmb.112.1646496289826;
        Sat, 05 Mar 2022 08:04:49 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:49 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 6/9] fs: report per-sb io stats
Date:   Sat,  5 Mar 2022 18:04:21 +0200
Message-Id: <20220305160424.1040102-7-amir73il@gmail.com>
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

Show optional collected per-sb io stats in /proc/<pid>/mountstats
for filesystems that do not implement their own show_stats() method
and have generic per-sb stats enabled.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/proc_namespace.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 49650e54d2f8..9054a909e031 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -11,6 +11,7 @@
 #include <linux/nsproxy.h>
 #include <linux/security.h>
 #include <linux/fs_struct.h>
+#include <linux/fs_iostats.h>
 #include <linux/sched/task.h>
 
 #include "proc/internal.h" /* only for get_proc_task() in ->open() */
@@ -232,6 +233,21 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
 	if (sb->s_op->show_stats) {
 		seq_putc(m, ' ');
 		err = sb->s_op->show_stats(m, mnt_path.dentry);
+	} else if (sb_has_iostats(sb)) {
+		struct sb_iostats *iostats = sb_iostats(sb);
+
+		/* Similar to /proc/<pid>/io */
+		seq_printf(m, "\n"
+			   "\ttimes: %lld %lld\n"
+			   "\trchar: %lld\n"
+			   "\twchar: %lld\n"
+			   "\tsyscr: %lld\n"
+			   "\tsyscw: %lld\n",
+			   iostats->start_time, ktime_get_seconds(),
+			   sb_iostats_counter_read(sb, SB_IOSTATS_CHARS_RD),
+			   sb_iostats_counter_read(sb, SB_IOSTATS_CHARS_WR),
+			   sb_iostats_counter_read(sb, SB_IOSTATS_SYSCALLS_RD),
+			   sb_iostats_counter_read(sb, SB_IOSTATS_SYSCALLS_WR));
 	}
 
 	seq_putc(m, '\n');
-- 
2.25.1

