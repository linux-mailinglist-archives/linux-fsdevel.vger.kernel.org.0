Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9B31556E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhBIRxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 12:53:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:1742 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhBIRqg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:46:36 -0500
IronPort-SDR: AXfPJ7V6nCorbEHCpHcHImBnBMBjMtqRAnXYUbwESAYBvkUzNI+UW8DUamalFuf71GM8tbWfG/
 OgMb8hz/ebsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169605022"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="169605022"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 09:45:52 -0800
IronPort-SDR: cstN+t582r4QSCiqGpuCWcmu2AIhfPCuUlkZcqz99fTbbBQR1ZfiIxsYi2jzjx7ijO3Md44Byc
 9EZch06X0gsw==
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="375040816"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 09:45:52 -0800
Date:   Tue, 9 Feb 2021 09:45:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, Andrew Morton <akpm@linux-foundation.org>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-ID: <20210209174551.GA2975576@iweiny-DESK2.sc.intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
 <20210209151123.GT1993@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209151123.GT1993@suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:11:23PM +0100, David Sterba wrote:
> On Fri, Feb 05, 2021 at 03:23:00PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > There are many places where kmap/<operation>/kunmap patterns occur.  We lift
> > these various patterns to core common functions and use them in the btrfs file
> > system.  At the same time we convert those core functions to use
> > kmap_local_page() which is more efficient in those calls.
> > 
> > I think this is best accepted through Andrew's tree as it has the mem*_page
> > functions in it.  But I'd like to get an ack from David or one of the other
> > btrfs maintainers before the btrfs patches go through.
> 
> I'd rather take the non-mm patches through my tree so it gets tested
> the same way as other btrfs changes, straightforward cleanups or not.

True.

> 
> This brings the question how to do that as the first patch should go
> through the MM tree. One option is to posptpone the actual cleanups
> after the 1st patch is merged but this could take a long delay.
> 
> I'd suggest to take the 1st patch within MM tree in the upcoming merge
> window and then I can prepare a separate pull with just the cleanups.
> Removing an inter-tree patch dependency was a sufficient reason for
> Linus in the past for such pull requests.

There are others how want this base patch too.[1]  So I like this option.

>
> > There are a lot more kmap->kmap_local_page() conversions but kmap_local_page()
> > requires some care with the unmapping order and so I'm still reviewing those
> > changes because btrfs uses a lot of loops for it's kmaps.
> 
> It sounds to me that converting the kmaps will take some time anyway so
> exporting the helpers first and then converting the subsystems might be
> a good option. In case you'd like to get rid of the simple cases in
> btrfs code now we can do the 2 pull requests.

I would really like to get the simple case out of the way because the next
series has more difficult changes and the simple cases always cause me trouble
when grepping/coccinelle'ing for things.

So I would like a follow on pull request if possible.  But I'm willing to do
what works best for you.

For now I will spin a new version with the changes you've requested ASAP.

Ira

[1] https://lore.kernel.org/linux-f2fs-devel/20210207190425.38107-1-chaitanya.kulkarni@wdc.com/

