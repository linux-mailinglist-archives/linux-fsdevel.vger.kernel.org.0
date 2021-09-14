Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C240A83A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhINHoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhINHn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:43:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406B7C0613B9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u18so11994516pgf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CfoG77+GHMGoWvpmb0Om6WO4EZF5vVDZrlNrzkyEw1M=;
        b=nsB15Zu/N08EYQS1fOMnKPBfgz9FbWFrKXx6IeT8c4Kk0PQOORzcgc7XdjTxreVgo3
         vmvz1l+DBYMg94UlWVlOeqmzWXeyiyUXGJhKWElU9MkoRZIc1/+PdeY6I9GMnfsLTtgX
         iMVBI/jt3sEDRoHh5p4jaIl3hJBN6bMf9f5e1poH1KTAUK3roZBzlCHz1DEDsUrSTPpD
         V8CE5z9qjc9r45z+HrhMR4C4Wtx0UTGpNBinF9hIE5jJ1Ef8H4MJWJWgE5tibySqyy6D
         QVQefExtDsPELFRRftpZg/DrsiGoAe5lPHXNuc8Bw4onTWpnBfdDJZnvJDTJ1HmBE7RE
         ABjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfoG77+GHMGoWvpmb0Om6WO4EZF5vVDZrlNrzkyEw1M=;
        b=1AoKD8FJAwC+kMzpi6MT3o/x1Oxd2dMb9MrgwRMM+pJ0QMBBXHUkUcub4C31Wpr40F
         4TrM950kCR0OF0o4gosDYl3APm5oX9LLqmutM7iyCC3xjvvyTNZy3v/nrk9T6tBL55Pk
         Dvfy+AzR0ZMrqfGuT48czt7Vx868M/6nbTBoQE+2RgoD5IS/4UbQm/1BtvpfOzycYKL1
         tWJG7CK2JV5Uyi3K0VrWHhAQZ78GLiTYmEUsQXqOmVkSARQzd9HggXH5zOA0MSzIXHGI
         zDpJhb3nLB4FF7q0EGZ1OdDR6eqvoPLCGaWLcbrKjr8L2yX+jeZhtP4Zj2Y9Ze5pQNCj
         UAjA==
X-Gm-Message-State: AOAM532CP+PfdAys4Z57UXC3pTob7RXBfbZnA0nqn5NEk/NEG4LZhZii
        4s0wFVpR90Rqv+uwzpMUYgoN5g==
X-Google-Smtp-Source: ABdhPJykUi6xBK18c9DcjOjDauzCaD3qlmiJsluy1Xfxyi4MR8kmx7pulU9ughu32b8FMJ1cl9G4jw==
X-Received: by 2002:a63:150e:: with SMTP id v14mr14436018pgl.126.1631605185861;
        Tue, 14 Sep 2021 00:39:45 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:45 -0700 (PDT)
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
Subject: [PATCH v3 57/76] ufs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:19 +0800
Message-Id: <20210914072938.6440-58-songmuchun@bytedance.com>
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
 fs/ufs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 00a01471ea05..23377c1baed9 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1443,7 +1443,7 @@ static struct inode *ufs_alloc_inode(struct super_block *sb)
 {
 	struct ufs_inode_info *ei;
 
-	ei = kmem_cache_alloc(ufs_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, ufs_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
-- 
2.11.0

