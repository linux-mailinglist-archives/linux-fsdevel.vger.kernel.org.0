Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760212D9232
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 05:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438516AbgLNEHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 23:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLNEHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 23:07:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 20:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VRzOgK0YMQEO96+YLXvBYkoUdZ7djKezc8JpMLLul1o=; b=NfIvCb2u4JyXvCeydfdxzZGK9Y
        CQGKZiQp0JCRK/CxLw2OZbJIb4/7+8Gql2WCp790BPB35U36v3NiDxrzXF+7eHbN66DHtJSzOMLkI
        n9TotZbwPS9lzoe1Nq3F7hVEnt+2p9nRan0Xlb1UXLzGhzLxytMPo5CPX1IziL5MsjEubwi78RDHI
        2G7Cx2dMAnAzMccyqe2TFk8V6SGTkwj1w5PQJSQt8844sQay/uvAhcVefZXAGN+Wi7gVvNAli/xpa
        KgnhEqb68oWbgzHzz6lQLV1Wcl16SIw8JS2icY7x7FsIfkvkRsMA+1nQR/BfsGTWA0fNHV/rsMKoq
        L5TDmXyw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kof8Z-0006Vo-U3; Mon, 14 Dec 2020 04:07:04 +0000
Date:   Mon, 14 Dec 2020 04:07:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcapsc@gmail.com>
Subject: Re: "do_copy_range:: Invalid argument"
Message-ID: <20201214040703.GJ2443@casper.infradead.org>
References: <CAOg9mSSCsPPYpHGAWVHoY5bO8DozzFNWXTi39XBc+GhDmWcRTA@mail.gmail.com>
 <20201214030552.GI3913616@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214030552.GI3913616@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:05:52PM +1100, Dave Chinner wrote:
> On Fri, Dec 11, 2020 at 11:26:28AM -0500, Mike Marshall wrote:
> > Greetings everyone...
> > 
> > Omnibond has sent me off doing some testing chores lately.
> > I made no Orangefs patches for 5.9 or 5.10 and none were sent,
> > but I thought I should at least run through xfstests.
> > 
> > There are tests that fail on 5.10-rc6 that didn't fail
> > on 5.8-rc7, and I've done enough looking to see that the
> > failure reasons all seem related.
> > 
> > I will, of course, keep looking to try and understand these
> > failures. Bisection might lead me somewhere. In case the
> > notes I've taken so far trigger any of y'all to give me
> > any (constructive :-) ) suggestions, I've included them below.
> > 
> > -Mike
> > 
> > ---------------------------------------------------------------------
> > 
> > generic/075
> >   58rc7: ? (check.log says it ran, results file missing)
> >   510rc6: failed, "do_copy_range:: Invalid argument"
> >           read the tests/generic/075 commit message for "detect
> >           preallocation support for fsx tests"
> > 
> > generic/091
> >   58rc7: passed, but skipped fallocate parts "filesystem does not support"
> >   510rc6: failed, "do_copy_range:: Invalid argument"
> > 
> > generic/112
> >   58rc7: ? (check.log says it ran, results file missing)
> >   510rc6: failed, "do_copy_range:: Invalid argument"
> > 
> > generic/127
> >   58rc7: ? (check.log says it ran, results file missing)
> >   510rc6: failed, "do_copy_range:: Invalid argument"
> > 
> > generic/249
> >   58rc7: passed
> >   510rc6: failed, "sendfile: Invalid argument"
> >           man 2 sendfile -> "SEE ALSO copy_file_range(2)"
> 
> If sendfile() failed, then it's likely a splice related regression,
> not a copy_file_range() problem. The VFS CFR implementation falls
> back to splice if the fs doesn't provide a clone or copy offload
> method.
> 
> THere's only been a handful of changes to fs/splice.c since 5.8rc7,
> so it might be worth doing a quick check reverting them first...

I'd suggest applying the equivalent of
https://lore.kernel.org/linux-fsdevel/1606837496-21717-1-git-send-email-asmadeus@codewreck.org/
would be the first step.
