Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A97EA7DD7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfIDI2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 04:28:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:42422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfIDI2G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:28:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77B1EAE91;
        Wed,  4 Sep 2019 08:28:05 +0000 (UTC)
Date:   Wed, 4 Sep 2019 10:28:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 1/2] mm: Allow the page cache to allocate large pages
Message-ID: <20190904082805.GJ3838@dhcp22.suse.cz>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-2-william.kucharski@oracle.com>
 <20190903115748.GS14028@dhcp22.suse.cz>
 <68E123A9-22A8-40ED-B2ED-897FC02D7D75@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68E123A9-22A8-40ED-B2ED-897FC02D7D75@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-09-19 21:30:30, William Kucharski wrote:
> 
> 
> > On Sep 3, 2019, at 5:57 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Mon 02-09-19 03:23:40, William Kucharski wrote:
> >> Add an 'order' argument to __page_cache_alloc() and
> >> do_read_cache_page(). Ensure the allocated pages are compound pages.
> > 
> > Why do we need to touch all the existing callers and change them to use
> > order 0 when none is actually converted to a different order? This just
> > seem to add a lot of code churn without a good reason. If anything I
> > would simply add __page_cache_alloc_order and make __page_cache_alloc
> > call it with order 0 argument.
> 
> All the EXISTING code in patch [1/2] is changed to call it with an order
> of 0, as you would expect.
> 
> However, new code in part [2/2] of the patch calls it with an order of
> HPAGE_PMD_ORDER, as it seems cleaner to have those routines operate on
> a page, regardless of the order of the page desired.
> 
> I certainly can change this as you request, but once again the question
> is whether "page" should MEAN "page" regardless of the order desired,
> or whether the assumption will always be "page" means base PAGESIZE.
> 
> Either approach works, but what is the semantic we want going forward?

I do not have anything against handling page as compound, if that is the
question. All I was interested in whether adding a new helper to
_allocate_ the comound page wouldn't be easier than touching all
existing __page_cache_alloc users.
-- 
Michal Hocko
SUSE Labs
