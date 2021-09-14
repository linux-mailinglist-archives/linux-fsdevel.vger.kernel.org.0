Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F340A7FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbhINHlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbhINHkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:40:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B4C0613E3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v19so5566128pjh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ug2CfhnpXnTircvAyexMndzlOWvwUpbYkNH+XVMb7RY=;
        b=t+GIzASmHdVakA4h5l+IAozDzezhapoL3sp1pcm/t65BJX3rutl/KWV3Qm2QPbhjYz
         p/rRF+BphO+PrkXJilhr3xhnO2wB5hDhNE6uCCqWfyVH7Ad3pGBSIAHJO4FrLzNTrf5e
         ETmN4X1zqYqSimY9WNapyBUeOuVYn2nimycKQaUbBsdGVsSbuaNK4u+TDxc+R0bX+bnM
         akbw90cRwY9ax0h7jalRVbH4jUogRZITjRvHfLnF4Nqf3lSzi4bs84oRMgVMniknUq9V
         Qfq9QagKXmezJpUEaHacD1HAxC+kQsE5jjYZ8RLPY0/r/TSkhgNd6NK1BBdl5049vaD+
         eZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ug2CfhnpXnTircvAyexMndzlOWvwUpbYkNH+XVMb7RY=;
        b=53GudV/t2sq/lCwoYLl0siRe/umNQLjLGU8+S6rLP5DK9YSDIK5XurfBdfC7hISC7W
         6G07qYm/FGd0n81hjCnka/6te6S4pz4SvBoNFFKS2iV1XW5nVKBEPRoFNp7b4L6DHxG+
         on7qgG/Tx1amHhTe+lQ/Cut/T+ioMWtJMCOI3PsrnVutk3EjtLE1k00OhYfmIKniA8En
         W+vwPnRd9rLbDjlOrW2yx8jOxTAOWjTbMQ/m1AbMvTJPYwx/mh+FZkjwdl/kpANE9IUv
         F3xPd9jCYi4N+3VxMGb98jY2an8fJ1BZw7d8XhBn6ErLz3ppqG11EMhcrxyJOG8lr27o
         3z5g==
X-Gm-Message-State: AOAM532j4GoTMCoafl2bRVJDeGXhsYTd1Xr27ODOY9lLj1crnl89J6Vt
        THfYCW4+QTT4pq7f91bgkmeCDA==
X-Google-Smtp-Source: ABdhPJzoEWc0JweX9N6Ga3zaYNr1bmeJZgLXN1Uyt173hJeXuTknck19EkElbOg2kxH46qCDstqdiQ==
X-Received: by 2002:a17:90a:ab07:: with SMTP id m7mr551052pjq.27.1631605060269;
        Tue, 14 Sep 2021 00:37:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:39 -0700 (PDT)
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
Subject: [PATCH v3 39/76] jfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:01 +0800
Message-Id: <20210914072938.6440-40-songmuchun@bytedance.com>
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
 fs/jfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 9030aeaf0f88..5e77b5769464 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -102,7 +102,7 @@ static struct inode *jfs_alloc_inode(struct super_block *sb)
 {
 	struct jfs_inode_info *jfs_inode;
 
-	jfs_inode = kmem_cache_alloc(jfs_inode_cachep, GFP_NOFS);
+	jfs_inode = alloc_inode_sb(sb, jfs_inode_cachep, GFP_NOFS);
 	if (!jfs_inode)
 		return NULL;
 #ifdef CONFIG_QUOTA
-- 
2.11.0

