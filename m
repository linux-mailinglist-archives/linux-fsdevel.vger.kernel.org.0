Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF6373C5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhEEN2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 09:28:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhEEN2i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 09:28:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620221260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGLu3gLLUm9em9SOE5qtfKtO5dEYjOb/g2kUV6nMYNc=;
        b=n6TZpPwGis+vpxeyirf9mIIe9mAPXZkRzj2QcW0Hz5S8a6aERcTXnW0gWX6OjUmbWSvICg
        sOuW3IjuIvAXwuh4UEcJzAbeSDX+UINqNTBFrBFvHxCp2FfeWvlW5URegyu8k6matU4gWH
        gayQpGv9GqxKKNk/QMUP960Ni5k+AJQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE25DAE86;
        Wed,  5 May 2021 13:27:40 +0000 (UTC)
Date:   Wed, 5 May 2021 15:27:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
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
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Message-ID: <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com>
 <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
 <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-05-21 15:17:53, David Hildenbrand wrote:
> On 05.05.21 15:13, Michal Hocko wrote:
> > On Thu 29-04-21 14:25:15, David Hildenbrand wrote:
> > > Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
> > > introduced page_is_poisoned(), however, v5 [1] of the patch used
> > > "page_is_hwpoison()" and something went wrong while upstreaming. Rename the
> > > function and move it to page-flags.h, from where it can be used in other
> > > -- kcore -- context.
> > > 
> > > Move the comment to the place where it belongs and simplify.
> > > 
> > > [1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > I do agree that being explicit about hwpoison is much better. Poisoned
> > page can be also an unitialized one and I believe this is the reason why
> > you are bringing that up.
> 
> I'm bringing it up because I want to reuse that function as state above :)
> 
> > 
> > But you've made me look at d3378e86d182 and I am wondering whether this
> > is really a valid patch. First of all it can leak a reference count
> > AFAICS. Moreover it doesn't really fix anything because the page can be
> > marked hwpoison right after the check is done. I do not think the race
> > is feasible to be closed. So shouldn't we rather revert it?
> 
> I am not sure if we really care about races here that much here? I mean,
> essentially we are racing with HW breaking asynchronously. Just because we
> would be synchronizing with SetPageHWPoison() wouldn't mean we can stop HW
> from breaking.

Right

> Long story short, this should be good enough for the cases we actually can
> handle? What am I missing?

I am not sure I follow. My point is that I fail to see any added value
of the check as it doesn't prevent the race (it fundamentally cannot as
the page can be poisoned at any time) but the failure path doesn't
put_page which is incorrect even for hwpoison pages.
-- 
Michal Hocko
SUSE Labs
