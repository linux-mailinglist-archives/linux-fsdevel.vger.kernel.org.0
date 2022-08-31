Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9305B5A7D66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 14:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiHaMcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiHaMc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:32:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C766D39AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 76so14268748pfy.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WugVPm8FmMPSaptmZMd5rqlv9lrGBWi6vcJNH+GONqA=;
        b=cxa4WizIxSVztAOwqS3p1vrzdIohGVelZD28GH/iej9ofpHRtLhH1cBA7X33awv5uL
         cFbWTqJtHS0Nf3ytkXuWXvIDZ+W16F2s0SE8uFO9WVsGt50aUgRrJIBTookyKK+4z1MW
         0VEh5Dk0odizW6XMn74eGMUNmoShini6IWqHJLKN6srUVYkbwqxwTmyWY2QiAhFqx6sK
         QyeLRjRDBbnWDoqGWc0Rq9qmFsmAYsOFrpD2C9KiY+Sc/r3L+j2NXv2UVz4WP06MBEVV
         0ZysMKgu4nNPNXs18LTsjU9MH3CrPsS1YZFjizFTKYkAIgl20QxwLTeLRSxnx2ob+Tyb
         lC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WugVPm8FmMPSaptmZMd5rqlv9lrGBWi6vcJNH+GONqA=;
        b=qlYItgbnyMpby1ZcL3Pat/r6O5vr7q6VirufpOe7XMEMmujRuOaiPhuymGHp/enP1/
         7Gxw/dRaTesVtrA5KI+t2R7ZeAuh3MsFgr4gV6/mJzJ2riNiXTyJLJMaB6LvRXcXQYec
         kPCXRUktkoP0YxV8jPvgdx7AfRlcCtURsqI060sd/lMjtjC2XjJWIJ/phrHE4RQb68gP
         q9NDUczHzs22xo/FHxJPMfKMJLBDGgf1wA0ezdt65CZbFu0cmvg9UvDCx1aG4EYWmBtl
         tR15Y2Ba+/t8AZUqxIQy5JGVwjigow7jL64SLerH00R3IrbyMIA9DXD8NJ7M1rISG3OG
         RueQ==
X-Gm-Message-State: ACgBeo3aBk77AzhfoscqL513AKKAdvGrKnsgsIeeffaNFMt4e3gGNSpo
        l8J97FQic1zjcMYID56yBAJS8g==
X-Google-Smtp-Source: AA6agR48GQvGj6dIP4ogw1z7Eg1rCQiwWE1zxsQ+xnXMrG9ghr/pZ2SUlTyFcCm74OOggxXrTFGE9A==
X-Received: by 2002:a05:6a00:228a:b0:538:47a7:706 with SMTP id f10-20020a056a00228a00b0053847a70706mr13569032pfe.62.1661949136951;
        Wed, 31 Aug 2022 05:32:16 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:32:16 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [RFC PATCH 4/5] erofs: remove duplicated unregister_cookie
Date:   Wed, 31 Aug 2022 20:31:24 +0800
Message-Id: <20220831123125.68693-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
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

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 55d2343c18a4..bbc63b7d546c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -929,7 +929,6 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.20.1

