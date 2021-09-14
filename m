Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1404040A7E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbhINHk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241513AbhINHkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:40:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D381DC061762
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u18so11988427pgf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIgyRDPnSS/1J7ag3xqeLWjyouPh4gl6PlA+qRTekZA=;
        b=PyOW/6GoK2XsRe2NJ7cCpiZLTaeT6F6pQKixcs2KAyvR+5Z/mRQxtEi0pP+vOjwEPO
         PAncKSttmDhCH49J1Gr6mtp8yGewJZDUJBBcwfLuSQYbBNZ/TI1LD4s1CxA3lH6TGEpo
         pdEP6cmECZIzLXxI8HQNVd4iZ50JSx2LapChtha0k5RqUSw5X4zBGJpaCQoHKK8hzcTu
         /MmDJc+NdtSatcI7E33E3jT/Rl8ublvlEtJTCwdJchle8cnvY8065nce6hh4uTvCrnjL
         Rd2voYUwAWg7g4s7EtR87k+jnfmazVddeuWYTEAOr4ug//3HYNtFpgcdVGLcTwOMwpwg
         d6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIgyRDPnSS/1J7ag3xqeLWjyouPh4gl6PlA+qRTekZA=;
        b=IAiW8RwOlMP0uQmCEd1dHA0CvttABLOLQtiT3kTiNvlpWsXCmg9m3cl87l8kVSzdlx
         qgiurWaOlNFpB6zs5QrWc07HuA1Pasl4rhxi4+BAe6t0zkb542QH97wPCWexEZ0VTp/V
         f1ARSmcSe03Ah18tHZXXab9PdLAxTKr594QZvxy3cDfhPnpFPO5mnYuRrIu65geYHcEs
         5ywnV3miEJsHTbJViyLiTcfrDAFprX1+Lpaz5XBbcf2p1UFO36WGV2qFwVSflzrL9YSS
         400yjDoWhS1rLSbXWJkxiT8ZVlAZ47j9KqVGNRrlqZq8gQG8RhujRidhufa6CHT/cRHj
         jJcw==
X-Gm-Message-State: AOAM530okcQacIEVc5n1mrmlZhKX0bNhx2UfIFU8gqvDDVqS7YxdxuDB
        vmQf5GETRGX8XT6bHrjpLKELuA==
X-Google-Smtp-Source: ABdhPJzBqv8a97y97tqrOm4MQyzpy5XU/BTSSq6lA22I2sLvRfI63XF8fDmB9QhcEgokLAlwmntHuQ==
X-Received: by 2002:a63:3602:: with SMTP id d2mr14279308pga.390.1631605016459;
        Tue, 14 Sep 2021 00:36:56 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:56 -0700 (PDT)
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
Subject: [PATCH v3 33/76] hfsplus: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:55 +0800
Message-Id: <20210914072938.6440-34-songmuchun@bytedance.com>
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
 fs/hfsplus/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index b9e3db3f855f..8479add998b5 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -624,7 +624,7 @@ static struct inode *hfsplus_alloc_inode(struct super_block *sb)
 {
 	struct hfsplus_inode_info *i;
 
-	i = kmem_cache_alloc(hfsplus_inode_cachep, GFP_KERNEL);
+	i = alloc_inode_sb(sb, hfsplus_inode_cachep, GFP_KERNEL);
 	return i ? &i->vfs_inode : NULL;
 }
 
-- 
2.11.0

