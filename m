Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D492F79AED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbjIKUyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjIKJps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:45:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D52E4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:45:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c39500767aso6230525ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425524; x=1695030324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igTSDR/vKXgPwxt8Nsf/dMSfVCUUURBFbV4iu+jj8kI=;
        b=ANfjxngdlKWe0cIPL4lNigyPs/iVppwhyMhlQQHDdoOGKcs2F+ledResIZ5sZ/Rk+v
         xkqa+RG32yNyFCnROoCM8dooTOBHN+dqXDlEQnfHr1UQYnItyiguYUBpbyCOUIviKtRi
         5F+eRsxp3DfnNVY7vQHNR0zqGGITao07XNrw4f9t/OG1sIC2JLjQ87Q9SBW65RmiT50w
         R+TMrj36JNbqxm1LZAYluyCTcsKRgUzOaG/C417SzWArWdMlmPCAz4N1NXaHl51d0yEF
         6Ovaglz/55c9qDq36rnEzgDl7kBHJy5rsQhGFdoSmk5L5iyME12YYV6eosKmkipZRw2t
         2DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425524; x=1695030324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igTSDR/vKXgPwxt8Nsf/dMSfVCUUURBFbV4iu+jj8kI=;
        b=sM+aColfUgZwfynPsk60mCjMsc0VCzVXHgbNOVi6MaWV1ii8A26aO26TJ2uaMmLdL2
         3KrdsUIRx5kdFYmgzXDRBnUfz30JkAHmMEH437j0hwt6XfgwgjIY0GDnlvTvkTEXsx3I
         rMuO+Uo8maB1SUKThF5S9wfk2qsA62O42qCoq7k4vwCFwraNzoYTz23FKmHSSYALTsG9
         vMJC7pnrDqfqYmoowwkwbqfUxSieicHDG4IMFLss+lL4f+vhIzxxkEgaAQvGUQZELuet
         1nF1GoVHF0CCe5QJeGOvj4ias6YoJzdRzmQADU4JmqDKCSEXQzveEGnsF7j28YX8IorC
         sp8A==
X-Gm-Message-State: AOJu0YzA077kplu6eJfWR+UvqQAMVQ1iRb/23itto4cnMhLt0hlwbwFE
        tJ5amZb/mg42GsHpdSQcKw9syQ==
X-Google-Smtp-Source: AGHT+IGwCbRmnmWBiffPOJTl07r9rRbQgpxezDjUTflYdm1L6Q4G0DETGg6o4mxqN/MXYenR4q9s6g==
X-Received: by 2002:a17:902:e5c7:b0:1c1:fc5c:b34a with SMTP id u7-20020a170902e5c700b001c1fc5cb34amr10655164plf.3.1694425524206;
        Mon, 11 Sep 2023 02:45:24 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:45:23 -0700 (PDT)
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
Subject: [PATCH v6 02/45] kvm: mmu: dynamically allocate the x86-mmu shrinker
Date:   Mon, 11 Sep 2023 17:44:01 +0800
Message-Id: <20230911094444.68966-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

