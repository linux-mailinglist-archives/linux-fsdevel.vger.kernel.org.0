Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111464C9374
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiCASna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiCASnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:43:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4130B60E8;
        Tue,  1 Mar 2022 10:42:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t11so949280wrm.5;
        Tue, 01 Mar 2022 10:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ueonWTV//RvtAAAtBT8j+To7cQQtx5NYZB3dLunG3vo=;
        b=Vp5u/dG3SIycMZeKXNcldGx9X1K4Vy/TwiYNqSqJwbAOpB3a3gdPwptS84IONVHao2
         a5jUW3bacopJO71ZjBszFhEPKgCB65rdva5zzhu2CqyVkU4GdqLu9FvBF/+6ln5iag4p
         hy4CmlJnKDHhzN6OIC/mmI+ncWIXAqI2mdIOHG0JrI1iiurq4cpneUjDb3Pl0PAGhizZ
         TbbV/b6p7e84gOlkmVeC0BtYFVbNwS6mm7RjR8EFju0MBGLj1PXdYJRtc3Q4z+psb7Nb
         fGkIPYeQS5Ni8avnfgSalslsgmL+QecYu5VsiP03QRn1ZxtaJ8QNUN4dVvmVYKzqv/F0
         iw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ueonWTV//RvtAAAtBT8j+To7cQQtx5NYZB3dLunG3vo=;
        b=jR9f1aR1akSgHUfCOILcdEe+5GxIER1SIo16WKDGgGPdxs846DPp02dd46fxwB5m20
         GfqkSq3YxDYrvElTF4VUxHXi6QWHUmPeGUbaUiXQOA5cHZmY6g6V9VRDoFm/Ri9P3vmg
         2oLNzuwKuJNhtMO6JE5QlgQoC9ln55pOmIp4pXAXAvFR0RUkCSk+6PcfX/VEy5AH8x2t
         oc9Qo8QtZjbGw6eZZxn7qLOHQomtlrWX1lf+7AiupJnxCuHRUHUEQKLZWM3FC4bNxi1d
         7Tnr+LT7D2KBj/pogSz7le96RoZhsb/HS/DgV3Kho/50tW6gow3XTykKQsSp4R7hLWGH
         jrdg==
X-Gm-Message-State: AOAM530SNa6ZSLHJATjJZhmY+pr2EekOl8fUjKPXYnN/oj5JPexAcrw8
        gR8lZc+LjuKT1b+elB/2C6w=
X-Google-Smtp-Source: ABdhPJwBn9+3kcV+Ev0GGTjW3YMOEQ5GEVq+NX4Vv5Kbm5xNwBpSV6vaWAu2zmnFDehK0pGVIshBJA==
X-Received: by 2002:adf:e751:0:b0:1f0:2139:2489 with SMTP id c17-20020adfe751000000b001f021392489mr2451021wrn.319.1646160161732;
        Tue, 01 Mar 2022 10:42:41 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm14020381wru.101.2022.03.01.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:42:41 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/6] fs: report per-sb io stats
Date:   Tue,  1 Mar 2022 20:42:19 +0200
Message-Id: <20220301184221.371853-5-amir73il@gmail.com>
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

Show optional collected per-sb io stats in /proc/<pid>/mountstats
for filesystems that do not implement their own show_stats() method
and opted-in to generic per-sb stats with sb_iostats_init().

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

