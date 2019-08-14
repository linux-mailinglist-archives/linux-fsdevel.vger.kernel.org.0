Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 082CE8E15B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 01:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfHNXuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 19:50:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:12480 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNXuB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:50:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 16:50:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; 
   d="scan'208";a="184468157"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2019 16:50:00 -0700
Date:   Wed, 14 Aug 2019 16:50:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
References: <20190812015044.26176-1-jhubbard@nvidia.com>
 <20190812015044.26176-3-jhubbard@nvidia.com>
 <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
 <38d2ff2f-4a69-e8bd-8f7c-41f1dbd80fae@nvidia.com>
 <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
 <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
 <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:56:31PM -0700, John Hubbard wrote:
> On 8/13/19 5:51 PM, John Hubbard wrote:
> > On 8/13/19 2:08 PM, Ira Weiny wrote:
> >> On Mon, Aug 12, 2019 at 05:07:32PM -0700, John Hubbard wrote:
> >>> On 8/12/19 4:49 PM, Ira Weiny wrote:
> >>>> On Sun, Aug 11, 2019 at 06:50:44PM -0700, john.hubbard@gmail.com wrote:
> >>>>> From: John Hubbard <jhubbard@nvidia.com>
> >>> ...
> >> Finally, I struggle with converting everyone to a new call.  It is more
> >> overhead to use vaddr_pin in the call above because now the GUP code is going
> >> to associate a file pin object with that file when in ODP we don't need that
> >> because the pages can move around.
> > 
> > What if the pages in ODP are file-backed? 
> > 
> 
> oops, strike that, you're right: in that case, even the file system case is covered.
> Don't mind me. :)

Ok so are we agreed we will drop the patch to the ODP code?  I'm going to keep
the FOLL_PIN flag and addition in the vaddr_pin_pages.

Ira

> 
> >>
> >> This overhead may be fine, not sure in this case, but I don't see everyone
> >> wanting it.
> 
> So now I see why you said that, but I will note that ODP hardware is rare,
> and will likely remain rare: replayable page faults require really special 
> hardware, and after all this time, we still only have CPUs, GPUs, and the
> Mellanox cards that do it.
> 
> That leaves a lot of other hardware to take care of.
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
