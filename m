Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3640A82E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhINHoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhINHnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:43:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB61AC0613B5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d17so7591501plr.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jq1ii8A4uQXumPf/NnNFLaE389Tt0HeSx3fXMRSpHEY=;
        b=mT4FkMAo0C9XvgGm7TTt1y2GGwp6xYsyTEyh37SSuVDZxf4eK7SKxsMqb30qkdoseX
         oKPLNqiO0xX7L7dj4fzYOpaFYrK0ux6Mob00Kaxx5nssQqOLDQQU9kq10h2rvO44/dKw
         dnxMA8j8877MzbRnf4MOF+sisgWX3j1StFcKANodUOY0BjcjxomePimI9sO0INBeGoja
         ysUOwHxnZdDmtmca/YNTEJ+JdJ9nCvxRBjng1nmfsvYJoGFqaFuV0RHWnnB5VC7PdV4c
         RXzO38ez4IIZvh0e72G8X4hH+GQMUD5mZ7lAB4rJNlofF+KHbzqmGHMljrx0pV0QbwYe
         jIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jq1ii8A4uQXumPf/NnNFLaE389Tt0HeSx3fXMRSpHEY=;
        b=yhzoRGT9taP9kj4+m/lr7na2E+YafDvMqtZxIqXMY+Ve0jK2RLCfVZvou1RMLS1ZUK
         TZVuvmOqR/lxFXN9d0Y+4zjyLKehxto8DUMhAfBupxDsRCEPNa82+Z7k4Ijz6/vTC93x
         ATLLlTrKS9F+t0gvq+G18IoFVWn5DSYGf98R3GqBn79u/RxI7uHr2rUgtlxNbFEQ4BGl
         Kpz56rqszkXcgnjYadmNXJHnCglLoeLdP9vmdM5NnbaTJBzsZLT2QHzhSLMdQKq35Iyc
         s1UDFp8jtt9FOKkUntNfp9lc40oYLYZ6DM6lGeVisaMlk/OUz0jBiY8EzVIj/xjTfS+B
         JhgA==
X-Gm-Message-State: AOAM5336hjb5UbeDVgqtUDsoTPHE4fcP+dEHlHbC8bWqc6tWgv/u9vhq
        Aabd1VXCEGSFZdPXos//DbZFjg==
X-Google-Smtp-Source: ABdhPJyKG+S3Gscm6xr8oqCH8qcvg04CqYQ0tSL54xAPfDg7x5NyQJSymcpp2OEzNTwQ6Ju0NLBrTA==
X-Received: by 2002:a17:902:c40e:b0:138:e2f9:6c97 with SMTP id k14-20020a170902c40e00b00138e2f96c97mr13786006plk.26.1631605172395;
        Tue, 14 Sep 2021 00:39:32 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:32 -0700 (PDT)
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
Subject: [PATCH v3 55/76] ubifs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:17 +0800
Message-Id: <20210914072938.6440-56-songmuchun@bytedance.com>
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
 fs/ubifs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f0fb25727d96..73b51f8e6817 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -268,7 +268,7 @@ static struct inode *ubifs_alloc_inode(struct super_block *sb)
 {
 	struct ubifs_inode *ui;
 
-	ui = kmem_cache_alloc(ubifs_inode_slab, GFP_NOFS);
+	ui = alloc_inode_sb(sb, ubifs_inode_slab, GFP_NOFS);
 	if (!ui)
 		return NULL;
 
-- 
2.11.0

