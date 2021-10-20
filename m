Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069004347C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 11:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhJTJUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 05:20:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53214 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhJTJUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:20:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DADA321A95;
        Wed, 20 Oct 2021 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634721495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPvjtKQOd7fMC/9/+8JIUhUxh+2Qtv3moJhg8NLiHcw=;
        b=awmXIrfSpc3o/SPaF6WaZAChHlN33ooMtYKNDMhPf/HHkoQk7qfj/Q/spZ5DhVbgTIOoin
        a2M69P4ECgh8NtrjfRAlZWAqyPTGO1qAFnttsXBpQqEDzzFAjLHG/a1X4dJ1kUlIaMJ3LB
        SARONEeIU6m24Y5NKJ46AJbENt2wuY4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A8187A3B81;
        Wed, 20 Oct 2021 09:18:15 +0000 (UTC)
Date:   Wed, 20 Oct 2021 11:18:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YW/e19fLyUy7ohR6@dhcp22.suse.cz>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan>
 <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan>
 <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-10-21 10:25:06, Michal Hocko wrote:
[...]
> > > The flag itself is not really necessary down there as long as we
> > > guarantee that the high level logic doesn't fail. In this case we keep
> > > retrying at __vmalloc_node_range level which should be possible to cover
> > > all callers that can control gfp mask. I was thinking to put it into
> > > __get_vm_area_node but that was slightly more hairy and we would be
> > > losing the warning which might turn out being helpful in cases where the
> > > failure is due to lack of vmalloc space or similar constrain. Btw. do we
> > > want some throttling on a retry?
> > > 
> > I think adding kind of schedule() will not make things worse and in corner
> > cases could prevent a power drain by CPU. It is important for mobile devices. 
> 
> I suspect you mean schedule_timeout here? Or cond_resched? I went with a
> later for now, I do not have a good idea for how to long to sleep here.
> I am more than happy to change to to a sleep though.

Forgot to paste the follow up I have staged currently
--- 
commit 66fea55e5543fa234692a70144cd63c7a1bca32f
Author: Michal Hocko <mhocko@suse.com>
Date:   Wed Oct 20 10:12:45 2021 +0200

    fold me "mm/vmalloc: add support for __GFP_NOFAIL"
    
    - add cond_resched

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0fb5413d9239..f7098e616883 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2944,6 +2944,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	do {
 		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift);
+		cond_resched();
 	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
 
 	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
@@ -3034,8 +3035,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed",
 			real_size);
-		if (gfp_mask & __GFP_NOFAIL)
+		if (gfp_mask & __GFP_NOFAIL) {
+			cond_resched();
 			goto again;
+		}
 		goto fail;
 	}
 

-- 
Michal Hocko
SUSE Labs
