Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8217E4C6C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiB1MYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiB1MX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:23:57 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1347520D
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:23:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u2so2993050ple.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CsekL525kd4wMUq3hGH48YYiOw10AxsnYHSRiavRRo=;
        b=yWb0o30Ai7jt2ic9aWpnmT0w6NOd++UYjPe4/U84uEfZ4Yi+dBC0OL9YaYP0QDWrod
         9S+z16kZh3BplAN3pFakq2BGTolIjPo9Lt/XyrYHdTnDcbNQnRQH9Yp/Q59ikL6eGeFK
         1ToP4tWaSgcD2SSmZuXcyjqtjf6qI5+uGQo4TjkT2REeZ+EYjQdcH9YZcm9ZfdAML+A/
         HihZUnPVgpAr0P5UzPoK8MZfq38wH/2HORkBwF92tUJcmlqe1tlMJYVnoHH1YJVNVIF8
         r2sMqsZMli/jOXygwlCZVLWU3lXaZ8PVWgjqzW1rrLElxuBjdOHU/h7JDB570GKrNzwo
         ZTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CsekL525kd4wMUq3hGH48YYiOw10AxsnYHSRiavRRo=;
        b=B175eAI4QkRhsZOX96q8PGvx6PU+9EiEsmTjcmI5DubsKaGYKLh9oB9y0gkKLBeUY+
         Rs8kd0+BszBTaXVjXv4OxdPk+K/XxCXyf7g/WHJylqB44Xi2QJzQKhuMuSzZTuGjARZL
         pTU8GXxTzBnxr60y4AmQTn4Hz07lMdQyrxqsamImZCrMmVzEJrN+3+H2Rbry2wb8BQEw
         9HaEp8ZXnfCSPlwuuddGc26ZPSUP4+lO7t1gvabhJ8/RE6uRbCqr/+kVbBGgCRD2V1PP
         f+fRbWISYZv7gQFYxmwpVHCcYfHC8P8pU60SpCA46n8BExq4YuGD/IBxUcBPPbrjoKuH
         AlZw==
X-Gm-Message-State: AOAM530GyAl06EfYJ+whtDcKuFN41PKajMhYio1RerWlcD61XFqrbzJ+
        XwN5OdAf+UswKjGyiOH/ihxtRA==
X-Google-Smtp-Source: ABdhPJz2mJtVFcGCpLkGoeKpHWerUiwrRW/dint6TVNOtnn8bqEp9SVeaF46LPLwo1CJnR1wfgQ1LQ==
X-Received: by 2002:a17:90a:bb0d:b0:1bd:3baf:c8b4 with SMTP id u13-20020a17090abb0d00b001bd3bafc8b4mr6631856pjr.15.1646050996207;
        Mon, 28 Feb 2022 04:23:16 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:23:15 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 07/16] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Mon, 28 Feb 2022 20:21:17 +0800
Message-Id: <20220228122126.37293-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like inode cache, the dentry will also be added to its memcg list_lru.
So replace kmem_cache_alloc() with kmem_cache_alloc_lru() to allocate
dentry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c84269c6e8bf..93f4f5ee07bf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1766,7 +1766,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	char *dname;
 	int err;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
+	dentry = kmem_cache_alloc_lru(dentry_cache, &sb->s_dentry_lru,
+				      GFP_KERNEL);
 	if (!dentry)
 		return NULL;
 
-- 
2.11.0

