Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA58BFE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfHMRqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 13:46:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:46814 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfHMRqh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:46:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 10:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="351604440"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2019 10:46:35 -0700
Date:   Tue, 13 Aug 2019 10:46:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
Message-ID: <20190813174635.GC11882@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-16-ira.weiny@intel.com>
 <20190812122814.GC24457@ziepe.ca>
 <20190812214854.GF20634@iweiny-DESK2.sc.intel.com>
 <20190813114706.GA29508@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813114706.GA29508@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:47:06AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2019 at 02:48:55PM -0700, Ira Weiny wrote:
> > On Mon, Aug 12, 2019 at 09:28:14AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 09, 2019 at 03:58:29PM -0700, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > The addition of FOLL_LONGTERM has taken on additional meaning for CMA
> > > > pages.
> > > > 
> > > > In addition subsystems such as RDMA require new information to be passed
> > > > to the GUP interface to track file owning information.  As such a simple
> > > > FOLL_LONGTERM flag is no longer sufficient for these users to pin pages.
> > > > 
> > > > Introduce a new GUP like call which takes the newly introduced vaddr_pin
> > > > information.  Failure to pass the vaddr_pin object back to a vaddr_put*
> > > > call will result in a failure if pins were created on files during the
> > > > pin operation.
> > > 
> > > Is this a 'vaddr' in the traditional sense, ie does it work with
> > > something returned by valloc?
> > 
> > ...or malloc in user space, yes.  I think the idea is that it is a user virtual
> > address.
> 
> valloc is a kernel call

Oh...  I thought you meant this: https://linux.die.net/man/3/valloc

> 
> > So I'm open to suggestions.  Jan gave me this one, so I figured it was safer to
> > suggest it...
> 
> Should have the word user in it, imho

Fair enough...

user_addr_pin_pages(void __user * addr, ...) ?

uaddr_pin_pages(void __user * addr, ...) ?

I think I like uaddr...

> 
> > > I also wish GUP like functions took in a 'void __user *' instead of
> > > the unsigned long to make this clear :\
> > 
> > Not a bad idea.  But I only see a couple of call sites who actually use a 'void
> > __user *' to pass into GUP...  :-/
> > 
> > For RDMA the address is _never_ a 'void __user *' AFAICS.
> 
> That is actually a bug, converting from u64 to a 'user VA' needs to go
> through u64_to_user_ptr().

Fair enough.

But there are a lot of call sites throughout the kernel who have the same
bug...  I'm ok with forcing u64_to_user_ptr() to use this new call if others
are.

Ira

