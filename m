Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FDAA46B1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 03:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfIABH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 21:07:28 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54233 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbfIABH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 21:07:28 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3970A361D0B;
        Sun,  1 Sep 2019 11:07:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i4EKv-0003RF-5v; Sun, 01 Sep 2019 11:07:21 +1000
Date:   Sun, 1 Sep 2019 11:07:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190901010721.GG7777@dread.disaster.area>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <295233.1567247121@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=J70Eh1EUuV4A:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=HHdat0QAHIJCkpzJUFMA:9
        a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 06:25:21AM -0400, Valdis Klētnieks wrote:
> On Fri, 30 Aug 2019 23:46:16 -0700, Christoph Hellwig said:
> > Since when did Linux kernel submissions become "show me a better patch"
> > to reject something obviously bad?
> 
> Well, do you even have a *suggestion* for a better idea?  Other than "just rip
> it out"?  Keeping in mind that:
> 
> > As I said the right approach is to probably (pending comments from the
> > actual fat maintainer) to merge exfat support into the existing fs/fat/
> > codebase.  You obviously seem to disagree (and at the same time not).
> 
> At this point, there isn't any true consensus on whether that's the best
> approach at the current.

Which, quite frankly, means it has been merged prematurely.

Valdis - the model for getting a new filesystem merged is the one
taken by Orangefs. That was not merged through the staging tree,
it was reviewd via patches to linux-fsdevel that were iterated far
faster than the stable merge cycle allows, allowed all the cleanups
to be done independently of the feature work needed, the structural
changes we easy to discuss, quote, etc.

These are the sorts of problems we are having with EROFS right now,
even though it's been in staging for some time, and it's clear we
are already having them with exfat - fundamental architecture issues
have not yet been decided, and so there's likely major structural
change yet to be done.

That's stuff that is much more easily done and reveiwed by patches
on a mailing list. You don't need the code in the staging tree to
get this sort of thing done and, really, having it already merged
gets in the way of doing major structural change as it cannot be
rapidly iterated independently of the kernel dev cycle...

So when Christoph say:

> "Just rip it out"

what he is really saying is that Greg has jumped the jump and is -
yet again - fucking over filesystem developers because he's
taken the review process for a new filesystem out of hands _yet
again_.

He did this with POHMELFS, then Lustre, then EROFS - they all got
merged into stable over the objections of senior filesystem
developers.  The first two were an utter disaster, the latter is
rapidly turning into one.

You wanted a "show me a better patch" response from Christoph. What
he actually is saying is "we've got a better process for reviewing
and merging filesystems". That is, we need to reboot the exfat
process from the start - sort out the fundamental implementation
direction and then implement via the normal out-of-tree patch series
iteration process.

That's the fundamental problem here - we have a rogue maintainer
that is abusing their power by subverting our normal review and
merge process. I don't know (or care) what motive that maintainer
has for expedited merging of this filesystem, but history tells us
it _will_ result in a total clusterfuck in the near future. In fact,
I'd argue that the clusterfuck has already arrived....

> And by the way, it seems like other filesystems rely on "others" to help out.
> Let's look at the non-merge commit for fs/ext4. And these are actual patches,
> not just reviewer comments....

Totally irrelevant to the issue at hand. You can easily co-ordinate
out of tree contributions through a github tree, or a tree on
kernel.org, etc.

Being in the staging tree does not get you more robust review -
it'll just delay it until someone wants it out of the staging tree,
and then you'll get all the same issues with experienced filesystem
developer review as you are getting now.

That's the choice you have to make now: listen to the reviewers
saying "resolve the fundamental issues before goign any further",
or you can ignore that and have it rejected after another year of
work because the fundamental issues haven't been resolved while it
sits in staging....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
