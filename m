Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E394940A7AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbhINHhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbhINHhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF0C0613A4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bb10so7603504plb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ngaq8HeXVg0bDvfdB7FNpFgH1Z9L4n9AUAaT+A4ybEY=;
        b=TxlM/LNag+9j+pHHnzYxUIcqTnlG8CAktsmrXO0thXlgjt/0xKpEydfDbhVIhyLlSb
         8yaYLg0UVhsiS0IwI3D60wScJOYPe1zGXz1U4suUJ+i/6kRKVhMTFdS8ckWexTA4EE8h
         QEQyxDPXEneT65b4sX+iNOkGENj27L7Kwcfw3Y/ZG6i4O76WdoUR05MkcXlpMHaATepI
         4bx70VoM3TP7FMg4DKmNTasIjpr6AutJjLhrZtyNJyGSIDlLVAovGaPfa/HNI2TpR4Ae
         bQbYTzgj4IThGaUi5gXbrxK+V+eg2xuZdXHAOCxucXaqXGVpbLtTzUvJmXX4EK4DfMmn
         xE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ngaq8HeXVg0bDvfdB7FNpFgH1Z9L4n9AUAaT+A4ybEY=;
        b=pLQanKV4f5Vdwlc+LBhQk4oj3fTsKj8H6r/hdlozNWk8V7zW8fsoY0T8+CX4twCbsk
         Yc2qmHrcQilXvM2Cqtce8H0hX3qiz4tt5VpagzYvVMPzqRNHJ5adRH+E6Dxt/iw6NHBV
         Ws7EC75pAxfbl7FTDqAPa31mRNb/bfSqBbG8Bqe5KVnZraGDl2UL05EnFppIBzYaDtXV
         9JPppAt1m6nS/20yDK4k0Q38JDq48/sotV+YW3xQ3J4moBPUgn67ouQrVLpapRoh9WRx
         3h6m1HxVe3PswwH3fIfYKkFqlkg05nQpJjbWsPQnGU7aCqicvPo3PvPMffqqTM1g0m/R
         2a5g==
X-Gm-Message-State: AOAM533IzBtf5+Z7z/V/IDcMb2O/dTa3HpUAwyOICxoijzBPTkr/HwBr
        aNVRm4xPl8KDwTJYWdTOkJmw0Q==
X-Google-Smtp-Source: ABdhPJyCiB4o0BV2SmG7F/g3um9IpNXO0UQAa8xTk2H4jdGoOJfauoZeyXj54vI3CCV0Vr4LlpBBNA==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr523956pjr.123.1631604898107;
        Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:57 -0700 (PDT)
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
Subject: [PATCH v3 17/76] block: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:39 +0800
Message-Id: <20210914072938.6440-18-songmuchun@bytedance.com>
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
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 45df6cbccf12..1630458b3e98 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -799,7 +799,7 @@ static struct kmem_cache * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
-	struct bdev_inode *ei = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
+	struct bdev_inode *ei = alloc_inode_sb(sb, bdev_cachep, GFP_KERNEL);
 
 	if (!ei)
 		return NULL;
-- 
2.11.0

