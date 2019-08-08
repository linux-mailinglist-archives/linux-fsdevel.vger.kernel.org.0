Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9277885A93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 08:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfHHGV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 02:21:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:35042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731005AbfHHGV6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:21:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FE4DAF37;
        Thu,  8 Aug 2019 06:21:57 +0000 (UTC)
Date:   Thu, 8 Aug 2019 08:21:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20190808062155.GF11812@dhcp22.suse.cz>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-08-19 16:32:08, John Hubbard wrote:
> On 8/7/19 4:01 AM, Michal Hocko wrote:
> > On Mon 05-08-19 15:20:17, john.hubbard@gmail.com wrote:
> >> From: John Hubbard <jhubbard@nvidia.com>
> >>
> >> For pages that were retained via get_user_pages*(), release those pages
> >> via the new put_user_page*() routines, instead of via put_page() or
> >> release_pages().
> > 
> > Hmm, this is an interesting code path. There seems to be a mix of pages
> > in the game. We get one page via follow_page_mask but then other pages
> > in the range are filled by __munlock_pagevec_fill and that does a direct
> > pte walk. Is using put_user_page correct in this case? Could you explain
> > why in the changelog?
> > 
> 
> Actually, I think follow_page_mask() gets all the pages, right? And the
> get_page() in __munlock_pagevec_fill() is there to allow a pagevec_release() 
> later.

Maybe I am misreading the code (looking at Linus tree) but munlock_vma_pages_range
calls follow_page for the start address and then if not THP tries to
fill up the pagevec with few more pages (up to end), do the shortcut
via manual pte walk as an optimization and use generic get_page there.
-- 
Michal Hocko
SUSE Labs
