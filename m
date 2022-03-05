Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC4B4CE5CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiCEQFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiCEQFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D35A38BE0;
        Sat,  5 Mar 2022 08:04:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n15so2781562wra.6;
        Sat, 05 Mar 2022 08:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwkEll/Fp2m1q/Q8MPQnu9BfhDdiF2uLgfkNWk7jG1o=;
        b=c8xfrY5KMxjGvAbdGOgwAAuBDQDUEomIJbz3cBMAkBlT3hYDhKNB/IssIKsfrbzz40
         C4wsUqOZhH6LQyPd7Q0VsTBE6/tGHr0yDcT+odnUfukSHqW3qNesQomZNJF5s89vpBkf
         M4hySUX9hx9u3JLu8qPbjwWvwIg1WK4f7MsXE8q1d9QbtC+2/TFqzSnlLneoHT4GSWUV
         zxmTpUnNGIxUfC46J544RzUlYJhP4mMM3BO1a9jFCPWpZIjyg/Eg5xwkJQkY6ajk0ncF
         hiWXiyOFGCLCamxhSC8sk82XnG6yUPQOixmY2HRSEY1oExsintzR9NgmrUwXX06bI+OR
         yTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwkEll/Fp2m1q/Q8MPQnu9BfhDdiF2uLgfkNWk7jG1o=;
        b=oA3DLQCOFRqbj/u1IV/j8KQ5X23nHldM6PTwLZyxX3VsqtWzt3cHDZYACruWvwvOSI
         LjI8Xo9bw6dfVy66Y6YpKkUfQQEgVcmP1cdoIGzfebk+JtzaotXXbv3We69R8zVZW3su
         fmE8db5z/fQUVGIS/wA0K3p+XFSovs8apH1LjIqJZ/XmaYqIaVFcUJaX7gRPtRslHDjA
         Mxlc6npqh03wgNuwh7dAN7GFWiblc3ccOKumfXPXmHCXBfmsj9egxeAstXN8wmjYhAR6
         3lbAr1PQDjaBvb9fz7ewE0d1YVzJJ46q5gZP5TkG/GOr162pSHvnz0P/wExkhAXr8YnM
         73QA==
X-Gm-Message-State: AOAM532DmVLpBAZMaOtsVs+275BbVlETMbwPO4IhNMJ9K/tvNeGAchGm
        J7qBA66fuhTUYRtE5mMfgQU=
X-Google-Smtp-Source: ABdhPJwGvoYr/6vkLkjML4gFOAxQ7zCfqGtN6TOiFIiJi3ZZz6Vacwc2+Y2wT1k/tLZ1HfDeBJ7oCQ==
X-Received: by 2002:a5d:6da1:0:b0:1e3:2bf5:13c with SMTP id u1-20020a5d6da1000000b001e32bf5013cmr3018931wrs.316.1646496292881;
        Sat, 05 Mar 2022 08:04:52 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:52 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 8/9] fuse: opt-in for per-sb io stats
Date:   Sat,  5 Mar 2022 18:04:23 +0200
Message-Id: <20220305160424.1040102-9-amir73il@gmail.com>
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

Traditionally, system administrators have used the iostat utility
to track the amount of io performed to a local disk filesystem.

Similar functionality is provided for NFS mounts via the nfsstat
utility that reads the NFS client's stats from /proc/pid/mountstats.

There is currently no good way for a system administrator or a
monitoring application to track the amount of io performed via fuse
filesystems.

Opt-in for generic io stats via /proc/pid/mountstats to provide
that functionality.

It is possible to collect io stats on the server side inside libfuse,
but those io stats will not cover cached writes and reads.  Therefore,
implementing the server side io stats would be complementary to these
client side io stats.  Also, this feature provides the io stats for
existing fuse filesystem/lib release binaries.

This feature depends on CONFIG_FS_IOSTATS.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9ee36aa73251..a2cd90e059f8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/fs_context.h>
+#include <linux/fs_iostats.h>
 #include <linux/fs_parser.h>
 #include <linux/statfs.h>
 #include <linux/random.h>
@@ -1806,7 +1807,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT | FS_SB_IOSTATS,
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_anon,
-- 
2.25.1

