Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8985D459172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 16:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbhKVPf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 10:35:56 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:33754 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhKVPfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:35:55 -0500
Received: by mail-ed1-f51.google.com with SMTP id t5so79080229edd.0;
        Mon, 22 Nov 2021 07:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzYIrpFjBHpBF/zYBCBZI1LNzRlLubcW/OTa711WwFs=;
        b=um7NOEWY4KkO1gt2GSX+u9NNV4EDl92GrtWmn7u3xxLU/qZEOj5+nn37OKCofcFgoX
         u4FIqVKtngUrwt+/9Ru21g8KG+GI934ihia2vLVNXxtfY0YRcl81eSyEWrt29S9HEbNm
         Dr6JBch3iFdu/W7Dqg9bd2jVrNMtJc56nswbFx/qVIhabcqUekSojyCTqZaSeObszIJn
         E+6Advb3LzwD+B6ZteZKcs4bevbkj+BviEYexpII+sGDol+aPpsLRot+diCn1a4KVD/9
         1yrU5F5j3b5s8MrKgHhVFc2hTjDJFL5GOkodxOagO1uQkwFXsSzCUbVFvnvVVOKDOegB
         rNfA==
X-Gm-Message-State: AOAM530QWeqxFsYVkyUF8o5KiI7DAcjfzYDoRx4jrxZTnRqtp0WnvLDh
        ZD7tZ6ukhsxUtpi0cxqBYjU=
X-Google-Smtp-Source: ABdhPJzdKoN82zhhsiyJJx1JG38ywi+mBrmuy8XTeco3UnBKVtMBJkCdWQ8DQwOdPSfVftlXDckg1g==
X-Received: by 2002:a17:907:3f18:: with SMTP id hq24mr41593437ejc.506.1637595166854;
        Mon, 22 Nov 2021 07:32:46 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id q7sm4247757edr.9.2021.11.22.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:32:46 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 1/4] mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc
Date:   Mon, 22 Nov 2021 16:32:30 +0100
Message-Id: <20211122153233.9924-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211122153233.9924-1-mhocko@kernel.org>
References: <20211122153233.9924-1-mhocko@kernel.org>
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
index d2a00ad4e1dd..17ca7001de1f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2926,6 +2926,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	unsigned long array_size;
 	unsigned int nr_small_pages = size >> PAGE_SHIFT;
 	unsigned int page_order;
+	unsigned int flags;
+	int ret;
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
 	gfp_mask |= __GFP_NOWARN;
@@ -2967,8 +2969,24 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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
 		warn_alloc(orig_gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to map pages",
 			area->nr_pages * PAGE_SIZE);
-- 
2.30.2

