Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868D737471A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhEERom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234985AbhEERm0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:42:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDDE4610E6;
        Wed,  5 May 2021 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620236483;
        bh=sJTYCVtiWBq6R74N8PqzXXzNwxH+DE+4BeekKhgRsus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOm7oY6myzQEP6uoSPfIMXx8U+Wh2fO3QQ1/fZd6PhHiWaSKbCaOfErNRQ10RdN0J
         0ooOeM6wc+4iUsJaoZsDZzULUEYx13oIo+2foz92jd8HKCY1R5mBVWc9IVM0ganfjC
         kwWALtAPHJUFsqdcHMcNyj+Tewn3d8q6RPBJwM7D0gp9daMwT1MRv/5bbm6l7vMe5G
         OJsr/DCsjLeT6EO8/HooHud3LhfJNJCf16hgb0+knxK3T3oka9aeAOw52PX8Lj4GFU
         xTqMBIvGxGJEdt3sSe1bWslJTiy/KQ2RcW0J46MHN6aHIaVBYOLUp8Xo8ukScsNKVh
         +c3j8Wqrx0m1w==
Date:   Wed, 5 May 2021 20:41:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
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
Subject: Re: [PATCH v1 5/7] mm: introduce
 page_offline_(begin|end|freeze|unfreeze) to synchronize setting
 PageOffline()
Message-ID: <YJLYuL/EceejLC7L@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-6-david@redhat.com>
 <YJKcg06C3xE8fCfu@dhcp22.suse.cz>
 <8650f764-8652-a82c-c54f-f67401c800e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8650f764-8652-a82c-c54f-f67401c800e8@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 05, 2021 at 05:10:33PM +0200, David Hildenbrand wrote:
> On 05.05.21 15:24, Michal Hocko wrote:
> > On Thu 29-04-21 14:25:17, David Hildenbrand wrote:
> > > A driver might set a page logically offline -- PageOffline() -- and
> > > turn the page inaccessible in the hypervisor; after that, access to page
> > > content can be fatal. One example is virtio-mem; while unplugged memory
> > > -- marked as PageOffline() can currently be read in the hypervisor, this
> > > will no longer be the case in the future; for example, when having
> > > a virtio-mem device backed by huge pages in the hypervisor.
> > > 
> > > Some special PFN walkers -- i.e., /proc/kcore -- read content of random
> > > pages after checking PageOffline(); however, these PFN walkers can race
> > > with drivers that set PageOffline().
> > > 
> > > Let's introduce page_offline_(begin|end|freeze|unfreeze) for
> > > synchronizing.
> > > 
> > > page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
> > > synchronize with such drivers, achieving that a page cannot be set
> > > PageOffline() while frozen.
> > > 
> > > page_offline_begin()/page_offline_end() is used by drivers that care about
> > > such races when setting a page PageOffline().
> > > 
> > > For simplicity, use a rwsem for now; neither drivers nor users are
> > > performance sensitive.
> > 
> > Please add a note to the PageOffline documentation as well. While are
> > adding the api close enough an explicit note there wouldn't hurt.
> 
> Will do.
> 
> > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > As to the patch itself, I am slightly worried that other pfn walkers
> > might be less tolerant to the locking than the proc ones. On the other
> > hand most users shouldn't really care as they do not tend to touch the
> > memory content and PageOffline check without any synchronization should
> > be sufficient for those. Let's try this out and see where we get...
> 
> My thinking. Users that actually read random page content (as discussed in
> the cover letter) are
> 
> 1. Hibernation
> 2. Dumping (/proc/kcore, /proc/vmcore)
> 3. Physical memory access bypassing the kernel via /dev/mem
> 4. Live debug tools (kgdb)

I think you can add

5. Very old drivers
 
> Other PFN walkers really shouldn't (and don't) access random page content.
> 
> Thanks!
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.
