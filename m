Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43D1904DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfHPPlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 11:41:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbfHPPlK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:41:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5584DAD0F;
        Fri, 16 Aug 2019 15:41:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B6F151E4009; Fri, 16 Aug 2019 17:41:08 +0200 (CEST)
Date:   Fri, 16 Aug 2019 17:41:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190816154108.GE3041@quack2.suse.cz>
References: <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
 <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
 <20190815173237.GA30924@iweiny-DESK2.sc.intel.com>
 <b378a363-f523-518d-9864-e2f8e5bd0c34@nvidia.com>
 <58b75fa9-1272-b683-cb9f-722cc316bf8f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b75fa9-1272-b683-cb9f-722cc316bf8f@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-08-19 19:14:08, John Hubbard wrote:
> On 8/15/19 10:41 AM, John Hubbard wrote:
> > On 8/15/19 10:32 AM, Ira Weiny wrote:
> >> On Thu, Aug 15, 2019 at 03:35:10PM +0200, Jan Kara wrote:
> >>> On Thu 15-08-19 15:26:22, Jan Kara wrote:
> >>>> On Wed 14-08-19 20:01:07, John Hubbard wrote:
> >>>>> On 8/14/19 5:02 PM, John Hubbard wrote:
> ...
> >> Ok just to make this clear I threw up my current tree with your patches here:
> >>
> >> https://github.com/weiny2/linux-kernel/commits/mmotm-rdmafsdax-b0-v4
> >>
> >> I'm talking about dropping the final patch:
> >> 05fd2d3afa6b rdma/umem_odp: Use vaddr_pin_pages_remote() in ODP
> >>
> >> The other 2 can stay.  I split out the *_remote() call.  We don't have a user
> >> but I'll keep it around for a bit.
> >>
> >> This tree is still WIP as I work through all the comments.  So I've not changed
> >> names or variable types etc...  Just wanted to settle this.
> >>
> > 
> > Right. And now that ODP is not a user, I'll take a quick look through my other
> > call site conversions and see if I can find an easy one, to include here as
> > the first user of vaddr_pin_pages_remote(). I'll send it your way if that
> > works out.
> > 
> 
> OK, there was only process_vm_access.c, plus (sort of) Bharath's sgi-gru
> patch, maybe eventually [1].  But looking at process_vm_access.c, I think 
> it is one of the patches that is no longer applicable, and I can just
> drop it entirely...I'd welcome a second opinion on that...

I don't think you can drop the patch. process_vm_rw_pages() clearly touches
page contents and does not synchronize with page_mkclean(). So it is case
1) and needs FOLL_PIN semantics.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
