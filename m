Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A240379BDF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjIKUwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjIKJrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:47:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F9FED
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2684e225a6cso580084a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425634; x=1695030434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NJRoYJvtB3JAQ6HjBpWzHn90j4fvohvXnELHULg3ZY=;
        b=kDIttM3a85tZdAmWjocCgqA2JqKhZ0XtHhS6GH4xb6lyScuVCOqulxGJL0ufwy+S1Y
         RUgHeDOJaCa/FSVaPd2k1EKkhFwbQRVibK7ZZwbBPJJG4aC7bObEDiuYhpF4ztnOJHzO
         51lVmT/r6VyAiFXUY+24n2sGXPK32ZejMLZq1k9SqZtv4asG+ZHcqh0e4IFx/n4fIt+r
         GfTZMBWwfXstdarvvm82kw8NMYgYMK/f4bkLvr0cOPNPOz0i/y3Y8LWEytpskkQQTBNw
         EEF2s7VuIE4oY7QxyTnwUO0xTYvlAPuB5qnehFuroBwLgIFufNGY84joHlpcIH7EnXnk
         lLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425634; x=1695030434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NJRoYJvtB3JAQ6HjBpWzHn90j4fvohvXnELHULg3ZY=;
        b=ImcVONaw30LnB6xwaVhan8tx47zNIHUbgo2RnVd2yOTeIRPFq/HO1Uqru3LXFSl9ci
         ZmlYgVW4yXYv1rf8XIJUsSrMYuNeHpdm7ohK6j0T+xSwPsldpRHq23dRngJ2p1Ggy3kW
         wh3Jwrl+G7acwd5zjkXf5hPfHrC3ofXsQ/J5wSQ3opB0L+XUfWXTixr8kgrYJ9Ui7U2C
         Hv1jLw5l2J/iIhlYfvxiH8B2ro9o3/JKc+jfe64HuvjbK1+5igJojkueFJLUq65U0Dzq
         g2lMgJ1jDG7UE8V6hrYWD335DmXVyV8t5RphKdV8E5m3gGwXZYZXR9L/PMFhCkuGxSzG
         QlIQ==
X-Gm-Message-State: AOJu0Yzn3VqnZv8VYF1zvOif1mJz11K0ZJWUz/3w0XdMR73bRaeWLD3m
        5/IBjqFWpbRIKZG6MhsownrxSQ==
X-Google-Smtp-Source: AGHT+IHGrhLYQcHrSOL/A0AfShLW1GL1aOG0gH1s0a/WptYINVPGtQZkcxOK/Zv27+cAk2ggUFIjmg==
X-Received: by 2002:a17:90a:9bc4:b0:273:e4a7:ce72 with SMTP id b4-20020a17090a9bc400b00273e4a7ce72mr6446431pjw.3.1694425634193;
        Mon, 11 Sep 2023 02:47:14 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:47:13 -0700 (PDT)
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
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v6 14/45] ubifs: dynamically allocate the ubifs-slab shrinker
Date:   Mon, 11 Sep 2023 17:44:13 +0800
Message-Id: <20230911094444.68966-15-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the ubifs-slab shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Richard Weinberger <richard@nod.at>
CC: linux-mtd@lists.infradead.org
---
 fs/ubifs/super.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b08fb28d16b5..96f6a9118207 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -54,11 +54,7 @@ module_param_cb(default_version, &ubifs_default_version_ops, &ubifs_default_vers
 static struct kmem_cache *ubifs_inode_slab;
 
 /* UBIFS TNC shrinker description */
-static struct shrinker ubifs_shrinker_info = {
-	.scan_objects = ubifs_shrink_scan,
-	.count_objects = ubifs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *ubifs_shrinker_info;
 
 /**
  * validate_inode - validate inode.
@@ -2373,7 +2369,7 @@ static void inode_slab_ctor(void *obj)
 
 static int __init ubifs_init(void)
 {
-	int err;
+	int err = -ENOMEM;
 
 	BUILD_BUG_ON(sizeof(struct ubifs_ch) != 24);
 
@@ -2439,10 +2435,15 @@ static int __init ubifs_init(void)
 	if (!ubifs_inode_slab)
 		return -ENOMEM;
 
-	err = register_shrinker(&ubifs_shrinker_info, "ubifs-slab");
-	if (err)
+	ubifs_shrinker_info = shrinker_alloc(0, "ubifs-slab");
+	if (!ubifs_shrinker_info)
 		goto out_slab;
 
+	ubifs_shrinker_info->count_objects = ubifs_shrink_count;
+	ubifs_shrinker_info->scan_objects = ubifs_shrink_scan;
+
+	shrinker_register(ubifs_shrinker_info);
+
 	err = ubifs_compressors_init();
 	if (err)
 		goto out_shrinker;
@@ -2467,7 +2468,7 @@ static int __init ubifs_init(void)
 	dbg_debugfs_exit();
 	ubifs_compressors_exit();
 out_shrinker:
-	unregister_shrinker(&ubifs_shrinker_info);
+	shrinker_free(ubifs_shrinker_info);
 out_slab:
 	kmem_cache_destroy(ubifs_inode_slab);
 	return err;
@@ -2483,7 +2484,7 @@ static void __exit ubifs_exit(void)
 	dbg_debugfs_exit();
 	ubifs_sysfs_exit();
 	ubifs_compressors_exit();
-	unregister_shrinker(&ubifs_shrinker_info);
+	shrinker_free(ubifs_shrinker_info);
 
 	/*
 	 * Make sure all delayed rcu free inodes are flushed before we
-- 
2.30.2

