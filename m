Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9CB40A83C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhINHo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhINHoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:44:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69462C0613DF
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1443569pjh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0gIedj0uRl6kYfJTbilxSjgpDw4b49jX6h+L9evK1A=;
        b=YcE8Qvsw9Jign0OLffDdLQTSWfd4ueUGxnw3H7nKu0CGfRee7lRQE1hCIMnRUNNGl3
         s6T/wrouUpAFKefJnDIlgErM20da5IuO32Z6soWIBPuJH+KrYllfrXv77Hifc6KQsJYX
         lI5aL2gWB3BEAmHwPzI8L+nfa1ZfuyeIcZh1DGf0t40599ced9gd8Jjem1KoPZCEbdGf
         rqEuzeCYG8DKB+s6XPGaeonTE7Mq5sWDhAPE4UXQaaCbThMCoCsqnX+E44V9nM/+P5aP
         z8YPeJUSJrEqb2cpL2Iy7xBK4GKdBhVRBZxUi2LJIlSmLwwjclUWxitsjeZVA/h/EQEH
         dgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0gIedj0uRl6kYfJTbilxSjgpDw4b49jX6h+L9evK1A=;
        b=JzFWS2/geaEE4h/ypL+r+wBEFj1ieLbVp/PQErfRjFAhzg2ZqgpTHImL755dCNDiOY
         eDj97wKY9xLsbDrO5PcXzGwYcSlCsS4iB2Zg3EaTmAjMni+XGbJ/iQQBYmV9RYGlyrbn
         3qFDf/ERbmgfUxDUhGmpMHOcYgzAnB/pyTH8x+ogN28jP/a1IlJ3MxugWVtHhsb7nEHS
         h6aeS8KW6ejEaH9vsMaC/Q2wU1LaCHomiESdgLFEweOtR3uLJGxoKPXvN01DeOgWiQ4x
         mNPBhpTsgUvWQEIy3LKXwVp1fIuQdFAdmMr1FxjEsRJTWMYL4ODDwBp8aP/QZK68M3Ce
         SZbA==
X-Gm-Message-State: AOAM532njitxJMxhipP5IGOjHnPiMS9Q7k4gBDDDmVmtM9HXrYEo7Yro
        BR9ZbpO9Yb2lRrkiHvXpCl5i4g==
X-Google-Smtp-Source: ABdhPJw9Xl/WZILl4Ds/Wqr3ng0djaEheCa6a46UTkodL4KpqRYh6SkR3hIq5nfVq1N2z4iUi4tdhw==
X-Received: by 2002:a17:90a:4ce3:: with SMTP id k90mr532351pjh.237.1631605193043;
        Tue, 14 Sep 2021 00:39:53 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:52 -0700 (PDT)
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
Subject: [PATCH v3 58/76] vboxsf: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:20 +0800
Message-Id: <20210914072938.6440-59-songmuchun@bytedance.com>
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
 fs/vboxsf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 4f5e59f06284..050ef855158b 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -244,7 +244,7 @@ static struct inode *vboxsf_alloc_inode(struct super_block *sb)
 {
 	struct vboxsf_inode *sf_i;
 
-	sf_i = kmem_cache_alloc(vboxsf_inode_cachep, GFP_NOFS);
+	sf_i = alloc_inode_sb(sb, vboxsf_inode_cachep, GFP_NOFS);
 	if (!sf_i)
 		return NULL;
 
-- 
2.11.0

