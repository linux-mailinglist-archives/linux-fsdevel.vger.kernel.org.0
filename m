Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0ED40A77A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhINHea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbhINHe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:34:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEB6C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v19so5558634pjh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+aIm9+GM4emS27x0YwVh2nGeYKtoN9v9qJyVZ5TBac=;
        b=tcVTQvhIix8U0yHs7BLHxZMEPABn2dsISnmA+yZSjfp2ev8MDXF7eDdHAJvKPJ4xkX
         PNr4ylRUrZ34B88F2kvtAUWfVN/EBD5BtpS3HZkEZR7BfQzT4p6Y06tR5/9VG6+Aodei
         kRVGcb0pqYSCsfsEgkErotCWrmEoNZD3PSjBW5Y1YAHYtiI/6gja9Wn4fePBE7onrQvH
         XAJ9td79+7/0McQCwSWs8BQRVLW9G2c19R0KmRwiF3B0GmMMCIdbZo5u6p4o2Eey12cL
         A5JPRu3pkpDV34iUR4H0LYryP9pdO/oldTjF/MRuJrzVq0xtrcya5/P41feW2Vomf4bo
         xiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+aIm9+GM4emS27x0YwVh2nGeYKtoN9v9qJyVZ5TBac=;
        b=htfONH9bR5BcKbJrFaxDMJLqpGIqzkQP1E4kNXsOlxNCdAxX/mTFctAnRYr11owqqj
         fCd/7NyN7G6YEFmiS/RGJkt5rC/X3ZbEjQz1xBaZY90qGOSuJkPycYIOcjzPemJI/DO7
         rEZlYnLNCIkhSbY4dyZJSrwotYqe/5M6XMlFGgCDZSJq1GvZnhaEGHdISu5MjQ4hGh3h
         sPAEMZk3hcp+nzfRss8nzDERb6GZchQlGsnxVBHeVgEr6iuPNGD6PYrAfOfjqNzKIA5T
         pzg6Y0JxYwURlh6IqBJfZeMx3l9llZPy2U8MGPlu5nUSLE1XyNCMQ9NdMH+B+BNohZOw
         kYoA==
X-Gm-Message-State: AOAM532MugT6xNR8tA+ShlL5R+BEZrGwQ9I3dVm6XTYHXxhzKMOloXgB
        MvgIu9o9TrI+SqvFm4pU3Ozwsg==
X-Google-Smtp-Source: ABdhPJy5yp11xZApIkE1Vn113OINJsFeyKeaalsWeRxGnUmKvHenQWNNl7bwBD87nXmQEd1XiYqflQ==
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr510983pjl.185.1631604790353;
        Tue, 14 Sep 2021 00:33:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 02/76] mm: memcontrol: remove kmemcg_id reparenting
Date:   Tue, 14 Sep 2021 15:28:24 +0800
Message-Id: <20210914072938.6440-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since slab objects and kmem pages are charged to object cgroup instead
of memory cgroup, memcg_reparent_objcgs() will reparent this cgroup and
all its descendants to its parent cgroup. This already makes further
list_lru_add()'s add elements to the parent's list. So it is unnecessary
to change kmemcg_id of an offline cgroup to its parent's id. It just
wastes CPU cycles. Just to remove those redundant code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 999e626f4111..e0d7ceb0db26 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3635,8 +3635,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
-	struct cgroup_subsys_state *css;
-	struct mem_cgroup *parent, *child;
+	struct mem_cgroup *parent;
 	int kmemcg_id;
 
 	if (memcg->kmem_state != KMEM_ONLINE)
@@ -3653,22 +3652,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
-	/*
-	 * Change kmemcg_id of this cgroup and all its descendants to the
-	 * parent's id, and then move all entries from this cgroup's list_lrus
-	 * to ones of the parent. After we have finished, all list_lrus
-	 * corresponding to this cgroup are guaranteed to remain empty. The
-	 * ordering is imposed by list_lru_node->lock taken by
-	 * memcg_drain_all_list_lrus().
-	 */
-	rcu_read_lock(); /* can be called from css_free w/o cgroup_mutex */
-	css_for_each_descendant_pre(css, &memcg->css) {
-		child = mem_cgroup_from_css(css);
-		BUG_ON(child->kmemcg_id != kmemcg_id);
-		child->kmemcg_id = parent->kmemcg_id;
-	}
-	rcu_read_unlock();
-
+	/* memcg_reparent_objcgs() must be called before this. */
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-- 
2.11.0

