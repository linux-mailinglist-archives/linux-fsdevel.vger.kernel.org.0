Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B056340A7FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhINHlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbhINHlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:41:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1DBC0617AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so2066912pjq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pk/g/5Ewh/BWbS+r3Zv89u3wQLvB5lvkiHidZy1oV4s=;
        b=WcY1yPh80TMJjBnbbZGtw/GMPkEzyaMHqlULd/NRUKXt8pI4DFQ48vleP7H1vE+xgZ
         hRxFd59Mq4NsGlRtjpmK2x5LpWLAQYeQFBDqRmENDo32s1LIcASy5xWfUrYjkoZah/VQ
         oVxqt22Ky7knQ+tVD3kq3XyLg/uaBhHDTOxc6/ej4r5Net3HI8MccZjHzIigwFKdgea8
         8PCWLWL82eHmzNQP69G+UrnMBcqm/xsVmXxC4b4wKzHRBu/EM8iYQg621F5+BXcaQvaG
         ay+FP0jNrKylQJlKN0ly0UWA/32zT83i11WoYwI8X4Jx7IHeJdR2TKFMAF7Ydcnwf2GF
         /fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pk/g/5Ewh/BWbS+r3Zv89u3wQLvB5lvkiHidZy1oV4s=;
        b=iH3MhmAPYf76g96i75eyekpNwu4kOucppewdm+I8hWg9vTORLtE8Cpsw1KKc0nhues
         6/xQpzh2D66UA0nw87+ufzBNHzmCELExQNgFh0a1/rzfIY22yQmBADRAFFCD3EBF4bNs
         mv9sQ69caVwlXenHwVYRG1Am92lmAkqtlmN/0LQvF70/7O95QTktrWrpVQn+a/evV9AG
         knEoils3CdCu9EniowRSinSA8VmZX7xuDVjaGZIO6epXa89o677SC4sGvPX+M/v9dMvl
         7NbtM5aZZ9sHCf399/rR4PVixQr7wjF3yA4Hr1JKJnXTUKLQWDHpjNWWzvPWe5RUkD/w
         rN8g==
X-Gm-Message-State: AOAM532J7TOHBuEdWiTsqGNg2dhDRToCPY8nAGebWiIWr9lfqbgx3kg2
        OYWjWL9jmdcSBUgcvGx6EErnEg==
X-Google-Smtp-Source: ABdhPJwAGMeu1lrF7aTg+QBhRC0+UWnw9p6bJoyt7yw1ZBNdvK+yJAu5u1J+ZNfa1KsLG6IJbI0Fcw==
X-Received: by 2002:a17:90a:4ce3:: with SMTP id k90mr524134pjh.237.1631605067036;
        Tue, 14 Sep 2021 00:37:47 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:46 -0700 (PDT)
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
Subject: [PATCH v3 40/76] minix: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:02 +0800
Message-Id: <20210914072938.6440-41-songmuchun@bytedance.com>
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
 fs/minix/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index a71f1cf894b9..8a0af80741b5 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -63,7 +63,7 @@ static struct kmem_cache * minix_inode_cachep;
 static struct inode *minix_alloc_inode(struct super_block *sb)
 {
 	struct minix_inode_info *ei;
-	ei = kmem_cache_alloc(minix_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, minix_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

