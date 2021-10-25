Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0514043998D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhJYPFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:05:55 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37884 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhJYPFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:05:54 -0400
Received: by mail-ed1-f51.google.com with SMTP id y12so807235eda.4;
        Mon, 25 Oct 2021 08:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWosBj9OWZSkL3mtoiOjTWkn1t44VoNIBaiKKWhE4fA=;
        b=2TMtV6rYzg0WaD4gTytlBBb/wBKqAcJD/9ahDE+KLd3fDMnXODFhZ439RQoPY+sL8v
         G8II7xF4SmmShAfXUPQXPiZbUeeOlS9lzOpWGfsF7574alGtdTNqeTChL7mClDX51aFZ
         rIvjp1vNxINygtkR1acwxyxO26Vz4HbLLsIHLH1wP4vMoMlyTdRizRZxpAS7du4Bh3qV
         rS1F+mt8T8Nvc67zMd1o7WeIeneuDyjmnWEKSxrKaI+ajkIcv3BhjJunyrh/hOtx7Iqd
         x7aIW7GrFYLzFlNQ7zHgj+wHr8fIXItF/jmRe74CC7I+NfwIPPb7KUzuKIHtiOt8bYey
         V+rw==
X-Gm-Message-State: AOAM531amCpfIrqLUYQ+wuUxqNys/AoDL6BqqxtkgAYQ8qxOEC2kI0BZ
        Hmv02VP0Y5ayjtM4lzjhN8A=
X-Google-Smtp-Source: ABdhPJyrqaKxrOj3aYHQIaLJBPjOPC0pTflJSf1TlN/flrqHe8ZJhLlPFUuDDm5YEqSqQrVQqs1BmQ==
X-Received: by 2002:a17:907:da3:: with SMTP id go35mr913924ejc.556.1635174158487;
        Mon, 25 Oct 2021 08:02:38 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-34-175.eurotel.cz. [85.160.34.175])
        by smtp.gmail.com with ESMTPSA id u23sm9098221edr.97.2021.10.25.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 08:02:37 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/4] mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc
Date:   Mon, 25 Oct 2021 17:02:20 +0200
Message-Id: <20211025150223.13621-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025150223.13621-1-mhocko@kernel.org>
References: <20211025150223.13621-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

vmalloc historically hasn't supported GFP_NO{FS,IO} requests because
page table allocations do not support externally provided gfp mask
and performed GFP_KERNEL like allocations.

Since few years we have scope (memalloc_no{fs,io}_{save,restore}) APIs
to enforce NOFS and NOIO constrains implicitly to all allocators within
the scope. There was a hope that those scopes would be defined on a
higher level when the reclaim recursion boundary starts/stops (e.g. when
a lock required during the memory reclaim is required etc.). It seems
that not all NOFS/NOIO users have adopted this approach and instead
they have taken a workaround approach to wrap a single [k]vmalloc
allocation by a scope API.

These workarounds do not serve the purpose of a better reclaim recursion
documentation and reduction of explicit GFP_NO{FS,IO} usege so let's
just provide them with the semantic they are asking for without a need
for workarounds.

Add support for GFP_NOFS and GFP_NOIO to vmalloc directly. All internal
allocations already comply with the given gfp_mask. The only current
exception is vmap_pages_range which maps kernel page tables. Infer the
proper scope API based on the given gfp mask.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmalloc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d77830ff604c..c6cc77d2f366 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2889,6 +2889,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	unsigned long array_size;
 	unsigned int nr_small_pages = size >> PAGE_SHIFT;
 	unsigned int page_order;
+	unsigned int flags;
+	int ret;
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
 	gfp_mask |= __GFP_NOWARN;
@@ -2930,8 +2932,24 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
-	if (vmap_pages_range(addr, addr + size, prot, area->pages,
-			page_shift) < 0) {
+	/*
+	 * page tables allocations ignore external gfp mask, enforce it
+	 * by the scope API
+	 */
+	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+		flags = memalloc_nofs_save();
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+		flags = memalloc_noio_save();
+
+	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
+			page_shift);
+
+	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+		memalloc_nofs_restore(flags);
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+		memalloc_noio_restore(flags);
+
+	if (ret < 0) {
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to map pages",
 			area->nr_pages * PAGE_SIZE);
-- 
2.30.2

