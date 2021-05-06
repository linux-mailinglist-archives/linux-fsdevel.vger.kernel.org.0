Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8730D375096
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhEFIOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 04:14:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhEFIOp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 04:14:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620288825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ko5Il7tnnaRh/+DWXvFr0zXq1UzJJiHuAYa3FhMkhY8=;
        b=DvYo4XmNOYmmrEoAZYXLTtTy/YE4UC2FnkoOEJAMP+jxdN2+/tgKZjwR+JpMPKjXgMNecI
        0uMm3ZjM0hg3VyIcL18eYC3Iu7lciFzXgVkNc+pbYqPyCcNmcg8Gj5JmWj3OPdzg1aaCws
        6E4OkjKv23e4xHMFUeG3Mk+1OSIY6Tg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7909B1C3;
        Thu,  6 May 2021 08:13:43 +0000 (UTC)
Date:   Thu, 6 May 2021 09:55:51 +0200
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
Message-ID: <YJOhBxiXIpaJpq+K@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com>
 <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
 <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
 <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
 <20210506085611.1ec21588@alex-virtual-machine>
 <YJOVZlFGcSG+mmIk@dhcp22.suse.cz>
 <20210506152805.13fe775e@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506152805.13fe775e@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-05-21 15:28:05, Aili Yao wrote:
> On Thu, 6 May 2021 09:06:14 +0200
> Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Thu 06-05-21 08:56:11, Aili Yao wrote:
> > > On Wed, 5 May 2021 15:27:39 +0200
> > > Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > > I am not sure I follow. My point is that I fail to see any added value
> > > > of the check as it doesn't prevent the race (it fundamentally cannot as
> > > > the page can be poisoned at any time) but the failure path doesn't
> > > > put_page which is incorrect even for hwpoison pages.  
> > > 
> > > Sorry, I have something to say:
> > > 
> > > I have noticed the ref count leak in the previous topic ,but  I don't think
> > > it's a really matter. For memory recovery case for user pages, we will keep one
> > > reference to the poison page so the error page will not be freed to buddy allocator.
> > > which can be checked in memory_faulure() function.  
> > 
> > So what would happen if those pages are hwpoisoned from userspace rather
> > than by HW. And repeatedly so?
> 
> Sorry, I may be not totally understand what you mean.
> 
> Do you mean hard page offline from mcelog?

No I mean soft hwpoison from userspace (e.g. by MADV_HWPOISON but there
are other interfaces AFAIK).

And just to be explicit. All those interfaces are root only
(CAP_SYS_ADMIN) so I am not really worried about any malitious abuse of
the reference leak. I am mostly concerned that this is obviously broken
without a good reason. The most trivial fix would have been to put_page
in the return path but as I've mentioned in other email thread the fix
really needs a deeper thought and consider other things.

Hope that clarifies this some more.
-- 
Michal Hocko
SUSE Labs
