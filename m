Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD42647A663
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhLTI6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhLTI6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:58:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12756C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id jw3so5271397pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSHxXbHNR9Rc8/n7evX6G7JU5+ww8i5AgHbjE2leDuw=;
        b=pkseBVxiIVLjFPQ3HkG1v4acWidTQTu648dwUZUQ1Y2jsErKfF7jNXiZV73LoUNZHZ
         FNcunv9qM9dd+sgZqZHvnTk5/tRhK8cVW343GbfaeLQssEqIuEnqGPEwYaGYM1P6SF4s
         nJLrDpS2jyGRdIuZ/HTALKBgNFs4bKZYYaX06mb8wYgZPCcnMbqcVH/RTWsofsrEs9CY
         5y6kz7y1/8e5edpv00DlG6y3CjhurUzxvNyZCBCyi02PwXPvghUhKwbwNAVKmWI/N0/C
         rg6z2fOHSkyVpjp6sSSl9laPGkwMeYwngIcTLdda/dBL68SyPk2dITkTdT0kmRiA/qQC
         P69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSHxXbHNR9Rc8/n7evX6G7JU5+ww8i5AgHbjE2leDuw=;
        b=xZD5yuUWFj7CwsTZWrs996/KTc/iDnPjNvPMPwNVIIfrnJVPg2drmBUBICPlqcm+Te
         EV7N2Lu47Id99aPHD3G15yJe2NzBzxBcEk4g44OXWdkznuLrUy/NPMbu13SrvhExdzcv
         eBfYZY5kJk5qfPNX4LJPGsuLXDJ2dh7WV5IhoYyfBpRaRrR284zqGiWdQDO9Haxxyx18
         rRIygfBpFM1MoEjW6pQAGmWYfYMe3DW02w2kRLZdXwKYvFWhBySibzRNEAz3wpSFPaIH
         D9UjYhoRzzE/bZX0v7kxv/TKsWRSPke/OZxIbULUADYi8e+9p/oYegnq7P0wPW45OPgl
         a9+A==
X-Gm-Message-State: AOAM533d9cbHKfnWCQH6C+N4JoOh7LefTWZ7ifGEVew/B0q+/f35F8iS
        some33TWo3KDS03Fs45OJDiL3Q==
X-Google-Smtp-Source: ABdhPJw258AnIObY6J9hLVJH94QtfvOW2y1dIGzgK9laqI7cjasH4nw2MKuyPCbXg99pz+xhksbuaA==
X-Received: by 2002:a17:90a:7782:: with SMTP id v2mr19160711pjk.81.1639990691615;
        Mon, 20 Dec 2021 00:58:11 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:58:11 -0800 (PST)
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
Subject: [PATCH v5 05/16] f2fs: allocate inode by using alloc_inode_sb()
Date:   Mon, 20 Dec 2021 16:56:38 +0800
Message-Id: <20211220085649.8196-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
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

