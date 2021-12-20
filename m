Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD13E47A67E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhLTI7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhLTI7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:59:47 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33250C06173F
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:59:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x1-20020a17090a2b0100b001b103e48cfaso8376075pjc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLFOwVFiZIjw3RVJm6qr/zBDVNSCqLZEWF5PJy3+HZY=;
        b=1m1uipmyXDVKXnb/j83XSckTtYI/vWJY+8BsxopX4OSiNiDP+urm0WN/C/haMxrDI+
         0MnF3qDqBtBh1Rscr+qsKFHU4osXfIYZUo/iPFn1THWNtnyyIHZdG87Fa3p6jy+pxK8h
         4UtpPN5vnDvJysuRkEfB7mf+LkGkxjzifGGjiKkkPPd5nBHVveADhXUSzP/z+lqRVYE/
         obkCs6GuNpTLTy+G81CMMg9Q5BNV/HakZKn8w/JLJaHt13hDOGu4FF4H6Z4M7bUGY0SI
         8F1orSxIT5IAhepsD91tdQpVP0m+eeAlhuPovFXskKkyHPXNA5W4ZFwZkYmDbhO4QNVE
         LC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLFOwVFiZIjw3RVJm6qr/zBDVNSCqLZEWF5PJy3+HZY=;
        b=FzuZhPMHG3j4B/+dRNuRmqN+Uf3BAfwH5VqEMr3j+hIROJIZX9IcNqKN2StHFpKKLi
         jm0CDMIlL8HIbWgVxbZt7Cbs9A43FpCGHLucRUfjvMnTOILRUwNsbKJUj9KAACptrWNn
         y8qktdsaUatxyAIMFj9yf8x9VS9oR6a++S3FLMCWAQdSDKKpjpjTh9O1zeyoC9uFwdEa
         GgilwJ7B93FPwYmDZeXZzgPU4ZgiVnx0TRwHl5Blm+eSc/KNmnsRcTJrJ8gRvBAVbMg2
         FyFbWlSqRsvGwXQeIHV00pm8UtCXbJWreWb5fHGxBYdLXgRvAdlIw2BUrC6GlZetaicP
         vtPg==
X-Gm-Message-State: AOAM5331jNRP442Xi6j5wEl7VqsfOGoKZ/PWdygB3KQDCpfZbgqIc0BA
        pfNOkARtV7Sruj456OKfTdpmag==
X-Google-Smtp-Source: ABdhPJw5ehYc9OocA6HcKwZyTrKBWh/AB+57172S/Xshm39KLQ+cdNqTHwRjWsexAMIpf2bGpEy3hA==
X-Received: by 2002:a17:902:8645:b0:142:8c0d:3f4a with SMTP id y5-20020a170902864500b001428c0d3f4amr16069379plt.3.1639990786755;
        Mon, 20 Dec 2021 00:59:46 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:59:46 -0800 (PST)
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
Subject: [PATCH v5 14/16] mm: memcontrol: fix cannot alloc the maximum memcg ID
Date:   Mon, 20 Dec 2021 16:56:47 +0800
Message-Id: <20211220085649.8196-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
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

