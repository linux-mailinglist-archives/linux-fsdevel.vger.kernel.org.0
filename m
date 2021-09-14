Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270E740A7E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbhINHkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbhINHjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:39:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D5C0612AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f129so11935962pgc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85ranNZdyaGfIOzMylg5hKugOz3EzRoTjtK/I6Bf/uc=;
        b=scs+UQEpQpVrbhxG/18iJA5iDDX5adwTaPjyTj1/tlfT8b0WEFYeJxSeuk0hq9oFGf
         KiuHBuMXlggevT7VbeCvO0Nzj5flt40abbEYfZapdScLVNqAOrrd33blZSHe6m9GL1Nc
         nGmuczfYWt1v2BoGnc7kjCgklwI3rluKyQ4jw6Erv6RYmGtQi0JH0Pm+b0JN7tQqU6Wy
         9Ik8pdsjFRHQN+PDPhkDjvqH0z9CuTyx9zk8yluDPCMeBnmd4pa9jfO/iBb8MORiUbnk
         ebvWdrJNF3aLWVgh3Xn2GT+GyvQbs5cktdqb35Jcauxi5iuXbEmUQspCHgqNhJGzGsda
         6zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85ranNZdyaGfIOzMylg5hKugOz3EzRoTjtK/I6Bf/uc=;
        b=ZuacHQAOBWUtp8VSAkMvV8Ukoc5iPDAKkUF25b/Pz5bnkzvMM866woRsWbpX1xvxoW
         1v/RK8JwDLEreAZFw+NcZR7XGcuR3wdB76pgcEeHQWCT0MQyXU2MbrvnC/4ZmiIsd7ax
         afqZWovc5nqn2lm2xrlQeNCWjjQDegVi6qsYWvpa+rMZAP0qjY+fqgeSKzXAKf2D4HCR
         RM9+EMWrgWzknwfCeCALqvIN8XDLmAp7EwPEDs2cBuhizTnsr0nbqHLwZS034UAyOIpA
         B6DeRsL9AYtZw63RffVcUwvGPfAPHucmxzwVSOJS1wrm8B1GjUle4ACvaT4cwUrYItTO
         gjtA==
X-Gm-Message-State: AOAM530XFkmVpGoa7XeYty4lfQ5WY5BSn7JY+vzBf4HEUY5zkv82r4gB
        zeQdNeYEAxwLRUFRAEf79zJjqQ==
X-Google-Smtp-Source: ABdhPJwGllShuPmxOvjVu6jph61EmdMYmV0yMEMvXmW9o6lRUA3dKq91tPkQW7t7gbAxo5+jDS7LSA==
X-Received: by 2002:a63:4b5a:: with SMTP id k26mr14357882pgl.241.1631605009165;
        Tue, 14 Sep 2021 00:36:49 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:48 -0700 (PDT)
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
Subject: [PATCH v3 32/76] hfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:54 +0800
Message-Id: <20210914072938.6440-33-songmuchun@bytedance.com>
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
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 12d9bae39363..6764afa98a6f 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -162,7 +162,7 @@ static struct inode *hfs_alloc_inode(struct super_block *sb)
 {
 	struct hfs_inode_info *i;
 
-	i = kmem_cache_alloc(hfs_inode_cachep, GFP_KERNEL);
+	i = alloc_inode_sb(sb, hfs_inode_cachep, GFP_KERNEL);
 	return i ? &i->vfs_inode : NULL;
 }
 
-- 
2.11.0

