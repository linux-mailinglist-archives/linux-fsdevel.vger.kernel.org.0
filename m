Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A3E40A848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhINHpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbhINHoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:44:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08FDC061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w19so6962534pfn.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzMpd2icHKDgVZh/IHRZAX4AuKL56PFsFqQ9a9tRdLM=;
        b=CU4bfhcQLvN5AHq3ebwvRClEL0E5KxzWHts0ZIvKkNBaQrTiIrNNOlVntjRB7muYwm
         Z3uL7AgyvuoShFx68rOd+Pj1uG/EiAeLfh6d4LbnixdAr//2M3cRXNvGvH3OL4tUWFnN
         m0n46F6LAsYd675kx2lQFhuECvqIW1otJNRsfkPcYDaXCcvNKHyQ88x5Xmu9UjHrW+CN
         5hxVUEg7E7+iQjjOrrmPpNtjPY/+Hg3vutmVZOMLFT39MwSP+TwZd24vYzo9+OIXHH1w
         KsbDFFT7SQVaHX08av/hPnnHGdB2RJJPysf/Pqf/CUAUx/F6q8XP0ft5TlIn3sB/HsDN
         kmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzMpd2icHKDgVZh/IHRZAX4AuKL56PFsFqQ9a9tRdLM=;
        b=xmzi+u0Odrug9lt/LypfdoODLuyLwIbt+VnW708d+gWT3A8psTSTQTddfkBDV/4JFY
         0yzqGx0wbOT1U6IuWVrUHdigrZ11jAiIKXgxR6FsNrSemk2gb7/qLF+O+N+1rD/iMLlR
         sO+AxkKoVgRxQSsNeGzc/G2wrDhQrKK2wnbnjgqHUl2oXrabuPspptBsvfi3naV67TJI
         vh5EqticqccX6Zyvx0DQJf78buYeyz+f7sXg5eHhJv9hWiOlEnJe4JplWfJqbKCazo3P
         4edDXM17S0d728ek3TtYe5WrMEn07UHcr2nuzskkhmuW3l6ZBZuOXyeEm5mfI4p/fxKq
         5YUw==
X-Gm-Message-State: AOAM533hC09+gAE1Oc4+oln3ZH1tOz9xJKmw3Qfsg2i704Q+rnkGRByi
        RTPnX8s+Z0biLDGDFP/+HbcTVg==
X-Google-Smtp-Source: ABdhPJyMNoiU0Jst3lZMbRSWOcK0XGszzmqSKadnFf8sWdj6xUiFiP28gaSKoLEjwgjodGoOC0DppA==
X-Received: by 2002:a62:64d3:0:b0:43d:ba3:1e2c with SMTP id y202-20020a6264d3000000b0043d0ba31e2cmr3457416pfb.5.1631605230405;
        Tue, 14 Sep 2021 00:40:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:30 -0700 (PDT)
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
Subject: [PATCH v3 63/76] net: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:25 +0800
Message-Id: <20210914072938.6440-64-songmuchun@bytedance.com>
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
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 7f64a6eccf63..cee567ccd99c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -300,7 +300,7 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 {
 	struct socket_alloc *ei;
 
-	ei = kmem_cache_alloc(sock_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	init_waitqueue_head(&ei->socket.wq.wait);
-- 
2.11.0

