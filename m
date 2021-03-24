Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F848347FA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 18:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbhCXRj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 13:39:58 -0400
Received: from verein.lst.de ([213.95.11.211]:38051 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237143AbhCXRjl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:39:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1520C68BEB; Wed, 24 Mar 2021 18:39:36 +0100 (CET)
Date:   Wed, 24 Mar 2021 18:39:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Message-ID: <20210324173935.GB12770@lst.de>
References: <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com> <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com> <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com> <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com> <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com> <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com> <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com> <CAPcyv4jhUU3NVD8HLZnJzir+SugB6LnnrgJZ-jP45BZrbJ1dJQ@mail.gmail.com> <20210324074751.GA1630@lst.de> <CAPcyv4hOrYCW=wjkxkCP+JbyD+A_Po0rW-61qQWAOm3zp_eyUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hOrYCW=wjkxkCP+JbyD+A_Po0rW-61qQWAOm3zp_eyUQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 09:37:01AM -0700, Dan Williams wrote:
> > Eww.  As I said I think the right way is that the file system (or
> > other consumer) can register a set of callbacks for opening the device.
> 
> How does that solve the problem of the driver being notified of all
> pfn failure events?

Ok, I probably just showed I need to spend more time looking at
your proposal vs the actual code..

Don't we have a proper way how one of the nvdimm layers own a
spefific memory range and call directly into that instead of through
a notifier?

> Today pmem only finds out about the ones that are
> notified via native x86 machine check error handling via a notifier
> (yes "firmware-first" error handling fails to do the right thing for
> the pmem driver),

Did any kind of firmware-first error handling ever get anything
right?  I wish people would have learned that by now.

> or the ones that are eventually reported via address
> range scrub, but only for the nvdimms that implement range scrubbing.
> memory_failure() seems a reasonable catch all point to route pfn
> failure events, in an arch independent way, to interested drivers.

Yeah.

> I'm fine swapping out dax_device blocking_notiier chains for your
> proposal, but that does not address all the proposed reworks in my
> list which are:
> 
> - delete "drivers/acpi/nfit/mce.c"
> 
> - teach memory_failure() to be able to communicate range failure
> 
> - enable memory_failure() to defer to a filesystem that can say
> "critical metadata is impacted, no point in trying to do file-by-file
> isolation, bring the whole fs down".

This all sounds sensible.
