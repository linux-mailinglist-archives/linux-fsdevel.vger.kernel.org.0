Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB2E904FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfHPPwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 11:52:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfHPPwY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:52:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 222B486663;
        Fri, 16 Aug 2019 15:52:24 +0000 (UTC)
Received: from redhat.com (ovpn-123-168.rdu2.redhat.com [10.10.123.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BF4583E86;
        Fri, 16 Aug 2019 15:52:22 +0000 (UTC)
Date:   Fri, 16 Aug 2019 11:52:20 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190816155220.GC3149@redhat.com>
References: <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
 <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
 <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
 <0d6797d8-1e04-1ebe-80a7-3d6895fe71b0@suse.cz>
 <20190816154404.GF3041@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190816154404.GF3041@quack2.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 16 Aug 2019 15:52:24 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 16, 2019 at 05:44:04PM +0200, Jan Kara wrote:
> On Fri 16-08-19 10:47:21, Vlastimil Babka wrote:
> > On 8/15/19 3:35 PM, Jan Kara wrote:
> > >> 
> > >> So when the GUP user uses MMU notifiers to stop writing to pages whenever
> > >> they are writeprotected with page_mkclean(), they don't really need page
> > >> pin - their access is then fully equivalent to any other mmap userspace
> > >> access and filesystem knows how to deal with those. I forgot out this case
> > >> when I wrote the above sentence.
> > >> 
> > >> So to sum up there are three cases:
> > >> 1) DIO case - GUP references to pages serving as DIO buffers are needed for
> > >>    relatively short time, no special synchronization with page_mkclean() or
> > >>    munmap() => needs FOLL_PIN
> > >> 2) RDMA case - GUP references to pages serving as DMA buffers needed for a
> > >>    long time, no special synchronization with page_mkclean() or munmap()
> > >>    => needs FOLL_PIN | FOLL_LONGTERM
> > >>    This case has also a special case when the pages are actually DAX. Then
> > >>    the caller additionally needs file lease and additional file_pin
> > >>    structure is used for tracking this usage.
> > >> 3) ODP case - GUP references to pages serving as DMA buffers, MMU notifiers
> > >>    used to synchronize with page_mkclean() and munmap() => normal page
> > >>    references are fine.
> > 
> > IMHO the munlock lesson told us about another one, that's in the end equivalent
> > to 3)
> > 
> > 4) pinning for struct page manipulation only => normal page references
> > are fine
> 
> Right, it's good to have this for clarity.
> 
> > > I want to add that I'd like to convert users in cases 1) and 2) from using
> > > GUP to using differently named function. Users in case 3) can stay as they
> > > are for now although ultimately I'd like to denote such use cases in a
> > > special way as well...
> > 
> > So after 1/2/3 is renamed/specially denoted, only 4) keeps the current
> > interface?
> 
> Well, munlock() code doesn't even use GUP, just follow_page(). I'd wait to
> see what's left after handling cases 1), 2), and 3) to decide about the
> interface for the remainder.
> 

For 3 we do not need to take a reference at all :) So just forget about 3
it does not exist. For 3 the reference is the reference the CPU page table
has on the page and that's it. GUP is no longer involve in ODP or anything
like that.

Cheers,
Jérôme
