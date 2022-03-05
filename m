Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A54CE5CA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiCEQFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiCEQFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9919454BCA;
        Sat,  5 Mar 2022 08:04:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so8246357wmq.4;
        Sat, 05 Mar 2022 08:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hK1LzTjIk6ekWwoL6fV3lgEDT91apb0sc/qKFWvkbwM=;
        b=GkGHEWXxoTrPmH7Mk9MIFj2BM8l3ufOFVCLLXWHxR8bK3DVGd/dDIhbYk6gclKD6bf
         hjgotmE9sslhMjmATEfbG+Up6lv6K7UPNisDm2UYrD+6IlKR7ml+TJGbaR6hi2GXj1ac
         ogycxiqdjNjvQFyTIS4i3WRLDZRXjVvfDH5shzXYp59T6OEA5D50f2FDaIYrD+e9HHwt
         K0jElp3++G9O8aNq4XNwqPS/DEGlgm9UEmmN3ubFNfgflBoUl8cq1hNkiCkvBE98NI5s
         FM9iU9O1d1E6/VYPevFmtxQYSlFrfR5fk8ZxHOX7r5t1I2cQLfAJfbshcnM7YgaLZLav
         dJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hK1LzTjIk6ekWwoL6fV3lgEDT91apb0sc/qKFWvkbwM=;
        b=7FpwxCKrRR76O9GclVsK3nA6i8l00o0T9ZXIVaATuRpRR87a+oP+LFNLZEHRFwgITI
         +bCQEEwMml5ifqi/FiB+wfOfyoB3rTiEYXhep7vNNFnDUJFquTiTpI3vekot/HbowRvC
         0z1KlweCtaV6AUpxLUsUiCRB+uem+ERtouAIpPo/Jnv4BQg96/0nJqREhwKvyoHV6txQ
         9XDTij3bcj+FYzrjgn4eEZTJmxgyiEoZDQvxHH4AHLCr0W2mdAotxmz/zmvIoSg9svWg
         vc8+KahPoIpMYNhCnZLLsCVB4vH7LJgQSqv3z65L1AqPZWRiYT5hJoI/oUH5HsBSH3gh
         UGQA==
X-Gm-Message-State: AOAM530bDQZ9K3UDcr6FM9Y0zcBlU36wnDxQyc1PdmNAOAKN6CJMlbwc
        j6UoGjq2ItpWT/DjVtKDRFw=
X-Google-Smtp-Source: ABdhPJxg6VAl9eZiZSmVUrGkXdtNwip7gD1K7QQ4gpXJAXSjwMqfIP6PnbCdp9EovoVRJ8r6YXTOAw==
X-Received: by 2002:a05:600c:3541:b0:389:95b2:5f63 with SMTP id i1-20020a05600c354100b0038995b25f63mr2249235wmq.126.1646496291198;
        Sat, 05 Mar 2022 08:04:51 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:50 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 7/9] ovl: opt-in for per-sb io stats
Date:   Sat,  5 Mar 2022 18:04:22 +0200
Message-Id: <20220305160424.1040102-8-amir73il@gmail.com>
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
monitoring application inside a container to track the amount of io
performed via overlayfs.

Opt-in for generic io stats via /proc/pid/mountstats to provide
that functionality.

This feature depends on CONFIG_FS_IOSTATS.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7bb0a47cb615..4a5847bca1a6 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -6,6 +6,7 @@
 
 #include <uapi/linux/magic.h>
 #include <linux/fs.h>
+#include <linux/fs_iostats.h>
 #include <linux/namei.h>
 #include <linux/xattr.h>
 #include <linux/mount.h>
@@ -2165,7 +2166,7 @@ static struct dentry *ovl_mount(struct file_system_type *fs_type, int flags,
 static struct file_system_type ovl_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "overlay",
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_MOUNT | FS_SB_IOSTATS,
 	.mount		= ovl_mount,
 	.kill_sb	= kill_anon_super,
 };
-- 
2.25.1

