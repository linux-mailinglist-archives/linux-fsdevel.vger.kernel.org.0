Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA46640A7BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbhINHiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbhINHhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7CAC0613AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t20so8229218pju.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yn4GjbGKOalkp7KyXghKb9kUqc+WdE7xPBBNtSw49kg=;
        b=npB+pVn/vbn0eNYwtlSthJv7NBkOrOYMdLVzNAnEHX0BsO73iZoa66jGaFaG5addC0
         cgJiTpm3Pv92k7hEjsZ05n4vWim9yUjZaflyMTHnB+SIxMH42+iuoY6FtWyfDm6T6uZM
         /SvJYTj0xZW4myvwa7ToEcgOpprF6LR7VMWYknvR26p0Qu6ZqxtY5e15cZta8W3aeblP
         Pu8Gyt1UcMCae2DKj9uC8co129TdSbpSUsUFBHsAv3ASerGOo92IyrNVp7P5ai0EDton
         KJkkOJDmM35KKrYqDrF7k790Srij5c5bn1mgnYI3eLrodF7RbhmMbZFUPZCbau4exCN+
         lHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yn4GjbGKOalkp7KyXghKb9kUqc+WdE7xPBBNtSw49kg=;
        b=pE9Lh9Ep2mbVBOOaljNXNyhpTf98NhS/KRvb4ij7PdsselhyLw1EP0IBDee+0fT2KD
         XMo+GFjzcwlWjEzymvMc1zyFIyYXjVWsyMa6Qs0XTHsjle3cjjpduvbUs5p6rxjarPnE
         j3n/9cwMgbLr9LHKY9VqkssPItDsQzScgRBUFRwwZpv7AONci++vhd6rx3WydaEG/jcJ
         2oN2q9gJ97Fq/u6hb83I8KWYBHk+Ul3+/MipeqkKhqP32rF7v0ew6u3lPZeKhGS5TNCl
         YDXtkeDzBVe7z9ZkZx0DBz/OcE6AHMH+wbdVOECE4Izc0esqt/KcCMn9upT3xT6LChvP
         XGGw==
X-Gm-Message-State: AOAM533Yhy6C4pmK0aW/Nc6Bz9t91FoDYPFyxhANlIdCOXBXvP8jmUeu
        nVwLN4z/ot9IqVPru6mLhv/gYw==
X-Google-Smtp-Source: ABdhPJxy4IufRBKzjD8wBmIhR6AaKyadsNj889rMyLOVXLMf+K5MDbdlRVSNpKLlmHyPRl+ICj25uQ==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr479092pjb.58.1631604926427;
        Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
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
Subject: [PATCH v3 21/76] coda: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:43 +0800
Message-Id: <20210914072938.6440-22-songmuchun@bytedance.com>
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
 fs/coda/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index d9f1bd7153df..2185328b65c7 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -43,7 +43,7 @@ static struct kmem_cache * coda_inode_cachep;
 static struct inode *coda_alloc_inode(struct super_block *sb)
 {
 	struct coda_inode_info *ei;
-	ei = kmem_cache_alloc(coda_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, coda_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	memset(&ei->c_fid, 0, sizeof(struct CodaFid));
-- 
2.11.0

