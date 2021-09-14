Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1608440A7CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbhINHi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241517AbhINHib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:38:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBFC0613E4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso1273983pjb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MveWRP8aGyEbJw0ZERHfw7irE+XE52etLPWDr/jyMk8=;
        b=1QCNrsd3fTrCJmYq7AjXylTezy2s+9nh0iSZRPvyjhcuVZGQZlQdPj3bGiN+SPoyMd
         6r9cYRZSakLZWOVLj7JnMRmbn1rQDqY190OcP9qawDYIurm6vnC7/vAFkOF48797xJS+
         55PhOky3xA8w3egEogrUC17aerb3ceC7orkYOSuS9XkYZD+UJe4nNKbGfhA/rJ7X7Tcu
         Ov6YOSnJRvoMjFUexePo/N9MYfL8e3MH8JQg5+WVDMkPoUNTQt3mixMBZA5j/6+uI+7a
         r3juszHqxmUE8+iCub+REM1C9zplbGz8lQ6tSS2t/9QdcGks/Ru7ahJNWbFn60UL1XR1
         yIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MveWRP8aGyEbJw0ZERHfw7irE+XE52etLPWDr/jyMk8=;
        b=X/2EPs3auG1Nu6bv6eBKJOStvus7o6I8EvYa5vQuhJT3rRPhk2kghBJJrulSKHKnVA
         XJwIJNZkREjwgNL91u9MJU24kNYqdfqWGDH6+IvmR6AyHrOJyVxx+P0DAzAw/wepGUas
         I8SqOqcU6Q6dyJFGAnoKHvBEsTYKdhmYc69lZcgoqNyQugeHYkQEfbuz+ZFHI+TqKVdc
         Gn8LDmsf1/D7pQtsYXYXBcJN5tLU3zA3lebDTEAJNEf/6sxfSkVR2mXzdScBpneNISqT
         xRJSb8Yb3AZEx6ZuN0oVMAurESjRUNWXc2ja7S0kF/q1b0wGxWvKN8RsgJ+mCxTrG5sY
         haQA==
X-Gm-Message-State: AOAM532DYw3w2/EuWMVodFv90aazsBZP4UHU0y0kyI1ta5kS8sg7smya
        2dtTQ/DHzC39w92CjUNlL+k5/A==
X-Google-Smtp-Source: ABdhPJy+tuUMTAb857qWSQifEc13Im/IfToxtwJuI833rQS1l7Wdsiv/q7Lz8DwaE+JIsU/V472dMw==
X-Received: by 2002:a17:90b:46cd:: with SMTP id jx13mr554861pjb.122.1631604963433;
        Tue, 14 Sep 2021 00:36:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:03 -0700 (PDT)
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
Subject: [PATCH v3 26/76] ext2: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:48 +0800
Message-Id: <20210914072938.6440-27-songmuchun@bytedance.com>
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
 fs/ext2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index d8d580b609ba..8deb03ae4742 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -180,7 +180,7 @@ static struct kmem_cache * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = kmem_cache_alloc(ext2_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, ext2_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	ei->i_block_alloc_info = NULL;
-- 
2.11.0

