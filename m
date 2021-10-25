Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2D4439992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhJYPGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:06:13 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44736 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhJYPGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:06:08 -0400
Received: by mail-ed1-f54.google.com with SMTP id a26so662466edy.11;
        Mon, 25 Oct 2021 08:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=is5ZDC1BahE5nkVkXn47Hcgm/HWZp8+0MbF9wxx8kgU=;
        b=5hPwlqc4j4hku/+6CKcR/EMugiF+FFZ+NLSZh2j4b8wirNShtAY5K0Y1h5YbPUQxv7
         iJJ9elLBiw4oXpVbxOWSIEviPVJEwrnyY/6UQhV+T03sXJIvcX3SiaWlYhAYOaSq0Rtl
         MT+eJ0rjTk4Rj0ST0w2Ok4DUVeZEs9BNIk0EgcshI+eLmzkHMtsM+QSuT3to9dF7p005
         KAiF4LgfEPMqhkCYdTiDIAZ5FIq/Q3PrGNWe43Pr2KLlEYAfxwwD5bzRo4G4eBuYrGcQ
         yt1dG2Ip9s/fJBiJw4zoE7/Yy/gqznI4ukklT74Gv9o3g9f3imw3QO5k5UtGWci6JXQB
         uHnw==
X-Gm-Message-State: AOAM533UlPwkJvhDUL7vQMPX5QCu0WwN+0Cqmi42angLy8FEzEg25Vqf
        LHDD5hoow34dhNBi7x/yC80=
X-Google-Smtp-Source: ABdhPJwwVcroxT7QraFpGhjr1v8G3BYv6JBUob+3acdxXiP1C2i0nOfZ2f/Nud8KWLUBV9luq/Yc4A==
X-Received: by 2002:a05:6402:11d4:: with SMTP id j20mr27327097edw.267.1635174160482;
        Mon, 25 Oct 2021 08:02:40 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-34-175.eurotel.cz. [85.160.34.175])
        by smtp.gmail.com with ESMTPSA id u23sm9098221edr.97.2021.10.25.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 08:02:39 -0700 (PDT)
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
Subject: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Date:   Mon, 25 Oct 2021 17:02:21 +0200
Message-Id: <20211025150223.13621-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025150223.13621-1-mhocko@kernel.org>
References: <20211025150223.13621-1-mhocko@kernel.org>
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

Add a short sleep before retrying. 1 jiffy is a completely random
timeout. Ideally the retry would wait for an explicit event - e.g.
a change to the vmalloc space change if the failure was caused by
the space fragmentation or depletion. But there are multiple different
reasons to retry and this could become much more complex. Keep the retry
simple for now and just sleep to prevent from hogging CPUs.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c6cc77d2f366..602649919a9d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2941,8 +2941,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
 		flags = memalloc_noio_save();
 
-	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
+	do {
+		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift);
+		if (ret < 0)
+			schedule_timeout_uninterruptible(1);
+	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
 
 	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
 		memalloc_nofs_restore(flags);
@@ -3032,6 +3036,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed",
 			real_size);
+		if (gfp_mask & __GFP_NOFAIL) {
+			schedule_timeout_uninterruptible(1);
+			goto again;
+		}
 		goto fail;
 	}
 
-- 
2.30.2

