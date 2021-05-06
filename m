Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE579374FBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhEFHHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 03:07:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbhEFHHP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 03:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620284776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ZsN+U9xYy8SB6qQBQij2SzxvCN+k/V0YckFGYc2r3w=;
        b=ffDOAVGcvH2zQvGSxi7ErqNPrJj5pM//Z1w8IoOiMf7JbN0XRZELBXG8ZCVBrEv9p/Qzig
        sxstkvj7FXtZl1AwHuusfPOP/u3JQ7fMAUER8GLoJjKjwcaUCkFMfNj1p5ed3yenArURyT
        aX9hDC+G8TKiOPQhbQ+CjXxi0YKn5HM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDEECAFD0;
        Thu,  6 May 2021 07:06:15 +0000 (UTC)
Date:   Thu, 6 May 2021 09:06:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        yaoaili126@gmail.com
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Message-ID: <YJOVZlFGcSG+mmIk@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com>
 <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
 <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
 <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
 <20210506085611.1ec21588@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506085611.1ec21588@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-05-21 08:56:11, Aili Yao wrote:
> On Wed, 5 May 2021 15:27:39 +0200
> Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Wed 05-05-21 15:17:53, David Hildenbrand wrote:
> > > On 05.05.21 15:13, Michal Hocko wrote:  
> > > > On Thu 29-04-21 14:25:15, David Hildenbrand wrote:  
> > > > > Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
> > > > > introduced page_is_poisoned(), however, v5 [1] of the patch used
> > > > > "page_is_hwpoison()" and something went wrong while upstreaming. Rename the
> > > > > function and move it to page-flags.h, from where it can be used in other
> > > > > -- kcore -- context.
> > > > > 
> > > > > Move the comment to the place where it belongs and simplify.
> > > > > 
> > > > > [1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine
> > > > > 
> > > > > Signed-off-by: David Hildenbrand <david@redhat.com>  
> > > > 
> > > > I do agree that being explicit about hwpoison is much better. Poisoned
> > > > page can be also an unitialized one and I believe this is the reason why
> > > > you are bringing that up.  
> > > 
> > > I'm bringing it up because I want to reuse that function as state above :)
> > >   
> > > > 
> > > > But you've made me look at d3378e86d182 and I am wondering whether this
> > > > is really a valid patch. First of all it can leak a reference count
> > > > AFAICS. Moreover it doesn't really fix anything because the page can be
> > > > marked hwpoison right after the check is done. I do not think the race
> > > > is feasible to be closed. So shouldn't we rather revert it?  
> > > 
> > > I am not sure if we really care about races here that much here? I mean,
> > > essentially we are racing with HW breaking asynchronously. Just because we
> > > would be synchronizing with SetPageHWPoison() wouldn't mean we can stop HW
> > > from breaking.  
> > 
> > Right
> > 
> > > Long story short, this should be good enough for the cases we actually can
> > > handle? What am I missing?  
> > 
> > I am not sure I follow. My point is that I fail to see any added value
> > of the check as it doesn't prevent the race (it fundamentally cannot as
> > the page can be poisoned at any time) but the failure path doesn't
> > put_page which is incorrect even for hwpoison pages.
> 
> Sorry, I have something to say:
> 
> I have noticed the ref count leak in the previous topic ,but  I don't think
> it's a really matter. For memory recovery case for user pages, we will keep one
> reference to the poison page so the error page will not be freed to buddy allocator.
> which can be checked in memory_faulure() function.

So what would happen if those pages are hwpoisoned from userspace rather
than by HW. And repeatedly so?
-- 
Michal Hocko
SUSE Labs
