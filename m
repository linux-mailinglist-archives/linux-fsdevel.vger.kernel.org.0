Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD2A8F243
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfHORcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 13:32:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:17145 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfHORcj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:32:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 10:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="260880031"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2019 10:32:37 -0700
Date:   Thu, 15 Aug 2019 10:32:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190815173237.GA30924@iweiny-DESK2.sc.intel.com>
References: <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
 <38d2ff2f-4a69-e8bd-8f7c-41f1dbd80fae@nvidia.com>
 <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
 <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
 <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815133510.GA21302@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:35:10PM +0200, Jan Kara wrote:
> On Thu 15-08-19 15:26:22, Jan Kara wrote:
> > On Wed 14-08-19 20:01:07, John Hubbard wrote:
> > > On 8/14/19 5:02 PM, John Hubbard wrote:
> > > 
> > > Hold on, I *was* forgetting something: this was a two part thing, and
> > > you're conflating the two points, but they need to remain separate and
> > > distinct. There were:
> > > 
> > > 1. FOLL_PIN is necessary because the caller is clearly in the use case that
> > > requires it--however briefly they might be there. As Jan described it,
> > > 
> > > "Anything that gets page reference and then touches page data (e.g.
> > > direct IO) needs the new kind of tracking so that filesystem knows
> > > someone is messing with the page data." [1]
> > 
> > So when the GUP user uses MMU notifiers to stop writing to pages whenever
> > they are writeprotected with page_mkclean(), they don't really need page
> > pin - their access is then fully equivalent to any other mmap userspace
> > access and filesystem knows how to deal with those. I forgot out this case
> > when I wrote the above sentence.
> > 
> > So to sum up there are three cases:
> > 1) DIO case - GUP references to pages serving as DIO buffers are needed for
> >    relatively short time, no special synchronization with page_mkclean() or
> >    munmap() => needs FOLL_PIN
> > 2) RDMA case - GUP references to pages serving as DMA buffers needed for a
> >    long time, no special synchronization with page_mkclean() or munmap()
> >    => needs FOLL_PIN | FOLL_LONGTERM
> >    This case has also a special case when the pages are actually DAX. Then
> >    the caller additionally needs file lease and additional file_pin
> >    structure is used for tracking this usage.
> > 3) ODP case - GUP references to pages serving as DMA buffers, MMU notifiers
> >    used to synchronize with page_mkclean() and munmap() => normal page
> >    references are fine.
> 
> I want to add that I'd like to convert users in cases 1) and 2) from using
> GUP to using differently named function. Users in case 3) can stay as they
> are for now although ultimately I'd like to denote such use cases in a
> special way as well...
> 

Ok just to make this clear I threw up my current tree with your patches here:

https://github.com/weiny2/linux-kernel/commits/mmotm-rdmafsdax-b0-v4

I'm talking about dropping the final patch:
05fd2d3afa6b rdma/umem_odp: Use vaddr_pin_pages_remote() in ODP

The other 2 can stay.  I split out the *_remote() call.  We don't have a user
but I'll keep it around for a bit.

This tree is still WIP as I work through all the comments.  So I've not changed
names or variable types etc...  Just wanted to settle this.

Ira

