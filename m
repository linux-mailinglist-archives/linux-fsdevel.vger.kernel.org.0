Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC305AA6A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiIBDtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 23:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiIBDsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:48:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3992B4E9F
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 20:48:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 199so724366pfz.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Sep 2022 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=29yigyMnPFGfDuD40Y83IOfvtDsC8VAK42q+yJUeUxw=;
        b=wdHIrpiSaBhjfQbqOd+Abr+Z7iAWnqTitm0NuSsGbPvaDveHA3TOCmzxpCEaxURIvn
         c4v4b8cLleHbAaCx7Pp/bxts1GEAxe61h0wmVCp0UPzqOM/w+wQyPhrW0zLkYq9qOBhf
         Yok1Z6ryVNgeKydsYzrzE2f1+QcKwwUjY0epN8bEV51Gn2fpLpHQ5fimRpaiotKtRmmS
         FaM2mEHm+hrTaNF9ek8tH40G1HIcPI1MV66GhzrFLYX1/3JVfh0AvFmLGjG/Nj71ugoc
         m4u9opqkr/kAkUKl65Ljw2aEOhQShGIYtP46EA3cAzRgwQx/ME02xiOMWu6+NuZVKe1l
         UEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=29yigyMnPFGfDuD40Y83IOfvtDsC8VAK42q+yJUeUxw=;
        b=bPpCDmP34j6HiYBxK44iYGISdm0hYaSpj+7u5qbcxfV++PrM4CW5m6uDFhKYZGjBUK
         Ko48hrBimTtY3+pBPayFf07AGjXrT7R++RSTmq4bgySUg2SU/zeTw7p8srTfCJQLzIiH
         vUFctUHqJGHghMscb5GjiwGowm7jTaVeQNDiM2tCTR9AhHUNsUrbJuV6Hr9113RzygRz
         /HuFuhGupgbehXBb9yvyl0WQeT+RhcF216qz55cFGyZAGceu1KeKrur0UqCi/LWGTvjn
         TcRnl2nn8+uxxYKgmXU3QElwfnu+wX10PMHBnp7y3ELY8HVzVTNAkOZ5GZ2IPQLdlaW2
         5ufg==
X-Gm-Message-State: ACgBeo1mV2AlxzoUCLl8iEXCGvZJ6jgCrT2csg9oR7qDgHoe5rW14YUK
        6CFYc27RYUpsl0VJZ4M2hY3wDQ==
X-Google-Smtp-Source: AA6agR6fClfcvJYshTe0TrLdO6pfsgDgdl3xFTGMsK3VFTkr/Loa612tx9QqfoxFg/OHj7mTD7JQeA==
X-Received: by 2002:a05:6a00:e8f:b0:536:c98e:8307 with SMTP id bo15-20020a056a000e8f00b00536c98e8307mr34362687pfb.73.1662090504153;
        Thu, 01 Sep 2022 20:48:24 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:23 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V1 4/5] erofs: remove duplicated unregister_cookie
Date:   Fri,  2 Sep 2022 11:47:47 +0800
Message-Id: <20220902034748.60868-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902034748.60868-1-zhujia.zj@bytedance.com>
References: <20220902034748.60868-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index a3ff87e45f2c..05dc83b25da3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -920,19 +920,20 @@ static void erofs_kill_sb(struct super_block *sb)
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
@@ -952,7 +953,6 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 struct file_system_type erofs_fs_type = {
-- 
2.20.1

