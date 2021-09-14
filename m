Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17740A79E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbhINHhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbhINHga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:36:30 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F277C0613DF
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y17so11323688pfl.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m96L+zVQUR6AnDBWXoAHTXEu/tNBSY5AnJri9rNBEEI=;
        b=Y0hjJinSBRIbrKfMVhAkCDp86Gz7tBwHyDz8ynbEIsICEuIt8cCVWfa19XoTVfKVr6
         iK3B1qUIgJuNqbVpIAiujCfNlFxPGo2o7L2KYY+JVh7XHWaqY08O0bVjWUunkwvUtHR0
         zdwwmbHa2Qs/YpRQjPWeB7HqWhUrAFlyO2MkLFB90Z/6H2V1TBxBacKnADuSA3GHns7q
         mCa5+IK8uXxjLu3yUjiSwSx1sbAgJxQKieCkM9RudG0n2qQE0NfXlp1JoP8c1VyPPpfj
         EiDKP6kikslkO98hgqx7q6ZxnG31L6mcG3CLAallv8dDWoA7qq/tuYUuHo43DWBh8wTb
         1l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m96L+zVQUR6AnDBWXoAHTXEu/tNBSY5AnJri9rNBEEI=;
        b=JojCvE6dpwZNy0q6ywkJDktR6LYlZwF+F+r6hL/ARzlEvFcQKYm5IZ33RCJA2r/KWQ
         abGM9Js8zddSC73BRhar2RFzXLNFys10YOkGxpXAbT5RrBabtc2fP1R+ElkEi+c5FnIr
         OhEDj77eeCO3GH+cRbLXCJK05VVWH84u+GAHAM+Eveak2sXjoB9sYPSWeCrsFwsQ2RZ+
         CMd2z5eM9bV7Bxo9oMItJNhbA+BZYvzJJ8d/gLlsL5FjytJjO4ReJFBtpu9n8dsHv/vL
         e8DQsCkqZBSOvAWzggQ4IY5hlcaKB8JPsjQhX5CNspYqKjp3iHp/bnv1C1WIqjTtnQNJ
         Ibxg==
X-Gm-Message-State: AOAM530BfgyNtrDP/iXxrm1oMnuEcvXA0RBHlSiemtuggcBcVkuv5czd
        EL6nTRyTY4cjM+ou3AwBDqhbrw==
X-Google-Smtp-Source: ABdhPJw5l5kBaKBTV84qO1bQ0kgDegLUgD7W0AdA+4Utz9av4/Ad6AgcCH+taK2oUcCvKKd8wZJi5A==
X-Received: by 2002:aa7:8d10:0:b0:414:ab01:656c with SMTP id j16-20020aa78d10000000b00414ab01656cmr3315679pfe.13.1631604873164;
        Tue, 14 Sep 2021 00:34:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:32 -0700 (PDT)
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
Subject: [PATCH v3 14/76] afs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:36 +0800
Message-Id: <20210914072938.6440-15-songmuchun@bytedance.com>
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
 fs/afs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index e38bb1e7a4d2..0ecea5a94af9 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -677,7 +677,7 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 {
 	struct afs_vnode *vnode;
 
-	vnode = kmem_cache_alloc(afs_inode_cachep, GFP_KERNEL);
+	vnode = alloc_inode_sb(sb, afs_inode_cachep, GFP_KERNEL);
 	if (!vnode)
 		return NULL;
 
-- 
2.11.0

