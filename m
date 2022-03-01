Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6E4C9376
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiCASnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiCASn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:43:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B505F9F;
        Tue,  1 Mar 2022 10:42:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so1271225wmj.2;
        Tue, 01 Mar 2022 10:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=keu9XQdfLfISkI3it9Db+YQ9uyOCCwUS2A+od60Osj8=;
        b=G+z/lzCJEZBFBWlqsLo6tNPh4FGNQTLjf5h5dqt3kIF3nwF/8hymAed/XgdjfQuDtA
         ICIIUY9c1yd3YT8SdK5V+7+5FpH6hc3GEO9uHSPV4A6y+FCmAG5E7kpgNuB2JsQVBca4
         5nN7lnp0iv/5+Q/ajOjjmXYzU2ZZsBiHr1qxulIsTHw47/Jjc+ZLLFqViRjZAl8suV4k
         k/JJ835Rhp9n/5WgF6joh34HGv5lOeS6pYvDrIfFObUfmQs1tIhU3OgulDVDuTDpNXJk
         fnriEbUF9nswpXgpcAIHGz5qhisT6iGST8uvxhdBkldMqO90Khav9/1GtPZx8IvxRI0J
         b0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=keu9XQdfLfISkI3it9Db+YQ9uyOCCwUS2A+od60Osj8=;
        b=qt7Do7habv4pnVuutwONMcNrJ/3IBf4j2Y0bdWSurRmaxsLHLYPFguVA416W7pWHHl
         i/Y9t7l9UfJsXX1t2njfZ0W8sdm5R/T6Hu2wNEI7TjscSHR5DEaNvLszPJmr7JMR3jdC
         zlLDLVJ3/3S+TCB0QvN7UMKtJYaQferfomkqCCJVx/T8JFl7DNOD28+AdYf6uzwPezcY
         bJBLI+cuYRpqyWyqPzX4ON75ydg2gG4mow2mjzDgZh4fgglbYKFoA5ia2WieqPac8+mI
         wQZdAiyAPPt8QmgTiNohGdBqZl2e+sl1BSPe3aBpEpRk/NR0fZDRhKHeCMASH3ghSKHi
         CD2g==
X-Gm-Message-State: AOAM5301UZpFhBvgemxpVUhkZp/M0iZAl27OWwWfdVl8GwEifQsB17an
        ZW9EfK7vclG/9AExSjlC10s1eNptx/4=
X-Google-Smtp-Source: ABdhPJz4MhuP1dVTfxo3a0hBm9dAT0IO3U32gcTpSu/6Qml5rElhu8Bg/0welr5e0juVKTefq8i2Tw==
X-Received: by 2002:a7b:cb46:0:b0:37b:dd79:e1c4 with SMTP id v6-20020a7bcb46000000b0037bdd79e1c4mr17704458wmj.39.1646160164933;
        Tue, 01 Mar 2022 10:42:44 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm14020381wru.101.2022.03.01.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:42:44 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/6] fuse: opt-in for per-sb io stats
Date:   Tue,  1 Mar 2022 20:42:21 +0200
Message-Id: <20220301184221.371853-7-amir73il@gmail.com>
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
 fs/fuse/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9ee36aa73251..f19c666b9ac3 100644
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
@@ -1517,6 +1518,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	if (sb->s_flags & SB_MANDLOCK)
 		goto err;
 
+	err = sb_iostats_init(sb);
+	if (err && err != -EOPNOTSUPP)
+		goto err;
+
 	rcu_assign_pointer(fc->curr_bucket, fuse_sync_bucket_alloc());
 	fuse_sb_defaults(sb);
 
-- 
2.25.1

