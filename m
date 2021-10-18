Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5494317E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhJRLtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 07:49:52 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44919 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhJRLtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:49:45 -0400
Received: by mail-ed1-f43.google.com with SMTP id w14so69741712edv.11;
        Mon, 18 Oct 2021 04:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4L8lFLAdXhWJMY8TqNwD1OY6QC5E8vHIjyqLADqFDA4=;
        b=47A5OPoc8SPxbGLytX4WskpX1QWqQxD6GtdhwZZtd3crC2CLsUsgtxfC5L4E6AF91x
         omuOLyX+z8ijIfd6Rh9tvB7cyceolHA7L2lJSbhqF8KUKFEmV4RMTZZjY7MhYjDZISZm
         gRrxVmZuM4yffDTBypM0wpGF6ahNN0Nh3LIaYgC01tWkSHl0UgzsCj36s72w+Gt+1EtA
         o74Lo+nkuxvXwl2rB7/8Wcnf4ewMftYUekOb72lyZx90IkytpuT7IdWAYtueCBr6H8ed
         ASHqjzWVuWXLwDmLAF0/X4Gc1BY45OfCG+3obKKFboqgjQJAPPgpjhclPvjDyvcSXBAh
         NMAA==
X-Gm-Message-State: AOAM5315IFF7rwDgVMOUu1Lh4jKK9NhIZucwYI5jGvbDapFR6uzzlL+7
        AxOKspeWIH0DmKj2Yppaojs=
X-Google-Smtp-Source: ABdhPJyBgibGZUkyEokdtRYfvSvKNqevOAdvgE5oWJNGtKyZ5EwnZkfw2zWnIDru9DVVWBa+3kOs3g==
X-Received: by 2002:a17:906:3510:: with SMTP id r16mr30003410eja.209.1634557648625;
        Mon, 18 Oct 2021 04:47:28 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-35-99.eurotel.cz. [85.160.35.99])
        by smtp.gmail.com with ESMTPSA id b2sm9587458edv.73.2021.10.18.04.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 04:47:28 -0700 (PDT)
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
Subject: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Date:   Mon, 18 Oct 2021 13:47:11 +0200
Message-Id: <20211018114712.9802-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018114712.9802-1-mhocko@kernel.org>
References: <20211018114712.9802-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Dave Chinner has mentioned that some of the xfs code would benefit from
kvmalloc support for __GFP_NOFAIL because they have allocations that
cannot fail and they do not fit into a single page.

The larg part of the vmalloc implementation already complies with the
given gfp flags so there is no work for those to be done. The area
and page table allocations are an exception to that. Implement a retry
loop for those.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmalloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7455c89598d3..3a5a178295d1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2941,8 +2941,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
 		flags = memalloc_noio_save();
 
-	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
+	do {
+		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift);
+	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
 
 	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
 		memalloc_nofs_restore(flags);
@@ -3032,6 +3034,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed",
 			real_size);
+		if (gfp_mask && __GFP_NOFAIL)
+			goto again;
 		goto fail;
 	}
 
-- 
2.30.2

