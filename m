Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588CD392794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhE0G2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhE0G2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:28:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF46C06134E
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h12so1818308plf.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxSxre2wDGLXpYpNahDKZAu3VAo2pfHZzOxhvD0wk18=;
        b=ZKubg9WZzxZUy30dowed69brRlvqEItapcPwLPgZswfpMdJ3cT/WDnRIkB4sOtsBvJ
         RF7PS1NNnnnkDwfJ3P+IMjR8tD0QZW8/88ZGllOgEBMnS1fbZYKJHaulTBoU99agPnhZ
         b7VcpA0nZy7pOhH05kUxqa4Rmfkw/fB2ALHIUiAxdfA17MOhOPuYft4X6x8pVDer+vG4
         ojkmOtmZTMf9QhdmT0rqC8Xtx0DA1msBALyhiqnWNwMWBSYkuIsziIMZ80EwhJkKlu6T
         mAHy106uSOoAlzLgtccHS2Nfo2XjJSHM4jMD4f+S9fyOqzocjIqw4YphBEEcJT8RrEJu
         cyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxSxre2wDGLXpYpNahDKZAu3VAo2pfHZzOxhvD0wk18=;
        b=Xu1M0VyeQzmDE+zUC+M1b4f3AZOLdC8BGZdVgj5dKhO1+87lDIjpQfDFQSCzoFG3//
         tnLnJa9W8GA/2B+WRW2MdreVS2PSHW88s7onAaT/bM39OcRNu+XjglTMTfQCMPfQyfV/
         heYL3ekS99VLvBmdsiUdcNk1ee4bUBcXI2SeF7/RLtpb44Jhq000RgONaQZ9cEo2Mp7p
         0fGQBDNGRUYOQIVFWeTaWuieN4H/LpBQdlGUxfMQUNC1NblkPAjqsG4YTDHY6hoXVBft
         lTx8Acd5EMqt/mm1DgvaMU8yPOFBnvEYW8RO9jMHVU/SxFjA+KwFmpY3lSTjXt/80+Qa
         H++A==
X-Gm-Message-State: AOAM530+CFcLOXJcDL+a068cSVD0Rp7iv94sGKplvrc7CUsk2IZVnJqY
        w7j7U8fgPpkcJUVMgTnLyrlCPw==
X-Google-Smtp-Source: ABdhPJyLAUuIAkmyYhUp7SVzVwB+y2sVQYdILO46NBcSQ91Ugrj375USQf1NBRX88v2oz8WRagoiDA==
X-Received: by 2002:a17:90a:4a89:: with SMTP id f9mr7889513pjh.50.1622096796281;
        Wed, 26 May 2021 23:26:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.26.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:35 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 19/21] mm: memcontrol: fix cannot alloc the maximum memcg ID
Date:   Thu, 27 May 2021 14:21:46 +0800
Message-Id: <20210527062148.9361-20-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The idr_alloc() does not include @max ID. So in the current implementation,
the maximum memcg ID is 65534 instead of 65535. It seems a bug. So fix this.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae3ad1001824..a1c8ec858593 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5044,7 +5044,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		return ERR_PTR(error);
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
+				 1, MEM_CGROUP_ID_MAX + 1,
 				 GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
-- 
2.11.0

