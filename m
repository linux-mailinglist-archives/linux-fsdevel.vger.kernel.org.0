Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA64640A80E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbhINHmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbhINHl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:41:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C0C0617AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q68so11922603pga.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ve9NmyEqViIV//dT1LdQKGfIMDinAsMmZ30wI0oWs1c=;
        b=EK1/Er6hRnVX2fZvCHsw8jkFa2Ov0/UEkz1sfPKz4MtyYRIdqAmwWsSyxtzaII34Nz
         9e83C/WbK0FuFRdNf91dfjq7dgGwtSNhk8uyhUMCzUu80LykfTTolGOAZVBRRERE/kYI
         3rYNpkJXSsaVMbdOfjreRbbNjkfn+/koajYsJ9jNXdQZ4O33b/pzTWEC3+bG+sjaJ7SX
         VWDLjdaBoB9i2RiWWJdxJdwSucyjxxkAx2LLpJhF7/Zq9fyIE2WQI5evsxwxJfVZegsK
         89iWFS2Mf9N0+v5ulDPu020wnvrnVNS5QcIsoELSBgldNohXdvu4JkCxEdF+FV7U8lTF
         Q5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ve9NmyEqViIV//dT1LdQKGfIMDinAsMmZ30wI0oWs1c=;
        b=Ew8lA3FPnFGlMAUrK65AXFENq4IKscibwQ8u5qaKtD5hd2IND1dkbSLeFVDeO5VHhx
         pI9oKk46dI0Qu+v+7VgbuhZqKvDVGx7jWYJjG1hEVTy1lK9EFWUhv0gsDIOxvTemmuMU
         onO+QiY5RexK5AJZJFZR1QDdCa/Y2+efBa3RB/p+uTsJHHkJuo0EyAOabRL2bLooVV9x
         7n6GWHtzwXipocUSr/2tYs6/D/LVsZCJetBddohFLrqGyCDHcmkaidPlT9TTHexUgd3o
         WuevBDLA/TnzKunKVC4dOgrorS+LJUt26hTltbCUJk/iRG3BZNAJxnavx1BCzbkP9BPt
         szcg==
X-Gm-Message-State: AOAM533ZwWLOj91gCwlhpU+n6sK8FSzN1BPxmOXlIRYZcmmKeDeXPeLf
        ytFP6g00QwRbi7IBaasm9nUWMA==
X-Google-Smtp-Source: ABdhPJzeNhtU+sPaFsnWmu7S41gs1Nsar9HXfmTanwRyM0Ad3KnBzwvJjy1sI44y8s95uozfMgdnWw==
X-Received: by 2002:a63:da49:: with SMTP id l9mr14258029pgj.277.1631605080003;
        Tue, 14 Sep 2021 00:38:00 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:59 -0700 (PDT)
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
Subject: [PATCH v3 42/76] nilfs2: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:04 +0800
Message-Id: <20210914072938.6440-43-songmuchun@bytedance.com>
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
 fs/nilfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index f6b2d280aab5..cf1de3ed9f8b 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -151,7 +151,7 @@ struct inode *nilfs_alloc_inode(struct super_block *sb)
 {
 	struct nilfs_inode_info *ii;
 
-	ii = kmem_cache_alloc(nilfs_inode_cachep, GFP_NOFS);
+	ii = alloc_inode_sb(sb, nilfs_inode_cachep, GFP_NOFS);
 	if (!ii)
 		return NULL;
 	ii->i_bh = NULL;
-- 
2.11.0

