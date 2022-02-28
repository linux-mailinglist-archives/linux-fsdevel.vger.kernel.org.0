Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65C04C6AD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 12:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiB1LkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 06:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbiB1LkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:40:12 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329571C8C;
        Mon, 28 Feb 2022 03:39:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j17so15027389wrc.0;
        Mon, 28 Feb 2022 03:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAdCnAeNh+/KXi8tE5JN2RpP/3wcVJ4rhcaX9E9RdrA=;
        b=W3vPFEEPyICp8MlhFKv76zhnFJNC9xv8u0PXU1xzwdb2TzfXc0FQISOxrdcEpg4Pym
         b24r8geHTgtGlgoqUdZdb+VRzQxUnsQaVqT4HVSb9fei3+6FspHdp32wi2/DjZnGb8Gt
         hvsF/ZDTmhHMkHshiP4AdTQdDtWSL8H5jGrxyJr1ql+qz3jdTyAgQ9wLhu/LHi4QYirZ
         6sJZYEg1BHZ9mOhW+xu7gVXPj+GDgrMgkA9H3qDtetATyb0amlpscozMVuP0sY0ey7/i
         eBdRMgm+JuNlv4FTCZarbAkAAdZie42tbQYEoQ24ePBLyXEaohO3etcu8TJK64j186XS
         xnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAdCnAeNh+/KXi8tE5JN2RpP/3wcVJ4rhcaX9E9RdrA=;
        b=d+U7PcxGH+yKdD5KSdYCE+Rmfjnc+vyjgLxQkzDxwl6c3XQG0SirMtjK+2ijq5L3vW
         EVjQOOvUKoM2eemxLQ+ll/5kxb9Th6dGbObgryZCrje9Cs5IhzRdvHLMQ/JTGObHWlN2
         E1Pku8jalNFsmW9C+7verKJ7tRx1MX7kHftR9v7O0wrKGY4FSol6W4/mpjjFzQziF4xZ
         yjKOGLbN39GF/AXDIKeg6iCa8xy2NGqy6pxzOd1B8RJlD1yL8TJDHlDSJ/OtgA/hZkEX
         Qg8j/sgrC9Dk4hsPoUjpSQrwOanEe33kN8jdxFpP3HqNLQ0q9AvchYJXzYbqZCK8g2rL
         pGIA==
X-Gm-Message-State: AOAM532mSUI2DGlDYK1aWec2qa4b4rJiSsBv1NqD9WPtYV+CEd5CrCp6
        GAzgjqhqmKBssKxxUEezPzM=
X-Google-Smtp-Source: ABdhPJzCwegu8RMbRSzfsAQ+1JNo6Vm/YBliXUJFP9x33x0YfWht3hz6LdU7WKY2g6lHTJ039q1VTw==
X-Received: by 2002:a5d:67ca:0:b0:1ed:d1e4:bce2 with SMTP id n10-20020a5d67ca000000b001edd1e4bce2mr15282901wrw.493.1646048372055;
        Mon, 28 Feb 2022 03:39:32 -0800 (PST)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id e22-20020adf9bd6000000b001eda1017861sm10584592wrc.64.2022.02.28.03.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:39:31 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        containers@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/6] ovl: opt-in for per-mount io stats
Date:   Mon, 28 Feb 2022 13:39:09 +0200
Message-Id: <20220228113910.1727819-6-amir73il@gmail.com>
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

Traditionally, system administrators have used the iostat utility
to track the amount of io performed to a local disk filesystem.

Similar functionality is provided for NFS mounts via the nfsstat
utility that reads the NFS client's stats from /proc/pid/mountstats.

There is currently no good way for a system administrator or a
monitoring application inside a container to track the amount of io
performed via overlayfs.

Opt-in for generic io stats via /proc/pid/mountstats to provide
that functionality.

This feature depends on CONFIG_MOUNT_IO_STATS.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7bb0a47cb615..802e4ed567cc 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2165,7 +2165,7 @@ static struct dentry *ovl_mount(struct file_system_type *fs_type, int flags,
 static struct file_system_type ovl_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "overlay",
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_MOUNT | FS_MOUNT_STATS,
 	.mount		= ovl_mount,
 	.kill_sb	= kill_anon_super,
 };
-- 
2.25.1

