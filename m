Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A415F40A814
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhINHmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbhINHmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:42:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD875C0611BD
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d17so7590198plr.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Qc/LiwupPFvLM5PjYz1016FD4bXKawBQsMG6Y+2qQc=;
        b=Vt4T+99aUqqmK/2gRbOdiuTv8LFaIEnqMYscXlXYrrXZ9klxmtSKfdh8ea2MgqYSfO
         NnQS/Nsp4yjEsHeMD1eoI39VwM+q+33icicv11HpoRFb92fPs0y5B0jTlqWXyroZTm5L
         27H0F/8ukxcLz+lzc4pkfDte0ofTVl1cM+AZck8nCWhKYWVMqez2otMrz/VdanyIjf6P
         6QRsryXSIR/it0XwcnDjVH9lS5nRcQ/gs/WzzyXrch/ehXNE2TQHcyzBGMzZgNgibUfn
         3a5saAN504MO3x0ZUlQR+AfRVeUKFLc+Up+oi5X5/beXqlWX1B/omQF66oO0u6ztjAJW
         zhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Qc/LiwupPFvLM5PjYz1016FD4bXKawBQsMG6Y+2qQc=;
        b=WOwl80hvjB78AB8nXNHb4ky4Y6H0vj8lge6kFDaoDRndJoH4Not27lTHkwf3RkU9DU
         sGr2p1yHvcdNbQSapzmwJhafFZYb/zLOK0b6pI8tCAjuCgYekLXed0rpnbLEvnN1e8d3
         2A9FaP7/Myw/2NET3SGYsGWevWG8/W8aU/kbjLY0MuKFiBKHjRFayWv9YNHdwefUpHAW
         n3DgOjAgzU0Up547aZI7HBsBBPLHkp2GgHoQ2JadJarYWR9+o+R6AdDtR/lGW5WS77p4
         201hWvz14/wLfoJnusEC1f2FJ8AI4mXmFoDA7vbB7Eppq7P6iXUlLPhORkcNGyY9/YeO
         YS/w==
X-Gm-Message-State: AOAM533ZH60vxr+q9gOva29HL84r/qi1El0dF5CCeddzkS9etz1I+N93
        rtfViLPSZ5x5xqE86B9gRJnK9A==
X-Google-Smtp-Source: ABdhPJwnBjb+nXzxqyWjL0Fk9lx/rUaL7hrM3TuzCo/oPyxIZ3sIl5O4e3jS1LKm/iLzXYJDQo/5GA==
X-Received: by 2002:a17:902:e0c1:b0:13b:76f5:c3b4 with SMTP id e1-20020a170902e0c100b0013b76f5c3b4mr13740150pla.85.1631605117505;
        Tue, 14 Sep 2021 00:38:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:37 -0700 (PDT)
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
Subject: [PATCH v3 47/76] overlayfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:09 +0800
Message-Id: <20210914072938.6440-48-songmuchun@bytedance.com>
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
 fs/overlayfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 178daa5e82c9..0e2a38a0b857 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -174,7 +174,7 @@ static struct kmem_cache *ovl_inode_cachep;
 
 static struct inode *ovl_alloc_inode(struct super_block *sb)
 {
-	struct ovl_inode *oi = kmem_cache_alloc(ovl_inode_cachep, GFP_KERNEL);
+	struct ovl_inode *oi = alloc_inode_sb(sb, ovl_inode_cachep, GFP_KERNEL);
 
 	if (!oi)
 		return NULL;
-- 
2.11.0

