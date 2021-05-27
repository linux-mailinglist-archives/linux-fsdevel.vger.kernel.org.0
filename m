Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A2039276E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhE0G1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhE0G0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:26:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C63C061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t193so2933117pgb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1X6OOf9lCjkP/bI+mce/Si1A6k74NmBkIKRRCYe+/To=;
        b=yUKu6uMU39gp5llazQNnfoBCQzbX3FSs734k0SCSX8eNSn4HYwd1czfoKj055JVrMK
         CnPyzs2aR5c5ooegedgR+MK1baVRLvuu4aaLxBxqw48Jbs0oyxGq42SqIG9r71sO/nPi
         1RTAx3wwATjb3m8mzeajh12oPVduLm/csn2woaCGJfZUXaMfFHiM5ttScvImxUUroHX3
         706O90OYql9Rkba+VivEBHx9xKY2ACadQYxTE5LmBt83UR4NVtDoreEy4bKyu9wlZb1I
         WTYyhuNCFAvi27uN8C6UFzeJ4zCF0A8iIk2VMFlWF+xjEJTVn449dE97X9MymaxPQWfm
         pn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1X6OOf9lCjkP/bI+mce/Si1A6k74NmBkIKRRCYe+/To=;
        b=m1+IUeFWW9YbYMNswOZcDvZAVKPWshfCdcl2+kiX4GwlvJ0e1XVC/dwu1L1RmkFRdc
         9nYeZzj1mbqWC00LLd0dYbnQgyjnPJyDuVIvPQxwLWJQ3XqyvZD/dL1KgrFmlem/WCtJ
         9rqfslE2H4muxj8eZBaeZHEIW3qrfvMZIM8X4IXkfq6XcwtVFfqr7IWGuMy3uXonKmvS
         yOfIHoZg/9s0NvG+0vnYXB2IlZ5kIIs4ikddrUB0Ynude1c3Nm/mfWpLIC0JbiJFXGXl
         9pWbCke8/E4P4K/uY/a9+K8Q737jDvFCgKxNXAFi8osaKKIMIPbx5pKN8oUIV/s9IAxh
         DuQg==
X-Gm-Message-State: AOAM532kOnOiYrJgvz6eUNGA1uO1eSb1yA93pFh9jO3wSUt6TPXDve96
        +NeJIM0QuRQbwGhBRvJm3P1aIQ==
X-Google-Smtp-Source: ABdhPJw8+YzYI06AWPrDB7x80mQ4G/SrhgscISaIe7PFwscFc5ZGQOT6F8IPqbvcXg3UKbUcia50kg==
X-Received: by 2002:a63:5322:: with SMTP id h34mr2320692pgb.182.1622096714294;
        Wed, 26 May 2021 23:25:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:14 -0700 (PDT)
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
Subject: [PATCH v2 08/21] mm: list_lru: remove memcg_aware field from struct list_lru
Date:   Thu, 27 May 2021 14:21:35 +0800
Message-Id: <20210527062148.9361-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can use ->memcg_lrus to indicate if the list_lru is memcg aware.
So ->memcg_aware is redundant and just remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h | 1 -
 mm/list_lru.c            | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 20a43904001d..4a9e4aaecc69 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -55,7 +55,6 @@ struct list_lru {
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 	int			shrinker_id;
-	bool			memcg_aware;
 	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
 	struct list_lru_memcg	__rcu *memcg_lrus;
 #endif
diff --git a/mm/list_lru.c b/mm/list_lru.c
index e52f5a91fa0f..8006c0fcc506 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(list_lrus_mutex);
 
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
-	return lru->memcg_aware;
+	return !!rcu_access_pointer(lru->memcg_lrus);
 }
 
 static void list_lru_register(struct list_lru *lru)
@@ -73,7 +73,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 	struct list_lru_one *l = &nlru->lru;
 	struct mem_cgroup *memcg = NULL;
 
-	if (!lru->memcg_lrus)
+	if (!list_lru_memcg_aware(lru))
 		goto out;
 
 	memcg = mem_cgroup_from_obj(ptr);
@@ -367,9 +367,10 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 	struct list_lru_memcg *memcg_lrus;
 	int size = memcg_nr_cache_ids;
 
-	lru->memcg_aware = memcg_aware;
-	if (!memcg_aware)
+	if (!memcg_aware) {
+		lru->memcg_lrus = NULL;
 		return 0;
+	}
 
 	memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
 			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
-- 
2.11.0

