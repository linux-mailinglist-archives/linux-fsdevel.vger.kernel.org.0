Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B62AA4C7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 00:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfIAWng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 18:43:36 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:49409 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728942AbfIAWng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 18:43:36 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 251FA3610F5;
        Mon,  2 Sep 2019 08:43:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i4YZF-00035I-RZ; Mon, 02 Sep 2019 08:43:29 +1000
Date:   Mon, 2 Sep 2019 08:43:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190901224329.GH7777@dread.disaster.area>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
 <20190901010721.GG7777@dread.disaster.area>
 <339527.1567309047@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <339527.1567309047@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=J70Eh1EUuV4A:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=K2SI45MAujIxdphGjPIA:9
        a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 11:37:27PM -0400, Valdis Klētnieks wrote:
> On Sun, 01 Sep 2019 11:07:21 +1000, Dave Chinner said:
> > Totally irrelevant to the issue at hand. You can easily co-ordinate
> > out of tree contributions through a github tree, or a tree on
> > kernel.org, etc.
> 
> Well.. I'm not personally wedded to the staging tree.  I'm just interested in
> getting a driver done and upstreamed with as little pain as possible. :)

Understood - I'm trying to head off you guys getting delayed
by sitting for a year in the staging tree polishing a turd and not
addressing the things that really need to be done first...

> Is there any preference for github versus kernel.org?  I can set up a github
> tree on my own, no idea who needs to do what for a kernel.org tree.

What ever is most convenient for you to manage and co-ordinate. :P

> Also, this (from another email of yours) was (at least to me) the most useful
> thing said so far:
> 
> > look at what other people have raised w.r.t. to that filesystem -
> > on-disk format validation, re-implementation of largely generic
> > code, lack of namespacing of functions leading to conflicts with
> > generic/VFS functionality, etc.
> 
> All of which are now on the to-do list, thanks.
> 
> Now one big question:
> 
> Should I heave all the vfat stuff overboard and make a module that
> *only* does exfat, or is there enough interest in an extended FAT module
> that does vfat and extfat, in which case the direction should be to re-align
> this module's code with vfat?

I don't know the details of the exfat spec or the code to know what
the best approach is. I've worked fairly closely with Christoph for
more than a decade - you need to think about what he says rather
than /how he says it/ because there's a lot of thought and knowledge
behind his reasoning. Hence if I were implementing exfat and
Christoph was saying "throw it away and extend fs/fat"
then that's what I'd be doing.

A lot of this is largely risk management - there's a good chance
that the people developing the code move on after the project is
done and merged, which leaves the people like Christoph with the
burden of long term code maintenance for that filesystem. There's
enough crusty, old, largely unmaintained filesystem code already,
and we don't want more. Implementing exfat on top of fs/fat kills
two birds with one stone - it modernises the fs/fat code base and
brings new functionality that will have more developers interested
in maintaining it over the long term. So from an overall filesystem
maintenance perspective, building on top of fs/fat makes a lot of
sense to a kernel filesystem developer...

This is not a judgement on the quality of the existing exfat code
or it's developers - it's just that there are very good reasons for
building on existing codebase rather than creating a whole new code
base that has very similar functionality.

That's my total involvement in this - I don't really care about
exfat at all - my stake in this is to improve the development,
review and merge process being undertaken. We have a history of lax
review, poor processes and really shitty code being merged into the
kernel and I've been on the cleanup squad for a few of them over the
past couple of years. That's a burnout vector, so it's in the
interests of my own sanity (and fs developers) to set standards and
precedence to prevent more trainwrecks from happening before the
train even leaves the station...

> > That's the choice you have to make now: listen to the reviewers
> > saying "resolve the fundamental issues before goign any further",
> 
> Well... *getting* a laundry list of what the reviewers see as the fundamental
> issues is the first step in resolving them ;)

You won't get them all at once. You'll get something new every round
of review as the bigger issues are worked out, the reviewers become
more familiar with the code and notice more detailed/subtle
issues. Most filesystem reviews start with developers trying to
understand the on-disk structure and architecture rather that focus
on whitespace and code cleanliness. Cleaning up the code can be done
after we work through all the structural issues...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
