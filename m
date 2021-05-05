Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68233373CA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 15:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhEENqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 09:46:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhEENqr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 09:46:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620222350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zmxur1kgzuevsre8s/5Lx5vP8+P1yeG3cdZsfEJFfbI=;
        b=e9SF9KizJ6skQ3SZqBMxV9jRhsS9xJskcYraE7q5zDy20XZbIx9mgQGPLYTnnz6IkdnBFE
        mbwJODkGnxRAELnkaaE6ybeyPhOe/alOTs9q6Hv5usMLRcwnF3mSOyJPWwavA6eL2vXm3P
        syN4KPLO/yREBYmukxjyUUZFSWkQ8hY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B76EADB3;
        Wed,  5 May 2021 13:45:50 +0000 (UTC)
Date:   Wed, 5 May 2021 15:45:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <YJKhi6T33UmiZ/kE@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com>
 <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
 <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
 <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
 <57ac524c-b49a-99ec-c1e4-ef5027bfb61b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57ac524c-b49a-99ec-c1e4-ef5027bfb61b@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-05-21 15:39:08, David Hildenbrand wrote:
> > > Long story short, this should be good enough for the cases we actually can
> > > handle? What am I missing?
> > 
> > I am not sure I follow. My point is that I fail to see any added value
> > of the check as it doesn't prevent the race (it fundamentally cannot as
> > the page can be poisoned at any time) but the failure path doesn't
> > put_page which is incorrect even for hwpoison pages.
> 
> Oh, I think you are right. If we have a page and return NULL we would leak a
> reference.
> 
> Actually, we discussed in that thread handling this entirely differently,
> which resulted in a v7 [1]; however Andrew moved forward with this
> (outdated?) patch, maybe that was just a mistake?
> 
> Yes, I agree we should revert that patch for now.

OK, Let me send the revert to Andrew.

-- 
Michal Hocko
SUSE Labs
