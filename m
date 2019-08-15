Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926988ECF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfHONfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 09:35:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731747AbfHONfN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:35:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C57B7AE12;
        Thu, 15 Aug 2019 13:35:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 357491E4200; Thu, 15 Aug 2019 15:35:10 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:35:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190815133510.GA21302@quack2.suse.cz>
References: <20190812015044.26176-3-jhubbard@nvidia.com>
 <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
 <38d2ff2f-4a69-e8bd-8f7c-41f1dbd80fae@nvidia.com>
 <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
 <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
 <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815132622.GG14313@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-08-19 15:26:22, Jan Kara wrote:
> On Wed 14-08-19 20:01:07, John Hubbard wrote:
> > On 8/14/19 5:02 PM, John Hubbard wrote:
> > > On 8/14/19 4:50 PM, Ira Weiny wrote:
> > > > On Tue, Aug 13, 2019 at 05:56:31PM -0700, John Hubbard wrote:
> > > > > On 8/13/19 5:51 PM, John Hubbard wrote:
> > > > > > On 8/13/19 2:08 PM, Ira Weiny wrote:
> > > > > > > On Mon, Aug 12, 2019 at 05:07:32PM -0700, John Hubbard wrote:
> > > > > > > > On 8/12/19 4:49 PM, Ira Weiny wrote:
> > > > > > > > > On Sun, Aug 11, 2019 at 06:50:44PM -0700, john.hubbard@gmail.com wrote:
> > > > > > > > > > From: John Hubbard <jhubbard@nvidia.com>
> > > > > > > > ...
> > > > > > > Finally, I struggle with converting everyone to a new call.  It is more
> > > > > > > overhead to use vaddr_pin in the call above because now the GUP code is going
> > > > > > > to associate a file pin object with that file when in ODP we don't need that
> > > > > > > because the pages can move around.
> > > > > > 
> > > > > > What if the pages in ODP are file-backed?
> > > > > > 
> > > > > 
> > > > > oops, strike that, you're right: in that case, even the file system case is covered.
> > > > > Don't mind me. :)
> > > > 
> > > > Ok so are we agreed we will drop the patch to the ODP code?  I'm going to keep
> > > > the FOLL_PIN flag and addition in the vaddr_pin_pages.
> > > > 
> > > 
> > > Yes. I hope I'm not overlooking anything, but it all seems to make sense to
> > > let ODP just rely on the MMU notifiers.
> > > 
> > 
> > Hold on, I *was* forgetting something: this was a two part thing, and
> > you're conflating the two points, but they need to remain separate and
> > distinct. There were:
> > 
> > 1. FOLL_PIN is necessary because the caller is clearly in the use case that
> > requires it--however briefly they might be there. As Jan described it,
> > 
> > "Anything that gets page reference and then touches page data (e.g.
> > direct IO) needs the new kind of tracking so that filesystem knows
> > someone is messing with the page data." [1]
> 
> So when the GUP user uses MMU notifiers to stop writing to pages whenever
> they are writeprotected with page_mkclean(), they don't really need page
> pin - their access is then fully equivalent to any other mmap userspace
> access and filesystem knows how to deal with those. I forgot out this case
> when I wrote the above sentence.
> 
> So to sum up there are three cases:
> 1) DIO case - GUP references to pages serving as DIO buffers are needed for
>    relatively short time, no special synchronization with page_mkclean() or
>    munmap() => needs FOLL_PIN
> 2) RDMA case - GUP references to pages serving as DMA buffers needed for a
>    long time, no special synchronization with page_mkclean() or munmap()
>    => needs FOLL_PIN | FOLL_LONGTERM
>    This case has also a special case when the pages are actually DAX. Then
>    the caller additionally needs file lease and additional file_pin
>    structure is used for tracking this usage.
> 3) ODP case - GUP references to pages serving as DMA buffers, MMU notifiers
>    used to synchronize with page_mkclean() and munmap() => normal page
>    references are fine.

I want to add that I'd like to convert users in cases 1) and 2) from using
GUP to using differently named function. Users in case 3) can stay as they
are for now although ultimately I'd like to denote such use cases in a
special way as well...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
