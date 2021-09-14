Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E411040A795
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbhINHgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241071AbhINHfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:35:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC823C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m21-20020a17090a859500b00197688449c4so2094896pjn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDLcpu946MbvuRuUN1EHiKI2jWbJ59wOnelshGEwx5o=;
        b=EGcTSzQ7LymxzMTmcq+dY1RH9ZVtzdq+L+Vjkit29Ww41oJngNrtZ5zm4052jkZaiC
         7p5aUcuMt6czSQXWt/P7YkfR8Ulh2OdcakbGakJT015ZoKEn38W1rljR2BFsXSDp9ka+
         F9mDBF9RU/Hw9axHyaHS2b3yPsMb9t+e3Od/Xku/gOZTsipnJAFz4qYQsqFnqWf5LS0w
         qPaRpBgAq+f5zw1gxYt1jFvBh+OBB5rYVBWGCM9yx5HNHrx9ytpfVq9LNIiEm1vzlJBO
         7pO4zaMTd9lpyex/J8rVnUKWsUjiTHpJuVl++l1wgTf5D24yJI58JBZI0UiXD+wis+Lh
         ke1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDLcpu946MbvuRuUN1EHiKI2jWbJ59wOnelshGEwx5o=;
        b=inZBfjuoRLZ1OmWnHqSDHTPzVcAbfCHSydq5JGihPcb5+dKL09uMZkNrkLMY3tliV1
         BachfllCVhxN6GkeYKZ3E41RHLHDboWeDoWFa7G5lprV7r1k+F5Q4TcU5ZLFUnBHDfwQ
         4196eCz5t3/lPaCjr7sm88oXIjp+7+n0X1Kv4bWyf2+3GHxJLkiEnpmUYqd1lXRVKK0r
         a7AgjQiHujaxaypbYUKJNyBQreUN8svu2sUHmuym0AaREG9rF1Toi9ihvCZCbVobB/8Z
         q08xCZyii2DKSedBeZktaSrDe1g6j48Isdrnff7xPKMyDIcYSQGamixypKJXLYqlazLv
         1o4g==
X-Gm-Message-State: AOAM5338PAytrfs07X2OOjm8rM6YUQ5hwq2iPCZatpbvisZ8DSnXUl9Z
        viLWxtsAAuUM3OV3ep+oPanavg==
X-Google-Smtp-Source: ABdhPJwbNQU8pwckWFcISKjOKiStbCnWygByP2QJqQa3Fx2qPJKGChBhiiUStRWPmq4GXF6FfmvNuw==
X-Received: by 2002:a17:902:c40e:b0:138:e2f9:6c97 with SMTP id k14-20020a170902c40e00b00138e2f96c97mr13773344plk.26.1631604850440;
        Tue, 14 Sep 2021 00:34:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:10 -0700 (PDT)
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
Subject: [PATCH v3 11/76] 9p: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:33 +0800
Message-Id: <20210914072938.6440-12-songmuchun@bytedance.com>
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
 fs/9p/vfs_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 795706520b5e..5311f35accf5 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -223,7 +223,7 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
 struct inode *v9fs_alloc_inode(struct super_block *sb)
 {
 	struct v9fs_inode *v9inode;
-	v9inode = kmem_cache_alloc(v9fs_inode_cache, GFP_KERNEL);
+	v9inode = alloc_inode_sb(sb, v9fs_inode_cache, GFP_KERNEL);
 	if (!v9inode)
 		return NULL;
 #ifdef CONFIG_9P_FSCACHE
-- 
2.11.0

