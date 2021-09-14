Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E833D40A7C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbhINHid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbhINHiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:38:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B79C0613B8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w19so6950907pfn.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQ5/G4W/vpgRy8GesLP2bdOIlsZoFdBH5AJaA8cLR/Y=;
        b=FarpNNTHbqImJsUbmxvWFBcLoHkl6BQ5MmiEIzrpgL9pKZtHDMT/WVn7YqLTChckTQ
         Vb8mkkzxsiy5d984PcX6Y2tr+T935aXAw6/2kOpwngXBmppzWAh4woYUdrs6pLSbX+uf
         5hmRpYQQOKXSOdQxVx7V+uYhC9vy6Qsl0ItU2KVF8SgisNPegYwAwxNKe1iu2XhKqi/u
         k6bRj20yfz6bsax0wNnkn30hXSOzmwtCT7Ngn+siAc41Smq0h83aaIGKAlvqV5ClQ52Z
         Cmg7DrTJkg4LiQDdE8uSNXwck3v/ZvhBmAJdb+6UQp5nl9CC3iGNHX6DskJznrt4+5oW
         of/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQ5/G4W/vpgRy8GesLP2bdOIlsZoFdBH5AJaA8cLR/Y=;
        b=EMsD/L3ggRj+7uqwX41hcbdzYgwsCxtCw7Bfa84p1wrXnBVicxjGDhSBfB57yVNrHv
         Xj8SM0joW9t2bMXS/ECH74m+ccFVvwhx4pxlN/OoFDJGnBdhdVJapRiC3guOApw2UNsc
         xozoMm2iDAPXJQGUuTr8yBk07pXw6bUnR1iJX9kevpLBQRh+SSPoczBq+AyGoTkrRwRR
         khgwdxqXjY6lpz+0XCtjgCsWklLAjVro60dJ9u3T/kMsM7oquFSGa0YottNqMPV2oVqH
         1Nkif+QQUPi3BcCMCaWdWE6CfIbIaj8wuJ7OjnPG7r++YfpIK80carputs1fTpxAfDGu
         tu4w==
X-Gm-Message-State: AOAM532O7JKtLrgAxi/sL5m7eQ0inukNkXyA2NOd0IOkfrlzhIACLwgO
        tXIh+Bdm2gtRgrpNk18FSYKKkg==
X-Google-Smtp-Source: ABdhPJztT6eT0YF+2K2i8AUHFeeTV5oxPFhuvtG9eResvbJYAu+ZabBJCKiHNMZu23im7o95eJDAOg==
X-Received: by 2002:a62:b414:0:b029:32e:3ef0:7735 with SMTP id h20-20020a62b4140000b029032e3ef07735mr3406553pfn.61.1631604946790;
        Tue, 14 Sep 2021 00:35:46 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:46 -0700 (PDT)
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
Subject: [PATCH v3 24/76] erofs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:46 +0800
Message-Id: <20210914072938.6440-25-songmuchun@bytedance.com>
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
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 2dc0b9f1d421..1bf7f8c6cfab 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -83,7 +83,7 @@ static void erofs_inode_init_once(void *ptr)
 static struct inode *erofs_alloc_inode(struct super_block *sb)
 {
 	struct erofs_inode *vi =
-		kmem_cache_alloc(erofs_inode_cachep, GFP_KERNEL);
+		alloc_inode_sb(sb, erofs_inode_cachep, GFP_KERNEL);
 
 	if (!vi)
 		return NULL;
-- 
2.11.0

