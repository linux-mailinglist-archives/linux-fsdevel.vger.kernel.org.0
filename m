Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A80F75F2DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjGXKUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 06:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjGXKTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:19:51 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3136530FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 03:12:03 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-637aaaf27f1so7221706d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193522; x=1690798322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMESg6KcZ1f/x8j8WNeV/0Ezds9kYbd4Innm/bU0Ooo=;
        b=KaW7hLP+oLSIc1hOleaJzO+Nwr62quInBIZpazJrxfdHALbfVgkguQEBAzVXxha7Me
         zuLoprOhIO3YXm25ftRZkgJnzx3HavyddjzwUNcdI7IoduDR+baU4koV4cW06J1YpZjl
         rB2Icoq2+Xka8XrVL+kv1Mr4t4l5+RsSdzITjVFhx/qd5rsscKjGUTGZjwFx5fLC/5OV
         SqWAAN16X6jb6t6dqxfxJBI8KJvRlbWyD/XScUk8xbVaTJEk9yAHaMB+cnOzr7bXuaxi
         e7hqs/3fH2p/Y5GIepfRUqCfKRmPxuUSH2g6oxgYHnDDq1wGH80Aky7IFX6dho93srK7
         A31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193522; x=1690798322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMESg6KcZ1f/x8j8WNeV/0Ezds9kYbd4Innm/bU0Ooo=;
        b=Fj3em7ohw82atZZMDXl6xUO1WzGTA5vRq4cXdUqivRR6vBwiOZLVp3+I1EqUycThdc
         HijBVGiLR/QHLMG+toD+pJM60ecyZflGAteUfzi5O+bRfznUDbqupQSbG7COkLgsFBMl
         OOO+z6r1V/Adi83NcfDypmMZtNnsbsR4MuvV63yO4N/IM0tMdDvHKa+JTxThu7k0nYP8
         XSKUAiEJHzJ9rCApTbkny8VkM27nQ1i3lK0vg6XnBDPVCC0gXOyEH9Ud9v8C3jHUiCH8
         9lp8XiayyGySgkcu9OyRQ1uKX5Lwbd7C8wG4WatHHlSNtPK+5edULL/eufBccBx4dBLz
         aCsw==
X-Gm-Message-State: ABy/qLZCJTrK/eQcTGhxgXBllfDOtkgwUliwibVD09OpHBIQmc6wFxRN
        EYhCRkYMmRyZgfhDKcg+Wsx9/QUCr6d2hCl5plE=
X-Google-Smtp-Source: APBJJlGXXWR+7sUNZwfELUHGku1GBmb2Z0Up/m3d12N15W4mEcGvzf3zzmR3Y2DB2osG2hV81y8tMw==
X-Received: by 2002:a17:902:dacf:b0:1b8:9215:9163 with SMTP id q15-20020a170902dacf00b001b892159163mr12209813plx.6.1690192456927;
        Mon, 24 Jul 2023 02:54:16 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:54:16 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 46/47] mm: shrinker: hold write lock to reparent shrinker nr_deferred
Date:   Mon, 24 Jul 2023 17:43:53 +0800
Message-Id: <20230724094354.90817-47-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, reparent_shrinker_deferred() is the only holder of read lock of
shrinker_rwsem. And it already holds the global cgroup_mutex, so it will
not be called in parallel.

Therefore, in order to convert shrinker_rwsem to shrinker_mutex later,
here we change to hold the write lock of shrinker_rwsem to reparent.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 744361afd520..90c045620fe3 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -303,7 +303,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -316,7 +316,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			}
 		}
 	}
-	up_read(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
 }
 #else
 static int shrinker_memcg_alloc(struct shrinker *shrinker)
-- 
2.30.2

