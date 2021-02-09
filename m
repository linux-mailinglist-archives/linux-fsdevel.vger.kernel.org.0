Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7A31587F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 22:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhBIVTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 16:19:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:22566 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234124AbhBIUxi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:53:38 -0500
IronPort-SDR: wXZJmMZuNFYMuHRECnobejEZvEfXhwNGwiR+7sZfb+p06VN2YlBzmUkLjXBY60BI5v8OiUba11
 EkLwZQr+OGkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182102420"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="182102420"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 12:52:49 -0800
IronPort-SDR: yezsVp5N+8knykoCLGY5c2hMEgzC12uwFnlTvlqcAon3dZuYKbYPv77VuV/b7LkpZI9mfORaxr
 pSjFl7e5AMiQ==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="412338007"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 12:52:49 -0800
Date:   Tue, 9 Feb 2021 12:52:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-ID: <20210209205249.GB2975576@iweiny-DESK2.sc.intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
 <20210209151123.GT1993@suse.cz>
 <20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:09:31AM -0800, Andrew Morton wrote:
> On Tue, 9 Feb 2021 16:11:23 +0100 David Sterba <dsterba@suse.cz> wrote:
> 
> > On Fri, Feb 05, 2021 at 03:23:00PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > There are many places where kmap/<operation>/kunmap patterns occur.  We lift
> > > these various patterns to core common functions and use them in the btrfs file
> > > system.  At the same time we convert those core functions to use
> > > kmap_local_page() which is more efficient in those calls.
> > > 
> > > I think this is best accepted through Andrew's tree as it has the mem*_page
> > > functions in it.  But I'd like to get an ack from David or one of the other
> > > btrfs maintainers before the btrfs patches go through.
> > 
> > I'd rather take the non-mm patches through my tree so it gets tested
> > the same way as other btrfs changes, straightforward cleanups or not.
> > 
> > This brings the question how to do that as the first patch should go
> > through the MM tree. One option is to posptpone the actual cleanups
> > after the 1st patch is merged but this could take a long delay.
> > 
> > I'd suggest to take the 1st patch within MM tree in the upcoming merge
> > window and then I can prepare a separate pull with just the cleanups.
> > Removing an inter-tree patch dependency was a sufficient reason for
> > Linus in the past for such pull requests.
> 
> It would be best to merge [1/4] via the btrfs tree.  Please add my
> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> 
> 
> Although I think it would be better if [1/4] merely did the code
> movement.  Adding those BUG_ON()s is a semantic/functional change and
> really shouldn't be bound up with the other things this patch series
> does.

I proposed this too and was told 'no'...

<quote>
If we put in into a separate patch, someone will suggest backing out the
patch which tells us that there's a problem.
</quote>
	-- https://lore.kernel.org/lkml/20201209201415.GT7338@casper.infradead.org/

> This logically separate change raises questions such as
> 
> - What is the impact on overall code size?  Not huge, presumably, but
>   every little bit hurts.
> 
> - Additional runtime costs of those extra comparisons?
> 
> - These impacts could be lessened by using VM_BUG_ON() rather than
>   BUG_ON() - should we do this?

<sigh>  I lost that argument last time around.

<quote>
BUG() is our only option here.  Both limiting how much we copy or
copying the requested amount result in data corruption or leaking
information to a process that isn't supposed to see it.
</quote>

https://lore.kernel.org/lkml/20201209040312.GN7338@casper.infradead.org/

CC'ing Matthew because I _really_ don't want to argue this any longer.

> 
> - Linus reeeeeeeally doesn't like new BUG_ON()s.  Maybe you can sneak
>   it past him ;)

I'm worried too...  :-(

> 
> See what I mean?

Yes I do however ...  see above...  :-/

Ira

> I do think it would be best to take those assertions
> out of the patch and to propose them separately, at a later time.
> 
