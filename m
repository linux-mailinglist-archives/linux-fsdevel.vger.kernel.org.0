Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5501D78663C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbjHXDt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbjHXDt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:49:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E551BD1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:48:02 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-760dff4b701so60530539f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848869; x=1693453669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g9VNwXC7u3b4Fe8S+2AtVie+S5coxV+WBg8Oh06A1E=;
        b=kmtsq//68LoSSVsyr/YBBGvDgqmBUsO880HB0D/X0A9lvPp+wiXhpBHLd0cfIsISJ1
         WySRAQJbOB7MirqRDUr1lxDBiz4bG14CaKe7yuO/GO7cBBb0YcTM9Y2I3EbKN+nNzPLi
         GguYtSQnyC5GCZ96dWUb+BUtsgcR3JqmFJQHmDPKX024szPrXCnBPbbW9YCcGmCws6Ag
         O3VqAcSntA5bd88T594vNGXtnhYJdlTyYo/z8+mucyI7RsSPbvZ9Tlk5oJv0m0ggTdMc
         0VdvEN/SRUhc+98mEttt+2USPb5pXEEKX1ITu4ac2rdVGkAruMTdyg9H0mmnNrZt4fBx
         MFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848869; x=1693453669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g9VNwXC7u3b4Fe8S+2AtVie+S5coxV+WBg8Oh06A1E=;
        b=jkugME0bSC2MMctqfwN+YhqIP2DY5S8A1XXNQCyh8BEIvgB4txz8sJk4x9kE2tH/Dw
         b5lys9eLP5Vr9zUOEunM30RzAvi0R8Jy/x9BH+dymkWKwWclwxf4AnXfgVCzSWhyYyQQ
         fTfzDpbEBFO42atGPDmx1XUYJODIx1VWD/re4u/DDWV69f6j3tJfDWM9uBTCkSQwIlT5
         OaMWaNxs0njFqEf3auhIrVzXTi7Oqiigq8YQJTT+A4QGCvo/Poo5qfwNbiD3h7jBdog6
         uccj1AFT+8r9p+Wuecn8F+ItvDI2nJlc8vUnocgERvvWaoOicTQy6CMECPb6wO4Scm4M
         kxJw==
X-Gm-Message-State: AOJu0YzQpVihpDMdSc27rJLpRX1muug9TaQsw3dRDdz6Oiv6HyHbYYWi
        0bKaSd+WkEAyxbwFjDxVHiA33w==
X-Google-Smtp-Source: AGHT+IEQ6BDL0ShOsvxn7MkRzNY4X27PtjN7dkB9TSd0YJiI2pZEQO2zVH6oQz1kCHFDDwRb6mYVFQ==
X-Received: by 2002:a92:4b0d:0:b0:345:e438:7381 with SMTP id m13-20020a924b0d000000b00345e4387381mr14623814ilg.2.1692848869651;
        Wed, 23 Aug 2023 20:47:49 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:47:49 -0700 (PDT)
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
        Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 27/45] vmw_balloon: dynamically allocate the vmw-balloon shrinker
Date:   Thu, 24 Aug 2023 11:42:46 +0800
Message-Id: <20230824034304.37411-28-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the vmw-balloon shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct vmballoon.

And we can simply exit vmballoon_init() when registering the shrinker
fails. So the shrinker_registered indication is redundant, just remove it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Nadav Amit <namit@vmware.com>
CC: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_balloon.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 9ce9b9e0e9b6..ac2cdb6cdf74 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -380,16 +380,7 @@ struct vmballoon {
 	/**
 	 * @shrinker: shrinker interface that is used to avoid over-inflation.
 	 */
-	struct shrinker shrinker;
-
-	/**
-	 * @shrinker_registered: whether the shrinker was registered.
-	 *
-	 * The shrinker interface does not handle gracefully the removal of
-	 * shrinker that was not registered before. This indication allows to
-	 * simplify the unregistration process.
-	 */
-	bool shrinker_registered;
+	struct shrinker *shrinker;
 };
 
 static struct vmballoon balloon;
@@ -1568,29 +1559,27 @@ static unsigned long vmballoon_shrinker_count(struct shrinker *shrinker,
 
 static void vmballoon_unregister_shrinker(struct vmballoon *b)
 {
-	if (b->shrinker_registered)
-		unregister_shrinker(&b->shrinker);
-	b->shrinker_registered = false;
+	shrinker_free(b->shrinker);
 }
 
 static int vmballoon_register_shrinker(struct vmballoon *b)
 {
-	int r;
-
 	/* Do nothing if the shrinker is not enabled */
 	if (!vmwballoon_shrinker_enable)
 		return 0;
 
-	b->shrinker.scan_objects = vmballoon_shrinker_scan;
-	b->shrinker.count_objects = vmballoon_shrinker_count;
-	b->shrinker.seeks = DEFAULT_SEEKS;
+	b->shrinker = shrinker_alloc(0, "vmw-balloon");
+	if (!b->shrinker)
+		return -ENOMEM;
 
-	r = register_shrinker(&b->shrinker, "vmw-balloon");
+	b->shrinker->scan_objects = vmballoon_shrinker_scan;
+	b->shrinker->count_objects = vmballoon_shrinker_count;
+	b->shrinker->seeks = DEFAULT_SEEKS;
+	b->shrinker->private_data = b;
 
-	if (r == 0)
-		b->shrinker_registered = true;
+	shrinker_register(b->shrinker);
 
-	return r;
+	return 0;
 }
 
 /*
@@ -1883,7 +1872,7 @@ static int __init vmballoon_init(void)
 
 	error = vmballoon_register_shrinker(&balloon);
 	if (error)
-		goto fail;
+		return error;
 
 	/*
 	 * Initialization of compaction must be done after the call to
@@ -1905,9 +1894,6 @@ static int __init vmballoon_init(void)
 	vmballoon_debugfs_init(&balloon);
 
 	return 0;
-fail:
-	vmballoon_unregister_shrinker(&balloon);
-	return error;
 }
 
 /*
-- 
2.30.2

