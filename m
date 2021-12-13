Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554EB47325D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 17:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbhLMQzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 11:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbhLMQzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:55:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2FC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q17so11569191plr.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSHxXbHNR9Rc8/n7evX6G7JU5+ww8i5AgHbjE2leDuw=;
        b=SsrHD5a1YsNTkjQwGO70IwZYiI4z58X6Hh/W2mu4MFq4zTmi4R4OXLqm+5jewpLxw+
         FD27XY6/bikucaLfWhzCv7TsOJV1Mpknj/4t97YnkULfwfpzaRK4GRNDbLqW5VkQqxyZ
         Uq87A1K481iBo1gNI01EscGkh+Nyae29ry1u8e+WLzkoKFMSpfhV9h5KdfD+8Ej+m6mu
         DrV/IH2FKev4pzOqAubtakVqnzZPV2Y99knOAvdAlzTNACCg26VzzDQL4bEZcGnNVNEI
         xJ6CDwNou3qzGb8duVUjTjVQyX5EewANLm9Fx/Yc8ldIJ/6lIgD5hJaQARdv970HoPHP
         uroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSHxXbHNR9Rc8/n7evX6G7JU5+ww8i5AgHbjE2leDuw=;
        b=fUZWtdJo3zzbb0TxPbswh27cKMSbJkJCGx5uvtjPJfZzhWII3Yhx1hkHlHdq9B0FTW
         nIg5Urf2LprAyDwwXK4q3Q3Ngm9/KXjdd2jbUJem4KjxZ9zLtvg1+m+c25o/n8j+9zfX
         uoD6yCK5RIPF4N8udjtWI/BBbIWDGkRTZ9mn4eoGW6CGoxHg0rjadEG8DqZ3ZlBV71sf
         cuF4XmNevJ28w4vDL1VVvkQrHY0pgG5sKfGLmUUvHTPlhL14VjQLSjPeac11RU3dk5RL
         k839TBgsSETtTCpmnZOa22PMInSP4cNahNvgkgHOZuGzRAKadAPWwOMiIWAtCvLMWlDK
         FyyA==
X-Gm-Message-State: AOAM530lklR5VWsEtRnE2HKOIKbndPnPf+iS0Z4GSm2BHDVXBj+E8fFi
        Mp86tKoPjafPQX7mZ5Yd91brRQ==
X-Google-Smtp-Source: ABdhPJzcDMOwfoOmcXqJmG6ge1qJlkO2yMdNNMF52Tgn4l50T6H6DBr21EDmpP5VcwYgAI2vge0pyg==
X-Received: by 2002:a17:902:c204:b0:142:2441:aa26 with SMTP id 4-20020a170902c20400b001422441aa26mr97348954pll.84.1639414501276;
        Mon, 13 Dec 2021 08:55:01 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.54.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:55:01 -0800 (PST)
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
Subject: [PATCH v4 05/17] f2fs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Dec 2021 00:53:30 +0800
Message-Id: <20211213165342.74704-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/f2fs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 040b6d02e1d8..6cdbf520b435 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1311,8 +1311,12 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
 
-	fi = f2fs_kmem_cache_alloc(f2fs_inode_cachep,
-				GFP_F2FS_ZERO, false, F2FS_SB(sb));
+	if (time_to_inject(F2FS_SB(sb), FAULT_SLAB_ALLOC)) {
+		f2fs_show_injection_info(F2FS_SB(sb), FAULT_SLAB_ALLOC);
+		return NULL;
+	}
+
+	fi = alloc_inode_sb(sb, f2fs_inode_cachep, GFP_F2FS_ZERO);
 	if (!fi)
 		return NULL;
 
-- 
2.11.0

