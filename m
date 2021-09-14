Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2A40A79B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbhINHgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbhINHf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:35:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFEC0617A8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so7587384plp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=23796e/EkCqGxsts7z4T27F2CElIqEnQP+HmB8HPPWM=;
        b=MS7HQl7iHYUzOUvFODQmZjoYJ4YLn/YMn1KBuXeAE2HJsvzgrUzAjKGouJbWUwM7fe
         xcLQCyRaqQ7kh33upx0tME0azMBtkyyer0bC8FTcuCgmgbh0btr2Txss3es2Te9U66Zx
         /04nyjlNDY6baWg7SFPt2EUhbDw5/cKAZ+XSb6ErGfhmfLnm0vBex0BhMrVmfMCMgurQ
         g2ht4nFNF3rZcOdh8Sr422taztMsvkAlurB4SsGBYcCgN3HwxTWMbH1i6EW2K6w5oRNs
         yTl3jldf4WiT3d4gutcEIR3UXl9ydfUc036e15wEPpwhC00zBAXgTXc5r5T84cESZh6h
         8pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23796e/EkCqGxsts7z4T27F2CElIqEnQP+HmB8HPPWM=;
        b=U7svALpV4OZuoRLtlJHfiYlAswxF71PeMzfqgJdvjD9SNVcFvWbcTcmAI1rsDZAaVx
         0fgmCOg7k0BIPIcpMtiHxiHUFB1/BfYimiC1dH+we8UbEI8qG44LeVUdWvBvEvKwkJkA
         FiMJoip8y35K1JlIN8M6MjhKTaz0n3pcbXgjGfaLIJ2Jn3T9VbwCjcl3zMbK6Vt48a1l
         Gyz1psgyrNafk9lKtXL2MTUc/Pp5U7EiJLTkouuZFdqEdc5lztZY+SEwYZtc8SiBckgf
         wSGotZlnHKfXGlES6i01i6UIkxWyuzzVP7IR7AC9vTpSa/tVFw6kZYdpA75rfAD2Rwf+
         ZsPA==
X-Gm-Message-State: AOAM530dJvOCHH7Ca9rS+fYvArgnHL0ydQSbijRpxC+tlN6H/e5bf4zT
        z9EjShF5ShQUXQ2/gkhJGt1TOg==
X-Google-Smtp-Source: ABdhPJx1OdmjbG0QVQ5po/ZxEEh1YazMixa0/wdVxV+iLUPLe1yC8JzYAiRcPVg6pyBEe4boi4Y7kg==
X-Received: by 2002:a17:90a:12:: with SMTP id 18mr561980pja.104.1631604866075;
        Tue, 14 Sep 2021 00:34:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:25 -0700 (PDT)
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
Subject: [PATCH v3 13/76] affs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:35 +0800
Message-Id: <20210914072938.6440-14-songmuchun@bytedance.com>
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
 fs/affs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index c6c2a513ec92..67458f63a1ab 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -100,7 +100,7 @@ static struct inode *affs_alloc_inode(struct super_block *sb)
 {
 	struct affs_inode_info *i;
 
-	i = kmem_cache_alloc(affs_inode_cachep, GFP_KERNEL);
+	i = alloc_inode_sb(sb, affs_inode_cachep, GFP_KERNEL);
 	if (!i)
 		return NULL;
 
-- 
2.11.0

