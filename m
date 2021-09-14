Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67F540A809
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbhINHlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbhINHlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:41:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D6BC0611DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t4so2005552plo.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmuZFesbpf8uQ/0U/I68C6j1VVIpTQ3yrDpf1uAvzL4=;
        b=bgSbC9nMXbIXpDtFIbUvIIBISucVdUce6cYRarD5Z+zO9DijpzRA0GAKx4Qr7XknRb
         IAa6m+MXFI0tcemn4JjcyIkXKnkn9KfmBAp/hMCGMwHnkAXA1BP6ikF+03Bm5Ofbae8/
         /nTLzMwKnBb/FfZARyMkXjPhVfl/+/uAtq93mA8m+ZMqy1vcfPbnhArVMb/QC4peXL87
         iq1K2GDZJvUR7B6LHv6aaUmHEYlmqlaAtPeJ5LVM/yKgO3U4JSdOOVUNKlESs8GBZJrc
         NWa/Tas0VNSeOvqaLMV2UYYE9Hu/CfqNNYdxpTPdtOZRg0ubamiyDOeOuH1ZgMlBLEUw
         D9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmuZFesbpf8uQ/0U/I68C6j1VVIpTQ3yrDpf1uAvzL4=;
        b=V8erPIcnbDdnRGCG9y3CFzWIfctoiO8vDSN2CZfN209FHLrJwM+vqnogpy2KhAxHLv
         xECaRHm+f11+L3qLHPutjelyLq30s6xXO4IZwwaNZJfabrXuewSV6c9WlutRjB3Sg5Sq
         Hf9M63QelA+5cCP3pgJiGzip0UG0GjshclkFXzCbMG6yWKR3hhyzUq2GFH8lFMDsdIe5
         y/C2/ixoC1Ozj1CJ4bQP37YulU7fYSAC/Vg7VIofV+FAfmofRv/ioVi3TI2ZXXgsvNWE
         GvPhsTWfmNXldEVndP7D+6/pJp6S3DJyYkAFxcoUm2gCkupMoibIoJvR7v+3jxEQcS6v
         O14g==
X-Gm-Message-State: AOAM533479Pk36wDiRnGkV0pWN44eN2RsylDsrgHJ2RYO0zwSX4Ar5E0
        4HjlaTEnt+SwpTl1O+VPfznexA==
X-Google-Smtp-Source: ABdhPJw90nC1k6rLS9wrGcxTCSyCDkf3544V1/e7PHbcVflNDzWUqiUYKuHW04uAGZMqykcw6JX3Bw==
X-Received: by 2002:a17:90b:390c:: with SMTP id ob12mr567246pjb.196.1631605073432;
        Tue, 14 Sep 2021 00:37:53 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:53 -0700 (PDT)
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
Subject: [PATCH v3 41/76] nfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:03 +0800
Message-Id: <20210914072938.6440-42-songmuchun@bytedance.com>
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
 fs/nfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 853213b3a209..b759264885e9 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2221,7 +2221,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 struct inode *nfs_alloc_inode(struct super_block *sb)
 {
 	struct nfs_inode *nfsi;
-	nfsi = kmem_cache_alloc(nfs_inode_cachep, GFP_KERNEL);
+	nfsi = alloc_inode_sb(sb, nfs_inode_cachep, GFP_KERNEL);
 	if (!nfsi)
 		return NULL;
 	nfsi->flags = 0UL;
-- 
2.11.0

