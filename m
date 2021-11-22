Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE5459173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbhKVPf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 10:35:57 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40494 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbhKVPf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:35:56 -0500
Received: by mail-ed1-f49.google.com with SMTP id r25so41802247edq.7;
        Mon, 22 Nov 2021 07:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhNo8C5VhREj9v7bG8TFdKTfEqQRTCL9W5KEynh9aDo=;
        b=5mQ37z8RMQphNw3gIOtpMj2qal0xadFkc9084NDuweiuHRp60tNyINAiHD6QIruEXI
         LNiGBlFXAm0wdVCwv7y9s3jSK06tfSRrdivm0Nsq+JUMXR8SakDnwuddSaHZiu06TxzK
         FIAv7DBEyQqzDyIkClFj06ORSELLQnZjRiQh0G/TAovgsx5n4Js9vVic2UZ2W6Kge0IC
         OkzKisZqOQ2EGzJS3Hcx2mqi0RlTzV/1Bo2wHroyaKkbGH9ABDqTJ4LlKzPL7RU/ZNL7
         Jp37in86+Knr25xs4pOszKOC7+AMTTDi4Vo558c7ej0HLJ3lRdq1MaECyxKpYTCMwTtM
         4b4A==
X-Gm-Message-State: AOAM530dwmllJ/9Ip1cr79yFF8HUr/ubB6Uz2f4IkCb7i/jai0DjJLkg
        yBab2LYmBfBXHQIbt29NWVU=
X-Google-Smtp-Source: ABdhPJxBFqIXl30IalHLlxGPJUoekpcMvT3WF//HONPA1J1pzrEdOxtNc1nx/4+x08fBLVojY8iYjg==
X-Received: by 2002:a17:907:9802:: with SMTP id ji2mr39237198ejc.352.1637595168343;
        Mon, 22 Nov 2021 07:32:48 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id q7sm4247757edr.9.2021.11.22.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:32:47 -0800 (PST)
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
Subject: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Date:   Mon, 22 Nov 2021 16:32:31 +0100
Message-Id: <20211122153233.9924-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211122153233.9924-1-mhocko@kernel.org>
References: <20211122153233.9924-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Dave Chinner has mentioned that some of the xfs code would benefit from
kvmalloc support for __GFP_NOFAIL because they have allocations that
cannot fail and they do not fit into a single page.

The large part of the vmalloc implementation already complies with the
given gfp flags so there is no work for those to be done. The area
and page table allocations are an exception to that. Implement a retry
loop for those.

Add a short sleep before retrying. 1 jiffy is a completely random
timeout. Ideally the retry would wait for an explicit event - e.g.
a change to the vmalloc space change if the failure was caused by
the space fragmentation or depletion. But there are multiple different
reasons to retry and this could become much more complex. Keep the retry
simple for now and just sleep to prevent from hogging CPUs.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmalloc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 17ca7001de1f..b6aed4f94a85 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2844,6 +2844,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * more permissive.
 	 */
 	if (!order) {
+		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
+
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
 
@@ -2861,12 +2863,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * but mempolcy want to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
-				nr = alloc_pages_bulk_array_mempolicy(gfp,
+				nr = alloc_pages_bulk_array_mempolicy(bulk_gfp,
 							nr_pages_request,
 							pages + nr_allocated);
 
 			else
-				nr = alloc_pages_bulk_array_node(gfp, nid,
+				nr = alloc_pages_bulk_array_node(bulk_gfp, nid,
 							nr_pages_request,
 							pages + nr_allocated);
 
@@ -2921,6 +2923,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 {
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
 	const gfp_t orig_gfp_mask = gfp_mask;
+	bool nofail = gfp_mask & __GFP_NOFAIL;
 	unsigned long addr = (unsigned long)area->addr;
 	unsigned long size = get_vm_area_size(area);
 	unsigned long array_size;
@@ -2978,8 +2981,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
 		flags = memalloc_noio_save();
 
-	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
+	do {
+		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift);
+		if (nofail && (ret < 0))
+			schedule_timeout_uninterruptible(1);
+	} while (nofail && (ret < 0));
 
 	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
 		memalloc_nofs_restore(flags);
@@ -3074,9 +3081,14 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 				  VM_UNINITIALIZED | vm_flags, start, end, node,
 				  gfp_mask, caller);
 	if (!area) {
+		bool nofail = gfp_mask & __GFP_NOFAIL;
 		warn_alloc(gfp_mask, NULL,
-			"vmalloc error: size %lu, vm_struct allocation failed",
-			real_size);
+			"vmalloc error: size %lu, vm_struct allocation failed%s",
+			real_size, (nofail) ? ". Retrying." : "");
+		if (nofail) {
+			schedule_timeout_uninterruptible(1);
+			goto again;
+		}
 		goto fail;
 	}
 
-- 
2.30.2

