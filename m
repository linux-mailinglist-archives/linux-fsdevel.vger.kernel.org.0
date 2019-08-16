Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02D390A9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 00:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfHPWAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 18:00:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:24559 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfHPWAY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:00:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="201663215"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2019 14:59:54 -0700
Date:   Fri, 16 Aug 2019 14:59:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190816215954.GA19549@iweiny-DESK2.sc.intel.com>
References: <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
 <20190815173237.GA30924@iweiny-DESK2.sc.intel.com>
 <b378a363-f523-518d-9864-e2f8e5bd0c34@nvidia.com>
 <58b75fa9-1272-b683-cb9f-722cc316bf8f@nvidia.com>
 <20190816154108.GE3041@quack2.suse.cz>
 <20190816183337.GA371@iweiny-DESK2.sc.intel.com>
 <a584cfbd-b458-dce9-4144-3b542bcf163d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a584cfbd-b458-dce9-4144-3b542bcf163d@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:50:09AM -0700, John Hubbard wrote:
> On 8/16/19 11:33 AM, Ira Weiny wrote:
> > On Fri, Aug 16, 2019 at 05:41:08PM +0200, Jan Kara wrote:
> > > On Thu 15-08-19 19:14:08, John Hubbard wrote:
> > > > On 8/15/19 10:41 AM, John Hubbard wrote:
> > > > > On 8/15/19 10:32 AM, Ira Weiny wrote:
> > > > > > On Thu, Aug 15, 2019 at 03:35:10PM +0200, Jan Kara wrote:
> > > > > > > On Thu 15-08-19 15:26:22, Jan Kara wrote:
> > > > > > > > On Wed 14-08-19 20:01:07, John Hubbard wrote:
> > > > > > > > > On 8/14/19 5:02 PM, John Hubbard wrote:
> > > > ...
> > > > 
> > > > OK, there was only process_vm_access.c, plus (sort of) Bharath's sgi-gru
> > > > patch, maybe eventually [1].  But looking at process_vm_access.c, I think
> > > > it is one of the patches that is no longer applicable, and I can just
> > > > drop it entirely...I'd welcome a second opinion on that...
> > > 
> > > I don't think you can drop the patch. process_vm_rw_pages() clearly touches
> > > page contents and does not synchronize with page_mkclean(). So it is case
> > > 1) and needs FOLL_PIN semantics.
> > 
> > John could you send a formal patch using vaddr_pin* and I'll add it to the
> > tree?
> > 
> 
> Yes...hints about which struct file to use here are very welcome, btw. This part
> of mm is fairly new to me.

I'm still working out the final semantics of vaddr_pin*.  But right now you
don't need a vaddr_pin if you don't specify FOLL_LONGTERM.

Since case 1, this case, does not need FOLL_LONGTERM I think it is safe to
simply pass NULL here.

OTOH we could just track this against the mm_struct.  But I don't think we need
to because this pin should be transient.

And this is why I keep leaning toward _not_ putting these flags in the
vaddr_pin*() calls.  I know this is what I did but I think I'm wrong.  It should
be the caller specifying what they want and the vaddr_pin*() calls check that
what they are asking for is correct.

Ira

> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
