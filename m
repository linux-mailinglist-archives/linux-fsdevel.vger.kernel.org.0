Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF88473284
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbhLMQ4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 11:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbhLMQ4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:56:37 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E868C0617A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:36 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x131so15414575pfc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLFOwVFiZIjw3RVJm6qr/zBDVNSCqLZEWF5PJy3+HZY=;
        b=QAlsi5aB2S4JGjdhJQHJwLkPYLaYCxlMcWFdCpAGgILAmQ3yJtqUqPJIPu2EyFMu+L
         Sljc/YDzNa/yz/MMhF9lP+vH1SLCYpsWTEEDczhFV+NaaxMUVy0ldNCmcv8T/RQNyiXx
         LpdCzrFc1+Kham3AMOJDfOCG7HJogDdgimu/A5tMKIrFVXKAzEzj80VfEfNqe5vpdif/
         xO7IrKNq27ytbrgAFZdwArurcmql9s9JHzPnilSyBG6GbieeDQWckGyfLxTG8QMFP2di
         MD/C+X5NXqnwy2J7ELfq1nwlTDwr0wB2m6mXvWXCKXP8TWFiFzCksXVD3FTxKXTH9sLd
         wvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLFOwVFiZIjw3RVJm6qr/zBDVNSCqLZEWF5PJy3+HZY=;
        b=6rgaBSqvtE+HLLt8zTSjHNvB8BxtlAIIAz1ql92uNYGpC89rY6mHwhsUKRm2kfzZvh
         kFxTnWpyPdx/uTuAzIFYkVKjbjAQxUCB8OD4QjwZpp+z5sfO0EnHtK/RwimP8lh63+6k
         s8yWmGrqjvtMeMHmF+F0P654QE832uuMxlvxlK9m4S67xiP/ADHZ7uXYyyd2Eduo356d
         q90OOdFy+9Abd8rvY72YK+WjjZG6kUYPvWBKe//2mg8F/VJckC6yZzY249SJkqmQHPaX
         TQkqvAeA9TZJdBh7/Y/83I8tz+X4nzbPdJ7wkhzskcH696YmLPdAdZPM12IPTqIcwDgr
         MJmg==
X-Gm-Message-State: AOAM533ynq8YZL+wo5HuTcxxxJKy4UYpY3scKZN0WO5ApNdTbGFYUqqd
        mSHrZDHydS+T9z2xncnOYfB1Lg==
X-Google-Smtp-Source: ABdhPJzE4a1kZu/ivyo55Pbrq/BR4Di7/uhHuJrdlOn6j35MJ69seAxzISDcrCtQihz3i8Ci5Sb1sg==
X-Received: by 2002:a62:e309:0:b0:4a2:e288:6203 with SMTP id g9-20020a62e309000000b004a2e2886203mr34382854pfh.13.1639414595701;
        Mon, 13 Dec 2021 08:56:35 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:56:35 -0800 (PST)
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
Subject: [PATCH v4 15/17] mm: memcontrol: fix cannot alloc the maximum memcg ID
Date:   Tue, 14 Dec 2021 00:53:40 +0800
Message-Id: <20211213165342.74704-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
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
index 04f75055f518..fdd0007554a0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5013,7 +5013,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		return ERR_PTR(error);
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 MEM_CGROUP_ID_MIN, MEM_CGROUP_ID_MAX,
+				 MEM_CGROUP_ID_MIN, MEM_CGROUP_ID_MAX + 1,
 				 GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
-- 
2.11.0

