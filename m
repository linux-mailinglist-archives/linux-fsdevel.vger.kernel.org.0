Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC340A7E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbhINHjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbhINHjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:39:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1D8C0612E7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v19so5564090pjh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqeEB6Z1lu1YikTUjiCI3SOPcDMSLqCAf74hbamBzSk=;
        b=QoSWUeR65uEahiEKqRTucDY0Wp5Y3nKeDQz+RwKu+bXIO6FI9E7mLfiV5M3mk1I0vQ
         CINhG0Z7eKGHFS54U6wB5LI1BPDocuQCKLS/4Pg4h92qe2GhRj8xTBu7WArvYORkaRX3
         +iy8lSraS7pjYVR7KzEfcR65lTLifqj9wdRaEmEqe3QGG+7rdea8/OIHOMvoiGuCD9hV
         BcxDW2AQfO4losbPjoUUz6VZc++Ls7XJIYxAAEhnsXDbm01fLmm6SgAxQzx3nTKzrrw+
         iPkxUoOvtqb0u01J2FuU1ugdp33XWMeUKkZXUUmnqmqykKPe+0Zs9T8sLzEmF3ZfV6sR
         8QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqeEB6Z1lu1YikTUjiCI3SOPcDMSLqCAf74hbamBzSk=;
        b=dBIJrQZxiAZcBoHd07u839Iu0tI5s8YgGUu53nI10ZefRUj5BOarvJ5uREsUHHX9Xa
         eo1FJ0DiCXxbvKS8yEL6vYPQil+xTseivILBDPOorcPrlvbZMyWbRC3LMqisEfoGGbPK
         pT4iHwB4UOyuKSFglkrrXAa8jZyrS/MdCdHw25ztWLnXAcyS9YXOpHlEl/4s0alE6Rbo
         lSzhbE9ecL1KYjiCc3+HkBPoDqBiO/ktfRlT4S2w1Wq8msxdPSdUHWBJkWWKKyi2oFiK
         //bA3kLmrGIie4x3woJBlsD3h5uzlp2RBKWrdXmT+xfQRuZXi7EXSFAPKrkHG4u0VZ6s
         5Ppw==
X-Gm-Message-State: AOAM5339M26tkQA8al7fdqZevzSATjIg1fMB5ygRIVP0AbEcfPzCoHZM
        Ddd3fn4oC00lE3c57EYUTJDQww==
X-Google-Smtp-Source: ABdhPJwaxpmIuEPcMTXjjIYbJvFSyhYriXYhvhKQEm4ywlA78+6xQFYUylgy3qJj1WpGr5jNpjYEig==
X-Received: by 2002:a17:902:76c1:b0:13a:95b:c138 with SMTP id j1-20020a17090276c100b0013a095bc138mr14100410plt.34.1631604993769;
        Tue, 14 Sep 2021 00:36:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:33 -0700 (PDT)
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
Subject: [PATCH v3 30/76] fuse: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:52 +0800
Message-Id: <20210914072938.6440-31-songmuchun@bytedance.com>
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
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8baa76b4ae41..bab5c564301e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -73,7 +73,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
 
-	fi = kmem_cache_alloc(fuse_inode_cachep, GFP_KERNEL);
+	fi = alloc_inode_sb(sb, fuse_inode_cachep, GFP_KERNEL);
 	if (!fi)
 		return NULL;
 
-- 
2.11.0

