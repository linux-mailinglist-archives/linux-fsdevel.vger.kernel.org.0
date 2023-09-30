Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51DC7B3E42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjI3FDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjI3FCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:02:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9CE10FD;
        Fri, 29 Sep 2023 22:01:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690bd8f89baso12039926b3a.2;
        Fri, 29 Sep 2023 22:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050118; x=1696654918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkmcdMm12QbRMkcwPXJsldRA3LZpvW1XQ5QQ1oyLq3Q=;
        b=RxY+KqYdSUGCZ63RUITbenHyMOEDNmO3pSOrLr1XxtI7FrWkxzte5exlMEtYRal3Ys
         5BS4lf7O/WyeUdEk8CmX3TwS5eduZswvnOCcw9zlhjOWABca+VX/GEK3p62qZuIM46al
         wqG2PFikr1A/0Fp3kC11uqG1Unza/Bu3jDbmt90cRaJF/0oZEbp46yGzRJgd8DgZ7yHV
         q5VCItp+QRVRfEnxI5gQJnn7IprZWNU1iDy+v5m+zzuTjc87R6KUxOtnR1/JG5kXVhUw
         iKVRCmv4H2RVetzmOy0DAmOLZwaV381IaKfuSPH1AUB4Xz1UCU4m2Zvj4xZaqulLyUn6
         r2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050118; x=1696654918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkmcdMm12QbRMkcwPXJsldRA3LZpvW1XQ5QQ1oyLq3Q=;
        b=r/WowLRJx3/2qFwFWhHQ5V04KAzIuiuj/M3zywVNtil/OlDUS7jaKPvJ2wjAMsWcW4
         W/ciccC++0+eHBV7pFZpHk33WPf9/euxX29lQL5J9U0UYPfrCs7PJURLtSH1cDUHvOnB
         WDj/brPdvkzPoXPEkia/Mk77B38ohjwIw/h3Ogq/XTw7I5YWBM1OQJy2/Zs9pvaLp9I9
         ZyHiGgpVFuiuMHvyvK/USRb3togU1dlPRVJe6AIroaLZyEMsCsuH8SEDfc537FQ4DVhZ
         4Aj8LToqNGGY2zRSyvIacLRsfOTS6P+S9qCeXt480cKGPghKOvnSzMl5CamqambMVZK2
         XUYQ==
X-Gm-Message-State: AOJu0Yzxg5ZebeBDSLHKhLOV8hhpLUeJGrHBTHBZlbZ0Ak1bl7tsnfpE
        pWik/x3whY/mpsEM3F9obgQ=
X-Google-Smtp-Source: AGHT+IFImlr28SMYKxU0nbWofyYiwpfcz2Z7YacvsYNMXPTB8Qo8TCN72xecAmOwWNdopWih7rr/6w==
X-Received: by 2002:a05:6a20:734a:b0:14d:4ab5:5e34 with SMTP id v10-20020a056a20734a00b0014d4ab55e34mr6205874pzc.51.1696050118456;
        Fri, 29 Sep 2023 22:01:58 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:58 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH 18/29] nfs: move nfs4_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:22 -0300
Message-Id: <20230930050033.41174-19-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
nfs4_xattr_handlers at runtime.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/nfs/nfs.h      | 2 +-
 fs/nfs/nfs4_fs.h  | 2 +-
 fs/nfs/nfs4proc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs.h b/fs/nfs/nfs.h
index 5ba00610aede..0d3ce0460e35 100644
--- a/fs/nfs/nfs.h
+++ b/fs/nfs/nfs.h
@@ -18,7 +18,7 @@ struct nfs_subversion {
 	const struct rpc_version *rpc_vers;	/* NFS version information */
 	const struct nfs_rpc_ops *rpc_ops;	/* NFS operations */
 	const struct super_operations *sops;	/* NFS Super operations */
-	const struct xattr_handler **xattr;	/* NFS xattr handlers */
+	const struct xattr_handler * const *xattr;	/* NFS xattr handlers */
 	struct list_head list;		/* List of NFS versions */
 };
 
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 4c9f8bd866ab..28499a0da4c3 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -315,7 +315,7 @@ extern struct rpc_clnt *nfs4_proc_lookup_mountpoint(struct inode *,
 						    struct nfs_fh *,
 						    struct nfs_fattr *);
 extern int nfs4_proc_secinfo(struct inode *, const struct qstr *, struct nfs4_secinfo_flavors *);
-extern const struct xattr_handler *nfs4_xattr_handlers[];
+extern const struct xattr_handler * const nfs4_xattr_handlers[];
 extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
 		const struct nfs_open_context *ctx,
 		const struct nfs_lock_context *l_ctx,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 832fa226b8f2..4557a14a596c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10740,7 +10740,7 @@ static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
 };
 #endif
 
-const struct xattr_handler *nfs4_xattr_handlers[] = {
+const struct xattr_handler * const nfs4_xattr_handlers[] = {
 	&nfs4_xattr_nfs4_acl_handler,
 #if defined(CONFIG_NFS_V4_1)
 	&nfs4_xattr_nfs4_dacl_handler,
-- 
2.34.1

