Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD744C6C2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiB1MX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiB1MXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:23:39 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F574DD8
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:22:58 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c1so11204653pgk.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RQGHmSpLUsBWZUQYPpcdOjVs87EIcOAL9fVyXOtIRQ=;
        b=8OKYvg3uY+0MhQo9Sqp4PHlfDHE8n5JHFkh0d4IPnyiTC0hPfVIt2xxcAbqCQqdjsw
         92pF22xqGKb/Zrti0Hx41FWRNgFKxWIH8k7lmpuJTDWGL2jtVtg0hG5Bo1e26N00+Pdi
         Oqc524Bk6FBDUhr6GhV9xxi5TqJ13Igp/dPXx2cSS1lREZebqOGdvplA9VRbeohCo44V
         YUS5ig1qtXpGqzkxqWdrFWV0UhIkmcderji7aXysd68MOjjHiT4F/keQdesOWTeHVtRY
         HAO9FL0jJcoSvj/VubwpRqOyoeA/VkFZ3Ltb6A6wxOW19eajDaa8a3cedjQw620HUJ/i
         hbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RQGHmSpLUsBWZUQYPpcdOjVs87EIcOAL9fVyXOtIRQ=;
        b=kp3oqPIVhDiT5M4Gsal+4M5sMcKeW104xD7T9ikBtGXt9JGh2bGVyVqn5c7B2j9m3F
         slJ5snMVPXNXHYc3SpAuGTc8PQNM2wQh5cYdBPP+Ovdpnfhoa61Hzdxj3zJRKtF68frt
         bhWEvg5X5T2B8Z6DORNWt6v1KpR9+cXXcftQqNNmJiTc73hjP8F3hfXn9DPgfn6ZBoPw
         +eCUp4ihkXhj60YTuJIGMOgUN+/oWF4IDNVZr53prMZ/e5Ib3QdnnK5a0PuBkB8m4dsB
         vfWMeaPa4eQCGpAaB/ph+/YK7m2Vu1VoV5vB3flXCQLACycRuYW/bCx+gkhRtLr1I230
         ph2A==
X-Gm-Message-State: AOAM530Z7KH7kze6HCC0irJrOY0Y5m9x5c+LYybCQ7JbRGMreBqgsveD
        SHQHeAFU7xdckF2lFBMfp3M61w==
X-Google-Smtp-Source: ABdhPJzgAE0yHpfYS+vzCxbO7K/OSkp2rCJIamxAE5RBODPYQ4mTFqO8oVK9gFGTCNJgkd0+YSRxHA==
X-Received: by 2002:a05:6a00:278d:b0:4e1:4534:8801 with SMTP id bd13-20020a056a00278d00b004e145348801mr21153306pfb.78.1646050978317;
        Mon, 28 Feb 2022 04:22:58 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:22:58 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 05/16] f2fs: allocate inode by using alloc_inode_sb()
Date:   Mon, 28 Feb 2022 20:21:15 +0800
Message-Id: <20220228122126.37293-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 fs/f2fs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index baefd398ec1a..9cc753a3944d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1345,8 +1345,12 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
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

