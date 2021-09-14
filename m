Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3980140A7F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbhINHlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbhINHkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:40:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AACC0613DE
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so11928492pgc.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0tJ4LzCSiQNWlTK3v6ATr4GS5677vmJWHcgwSa7aCbg=;
        b=BXZkZbQfSd1qtezLFpJh8Hmqcad9Ntv+OyGHQ29vR2Mj6M0LFVrUWDUMYfLmUU1wvO
         KWuQ8ulc8fpG60BPuOQeoPfs95CDTRkTh+aLrQjk+MJc3jkMebS8bljQ+TSSe0y6PqdK
         x5Yswt2zN3uzOZGhos42+wGlhg6FW2DHfSg6AjX62Pu5bA8sxFovzAL/LtJgUzty/t8c
         oJN96DiB54fPw0Y4g6eMyj5qWFtsAdk+gFst6u+A8uJPIwc2t1uehq+0q3jdSKrmslsy
         W1snw7T7V6i0r923NINiMMN7+ZpI04pY9bAqgW2uYmxX9FF5jt8UqgPG70r5lQss7LmJ
         D/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tJ4LzCSiQNWlTK3v6ATr4GS5677vmJWHcgwSa7aCbg=;
        b=EEKv+6dJUDksPh2HNit+QLf4+Nl0id09QhBeQgziS5BHU/elka8Ss0e8KIsGlC/aEi
         58M02rxU/t02t4zQ7w7zulzoK7XX6EREo58GfSzm4LvknS6VIgqeskrGzZdi4Nv20RTY
         k+GDYsbbmn7OvLLGWUI2mt/n7lYzBRviH3TNUTPZqSvf4+N7X5UXTUSwTDUIsuXSRc1w
         BF1TIkNssgp5RG81Tecpch1fw4PykOf/+icl6DU5qIMcs+YZuiaXuX0DNUBaryc+9Mnp
         IwGjA2ti9mmg5FQt3xmWfknfmV9TyohZTo73nL7WXKBn8xBWQcx968l5ROJ0Pi7ejg/e
         kbNg==
X-Gm-Message-State: AOAM5335tK/HKKnduVX7R6TOCJNspKuE0aLRoriG8zUodE990xu6RhQ/
        oxQ6UdDb5bNpUGZNMol7wNxrAw==
X-Google-Smtp-Source: ABdhPJxKZ/dodBMrWu+ghMW0cf3Yf3jYjylcfThuGwO/YNFccWKegglZTgb34Bk4MJukfITA4YrVew==
X-Received: by 2002:a05:6a00:a10:b0:412:448c:89c7 with SMTP id p16-20020a056a000a1000b00412448c89c7mr3397757pfh.83.1631605053581;
        Tue, 14 Sep 2021 00:37:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:32 -0700 (PDT)
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
Subject: [PATCH v3 38/76] jffs2: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:00 +0800
Message-Id: <20210914072938.6440-39-songmuchun@bytedance.com>
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
 fs/jffs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 81ca58c10b72..7ea37f49f1e1 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -39,7 +39,7 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 {
 	struct jffs2_inode_info *f;
 
-	f = kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
+	f = alloc_inode_sb(sb, jffs2_inode_cachep, GFP_KERNEL);
 	if (!f)
 		return NULL;
 	return &f->vfs_inode;
-- 
2.11.0

