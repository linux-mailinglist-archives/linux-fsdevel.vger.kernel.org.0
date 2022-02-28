Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A594C6AD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiB1LkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 06:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiB1LkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:40:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812A71C91;
        Mon, 28 Feb 2022 03:39:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d28so14977247wra.4;
        Mon, 28 Feb 2022 03:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wlzIgcPfmWlzG8mZw8mU98HRU6UG4iDulaqC27k8XE=;
        b=HaWNuoLURtPmskYk3JMn81nh3G+CEz3F1Cb6avefJRfg7bdzYCv0GQKlYd01uf1icx
         ebYnR976irKAf+AiZ88Hy85/ZhE/9numO00I1Nq1PbXHsrTpJ0PUn1lh9tmaLzUbOchs
         xrIUDA4n5tRz8t/MhjFjEmnni4Jg3DeKqZ+GIAbNEfbUqfJ4DNGAJDERCfixc0ba55OX
         EcMYlns3XqGLd7TQsJCQGlUz9d7wHnRuZE6bzo4cstColw0lQnaoW8N2nZ33xUxye/fU
         OIyRC1Kufdq/kwwjy7Mr4zqMuAM58/571xa7kVUKcMy1lRCN7IhfbqvIqZtyNzu71vDh
         dCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wlzIgcPfmWlzG8mZw8mU98HRU6UG4iDulaqC27k8XE=;
        b=GuBHQ1YlOEXT2K4NJmTCYHSDMf9jqrxzOqpqGm/IBKZj21/WiaDkfipIPd+FjVrfLt
         rhwWCqkY5qPOviic54ibjs21mSw7MpJN+Oilr2MFxf3Uwbdgrm/58JwbQu4y5wy/awnj
         h23WOsxGWokzKUXkztVFXWaOFIWRIVpHb4ccakW1nrOOhqexIaQUbrKam7vmu6ej38NK
         zuBU/okYSvdGJwfjVigRaKst5u3h2u0OVvV+0/KKXHTZhxkJMKmNgxRxNo7Bf6/Z1Y+M
         +WQRnYoJ79uFu7RsjT/gQeBTYJsourR6E9HMvouC+T7j+gjY/ix+WTLtyXbpzRUkbUUm
         i+2Q==
X-Gm-Message-State: AOAM531vpEe86J8xl5yKW1ZUYKGS/Gv4NS+Y6wn2r2yrGcOiW16A0/T5
        5+hf3kOit6/uQescbVS8h/I=
X-Google-Smtp-Source: ABdhPJx3/58BLQbW37CqO1FcM0VcammSp/oCUcSsL3jYD3As8LSPNJ9Se3sgmxWJkzo6qkIg/DhlVA==
X-Received: by 2002:a5d:47ae:0:b0:1ef:d725:876e with SMTP id 14-20020a5d47ae000000b001efd725876emr2777714wrb.447.1646048373450;
        Mon, 28 Feb 2022 03:39:33 -0800 (PST)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id e22-20020adf9bd6000000b001eda1017861sm10584592wrc.64.2022.02.28.03.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:39:33 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        containers@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/6] fuse: opt-in for per-mount io stats
Date:   Mon, 28 Feb 2022 13:39:10 +0200
Message-Id: <20220228113910.1727819-7-amir73il@gmail.com>
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
monitoring application to track the amount of io performed via fuse
filesystems.

Opt-in for generic io stats via /proc/pid/mountstats to provide
that functionality.

It is possible to collect io stats on the server side inside libfuse,
but those io stats will not cover cached writes and reads.  Therefore,
implementing the server side io stats would be complementary to these
client side io stats.  Also, this feature provides the io stats for
existing fuse filesystem/lib release binaries.

This feature depends on CONFIG_MOUNT_IO_STATS.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9ee36aa73251..5c58583a12fc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1806,7 +1806,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT | FS_MOUNT_STATS,
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_anon,
-- 
2.25.1

