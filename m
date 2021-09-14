Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA44840A7C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbhINHiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbhINHhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C4C0613B0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:33 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s11so11919012pgr.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70dZb4sygyL4z0x1TtZhkqlyiFHEDmdlI4RF8O+Vt1A=;
        b=zJXxJLj4ESHJp25Po9c+bepEEQGcRbSFaDV2ROX2AMMoOoCP9TQExmc64Im8VFxp5B
         MUbQMCkQxxxkYmZCMzfBk6z8KLOFhOhku7W9pC0lFQPcLJ1LnGL4cdd+u1XWHfqEKaB3
         M/X9zlmNtovkUWmhhmvxlhBvO4p6EWob+U3epYvIHJD1ZJdbV+P1jW99NMGCAhMDPZnf
         NO+s0pwOoHRfDHA6amvhUyJItcpPPx/tURrq9o0lysXBBNnhuKjiPxZ2VUdVk3AO5I4B
         Ykd1TfvSaYv1qtzADmeKpO6qgYm9J5Wty1ohHvctCi6EFvSx5zps2XBMXfVs0cxgiR9t
         5CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70dZb4sygyL4z0x1TtZhkqlyiFHEDmdlI4RF8O+Vt1A=;
        b=VpCSFPrLEoXDA+iXOllueyzk1oG+rUI5DUIu265MfIRwoiHKvWLIf64hnBYbO4XDFB
         iCZONMqAauWb8xGdFlKQMXV6n0Wj0oocsfLN4tmIDnBelOP1ggWTUfUtHDgs8K1hG9jT
         Ceg6/h1kzagg2amgai1H0yg68qS9gZsu3dENnTLdxlTqJFBFJM3YQ2Lu2zZdCL8ONKI7
         QBQjW154RB9AKR1LG4mdbKcrcyG5xCy9IY599bPUjXgP6uCZ7r/VqQFRJJsywLSZbdWn
         eClm24zcp4cqJKQjtJ2zFA0m7/oNuk62S59lxifFLocagwiW/jJRS0hsEmCEw//Bnkjw
         8+rQ==
X-Gm-Message-State: AOAM530TtY9An/MiPMYed6+18ttPZXNsK1ZxM292DLh5LDhsvTx1hK5o
        OCkyfzpOd4tto7mnsFnREIuQMQ==
X-Google-Smtp-Source: ABdhPJwGydjmVciK31lObC1YoqbXvngbtFM+HXY2vjQE8P9Ine0QM594NQCVdnzHC2NEtuckQpjmzA==
X-Received: by 2002:a05:6a00:21c7:b0:412:bb0b:850d with SMTP id t7-20020a056a0021c700b00412bb0b850dmr3476534pfj.33.1631604933364;
        Tue, 14 Sep 2021 00:35:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:33 -0700 (PDT)
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
Subject: [PATCH v3 22/76] ecryptfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:44 +0800
Message-Id: <20210914072938.6440-23-songmuchun@bytedance.com>
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
 fs/ecryptfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 39116af0390f..0b1c878317ab 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -38,7 +38,7 @@ static struct inode *ecryptfs_alloc_inode(struct super_block *sb)
 	struct ecryptfs_inode_info *inode_info;
 	struct inode *inode = NULL;
 
-	inode_info = kmem_cache_alloc(ecryptfs_inode_info_cache, GFP_KERNEL);
+	inode_info = alloc_inode_sb(sb, ecryptfs_inode_info_cache, GFP_KERNEL);
 	if (unlikely(!inode_info))
 		goto out;
 	if (ecryptfs_init_crypt_stat(&inode_info->crypt_stat)) {
-- 
2.11.0

