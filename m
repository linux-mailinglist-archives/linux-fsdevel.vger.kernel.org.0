Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81484C9377
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbiCASnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiCASn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:43:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00ED6355;
        Tue,  1 Mar 2022 10:42:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r10so21971325wrp.3;
        Tue, 01 Mar 2022 10:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IbkBPOZHxyDhwbYI6C6WAbl6xgULu/qJuZj2bKD1dnc=;
        b=q6I+c6zPqDZ8NcQLkf2WIiIpNUtokW2SnfWmoxsQtHH1NYB4fdx/G3iRmuDL0br88e
         P3NYZiRu8ofeYfhBtpgG9eyK7q93yPoU+d/zk2CfLQq5sN35j1gQnJ19wklGrUJeobtQ
         aHIDB1cOwfjCae2g/VPWuFl9Xn8ZMVl5jigrtPMaoYOlsF/L5zWRwq9CcYMD1AFdOFCq
         K7Z4oAF4MJ1M5Ub0FdyT9RwcUV+s/0mD9kpZBFgOY+P7/7rHQ7sCPla6ng/Hqg3P3J0C
         8E4MYAyiZwMA7YrPeo9/Trs0FRuax9lcHQEHR3RtL//S2iAAiN9XQ1C5RlDKzdna23g/
         ml6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbkBPOZHxyDhwbYI6C6WAbl6xgULu/qJuZj2bKD1dnc=;
        b=nBGCZrNR+HNeNJL6/5PVh5WSqsUSUWDbscRC4RuWK8sVCSP5SYCc3zAXv8NMg4LjLd
         kfKZfM9LXOC6OQgYOCDDZxdDlyOX4fJg+F4cFvPDAYPKm1E1Mm26LBB4RDF3qabSaOmh
         x8LVBBKSmOwF+BkQc5Le42ZvVql1B4eDy+4WRrAUwlH5YJPnnKGZlRfQ4A1hkNXgbNrZ
         mUAMaoTeUYiW6Q01VLPkGpxDpJ8tiilOaPlMAPIQesCfvwq4Cag3fDDoZR/iG0W+ZQgM
         vZfKOHr2bq9JU6Y6nz3XrPvF/Kk3puKuQRAAlV/Zy5jbDNdJmJMbB6dBzOnwUZRKxHfh
         kNGw==
X-Gm-Message-State: AOAM531nQRTAIx47A7pCl5gZJwnPaBZdysDOOr0h5DBVScQLqOc0lY3Q
        iuiZrCtkjVrcjR+2i56CYzw=
X-Google-Smtp-Source: ABdhPJybUxlu+Sr/K1q/+6lGsklHkTQSyTz+hFA4ND4TtDdWCZL+Q8J/MifE8UeM2Ciewr/V58MU+w==
X-Received: by 2002:a05:6000:1864:b0:1ef:d2b0:560a with SMTP id d4-20020a056000186400b001efd2b0560amr8493910wri.38.1646160163271;
        Tue, 01 Mar 2022 10:42:43 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm14020381wru.101.2022.03.01.10.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:42:42 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 5/6] ovl: opt-in for per-sb io stats
Date:   Tue,  1 Mar 2022 20:42:20 +0200
Message-Id: <20220301184221.371853-6-amir73il@gmail.com>
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

Traditionally, system administrators have used the iostat utility
to track the amount of io performed to a local disk filesystem.

Similar functionality is provided for NFS mounts via the nfsstat
utility that reads the NFS client's stats from /proc/pid/mountstats.

There is currently no good way for a system administrator or a
monitoring application inside a container to track the amount of io
performed via overlayfs.

Opt-in for generic io stats via /proc/pid/mountstats to provide
that functionality.

This feature depends on CONFIG_FS_IOSTATS.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7bb0a47cb615..94ab6adebe07 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -6,6 +6,7 @@
 
 #include <uapi/linux/magic.h>
 #include <linux/fs.h>
+#include <linux/fs_iostats.h>
 #include <linux/namei.h>
 #include <linux/xattr.h>
 #include <linux/mount.h>
@@ -1979,6 +1980,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_d_op = &ovl_dentry_operations;
 
+	err = sb_iostats_init(sb);
+	if (err && err != -EOPNOTSUPP)
+		goto out;
+
 	err = -ENOMEM;
 	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
 	if (!ofs)
-- 
2.25.1

