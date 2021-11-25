Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324A945D739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 10:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353958AbhKYJfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 04:35:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55524 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344571AbhKYJdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:33:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1E8B11FDF1;
        Thu, 25 Nov 2021 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637832629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wjymsJw1KuuOaku602rZWWeCSBGE+/RZzn+XDn1Ko8=;
        b=DlPa4EjjqNYOQrMm9Ow0lnQOXNUmNwmMUCZ48pzutvrLmSXcNN8mo/cQVPHFWdedIVF9IN
        NvBZVFwBQEZYRHN2OIb7ck+onih1PPnqGVJeeuj7b8oO4stNYO4rCmQtGtlQpfeZ81FuR8
        /voxQX5FnMpJUCt3CsbqhwOYrDQn5Sg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E730FA3B8F;
        Thu, 25 Nov 2021 09:30:28 +0000 (UTC)
Date:   Thu, 25 Nov 2021 10:30:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 0/4] extend vmalloc support for constrained allocations
Message-ID: <YZ9XtLY4AEjVuiEI@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211124225526.GM418105@dread.disaster.area>
 <YZ9QNeHYt99mdfbZ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ9QNeHYt99mdfbZ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc Sebastian and Vlastimil]

On Thu 25-11-21 09:58:31, Michal Hocko wrote:
> On Thu 25-11-21 09:55:26, Dave Chinner wrote:
> [...]
> > Correct __GFP_NOLOCKDEP support is also needed. See:
> > 
> > https://lore.kernel.org/linux-mm/20211119225435.GZ449541@dread.disaster.area/
> 
> I will have a closer look. This will require changes on both vmalloc and
> sl?b sides.

This should hopefully make the trick
--- 
From 0082d29c771d831e5d1b9bb4c0a61d39bac017f0 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 25 Nov 2021 10:20:16 +0100
Subject: [PATCH] mm: make slab and vmalloc allocators __GFP_NOLOCKDEP aware

sl?b and vmalloc allocators reduce the given gfp mask for their internal
needs. For that they use GFP_RECLAIM_MASK to preserve the reclaim
behavior and constrains.

__GFP_NOLOCKDEP is not a part of that mask because it doesn't really
control the reclaim behavior strictly speaking. On the other hand
it tells the underlying page allocator to disable reclaim recursion
detection so arguably it should be part of the mask.

Having __GFP_NOLOCKDEP in the mask will not alter the behavior in any
form so this change is safe pretty much by definition. It also adds
a support for this flag to SL?B and vmalloc allocators which will in
turn allow its use to kvmalloc as well. A lack of the support has been
noticed recently in http://lkml.kernel.org/r/20211119225435.GZ449541@dread.disaster.area

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3b79a5c9427a..2ceea20b5b2a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -21,7 +21,7 @@
 #define GFP_RECLAIM_MASK (__GFP_RECLAIM|__GFP_HIGH|__GFP_IO|__GFP_FS|\
 			__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NOFAIL|\
 			__GFP_NORETRY|__GFP_MEMALLOC|__GFP_NOMEMALLOC|\
-			__GFP_ATOMIC)
+			__GFP_ATOMIC|__GFP_NOLOCKDEP)
 
 /* The GFP flags allowed during early boot */
 #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS))
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
