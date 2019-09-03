Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813E1A7387
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfICTSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 15:18:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfICTSW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:18:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFCC2AF10;
        Tue,  3 Sep 2019 19:18:20 +0000 (UTC)
Date:   Tue, 3 Sep 2019 21:18:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH v5 1/2] mm: Allow the page cache to allocate large pages
Message-ID: <20190903191819.GD14028@dhcp22.suse.cz>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-2-william.kucharski@oracle.com>
 <20190903115748.GS14028@dhcp22.suse.cz>
 <20190903121155.GD29434@bombadil.infradead.org>
 <20190903121952.GU14028@dhcp22.suse.cz>
 <20190903162831.GI29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903162831.GI29434@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-09-19 09:28:31, Matthew Wilcox wrote:
> On Tue, Sep 03, 2019 at 02:19:52PM +0200, Michal Hocko wrote:
> > On Tue 03-09-19 05:11:55, Matthew Wilcox wrote:
> > > On Tue, Sep 03, 2019 at 01:57:48PM +0200, Michal Hocko wrote:
> > > > On Mon 02-09-19 03:23:40, William Kucharski wrote:
> > > > > Add an 'order' argument to __page_cache_alloc() and
> > > > > do_read_cache_page(). Ensure the allocated pages are compound pages.
> > > > 
> > > > Why do we need to touch all the existing callers and change them to use
> > > > order 0 when none is actually converted to a different order? This just
> > > > seem to add a lot of code churn without a good reason. If anything I
> > > > would simply add __page_cache_alloc_order and make __page_cache_alloc
> > > > call it with order 0 argument.
> > > 
> > > Patch 2/2 uses a non-zero order.
> > 
> > It is a new caller and it can use a new function right?
> > 
> > > I agree it's a lot of churn without
> > > good reason; that's why I tried to add GFP_ORDER flags a few months ago.
> > > Unfortunately, you didn't like that approach either.
> > 
> > Is there any future plan that all/most __page_cache_alloc will get a
> > non-zero order argument?
> 
> I'm not sure about "most".  It will certainly become more common, as
> far as I can tell.

I would personally still go with  __page_cache_alloc_order way, but this
is up to you and other fs people what suits best. I was just surprised
to see a lot of code churn when it was not really used in the second
patch. That's why I brought it up. 

> > > > Also is it so much to ask callers to provide __GFP_COMP explicitly?
> > > 
> > > Yes, it's an unreasonable burden on the callers.
> > 
> > Care to exaplain why? __GFP_COMP tends to be used in the kernel quite
> > extensively.
> 
> Most of the places which call this function get their gfp_t from
> mapping->gfp_mask.  If we only want to allocate a single page, we
> must not set __GFP_COMP.  If we want to allocate a large page, we must
> set __GFP_COMP.  Rather than require individual filesystems to concern
> themselves with this wart of the GFP interface, we can solve it in the
> page cache.

Fair enough.

-- 
Michal Hocko
SUSE Labs
