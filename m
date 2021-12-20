Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C148E47A66B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhLTI6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbhLTI6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:58:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3EC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:30 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 8so1233859pgc.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=8TvIWV4OcYjjwOFikHz5icX5EPwoGVd0G0cgNnPZ3OwEVCd1pU0l0TJ8kMAJsPK9RM
         PRN4azkexQwIGxX7faj/qui7DqF2/6qbwIrig1emlHBmVHQtiuJgzZaDIoVdcE/hIYRa
         f/oN6byDYFY09mwkdmC+7+ld0PrHoNv7SsfBSloklfRKOZyVer4Py+Otclx/EreCtJG/
         b3mcLGEd2YVWGbstIdlB20L0l9MilJgHwRkTvvvTYy6fKkULljGQNO7/4W7UzWrTBCu4
         jGyczyontU6bv3EgHxp9f9K3KxkB978FR87aHBY1Hv3kkxaFJcrHa0C/5zZlyAU28jXI
         BB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=ZGw5MXKSHwm103+e9WSVVRQeSZJuvTw+gNm2iw5+x1K+QmmQJvYnjkd1cN71CircEr
         1Hi7kSW+YSbipdncvGW/8q6qWeNkij/Jleykc76QZhdLqIRKmDaJPgN6WzBsnNqjsSPg
         o2NetohjaFAZZ4+nCLaXqOd9/eduMSxyNHvAxi4ysZ3dkq3UfPfDsvoQ+KvqY3bPheQu
         3/IXYxpWV6Hm4qMazZD4/Ha2GG/HEPqXaFKgu9iPF12eQ1PZZoyv6YSb7dDBSzk2ePhY
         9+reNOdZW2+fwu7vom0uGYYET1V0Q5JzuIplu/jTGUbo43TdE5zc1HfHkfW5g50lxMfa
         mrCw==
X-Gm-Message-State: AOAM531aczyJx9tyMXhmmk6D1z1UcYRsLAqEpDPjadmDGzusgVWU01W0
        JyqkJTxEL1yP+VTOT2eXA7gMOP2MIl2oTw==
X-Google-Smtp-Source: ABdhPJwgD7F+t3CwkzWdwKXbO2malMfQYkfyNPYoSA3kA4cX5MYf5gaBUpJ0WwXdbwxNoKoRJzJXUg==
X-Received: by 2002:a63:951b:: with SMTP id p27mr14121588pgd.524.1639990709993;
        Mon, 20 Dec 2021 00:58:29 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:58:29 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 07/16] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Mon, 20 Dec 2021 16:56:40 +0800
Message-Id: <20211220085649.8196-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like inode cache, the dentry will also be added to its memcg list_lru.
So replace kmem_cache_alloc() with kmem_cache_alloc_lru() to allocate
dentry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..36d4806d7284 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1741,7 +1741,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	char *dname;
 	int err;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
+	dentry = kmem_cache_alloc_lru(dentry_cache, &sb->s_dentry_lru,
+				      GFP_KERNEL);
 	if (!dentry)
 		return NULL;
 
-- 
2.11.0

