Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E3940A830
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhINHov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbhINHli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:41:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591FCC061198
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c4so6051639pls.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8hlIcDfk0mow6llnUEv9/58AX1omPaJoCkY30fcKWY=;
        b=fGvI7crPN7y2wB7zugMSVMD934Rpx18owGNJqX667ywd7wjVyIEVf68TUocK6k8Biq
         0qxPe5D1SShPrdfucXUFLWGS3ekJaSpwv32maWMZRKeiCb8roNmC00EUhRyPN6kyCs6h
         eMrUxk+YqESaxDXnJRE5Ojjd7g/Y7cnlqzM5KVuGCmweYIh6v065qQ1YlyZsFq3bdjRF
         hh3i2wJdIoIPvB6++RUiegYh9oxErKNxyyw50T1L+zev55HJf0ChPw7lfmILcARbqI+Y
         itOpA48+irtTc+zZzxHwFQty9pb1lM6NTEzw+TiwKNAgMmrH05j0JRZllHytGgz30WYl
         1yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8hlIcDfk0mow6llnUEv9/58AX1omPaJoCkY30fcKWY=;
        b=Yf3sy6pCObIspQA/PGgBYhDzb5sxfK6eK1Azr0Gze4lyeci8VH06BJgETLF1R+U9yi
         325H3pm6T5FsrD/DF3A7LQoAglDH5WTDBQ6ST+rLXfG2DP0TedsftdONn7l80uTACEec
         sRyxq4denYntHrPR83nE5IX19GkBCtwqtrZxX0+oZJ1gtz+549j9HiFY5bhd5xkZYjMD
         c1Qva2GWCFX7cYrxoeihvMpPmk/CdSBuJblpKduVJjoVPOz+zINd8enS8BsEhxJSqa/w
         bcPGg3bPjfBuBJ5WcjTWKgoIbjK+jbR212uGtRS1ERVzCWHnbqfEzjPdxEAxusUi8ZZF
         4EKQ==
X-Gm-Message-State: AOAM532DCbemwsEN12s3N+miapwRHAiskMGPJBnc6Wq8T1J0P1EP9z+r
        Aucd2eW4jF1YjWat8w37iLVISw==
X-Google-Smtp-Source: ABdhPJwdMtQMYVXYBSOM8G6vlPmp0Zlhj0YG5SwPDq2spUGsssa5kLTHoX9Qr5rBUcowcrrjr8bl1A==
X-Received: by 2002:a17:902:dac6:b0:138:85a7:ef80 with SMTP id q6-20020a170902dac600b0013885a7ef80mr13793050plx.45.1631605086892;
        Tue, 14 Sep 2021 00:38:06 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:06 -0700 (PDT)
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
Subject: [PATCH v3 43/76] ntfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:05 +0800
Message-Id: <20210914072938.6440-44-songmuchun@bytedance.com>
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
 fs/ntfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 4474adb393ca..fca18ac72b4f 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -310,7 +310,7 @@ struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_big_inode_cache, GFP_NOFS);
+	ni = alloc_inode_sb(sb, ntfs_big_inode_cache, GFP_NOFS);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
-- 
2.11.0

