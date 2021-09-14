Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFA840A846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbhINHpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbhINHoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:44:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D3C0611C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r2so11919355pgl.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7/YayZrshcF7Mwrc2QA6L3YOuEA3tYMHuJ8BscQyJk=;
        b=z9t/5nzUvwFyULnC4TA8PMncxhfHbGYcOY/JnfGiZPat2l+jPZ76aJb9o+Sh412CZs
         zU2QysWuiqUVdhHU/4IuVhePtFuR7J8aMaiYFfC2uaZWt8p4ebDXUN7RoRb2cGXSGxtL
         wwd5vXhsOZ3GtuIFOdYDLierUO4oVjKlJIxua8wx0ZImVGGAAI4uUQSMC1LFZccKiOpL
         jAeCcr2gT9ChitIj1NoDoqSOAP/47HG7xwFeRdD7oyqGLV4QV/4rWwWfI04JpFm59kyx
         1gUr7iPKr9SQ9o3cB4B0URKzG5HTMDVr7mhm0cyuD6V7Ch6oqD+qhpzCl16b0Y7TROUX
         4tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7/YayZrshcF7Mwrc2QA6L3YOuEA3tYMHuJ8BscQyJk=;
        b=bKBoOi+/aSTkgwZnCe3X++cO20qHzWgN1WnxCRkoywFS7ofTQ61LDt2jE920PUi53e
         7bkkDP943+dmUg6Zn+Cc6sWYU7NOxikhRk0GHa536lzW1skKdgBByHTPA8Tp77cdhlu/
         B1OvK4vXt++gt5t6YtTAPGY5e+mBQsBjnhGOuUCBcJqNyu46RQQ9UcN51y4YetE3n3Du
         2lO8es+z/9LpLmB5++5NpngmBxr8KDP80JujJ30TdG1S+9lYSpxJ+cUT76QZ+wb2OPTS
         4KppTqGChQ9hzBTvSeaZHULsFbmgCgLvxiAM+Tu2zHwL339sRxdku0PEnITGrvso4Pok
         blfA==
X-Gm-Message-State: AOAM531ufc3qx/dDCHrwyiyLGU1xeinOiOvBQ6E8kLhkq4c1OmLuUtpf
        4uGy5Hb80ddeWR1dR/XkFCJffw==
X-Google-Smtp-Source: ABdhPJx4WMylrbowlkfveFjBUl4wg3+euB+A0opiDR8fYsKryJNGlR8lQaUcijHeFf/jEbbrdD28TA==
X-Received: by 2002:a62:6103:0:b0:405:2c7a:9ee9 with SMTP id v3-20020a626103000000b004052c7a9ee9mr3475258pfb.71.1631605223847;
        Tue, 14 Sep 2021 00:40:23 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:23 -0700 (PDT)
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
Subject: [PATCH v3 62/76] shmem: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:24 +0800
Message-Id: <20210914072938.6440-63-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a5ae8266891d..541bdf61113e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3738,7 +3738,7 @@ static struct kmem_cache *shmem_inode_cachep;
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
 	struct shmem_inode_info *info;
-	info = kmem_cache_alloc(shmem_inode_cachep, GFP_KERNEL);
+	info = alloc_inode_sb(sb, shmem_inode_cachep, GFP_KERNEL);
 	if (!info)
 		return NULL;
 	return &info->vfs_inode;
-- 
2.11.0

