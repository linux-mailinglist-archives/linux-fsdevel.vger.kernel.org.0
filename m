Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13DB40A820
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhINHnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhINHmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:42:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08642C0612AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so2069609pjq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=by9NfbxzyA9OaU41O415kc2mnEvP01WDocZm+uGoCXI=;
        b=lDvvzY0uEA3X/+hq1dQH9zDz/ubjo0Dqpy4DFm8dgjth7TNPsAgsg7nkg7/yqzvUE1
         WqaLt5T+Soiuh5YENtaxfVOJsNK1dz9wvizCFZpKgtImRU3yCtYtTlqyr6jMw9iN7pUZ
         fcbXR/5eEZ2iyj28KJAddteqj3wGgAQ87gbMdap5r/uBLJqvwoX2GLTT/twasEGndVZO
         zRhg+pzuTp63xBaKB93cVBrd2qthIp4O68AQbutKy/WthW7fuhkauWwAUwnzXxCprZ0u
         hVvFagzNBb6FEOgL91BQx0mq1qH1a0XoBq0pG3yZ4Hz+HEPAPzhQTrMAxNivNB75M3Jf
         7lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=by9NfbxzyA9OaU41O415kc2mnEvP01WDocZm+uGoCXI=;
        b=5RVWW1ATxozSMFx6ryjpJ28OGipnaEAmOZ0cc6PVAnLFLMTYh7xHYDXFjC+LCbTJRx
         S4V4dD9/wv3ClxmttrBiqE1ZR68IF+XfnK3Sacbyuv4ctiiuO1odC56R/9W3qw1ddy46
         DjcEeV2nNDfB05huamRBF4QEQA1/7viQcYLZksmREmNWXguO1t7hEySkbSmh979BJgFk
         HtBAeAYutVbSpSSgd4v/DLhj4y6eCp/23VvqHvQ3CUfH1V3Vt3yrC2P5PL5gVa4A7P2/
         6EZ71NtDjxDhMmpnmsODERySZjxDloIYR61qNZ2rksImt8Qj9koEVu4VYdj6krqlJH0T
         h+DA==
X-Gm-Message-State: AOAM532/2Pdc1XrXeBB9N/es2zc2N1oG3fW811d8te5Z+LHepHRbMGXD
        olMtXLBhgyV90lIjX7bygJPruQ==
X-Google-Smtp-Source: ABdhPJwWCz+YhluUHhHodW2PrbNo6vi+zerFmcFdV98Ijs8yYhsRbP2lKnBz3Rx4FUr7kVF3FNyXBQ==
X-Received: by 2002:a17:90a:12:: with SMTP id 18mr579942pja.104.1631605145552;
        Tue, 14 Sep 2021 00:39:05 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:05 -0700 (PDT)
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
Subject: [PATCH v3 51/76] reiserfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:13 +0800
Message-Id: <20210914072938.6440-52-songmuchun@bytedance.com>
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
 fs/reiserfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 58481f8d63d5..e7beba4dae09 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -639,7 +639,7 @@ static struct kmem_cache *reiserfs_inode_cachep;
 static struct inode *reiserfs_alloc_inode(struct super_block *sb)
 {
 	struct reiserfs_inode_info *ei;
-	ei = kmem_cache_alloc(reiserfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, reiserfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	atomic_set(&ei->openers, 0);
-- 
2.11.0

