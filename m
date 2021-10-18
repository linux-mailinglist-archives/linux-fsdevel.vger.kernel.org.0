Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E244317E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhJRLtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 07:49:45 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39690 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhJRLtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:49:40 -0400
Received: by mail-ed1-f45.google.com with SMTP id ec8so70141558edb.6;
        Mon, 18 Oct 2021 04:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0T7gxYUX1IZe+6zZc2VL/ygWEQ9BUReTwyQ18vECfw=;
        b=AUplAMrkfyHwatqqx4jbQXuA/2mvs5Q31jn38/g5g4ErdLNa7Uf5+DimQNL5BTUYWt
         dYqm6GdPrasQ8BwlKi5fjx3URed5zUWj0bYkzcGQ+c7lFAtF8oy39TV0F5WDbnN33faz
         Zw10mnJBi+fC/SPFo2/eKYQMZ+2M5EX32JVQRpMUyCSHIbZJ4gNyCj+cY+ml0MEeBrTU
         6VUfH1HGgohfkVh1U4W/Ohinjv+kAJD4kBPi75OeGTZqU591C3YeW1q0aaFzRrZX6ZTU
         zHYxo39ZeUm02DbeiK9m3AccDdu7eWv3WP9bLSJ4t7/rX4eSLqEGceXZV/Q1By1pkq5w
         W4LA==
X-Gm-Message-State: AOAM532YJLeZTzs0aohfQJhIg9/IfeJisM31kjVBwNEVqLKcsWXETvxS
        teLj1zHVSXhJpXz2y66joeI=
X-Google-Smtp-Source: ABdhPJzA3Yw8UY1rj4xrYibdkMXEXhftxv4Gy8AnglURF2yg0TH0pLfxdQCB3cT2eLr75LPxwjK2Xg==
X-Received: by 2002:a17:906:7017:: with SMTP id n23mr29088204ejj.446.1634557647343;
        Mon, 18 Oct 2021 04:47:27 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-35-99.eurotel.cz. [85.160.35.99])
        by smtp.gmail.com with ESMTPSA id b2sm9587458edv.73.2021.10.18.04.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 04:47:26 -0700 (PDT)
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
Subject: [RFC 1/3] mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc
Date:   Mon, 18 Oct 2021 13:47:10 +0200
Message-Id: <20211018114712.9802-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018114712.9802-1-mhocko@kernel.org>
References: <20211018114712.9802-1-mhocko@kernel.org>
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
index d77830ff604c..7455c89598d3 100644
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
+	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
+		flags = memalloc_noio_save();
+
+	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
+			page_shift);
+
+	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+		memalloc_nofs_restore(flags);
+	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
+		memalloc_noio_restore(flags);
+
+	if (ret < 0) {
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to map pages",
 			area->nr_pages * PAGE_SIZE);
-- 
2.30.2

