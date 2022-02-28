Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEDE4C6C5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiB1MZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiB1MZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:25:16 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076275C1E
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:24:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i1so10562859plr.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OoMgzdYapj8GOdfPEOkybEme/3XTyQ2VrTMps0q2PrA=;
        b=MY4WDJ8X56A+gQ/cLVJur3SrDm3EQKN4EZJt5lZ+9Cjo6Qf9bggHRbRFFzT61hhveJ
         6llCa/oKNMcsL76YUQw6b2d6O43L82wgPEiEHoU+ucBYNIVlHE3DWygEJoZi6YSvWJ67
         /wPNjrpz1ZMRw0ww9cakaygssVdi8m5NyOgvH0cttq0NVGVWMiO+8SW6Ce6TYCW9DpUz
         CCfNEsXaEm1bwlznl+crzJ8BZNp/0S/lJuMXy53yMDCRRI/6DVnvCVD+8L9n8BQ/0FsJ
         0V/AkT/2mppxZSGo9WhzogNTJG6buGPwCZ8xc4qX9CCzzQd2534lOpSgMCU3uGRGYOUO
         NpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OoMgzdYapj8GOdfPEOkybEme/3XTyQ2VrTMps0q2PrA=;
        b=MpirkYNX2NwA23Y1OhoKKkzcg412rtW63RGUCFoKqQEztEUBqz0UTzeGSMJWA369wl
         fRJhFBnBErrmpfGUJzKEHlFL4+xVyAor4TR90jxmRWOszxkMqwXctaPRk6poHGtqu4Uc
         Z5nqqbCWPVUIgnW+Pq9fljybUI5eXHx2AKk8ri32qYvmkeGU7v8m1DuQ6Lo3Ppt76CBh
         uyaQomR1l7xgXFdCslAux/rRx/qSIMweY+FcunhDCwj/YplfBdsuKXc1bMZ3ZNy9GSys
         jLv1B1VGgXzAgPMNiFNwazNeo5gpT60E+P0PFXRL/XPpD/Lt2XiM1JTqkOUIorEbt+6P
         JH3w==
X-Gm-Message-State: AOAM531Y2xAoh3I6wR/Je0G3qykL18h8AIWFLjhyOTr/1Cspol7nZ1Xe
        lrG4l8SsN3sNsTllQYrXTH1qLg==
X-Google-Smtp-Source: ABdhPJxledOS9MW9Pak+bHPtviUjpNtJQSZYmAT5JHc/iQf/jt1NmPdvAPkhddFMB/KNePUGkwRzZQ==
X-Received: by 2002:a17:90a:d511:b0:1bc:50c9:8d8a with SMTP id t17-20020a17090ad51100b001bc50c98d8amr16432585pju.112.1646051057271;
        Mon, 28 Feb 2022 04:24:17 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:24:17 -0800 (PST)
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
Subject: [PATCH v6 14/16] mm: memcontrol: fix cannot alloc the maximum memcg ID
Date:   Mon, 28 Feb 2022 20:21:24 +0800
Message-Id: <20220228122126.37293-15-songmuchun@bytedance.com>
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

The idr_alloc() does not include @max ID. So in the current implementation,
the maximum memcg ID is 65534 instead of 65535. It seems a bug. So fix this.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 809dfa4b2abc..cbe6f9bb37bb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5029,8 +5029,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		return ERR_PTR(error);
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
-				 GFP_KERNEL);
+				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
-- 
2.11.0

