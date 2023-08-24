Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE175786600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbjHXDo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238802AbjHXDo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:44:26 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823410F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:04 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57328758a72so31969eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848644; x=1693453444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igTSDR/vKXgPwxt8Nsf/dMSfVCUUURBFbV4iu+jj8kI=;
        b=OsYjiPgRzrTeETdk6GAchasY+z5fr/eZhmMBlkdIascYBtVVr8yTfuT5MPzgyaDuTX
         GP27vx5e3ZRKiWmF8godLPx25zsGkXM7WpgRAlINmRy7OtyQBZMd0woJ7eRBd8ABjz0B
         gg0KXTzJI21aCRCVIqH7SIRY1+q2UC1Eevp1gZIrFwnGhfMs71V461lgE1bLRRacaMrl
         VvaxQGpwJpwk7Ore7I/VQ0LQeEZ8Yda/FdaKJLsSrCojTzfm74tjEvkxxRIsttzCumIH
         JYDNB092mTWiwSCXEE9fsozeBAYzex4vsPbHJSxRaP6Kzq97D+z6ONh9Db9HAMNes38c
         GNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848644; x=1693453444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igTSDR/vKXgPwxt8Nsf/dMSfVCUUURBFbV4iu+jj8kI=;
        b=h/ymNWIpyeEloJmslDicHhuI75Ju+vCjDvKfRywYjYaeQuJ6mvl4THrgqRzuDSyUqW
         SvK9IdRn9ULx7D3/qOOfn5m7y79taJM07NB44U0h6Uk0K38Rh8cpWcThCBa8gpzTJtz5
         7zbOowmCTeHFY9JwTazOcH5eFqfWD2L6+hBGYZWmNehQoK8Xw06hvI2bzitzB6k18Dg0
         cFoKCRwXEQgFQ+EKIIx4Ewc9Oa53JlN9vvA7r3ySphPJRCihSMfFmuJbTVHCIM44MuBi
         WogIu5FPvlgixwDr+lJfoXL0+ZzY/0SzcD8SAPUJ8x/CamYZXOMi/rXVNH7ukgEBYaao
         43hw==
X-Gm-Message-State: AOJu0YxY6kWGeIFfEyVIwZn+eIryOTtlXZzxw/zrD9TGroNmIdA6ZLL5
        Dx28wwWUDM5zO5v6SZ9cYuysLQ==
X-Google-Smtp-Source: AGHT+IEujkxb/oLvenG0xAi0WFnbnLyYwhJyu7dzjt01VW0xqm24WtRNYpeYKjaTV28dKNThLBHLgg==
X-Received: by 2002:a05:6808:152a:b0:3a7:72e2:3262 with SMTP id u42-20020a056808152a00b003a772e23262mr17143493oiw.5.1692848644029;
        Wed, 23 Aug 2023 20:44:04 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:44:03 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v5 02/45] kvm: mmu: dynamically allocate the x86-mmu shrinker
Date:   Thu, 24 Aug 2023 11:42:21 +0800
Message-Id: <20230824034304.37411-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the x86-mmu shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: kvm@vger.kernel.org
CC: x86@kernel.org
---
 arch/x86/kvm/mmu/mmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e1d011c67cc6..9252f2e7afbc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6796,11 +6796,7 @@ static unsigned long mmu_shrink_count(struct shrinker *shrink,
 	return percpu_counter_read_positive(&kvm_total_used_mmu_pages);
 }
 
-static struct shrinker mmu_shrinker = {
-	.count_objects = mmu_shrink_count,
-	.scan_objects = mmu_shrink_scan,
-	.seeks = DEFAULT_SEEKS * 10,
-};
+static struct shrinker *mmu_shrinker;
 
 static void mmu_destroy_caches(void)
 {
@@ -6933,10 +6929,16 @@ int kvm_mmu_vendor_module_init(void)
 	if (percpu_counter_init(&kvm_total_used_mmu_pages, 0, GFP_KERNEL))
 		goto out;
 
-	ret = register_shrinker(&mmu_shrinker, "x86-mmu");
-	if (ret)
+	mmu_shrinker = shrinker_alloc(0, "x86-mmu");
+	if (!mmu_shrinker)
 		goto out_shrinker;
 
+	mmu_shrinker->count_objects = mmu_shrink_count;
+	mmu_shrinker->scan_objects = mmu_shrink_scan;
+	mmu_shrinker->seeks = DEFAULT_SEEKS * 10;
+
+	shrinker_register(mmu_shrinker);
+
 	return 0;
 
 out_shrinker:
@@ -6958,7 +6960,7 @@ void kvm_mmu_vendor_module_exit(void)
 {
 	mmu_destroy_caches();
 	percpu_counter_destroy(&kvm_total_used_mmu_pages);
-	unregister_shrinker(&mmu_shrinker);
+	shrinker_free(mmu_shrinker);
 }
 
 /*
-- 
2.30.2

