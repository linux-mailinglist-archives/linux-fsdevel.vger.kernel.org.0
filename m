Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E36873EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 10:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405928AbfHIIXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 04:23:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:34146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405915AbfHIIXJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:23:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C33ACAF50;
        Fri,  9 Aug 2019 08:23:07 +0000 (UTC)
Date:   Fri, 9 Aug 2019 10:23:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
Message-ID: <20190809082307.GL18351@dhcp22.suse.cz>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
 <20190808062155.GF11812@dhcp22.suse.cz>
 <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
 <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
 <d1ecb0d4-ea6a-637d-7029-687b950b783f@nvidia.com>
 <420a5039-a79c-3872-38ea-807cedca3b8a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420a5039-a79c-3872-38ea-807cedca3b8a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 09-08-19 10:12:48, Vlastimil Babka wrote:
> On 8/9/19 12:59 AM, John Hubbard wrote:
> >>> That's true. However, I'm not sure munlocking is where the
> >>> put_user_page() machinery is intended to be used anyway? These are
> >>> short-term pins for struct page manipulation, not e.g. dirtying of page
> >>> contents. Reading commit fc1d8e7cca2d I don't think this case falls
> >>> within the reasoning there. Perhaps not all GUP users should be
> >>> converted to the planned separate GUP tracking, and instead we should
> >>> have a GUP/follow_page_mask() variant that keeps using get_page/put_page?
> >>>  
> >>
> >> Interesting. So far, the approach has been to get all the gup callers to
> >> release via put_user_page(), but if we add in Jan's and Ira's vaddr_pin_pages()
> >> wrapper, then maybe we could leave some sites unconverted.
> >>
> >> However, in order to do so, we would have to change things so that we have
> >> one set of APIs (gup) that do *not* increment a pin count, and another set
> >> (vaddr_pin_pages) that do. 
> >>
> >> Is that where we want to go...?
> >>
> 
> We already have a FOLL_LONGTERM flag, isn't that somehow related? And if
> it's not exactly the same thing, perhaps a new gup flag to distinguish
> which kind of pinning to use?

Agreed. This is a shiny example how forcing all existing gup users into
the new scheme is subotimal at best. Not the mention the overal
fragility mention elsewhere. I dislike the conversion even more now.

Sorry if this was already discussed already but why the new pinning is
not bound to FOLL_LONGTERM (ideally hidden by an interface so that users
do not have to care about the flag) only?
-- 
Michal Hocko
SUSE Labs
