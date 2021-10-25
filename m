Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE94394AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJYLYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 07:24:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58124 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhJYLXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:23:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 207DB1FD3E;
        Mon, 25 Oct 2021 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635160842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SgccS7iH62TPzdASgUY4+1bxWzoWrC+SmORjKFFwhmE=;
        b=f04zZ3x96IraB5r5N/NKye85sQDxJcfMc4QHbSXMvRWG9eBPa4/U773x8vvbOUO+/HxLmx
        wSgFmiM6nfFOrr7kqEFefOrsNZ4th1sNXmfp2oYQu01W9RqdsJDv3+/obfcLGRRZUE+0E/
        NRVSjR72lkcytWwMym9dIqzajINScEk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E71DCA3B81;
        Mon, 25 Oct 2021 11:20:41 +0000 (UTC)
Date:   Mon, 25 Oct 2021 13:20:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     NeilBrown <neilb@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXaTBrhEqTZhTJYX@dhcp22.suse.cz>
References: <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
 <20211020192430.GA1861@pc638.lan>
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>
 <20211021104038.GA1932@pc638.lan>
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>
 <20211025094841.GA1945@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025094841.GA1945@pc638.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-10-21 11:48:41, Uladzislau Rezki wrote:
> On Fri, Oct 22, 2021 at 09:49:08AM +1100, NeilBrown wrote:
[...]
> > If, as you say, the precision doesn't matter that much, then maybe
> >    msleep(0)
> > which would sleep to the start of the next jiffy.  Does that look a bit
> > weird?  If so, the msleep(1) would be ok.
> > 
> Agree, msleep(1) looks much better rather then converting 1 jiffy to
> milliseconds. Result should be the same.

I would really prefer if this was not the main point of arguing here.
Unless you feel strongly about msleep I would go with schedule_timeout
here because this is a more widely used interface in the mm code and
also because I feel like that relying on the rounding behavior is just
subtle. Here is what I have staged now.

Are there any other concerns you see with this or other patches in the
series?

Thanks!
--- 
commit c1a7e40e6b56fed5b9e716de7055b77ea29d89d0
Author: Michal Hocko <mhocko@suse.com>
Date:   Wed Oct 20 10:12:45 2021 +0200

    fold me "mm/vmalloc: add support for __GFP_NOFAIL"
    
    Add a short sleep before retrying. 1 jiffy is a completely random
    timeout. Ideally the retry would wait for an explicit event - e.g.
    a change to the vmalloc space change if the failure was caused by
    the space fragmentation or depletion. But there are multiple different
    reasons to retry and this could become much more complex. Keep the retry
    simple for now and just sleep to prevent from hogging CPUs.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0fb5413d9239..a866db0c9c31 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2944,6 +2944,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	do {
 		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift);
+		schedule_timeout_uninterruptible(1);
 	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
 
 	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
@@ -3034,8 +3035,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed",
 			real_size);
-		if (gfp_mask & __GFP_NOFAIL)
+		if (gfp_mask & __GFP_NOFAIL) {
+			schedule_timeout_uninterruptible(1);
 			goto again;
+		}
 		goto fail;
 	}
 

-- 
Michal Hocko
SUSE Labs
