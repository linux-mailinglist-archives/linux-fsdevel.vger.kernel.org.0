Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FB140A810
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhINHmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbhINHl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:41:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32853C0612E7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f65so11337662pfb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5L3/NHaCGqFlXi1PgtyPXPldesWisd5M2MzkdPFswpU=;
        b=aawds+ZdgmQfgr4O19Bbjb1tnmHppDZeHQM28obpBAxc63f/d3ki+9vg8HMeNgCvZ9
         l1fv4U38sV9NVGlyrHRR/L3biZ3qMuBgMcBJ9/4d/3OdwQf3VnFrxWRGbbepAVI7sArV
         AfkHKSDuNhvgEgZEYICVo1qqRY2XolcCiBTM1eqKKDTjabKr7vU/Ew7prI441h+yxe0U
         psjwfhIeEXa1UIUGkoULi4SOGfFHhOQyRxNyt5yf1UEVjJttnJu7DoFDtotNJ2hUvFWV
         UUH2szXMKPJVLVV9cXPKc0GnOYjr5NDBAiQOCIjsR5oBilqlzVRdV4l0VMHkUaTBja1J
         3l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5L3/NHaCGqFlXi1PgtyPXPldesWisd5M2MzkdPFswpU=;
        b=ciaFvBZlELfQxDVMv3qN6V+DUpk0ZkGNQwZ2vTtHx7vOeBhWEWVpIgpd2G/UhRB0zl
         DqSUBZ5RkLWCFkyFkBkIMKWV86NCnIVUX//fXQKQ20JlaccbpeIaRAf4S+PhhoaEvM9j
         20W2IQHz//B/5zHAZoJE4CdTYV1Zg3lQq0Dz8fL7C5O3gsF6b/t1Nm+EJ3STTVH+X4dL
         kXsox4xlkvEwfhm/v8qR1vabSGJ8JrXAuim/WUNunI7jbBarDsK08Wow9UOq1Wtnm4Jx
         KiELkAOX9w3ZIwOg9d8m6PmYus4HTtk4KSlxYgDQZWAK3JpGlD3yaee3Qkd0fF8W5QFP
         hWPA==
X-Gm-Message-State: AOAM532HM3VwsTN2qQV0nRpV3bU3DV8W7h4MhPmeuT9Ow+IFyprisNDm
        2mbXgRrjQbXlPU2bxkxTX2GzBQ==
X-Google-Smtp-Source: ABdhPJy8+rOLc14+gnFDljhOryw2SP31lFSN5DwaxpCdBACFxg01n2dIXxGl5EEh/bqyueZ408ipGg==
X-Received: by 2002:a63:7454:: with SMTP id e20mr14244578pgn.136.1631605109791;
        Tue, 14 Sep 2021 00:38:29 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:29 -0700 (PDT)
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
Subject: [PATCH v3 46/76] orangefs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:08 +0800
Message-Id: <20210914072938.6440-47-songmuchun@bytedance.com>
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
 fs/orangefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 2f2e430461b2..1deb411ca5e8 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -106,7 +106,7 @@ static struct inode *orangefs_alloc_inode(struct super_block *sb)
 {
 	struct orangefs_inode_s *orangefs_inode;
 
-	orangefs_inode = kmem_cache_alloc(orangefs_inode_cache, GFP_KERNEL);
+	orangefs_inode = alloc_inode_sb(sb, orangefs_inode_cache, GFP_KERNEL);
 	if (!orangefs_inode)
 		return NULL;
 
-- 
2.11.0

