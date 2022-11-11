Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4C6256F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 10:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiKKJhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 04:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKKJhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:37:12 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26516CA3D
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 01:37:11 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b29so4419717pfp.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 01:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AmA/wiGTgxxSgV/ULL1vm+H9tlQ/4RzcG0V6hjmLS9I=;
        b=XVKz1JCSIPdyUUo4gQ9rUzrRy5HmEp3kpsdg8K3eHfOkirx8584NyU5vkmNzO4M5VQ
         LW/XMA4X6QzDnJNA0aHHUM+z0S9D68b35PtTAF2iJ6iC+FAS/QdVq7i/Yvri6cVknKVU
         eu3bkntCNFzkROvqz92xT2UYE4op15fKXzX0Q0RedU9TkzIgRtURCeSAQmAhvVFuWvzF
         4GLOwvr0iBJVgYi9cQU0Boxnnwnd89oJbyI+uokfQV/iyUaznyEqZ9E/2D+haC5umf7Z
         OPoHBkFXp3Gx5H6A4YZuvUytErrRs1vaUgOSOY4Vc4VLfw62W7z5XfQOYB+aTT+FJo19
         byIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmA/wiGTgxxSgV/ULL1vm+H9tlQ/4RzcG0V6hjmLS9I=;
        b=K7Yylj3nXUUxjSJ1reBJzbKUgGChT3qXbOA0B8mmcNgFTjZf49dfPPcJ/Yc3svH+qO
         3NLaJOatPkIBoY5TZ2z+t1M9vDPHQrKSgGfmX6WEosEjWF27MoTYlsGqWqI1+uCvZUWV
         07N5dVV3BSE0wGH22NhhTjp9PzcZssDaGuVJRBWJqRpmJCWE327Fft2zG5NA84FOVZ8h
         Sb8tcfrd9HLjkS6Q4ntG+U1Zc4kjVr+uW4PYI7fOT2efOVJgj+MmsQz/7B1wXuA1mGvs
         zBrAuR0ua+kljEmGFRpVNeXCiEHUETh0kJRHhZP26EdIgUt055bJkiYi65BIRRjzPZqu
         UmWA==
X-Gm-Message-State: ANoB5pmhY6i32Jay9E0ttHVRQpXvKSLvpWTqL5dKTUzixg5EW9NKpwN+
        S+HoVMfuMeAjZUf1IdTQpk/DSw==
X-Google-Smtp-Source: AA0mqf7NcsEz6aTfOTnAD7xYlmi5Q1EjHThNEZUL3L5HAg1X1EnPe6ebwr7+D3ccxgOWoZKuAG/Zow==
X-Received: by 2002:aa7:91d8:0:b0:56b:e5de:8b4f with SMTP id z24-20020aa791d8000000b0056be5de8b4fmr1784629pfa.67.1668159431346;
        Fri, 11 Nov 2022 01:37:11 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709029a4a00b001886863c6absm1235641plv.97.2022.11.11.01.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:37:10 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH] fuse: initialize attr_version of new fuse inodes by fc->attr_version
Date:   Fri, 11 Nov 2022 17:37:02 +0800
Message-Id: <20221111093702.80975-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The FUSE_READDIRPLUS request reply handler fuse_direntplus_link() might
call fuse_iget() to initialize a new fuse_inode and change its attributes.
But as the new fi->attr_version is always initialized with 0, even if the
attr_version of the FUSE_READDIRPLUS request has become staled, staled attr
may still be set to the new fuse_inode. This may cause file size
inconsistency even when a filesystem backend is mounted with a single FUSE
mountpoint.

This commit fixes the issue by initializing new fuse_inode attr_versions by
the global fc->attr_version. This may introduce more FUSE_GETATTR but can
avoid weird attributes rollback being seen by users.

Fixes: 19332138887c ("fuse: initialize attr_version of new fuse inodes by fc->attr_version")
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6b3beda16c1b..145ded6b55af 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -71,6 +71,7 @@ struct fuse_forget_link *fuse_alloc_forget(void)
 static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
 	fi = alloc_inode_sb(sb, fuse_inode_cachep, GFP_KERNEL);
 	if (!fi)
@@ -80,7 +81,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->inval_mask = 0;
 	fi->nodeid = 0;
 	fi->nlookup = 0;
-	fi->attr_version = 0;
+	fi->attr_version = fuse_get_attr_version(fc);
 	fi->orig_ino = 0;
 	fi->state = 0;
 	mutex_init(&fi->mutex);
-- 
2.20.1

