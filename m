Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F366F33C95D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 23:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhCOW1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 18:27:45 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47511 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231969AbhCOW1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:27:16 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2A868828671;
        Tue, 16 Mar 2021 09:27:09 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lLvg4-002xIa-IE; Tue, 16 Mar 2021 09:27:08 +1100
Date:   Tue, 16 Mar 2021 09:27:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <20210315222708.GA349301@dread.disaster.area>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
 <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
 <20210315115501.7rmzaan2hxsqowgq@box>
 <YE9VLGl50hLIJHci@dhcp22.suse.cz>
 <20210315190904.GB150808@infradead.org>
 <20210315194014.GZ2577561@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315194014.GZ2577561@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8
        a=22_hVACOjlP6-iFW9EAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:40:14PM +0000, Matthew Wilcox wrote:
> I would agree that the conversion is both straightforward and noisy.
> There are some minor things that crop up, like noticing that we get
> the accounting wrong for writeback of compound pages.  That's not
> entirely unexpected since no filesystem supports both compound pages
> and writeback today.

And this is where the abstraction that the "folio" introduces is
required - filesystem people don't want to have to deal with all the
complexity and subtlety of compound pages when large page support is
added to the page cache. As Willy says, this will be a never-ending
source of data corruption bugs....

Hence from the filesystem side of things, I think this abstraction
is absolutely necessary. Especially because handling buffered IO in
4kB pages really, really sucks from a performance persepctive and
the sooner we have native high-order page support in the page cache
the better.  These days buffered IO often can't even max out a cheap
NVMe SSD because of the CPU cost of per-page state management in the
page cache. So the sooner we have large page support to mitigate the
worst of the overhead for streaming buffered IO, the better.

FWIW, like others, I'm not a fan of "folio" as a name, but I can live
with it because it so jarringly different to "pages" that we're not
going to confuse the two of them. But if we want a better name, my
suggestion would be for a "struct cage" as in Compound pAGE....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
