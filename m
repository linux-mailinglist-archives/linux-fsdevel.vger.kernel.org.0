Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FD4CE5CC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiCEQFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiCEQFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A256518CC50;
        Sat,  5 Mar 2022 08:04:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i66so6671121wma.5;
        Sat, 05 Mar 2022 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upK+r5bGarAos+F72cjx71QAT29yIXZ4291fjq5oru0=;
        b=iqSK7Ddsf9Vq6/L3TpAxkesAk19RGszbk9snI6jOGr46XHHMtDJL0gwBZW3p7fxgfy
         zSLUfMwK+ZNWGfLE1PO8JrxO3Yk6dGf6ir3sx+xcoi8Ds0ztGSS7OKlrm1I8J7TM45Ji
         NDybf3WPXniD/vAPUWxND/DkVlrOIByS+SywNgeSX8sPQOgMH6d06yqLcuKFD1g/duoQ
         ja2g+C6bMU82ZprwyveJCkYExqWBywV+vt1TsdUp7Xka2KN/zxI7jQoqY4Qr4WNCG21f
         Vz9IGV/rU0CxwHk8Dyf+MRhTNQildWsenXOomVx/odVwxPpBkZVqgybV3nmIzATQ8wHd
         6uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upK+r5bGarAos+F72cjx71QAT29yIXZ4291fjq5oru0=;
        b=MHNxhvWEpxRf7vJ+3caVD+SwWhtd2GTyC21RqttN+U3aKCQgfj23Vig9G3r8lKOE75
         EQfdh2H4iccksiF3jIkcY2GbTOByQU+vUsSHh5zMU0mC6qCtPecmVr8ytJIClVRe4Cwe
         C51vwPy6bKy+N4LSyGFgK3wQt4dqTor41HK/vOn3kSzc3ncFLs/2NIZXljMx61IeEFVt
         wCHz9/bslm4G3gjDMek+4kbV273RHMOglj264v2ZuhKVI5kN+jcfBmT7bNynUB4gr304
         4DV+OTWeWvJn4f9YeTOiYLe/wGkZL/k1PCsFg3ygpMUhtpcT1Z7KMwkv/W9PjX8AffhE
         CCug==
X-Gm-Message-State: AOAM530lAjhCAX9Dw2k0Rx//dFMq9av5KMJXRjb1qhaq4KDYBHLW+Dec
        SDTw+zAFDufeCaCXwN2IUuE=
X-Google-Smtp-Source: ABdhPJxX/uFQS1YsNh4MAfmtV+HP82Vkk6OnTAqo1x4vPWpbuucAjtD9p1NyKDXssa/1JJaag9dbTg==
X-Received: by 2002:a1c:7916:0:b0:389:8d21:caa9 with SMTP id l22-20020a1c7916000000b003898d21caa9mr2816774wme.106.1646496294166;
        Sat, 05 Mar 2022 08:04:54 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:53 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 9/9] fs: enable per-sb io stats for all blockdev filesystems
Date:   Sat,  5 Mar 2022 18:04:24 +0200
Message-Id: <20220305160424.1040102-10-amir73il@gmail.com>
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

In addition to filesystems that opt-in with FS_SB_IOSTATS, auto-enable
per-sb I/O stats for all blockdev filesystems.

This can be used by tools like iotop to display the total I/O stats
via sb along side the submitted I/O stats to block device to get a
more complete view that also includes the cached I/O stats.

Link: https://lore.kernel.org/linux-fsdevel/20220302211226.GG3927073@dread.disaster.area/
Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index a18930693e54..e1bee46dfb5a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -232,7 +232,12 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	if (security_sb_alloc(s))
 		goto fail;
 
-	if (type->fs_flags & FS_SB_IOSTATS && sb_iostats_init(s))
+	/*
+	 * Account per-sb I/O stats for all blockdev filesystems and for
+	 * filesystems that opt-in with FS_SB_IOSTATS.
+	 */
+	if (type->fs_flags & (FS_SB_IOSTATS | FS_REQUIRES_DEV) &&
+	    sb_iostats_init(s))
 		goto fail;
 
 	for (i = 0; i < SB_FREEZE_LEVELS; i++) {
-- 
2.25.1

