Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8026B40A815
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhINHmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241811AbhINHm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:42:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB73EC0613AA
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g14so11357631pfm.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aplee84Zb9DYoAB52arCh7gLLArJ+QtTZ9BkGVcgL3k=;
        b=j/KITuWPMbeYdulQFVpeP/6fD0wVWiV4+zVQkMSI3HkkPRSP+6UzBOZTn/DmoIwtuB
         uVkKwiZKIEvgt2hIWH1jffF8/MDudPq8wolnKMz+MPQW0Twzt4nEZ7yNGYbN23SULu+P
         kfm0rJ+lud7zRbJDyVRoUiIeT2U25ECHdNNVR8FifNLG0U88xJb02YWMMw+1VWBYJv0X
         IrpPE96zahuNqa3wxty4Lm1YBWwFzyH7pdLBphKs2gahsTWQs/tFHqlnHsEGoZ1nT3aG
         XFxOFpWgHJXxA3Pfacjy+4fOQEI4QvRB9AzxhRJe6KTgEZ8TRBD4l+yG8TuH5pYtMuJ6
         4Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aplee84Zb9DYoAB52arCh7gLLArJ+QtTZ9BkGVcgL3k=;
        b=klbBZ6tkDmN6unLDJC4b/UTZdGVjP6I/4QxxyoEGaO8eL8p7QgfxmcdQQn2tYbtM0G
         EFj1vbmZjkqVt+He+mITWv8PY01wqeTOz5H5WmsVhEhwVTvJ9Gk5COOK3IlHPeMJr0ha
         mVjcXfURrBAaYswtQmiGniTgEprLvrPzlFlBtQBSVDUekCbNegNOKQKhVUwWuiVQHwEs
         muxGg4O95qZPOdWC5qZbBU9bATlCZY/Vdi5fe70gng1Q4SsYwlx47uD+UbDlNoT9zdIv
         c01AHdcIyO1hOlzgiPWxAIXpvqDrWQcCUnMFoXGJt47cv+xUpHmgO6/HOlugMBnog34E
         ehRQ==
X-Gm-Message-State: AOAM533OjLhRhyK2ZajPiKUU+r8F5O/xb282fT98PFGIcmak5s5/2dDU
        wi3iS6BPxahiHJ5hpGWkd/DxcA==
X-Google-Smtp-Source: ABdhPJykIrXy8sqRbqD6MNKLcstRJMKicys4LzbaDZQB+C6WEgf2Ke4IbCOJzMR4/p4v17199zqJ6w==
X-Received: by 2002:a05:6a00:1147:b029:3e0:8c37:938e with SMTP id b7-20020a056a001147b02903e08c37938emr3328209pfm.65.1631605125499;
        Tue, 14 Sep 2021 00:38:45 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:45 -0700 (PDT)
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
Subject: [PATCH v3 48/76] proc: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:10 +0800
Message-Id: <20210914072938.6440-49-songmuchun@bytedance.com>
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
 fs/proc/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 599eb724ff2d..cc0a406d3a19 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -66,7 +66,7 @@ static struct inode *proc_alloc_inode(struct super_block *sb)
 {
 	struct proc_inode *ei;
 
-	ei = kmem_cache_alloc(proc_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, proc_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	ei->pid = NULL;
-- 
2.11.0

