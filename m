Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296F740A7A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbhINHh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbhINHgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:36:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A72C0613F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v1so7589713plo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pedf9du0q8x1qAsaM5V3taJv2nQf7Bhn4Zyu6Rs8BOA=;
        b=UmoEkfxCRPhIo5HEYCOvUTLwt2JiJ7GS6xmqjTUFzuAs0PIbDbopH2NDmuJyFjtvSA
         6Qocu6XCUru0ObSWp/NjROFSqLvbK1De3Fo1USBVt+p+GeyE7puX/aMKapXy+mPilRpn
         1AjHYrsyrr3J41uOox3PqjFfRqMWjfKb6impQOYoGwyJbValrlYJajenPS7+RYtemLIl
         GUO+IphKhrxtkIgZFF31nY2xO8r1RCKRr4NdnKa3tynWEIgt/k5x0ZJKfQ0ag50EUOwM
         tkrQAQyCR7aEmJqihD3I5zpip1PyBFUDFZkQWNKp6X/8XrHpgktM6ZkSnpzrvth72bFz
         4W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pedf9du0q8x1qAsaM5V3taJv2nQf7Bhn4Zyu6Rs8BOA=;
        b=Z+/ydRx9pTTE58NuwWUzWpsNYZJN3UXKHTDekz2KHkSsrvb4K1PEDbu7BUJDEgYZdf
         mvZTmYihOp0ReJPOqK62hetsiQDUQEcenE9E1cOq/vm5uK6A/wp+1gJTtgCGhXzgOxCZ
         re/a48GycFTx5UrF3WSc9Jy5J3x23pLEG7nQmxjeOGUMGnsLgb8yHqBqwGooB/ZSXKQZ
         mrzEEkLStMB0tVAbjSjFvhNzI0I94rtBrdCxTlQByC5/uB5O3dSAcF9aCNCXUjVqv8sL
         Z6ZKjtHwScbESwcauGl2Hf/TsQ5xTOP9Fanm2Bu8dSABhQL7bGyaRH6rleHfmPMxZPxy
         Dzsg==
X-Gm-Message-State: AOAM5338/Slk1K2i+Z+5zHAsEKCU/sUWPXHCbdZqH4SWsr3bZEu1+wxe
        ZQb39/nClHgfcjCZSuadsqN6jw==
X-Google-Smtp-Source: ABdhPJyrhuxUeqV+K1cl2xp3aIj58oY9WlBf65ST7PoGj30D+6kcbs/jZTrC/qRoOUA6+U41V1WqrQ==
X-Received: by 2002:a17:90b:4901:: with SMTP id kr1mr574557pjb.80.1631604883756;
        Tue, 14 Sep 2021 00:34:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:43 -0700 (PDT)
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
Subject: [PATCH v3 15/76] befs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:37 +0800
Message-Id: <20210914072938.6440-16-songmuchun@bytedance.com>
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
 fs/befs/linuxvfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index c1ba13d19024..b4b3567ac655 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -277,7 +277,7 @@ befs_alloc_inode(struct super_block *sb)
 {
 	struct befs_inode_info *bi;
 
-	bi = kmem_cache_alloc(befs_inode_cachep, GFP_KERNEL);
+	bi = alloc_inode_sb(sb, befs_inode_cachep, GFP_KERNEL);
 	if (!bi)
 		return NULL;
 	return &bi->vfs_inode;
-- 
2.11.0

