Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7E40A7EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbhINHkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241064AbhINHkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:40:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F75C0617A8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so2064223pji.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5iPQxmNGx8c9eY92mOopijUPDhnAgGjqRDHLpg8cWBc=;
        b=KnZSj8IleHoM8Qx7qtmx3jQgoCMLpLoyaVdHTTemIHbLy0HrzLLLGL2+x8Wvaaut2w
         GfGAmMnE/WY1PQtlqD4lXmGKfLluDTSogGWQ5fTa2VSkpA2bbn+SHjpxleHUPRe2fXOA
         VuZgEkG6inLqa8VANrweOCbrTdb0r5FWN5luXOcT4540XcPRSjY6SYPCfHYDggNXT9di
         lS0LbesxwPuQlNRDJfWT6a1UIBefry9JgwLo4oLwVtYP/U8c8QUPcgBj4tqShi7FJDd9
         nyEh0jfTQFRcSbHb86SJ9ndHBs7qHNa9KKuGp3NcGROL/MUGCqcfvr1I+hyyoV/G/mUu
         NqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5iPQxmNGx8c9eY92mOopijUPDhnAgGjqRDHLpg8cWBc=;
        b=NXgC1z3CSt/NmKBrbGmvLH8/VxMNyIFsHPoNpw8kN/qWZRPFn0LspK76m851jOyvqx
         6bfDmay5rbSxxTWIUKpgw6V5Vxdp8IQJs5pZFTRJGSQiaVOFSmKVruHj1yUgc9qToexL
         5m2vNUrwr9dmwS+8jP9yv2nw7vfZ2rPdDf27Ptr/h7Pq6sCgr7+szm+3O0W/XAGt2xV3
         2FP7I5XW3/nxKH7yHgPjq9nNj1qgqlIgjsPMgI4gZv4/WUf0+47QtWGykXuU9Y7qMg19
         tnH5ZuqesRfueMDGSjw8S+ae4Y3rlueDolL46Xq8gZ5F186E8bE7jvVQ/XyrVju3AWhp
         gvkw==
X-Gm-Message-State: AOAM530QII+ZG8KZov/N3/Fe1hWtZHyv5ePBsITpYI3k7CllRV1YgvIp
        zUU1mgx5a+xgsJYMTe++a1uGzw==
X-Google-Smtp-Source: ABdhPJxSG/kZh9LKDmkEuJyth73ipjaHCl1rtnOHTh4Hm2UylXX9XWCMskyVYqB8MJ5g19LpZwHl9Q==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr558209pju.208.1631605031038;
        Tue, 14 Sep 2021 00:37:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:10 -0700 (PDT)
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
Subject: [PATCH v3 35/76] hpfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:57 +0800
Message-Id: <20210914072938.6440-36-songmuchun@bytedance.com>
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
 fs/hpfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index a7dbfc892022..1cb89595b875 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -232,7 +232,7 @@ static struct kmem_cache * hpfs_inode_cachep;
 static struct inode *hpfs_alloc_inode(struct super_block *sb)
 {
 	struct hpfs_inode_info *ei;
-	ei = kmem_cache_alloc(hpfs_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, hpfs_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

