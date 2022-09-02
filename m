Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066BC5AACE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiIBKyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiIBKyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:54:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DACCC9938
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Sep 2022 03:54:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mj6so1686681pjb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Sep 2022 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AuN/fB7WFgyGdRo1r9YkRNBbxG011D/UvehVb1XsFR8=;
        b=kbfzT2ZCnk1BzCZUOZaSAPZHcn9bDeZoIcCQhUlUv1pniGRGW5nNiT5GTdes8JMaV3
         Y95kFlCTrSr2u/ho8LKBpM7nw0xPrCdk5y+RnYRy4rVkIvtbQBJe18GV3ATAHVdkwr6g
         jSlOLST7OCNNH/NBnvg2ORdfU6UIClzGfrTGx0ck4MdCrOdafFpH5+xU1lxMWQDU5H5b
         OZgJCmeJ4kGZJg7H4rvp49s+pALBQsNpqQWYlWdSYYyp6YhHMq6twrHzRoJROmbqq3KU
         iKyDIr8yonTBNEgRk4efSFsvao3qAC2QRKQTyK1/UMwBaOQJAAYjeuDvjBaLxNRXe0mX
         eJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AuN/fB7WFgyGdRo1r9YkRNBbxG011D/UvehVb1XsFR8=;
        b=V4axmGTl+LAXOCaTxZl59zwSEwe8ELtYTH2GzjWkJyeJsQViC1yozsxLdPsovX4qhb
         O1jDzhMAmd6b6NPu3xFh1r+pyCmoFTO5Ki6CUTy9gM9OPlL7Bdo8EIaHu2OiMovsXIBC
         prk3W7neUwK/MswlSezcxNuXjtDpbG+2P4DcmAmb2+e0WXDpy/rFp/u1Jm+3lJKPy2Vk
         p/JelaVR1PsAvkmRLZjjN/risbIGEMcuqbkhdVuB+PciuPzMiOUgfeL2QKSvVuAs0hrm
         2vDwNpLeZz8zTLIr0JGHX32RJz13Mvsf5W0x6YG2MUJ2zZaDa/Rp7KrN+v4nGGe+G2M7
         snKQ==
X-Gm-Message-State: ACgBeo1uz6SrgUKiQbvdQyKmHk52ZE8jzo0iyvVe/6CPBc3JGWk1sixO
        L6f8QCx0ag+XYsSBJSG3GSXIGQ==
X-Google-Smtp-Source: AA6agR6QGCXjeNASveGGnc4rOolzyZrMO6wMXa37BzI3m3bNUn3hb0Yu28Yt2LmUN5gFf7V7aMdZ9A==
X-Received: by 2002:a17:90b:4aca:b0:1fe:686:fbf3 with SMTP id mh10-20020a17090b4aca00b001fe0686fbf3mr4194388pjb.174.1662116066994;
        Fri, 02 Sep 2022 03:54:26 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a63d944000000b0041b29fd0626sm1128681pgj.88.2022.09.02.03.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:54:26 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V2 4/5] erofs: remove duplicated unregister_cookie
Date:   Fri,  2 Sep 2022 18:53:04 +0800
Message-Id: <20220902105305.79687-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902105305.79687-1-zhujia.zj@bytedance.com>
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In erofs umount scenario, erofs_fscache_unregister_cookie() is called
twice in kill_sb() and put_super().

It works for original semantics, cause 'ctx' will be set to NULL in
put_super() and will not be unregister again in kill_sb().
However, in shared domain scenario, we use refcount to maintain the
lifecycle of cookie. Unregister the cookie twice will cause it to be
released early.

For the above reasons, this patch removes duplicate unregister_cookie
and move fscache_unregister_* before shotdown_super() to prevent busy
inode(ctx->inode) when umount.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/super.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 69de1731f454..667a78f0ee70 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -919,19 +919,20 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_litter_super(sb);
 		return;
 	}
-	if (erofs_is_fscache_mode(sb))
-		generic_shutdown_super(sb);
-	else
-		kill_block_super(sb);
-
 	sbi = EROFS_SB(sb);
 	if (!sbi)
 		return;
 
+	if (erofs_is_fscache_mode(sb)) {
+		erofs_fscache_unregister_cookie(&sbi->s_fscache);
+		erofs_fscache_unregister_fs(sb);
+		generic_shutdown_super(sb);
+	} else {
+		kill_block_super(sb);
+	}
+
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
-	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
 	kfree(sbi->opt.domain_id);
 	kfree(sbi);
@@ -951,7 +952,6 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 struct file_system_type erofs_fs_type = {
-- 
2.20.1

