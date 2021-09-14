Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7125140A860
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhINHqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhINHpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:45:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0AAC06115A
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j1so8242524pjv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=JhAlTvU3RWk3oRDa2aTY8JKMFt9Ez7Qvhwau43LIZwVt3n/yJ2Ir8tLfT7NZ0H6X12
         BDxLL+Oux2/7MjK3Lk+uIMdVrHQuYow40eQBrr/gTXkfEwB7Uc1quD/ffiKvxxblMBvm
         xEsvUkz22/wDzy0vSKKxw6k8g7pGDQtRTRrQNErOmdxF+ohBQk1K0XBFi5DnQYBH2r/W
         IWr5m2jyR7dnpVY7TDJbByTDRTtN51tcAQmDTCpmEb3lkUzPTJT8DNyN5RjuxCE9V1RT
         qXCa7mzgwY58hyW6b0OW7M80G8cYfjWnRViBLfe9PQZFD5CmWIplOlDoNwplM8r58hcM
         25UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=ml+SNG7fDI7MCZ/pMoY1FCNohttIgy+Lj5FqlBUYwZiYgxgIGxdsirqkY6A1wKCYN+
         7mGKmVzGfUzEBnytvVFOBaCJAlN3LzNHfLGXsGnR8Z6ukxdY83XK2ISXRUqFtOKTaZ9a
         l7AmNpBsjGj57UlQPW209LeQ4gH3PfuusTcU9O7a0XK+yABiEfmyNKuqi2Lkpz1BHEIw
         pWAE3UxL1vkla8sN07K19FY6bIO8hP1C2yfjZqoij+YdRX8BEo24GQMk7AbHqCRBv1k/
         mBJe5u+RePdO18veVkabhW65nYaz/3/bLa67rU1RY6DGgxJzcj9Qt82tu9xX9tpAGlMR
         gn5g==
X-Gm-Message-State: AOAM5339NkmvuYm8Eaqf4lzR7LRe8AVUwnABEwxD0BrfWlj59lfpS8Ug
        cDvvaYs0LrumeXkDP9ervhCyvQ==
X-Google-Smtp-Source: ABdhPJyAUjo4UZB4NIB2ZL+LCFQmoGF92sZYCgPBvTgn0UV2XRJw/w5a6fkyBczWBG3bB61VQWmbxw==
X-Received: by 2002:a17:90a:9a2:: with SMTP id 31mr588698pjo.58.1631605257891;
        Tue, 14 Sep 2021 00:40:57 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:57 -0700 (PDT)
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
Subject: [PATCH v3 67/76] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Tue, 14 Sep 2021 15:29:29 +0800
Message-Id: <20210914072938.6440-68-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like inode cache, the dentry will also be added to its memcg list_lru.
So replace kmem_cache_alloc() with kmem_cache_alloc_lru() to allocate
dentry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..36d4806d7284 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1741,7 +1741,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	char *dname;
 	int err;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
+	dentry = kmem_cache_alloc_lru(dentry_cache, &sb->s_dentry_lru,
+				      GFP_KERNEL);
 	if (!dentry)
 		return NULL;
 
-- 
2.11.0

