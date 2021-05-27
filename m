Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5299739277E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhE0G1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbhE0G1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:27:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02035C061348
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso1790093pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esJzMd1gfpQ9fKrHNcdHQMirHFw6zXQFsOGdVn4/sAs=;
        b=lg7fglwo870iqNRshvVXpvKjYWsyy0gdHArvvqoq9VYfn+EdTnRqUg7WMOQWjdPQE6
         eZ0wlnDPIul1IsIbXIyv9OaDHgh2r7ZAsx0HfZ0dZHWXaBBEp6dr/GLKXlQBU3DmAnSh
         x6gtjGTnKimDBrG31MHDks0RemPb+3PpCBEbNliGZbN1YUdDLHnfg7cmuwdFyngP2jL5
         yoW1mBXFX1bp074oOHquuzkEPGVqzHGbFrw6xJCXt5j+in5tvYnmgPYrfhMtwiR72uix
         dpN+CB+XL+pdYAsTGIzG8AAhxdlrp9hlpMiombqEn+bdkO7f0lyemvTTnaM9jN/A1vnx
         d8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esJzMd1gfpQ9fKrHNcdHQMirHFw6zXQFsOGdVn4/sAs=;
        b=Xog2t10ihl5I9Y14IJJBUzGztZ6HF6nIcmKyNbE79t073njskiqMxzTs/WVvAqkxVV
         yN4m79ZC4wg3+v7duvDimJ+I/hVmHvTw129RwFOhZFsfpXjSGjBccV3F3PpP8qmYQEiT
         3zvOcbFLwTmU4pAmK5ysJ3mXgS8ylkOWk0E1/0kdoqAiMI1DlC7g/xD+HobjWDgXwZGm
         115eZ9XI8uZvjzW/ZnWlgdTI3yH5d+jEOu3OAIavpHhoFp3UbDYxjxtTgcK/YtCi9OmC
         SM6st3sexuJMCwfNfXsm6j+roiwOH52P1XmJLV1Dd0iTdnhKvKZMLJY1eHKroVb7poVC
         JDGw==
X-Gm-Message-State: AOAM532YKXAVDz8hlY2xPTKISuuWY7Zm0ydSreKH8Yfd0/nDaGRImYEU
        Mt7zsTsKF2pPFO0+83QlvGZ9mA==
X-Google-Smtp-Source: ABdhPJwE3j/uDdrFkGioyn232Py8LrD+rF3I2uZIA4806ZDgCQOieiNs1D8mhZLhedMe5GVStbUYTg==
X-Received: by 2002:a17:902:c94a:b029:f4:ad23:7e59 with SMTP id i10-20020a170902c94ab02900f4ad237e59mr1757618pla.73.1622096751538;
        Wed, 26 May 2021 23:25:51 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:51 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 13/21] mm: workingset: use xas_set_lru() to pass shadow_nodes
Date:   Thu, 27 May 2021 14:21:40 +0800
Message-Id: <20210527062148.9361-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The workingset will add the xa_node to shadow_nodes, so we should use
xas_set_lru() to pass the list_lru which we want to insert xa_node
into to set up the xa_node reclaim context correctly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/swap.h | 5 ++++-
 mm/workingset.c      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 46d51d058d05..a2e1363b1509 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -323,9 +323,12 @@ void workingset_activation(struct page *page);
 
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
+extern struct list_lru shadow_nodes;
 #define mapping_set_update(xas, mapping) do {				\
-	if (!dax_mapping(mapping) && !shmem_mapping(mapping))		\
+	if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {		\
 		xas_set_update(xas, workingset_update_node);		\
+		xas_set_lru(xas, &shadow_nodes);			\
+	}								\
 } while (0)
 
 /* linux/mm/page_alloc.c */
diff --git a/mm/workingset.c b/mm/workingset.c
index 4f7a306ce75a..e50827fc3994 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -426,7 +426,7 @@ void workingset_activation(struct page *page)
  * point where they would still be useful.
  */
 
-static struct list_lru shadow_nodes;
+struct list_lru shadow_nodes;
 
 void workingset_update_node(struct xa_node *node)
 {
-- 
2.11.0

