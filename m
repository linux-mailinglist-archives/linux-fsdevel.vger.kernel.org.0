Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18140A832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhINHov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbhINHli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:41:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E5C06178A
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso1496987pjj.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDI0Aoe7eT1WdPk/YAFlqrx6K3CnKuQcRsWNZhlvGYc=;
        b=xmAVwDPGqQgJ4ViOkNcgEdLsmrxLdgD4nzwJ67CzaKU4Gh5OML8j/82b/juelP9nDl
         dS02vJ+dVl8pzb/vku+BjPvvG9g9JYAl6me/jLf71Rea0xorlDpTO+z/wqztU5LcMFjA
         haYHB/sXqNfZU/nvJrwiOk3BiTzncYQb/wwxHn39vbv9kIRt6QG0O/faUEgjPtPyLVTG
         5uEw3UynCL3jRk3K5yYBwxCToAxr+Av0xazp8WItfLAxdFWuFsd9TBb77caoXY1gTlfz
         r3J2wzT60oicpMvNiJyR01mTe8DFp/1DX3WKELu7cwnteoHIjIgHzBlgj8PoPSNmVSFX
         QPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDI0Aoe7eT1WdPk/YAFlqrx6K3CnKuQcRsWNZhlvGYc=;
        b=aU2UAVSEvG+nCVCyijqpFeAQronHtJiDr4bNQ8pD0DxZX/yFItEHmrHFh0UsBWgRva
         zdfIqtbI7DfYhUnOT/1aHWAqKmVCb39TLEEITBRjAlTV4fJhneagzelJcl1gSuiNx4Ne
         8PjeyajBqp8u96zHpEVn7bnNpojcYnE2R9xq33/ydTmCkJl3WBjGnE2rVWUFPP8pbu/C
         T0NEETDozz2sg3oomMXadastRFe/6U0z5OYe8ssGWkbUZWG14vigxN4OAJaJbllYGVr4
         1okAaZn8Lge+R8gHgBPwRABQLtfBRnZI7df0gZPxYNOTkUMJgz5QuT/Zc1Jd7/PWrnzy
         jWZw==
X-Gm-Message-State: AOAM531jJdKZX6CAxMxILdY8lWL7WWGV7R799u+se7XlxKl6D2xDfJUo
        KsQ/iezsviNNjHN3FlztFyMf4g==
X-Google-Smtp-Source: ABdhPJx4nRZTniyyUS2frGvxC8q+96wmQPLzlD/q8gPXNAbizsbYA949H3H7LiYRJPbuhZAhNGZDMw==
X-Received: by 2002:a17:90a:12:: with SMTP id 18mr576576pja.104.1631605093651;
        Tue, 14 Sep 2021 00:38:13 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:13 -0700 (PDT)
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
Subject: [PATCH v3 44/76] ocfs2: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:06 +0800
Message-Id: <20210914072938.6440-45-songmuchun@bytedance.com>
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
 fs/ocfs2/dlmfs/dlmfs.c | 2 +-
 fs/ocfs2/super.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index fa0a14f199eb..e360543ad7e7 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -280,7 +280,7 @@ static struct inode *dlmfs_alloc_inode(struct super_block *sb)
 {
 	struct dlmfs_inode_private *ip;
 
-	ip = kmem_cache_alloc(dlmfs_inode_cache, GFP_NOFS);
+	ip = alloc_inode_sb(sb, dlmfs_inode_cache, GFP_NOFS);
 	if (!ip)
 		return NULL;
 
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index c86bd4e60e20..cf044448130f 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -549,7 +549,7 @@ static struct inode *ocfs2_alloc_inode(struct super_block *sb)
 {
 	struct ocfs2_inode_info *oi;
 
-	oi = kmem_cache_alloc(ocfs2_inode_cachep, GFP_NOFS);
+	oi = alloc_inode_sb(sb, ocfs2_inode_cachep, GFP_NOFS);
 	if (!oi)
 		return NULL;
 
-- 
2.11.0

