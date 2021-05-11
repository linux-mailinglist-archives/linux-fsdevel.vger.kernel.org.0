Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ECD37A51F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhEKKyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhEKKx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:53:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86B9C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:52:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i190so15730369pfc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UC6OZyaIhxumzS7XDWC0Pam7E2Uxa7uVbRoAHU6H0rc=;
        b=mvEtMpGAnQS8X8pRY7QVvYJqqFPUGuS6zE62rkByxR5oNroFVjCS/xKDGbYaocAf7z
         hH2gWvCBgKxEHy1XHZd1y2KTeOizDfHXJrv50DMYgnnhFlp1AEWzArmF/Ku8n2QKSQrw
         n0UxiRXkdGjhWXGofRNp7yl60YhBicMzxGfCQgcsFthk50VTyfFnVioBZCT6AnKa8Gel
         cUU1AQbGq6zAZMkEMMfKyksQht4k9fxrkdQdtKIQhRzpWK35znHAgqk3t5Bx1RDVKacM
         nKsk4K4cj9yoezeHv+dsCU7Is+7nMQ3Nk4ADCqY+FyBsQV/QqcmlmBAcD1ZLfyqdNc3V
         UYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UC6OZyaIhxumzS7XDWC0Pam7E2Uxa7uVbRoAHU6H0rc=;
        b=qapFntU6WyhMjsFYNY2c/Qak55F/moJtvUSyEhNl4DRmE2Yn72Ielh6LMe99jU7YPb
         /WOmWeh6b5gI5lZLD4KFWoDrbb8X2SsFIAgr3O022BdzOp7b6mZzvW30loHDelYVZsKn
         faTGZ6JOJB/wemmqr7d3UNuDHaff5+BPCiJHW8Pd2HcfiZyWGQujVulZg+eFsSAdITiR
         Vj7yxto1B+DS/UGAOTyNTScvxlZmzJAHXrUZa0nMorl5JH5AcwUqtSus31PBU66/hsmg
         q6UAaa3l1iXKU5YOp5jJ4699d8TZtD3vBlLKrpZJldiGHqy8A1kD9Zt4BrM/mM759sDA
         x29w==
X-Gm-Message-State: AOAM530UkjKA6MbWQ8VFuMKVh+kJds6ROHaJmoBFr0mrSZQ9MUq0IaYI
        +ILddD5IenvuQE6hedPScdddWQ==
X-Google-Smtp-Source: ABdhPJxTL3K0RlFgs0YRY1Okx+0Y055XXZQ5WoXKr6gJFjTzXss/+4eK36NqLpJQOuB3HmVlCM+m1Q==
X-Received: by 2002:a63:aa48:: with SMTP id x8mr6373173pgo.359.1620730372289;
        Tue, 11 May 2021 03:52:52 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.52.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:52:52 -0700 (PDT)
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
Subject: [PATCH 13/17] mm: workingset: allocate list_lru on xa_node allocation
Date:   Tue, 11 May 2021 18:46:43 +0800
Message-Id: <20210511104647.604-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The workingset will add the xa_node to its list_lru, we should use
xas_set_lru() to pass which lru we want to insert.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/swap.h | 5 ++++-
 mm/workingset.c      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 144727041e78..a2418ebad13d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -322,9 +322,12 @@ void workingset_activation(struct page *page);
 
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
+extern struct list_lru shadow_nodes;
 #define mapping_set_update(xas, mapping) do {				\
-	if (!dax_mapping(mapping) && !shmem_mapping(mapping))		\
+	if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {		\
 		xas_set_update(xas, workingset_update_node);		\
+		xas_set_lru(xas, &shadow_nodes);			\
+	}								\
 } while (0)
 
 /* linux/mm/page_alloc.c */
diff --git a/mm/workingset.c b/mm/workingset.c
index b7cdeca5a76d..f6923865be47 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -426,7 +426,7 @@ void workingset_activation(struct page *page)
  * point where they would still be useful.
  */
 
-static struct list_lru shadow_nodes;
+struct list_lru shadow_nodes;
 
 void workingset_update_node(struct xa_node *node)
 {
-- 
2.11.0

