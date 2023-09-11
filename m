Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB579B5BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjIKUwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjIKJvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA2E4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-56f8334f15eso230614a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425882; x=1695030682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv0TBZQkv9+j+cj13JOsDOVxquETdMy4ZuA8JAVbwFY=;
        b=YRRfnI9+VRJJTgeAFY/PXL07id3mMmoEVGPQCPpNE/SK6YzpPCphxeCFbdG0M9Uxe1
         IX14kV5lXoTEHgsVmQ6Azpu+HTkoEkv/19ixResLBXrxa0Av4SD5GW7urOHRzXkZDkYZ
         GxBWHMMr1jRkxtFxeWt92U5dEag1e/mI0LQGT9tRhWGXGtcJ7ervljxZ1nMZlQBqv0fd
         pjaRCDJTYfTEMXJffAkefYCJwJzgDPYRSmpU7eAMHs7XvL8IcUvHQM+ItEpPh0HRzOMw
         auJLJ73xb6ov3ZafP7dhUYBi64xbfrn9L0ZLAR8kBn6ZptC3BzHbXiuEonS78l+a3D8P
         cWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425882; x=1695030682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv0TBZQkv9+j+cj13JOsDOVxquETdMy4ZuA8JAVbwFY=;
        b=XjKmsUXOINNDTTGklMIlidOiTLYjOLlXtvIP119U6KEKpeA5lahUHosSVG+VflUTxp
         Axwuk232p+4O3yDDz6Mb8dexuFQt3Z6WpnRjL8jHqGAxjXvv0guoT+tPzJCzuyZp1ooK
         J4oar6Lp2EGlvGnZqmna/vmyVkoacHRB+D6Xxj+WoTruLMTPfekPKNWvzKHPEGVrBi7H
         RvTUCDL56uZYza8a2pLxZaudy6iMQ90zF0fMmBK+rsEilKLIpiqlB1cNa0AbDHt+YqdM
         /B1LJeksF4g10V03SmGOvSDarjJ3fvdIQp7jYDhRzFxdl4es9j97ZyTTQ28/HpmM0suk
         tTBA==
X-Gm-Message-State: AOJu0YwCE5vHYZ11p4+8l3amR72jsKEjGHtrQH/oFIC3qa3wjJ5cECcO
        /w/lPQIEQAuWDdWWvJrS/dkUtw==
X-Google-Smtp-Source: AGHT+IGKTvJsG+anhHgOhq4RXbEUzLj3hzjixmIPwpl+H2L5Yrr+lM0cdITBVAyo+CVp3tsEVeU2xg==
X-Received: by 2002:a05:6a20:a10c:b0:13f:9233:58d with SMTP id q12-20020a056a20a10c00b0013f9233058dmr11709606pzk.2.1694425882074;
        Mon, 11 Sep 2023 02:51:22 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:51:21 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v6 41/45] mm: shrinker: rename {prealloc|unregister}_memcg_shrinker() to shrinker_memcg_{alloc|remove}()
Date:   Mon, 11 Sep 2023 17:44:40 +0800
Message-Id: <20230911094444.68966-42-zhengqi.arch@bytedance.com>
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

With the new shrinker APIs, there is no action such as prealloc, so rename
{prealloc|unregister}_memcg_shrinker() to shrinker_memcg_{alloc|remove}(),
which corresponds to the idr_{alloc|remove}() inside the function.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 6723a8f4228c..0b9a43ce2d6f 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -209,7 +209,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 
 static DEFINE_IDR(shrinker_idr);
 
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+static int shrinker_memcg_alloc(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
@@ -235,7 +235,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	return ret;
 }
 
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
+static void shrinker_memcg_remove(struct shrinker *shrinker)
 {
 	int id = shrinker->id;
 
@@ -297,12 +297,12 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	up_read(&shrinker_rwsem);
 }
 #else
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+static int shrinker_memcg_alloc(struct shrinker *shrinker)
 {
 	return -ENOSYS;
 }
 
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
+static void shrinker_memcg_remove(struct shrinker *shrinker)
 {
 }
 
@@ -628,7 +628,7 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
 	shrinker->seeks = DEFAULT_SEEKS;
 
 	if (flags & SHRINKER_MEMCG_AWARE) {
-		err = prealloc_memcg_shrinker(shrinker);
+		err = shrinker_memcg_alloc(shrinker);
 		if (err == -ENOSYS)
 			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
 		else if (err == 0)
@@ -696,7 +696,7 @@ void shrinker_free(struct shrinker *shrinker)
 	}
 
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+		shrinker_memcg_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
 	if (debugfs_entry)
-- 
2.30.2

