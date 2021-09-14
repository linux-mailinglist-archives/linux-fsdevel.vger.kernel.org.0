Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD62D40A837
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhINHox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhINHnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:43:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D004BC06127E
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so8240313pjv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qZ3HM2fEOM8GlV59xjjOZKTYma6jyboi290AZRWTfs=;
        b=swLJ8MDrNcfBrHijdBeesk26tLZ9evHXGmrABe6JiHEC2dMct3uDEfFsFS9KVcnBfn
         QfZXodJK0a5ZnQosZhJSuYIa3Lix2y4kJLdl7v/hSBX8B/rX1/SFC3xmojH6F862U65c
         c/fKb/ZpcKlQF45RcJE0hU5BkVN7y5JsmZWIPIASs8Gzs5vsNcXERPhQQF7jDqnbwmOK
         9RjIsdvCbquMfvCvBbDuv5t+PsiqIk96BR55T0j9az5qtbRmIgHkImWRhZGNiGMb/7gf
         QMtsKp2pCZFNHPvohSX7niH6czQnhkjJgkH1/cGaJrNrfnpsiUBWm1BhFml/DIXEmWzy
         HV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qZ3HM2fEOM8GlV59xjjOZKTYma6jyboi290AZRWTfs=;
        b=4CCVYPJFgJOUkak8t0PiS8b3bDiDkj7lZj7L/rzJ+7eSlDdfuuKUG8VpzSnVwVFL4J
         OfKuOHWovCxROpkB+6jF8h0YMchkLahs74DJ+0gDAtjuzDqb8uDuQRvMzIudnu03nd+j
         nf0TECRGhJEmVd0IqY0COFjE9ePSZ0FhcIhacUWbLhCQ6cVfBu0njRZsDZgkGbHEqo6f
         ESdGEBD2Qb2lAiBOuhVsCVhk/sVROFRGC8GCoaN2XueS0l/VGqytkkc6QvPHV5+zdLo9
         ChHOhytO06VHyEFbwHiT57eLn4m6UsX+N37ag+rfuv05JcdxlPgJ1DjbSFp8daMSSGTh
         Hn+A==
X-Gm-Message-State: AOAM533Ow4QnV2sDpYYazCxuItDThm27SK7NtzKT0raBCxIlkbZQ+CV/
        oc2lMrWMQ20t/L1geeNmvPHOqg==
X-Google-Smtp-Source: ABdhPJyRnErQLsEhV2dixHxzYm9s/YemudAKqKC5KpMkxbE/v//U1xszVbuChuCQxD6ng/Fi/7efIQ==
X-Received: by 2002:a17:90b:250e:: with SMTP id ns14mr586106pjb.84.1631605179398;
        Tue, 14 Sep 2021 00:39:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:39 -0700 (PDT)
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
Subject: [PATCH v3 56/76] udf: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:18 +0800
Message-Id: <20210914072938.6440-57-songmuchun@bytedance.com>
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
 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index b2d7c57d0688..76b706584632 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -135,7 +135,7 @@ static struct kmem_cache *udf_inode_cachep;
 static struct inode *udf_alloc_inode(struct super_block *sb)
 {
 	struct udf_inode_info *ei;
-	ei = kmem_cache_alloc(udf_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, udf_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 
-- 
2.11.0

