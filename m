Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7689C7A9A51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjIUSiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjIUShl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:37:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181CDAE96F;
        Thu, 21 Sep 2023 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5JQjYlFnwxrhcfHqWw60RsFGqSkwN1XUouvFVD0EJfc=; b=RScI/c/GkXbCF4dJBoZpg+Q8j9
        vwH+a3Qh76zavs8//B94a3Mcg5/hAZK3d8b4bHRobDld6DAv+pb63hgWh1vRlKYXk8LA+uUx6A1R3
        ZeZDqHLogNmIcYhfNzWCzZulQwArVy+xDLLA3w8v992UU1Qx9Ep1XGz947HiWGBKzhpAc6nRG0ICZ
        3d/u2v5XeaHmscFTmkRxv8YxftoIW2bFoYkq38PLSR/s8QI2ceV58xuN4V+TTnfSmc/3sSbLm4Dut
        FVkaYf8LUpTY5iGEnKr0Q656BX9olDKH3J4sH/lRvdpAv49O5YGL8FbzAFNu9+G8jwvrp4prBcdvB
        t19YSvcA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qjDwz-005MFV-0W;
        Thu, 21 Sep 2023 07:18:13 +0000
Date:   Thu, 21 Sep 2023 00:18:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Pankaj Raghav <kernel@pankajraghav.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com, riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQvuNaYIukAnlEDM@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <ZQd4IPeVI+o6M38W@dread.disaster.area>
 <ZQewKIfRYcApEYXt@bombadil.infradead.org>
 <CGME20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8@eucas1p1.samsung.com>
 <ZQfbHloBUpDh+zCg@dread.disaster.area>
 <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
 <ZQuxvAd2lxWppyqO@bombadil.infradead.org>
 <ZQvNVAfZMjE3hgmN@bombadil.infradead.org>
 <ZQvczBjY4vTLJFBp@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQvczBjY4vTLJFBp@dread.disaster.area>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 04:03:56PM +1000, Dave Chinner wrote:
> On Wed, Sep 20, 2023 at 09:57:56PM -0700, Luis Chamberlain wrote:
> > On Wed, Sep 20, 2023 at 08:00:12PM -0700, Luis Chamberlain wrote:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=large-block-linus
> > > 
> > > I haven't tested yet the second branch I pushed though but it applied without any changes
> > > so it should be good (usual famous last words).
> > 
> > I have run some preliminary tests on that branch as well above using fsx
> > with larger LBA formats running them all on the *same* system at the
> > same time. Kernel is happy.

<-- snip -->

> So I just pulled this, built it and run generic/091 as the very
> first test on this:
> 
> # ./run_check.sh --mkfs-opts "-m rmapbt=1 -b size=64k" --run-opts "-s xfs_64k generic/091"

The cover letter for this patch series acknowledged failures in fstests.

For kdevops now, we borrow the same last linux-next baseline:

git grep "generic/091" workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev
workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev/xfs/unassigned/xfs_reflink_1024.txt:generic/091 # possible regression
workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev/xfs/unassigned/xfs_reflink_16k.txt:generic/091
workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev/xfs/unassigned/xfs_reflink_32k.txt:generic/091
workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev/xfs/unassigned/xfs_reflink_64k_4ks.txt:generic/091

So well, we already know this fails.

> For all these assertions about how none of your testing is finding
> bugs in this code, It's taken me *4 seconds* of test runtime to find
> the first failure.

Because you know what to look for and this is not yet perfect.

> And, well, it's the same failure as I reported for the previous
> version of this code:

And we haven't done *any* new changes to the patch series so no surprise
either.

> Guess what? The fsx parameters being used means it is testing things you
> aren't.

I actualy found quite a bit of issues with -W. And it was useful.

> Yes, the '-Z -R -W' mean it is using direct IO for reads and writes,
> mmap() is disabled. Other parameters indicate that using 4k aligned reads and
> 512 byte aligned writes and truncates.

Thanks! This will help for sure!.

> There is a reason there are multiple different fsx tests in fstests;

You made it clear, and I documented the goal to ensure we get to the
point we pass all those:

https://kernelnewbies.org/KernelProjects/large-block-size#fsx

> they all exercise different sets of IO behaviours and alignments,
> and they exercise the IO paths differently.
> 
> So there's clearly something wrong here - it's likely that the
> filesystem IO alignment parameters pulled from the underlying block
> device (4k physical, 512 byte logical sector sizes) are improperly
> interpreted.  i.e. for a filesystem with a sector size of 4kB,
> direct IO with an alignment of 512 bytes should be rejected......

So yes, this is not yet complete.

But now let's step back and I want you to realize where we started
and why we decided to post, in particular me, I was suggesting we
post now, instead of waiting for us to resolve *it all*.

When we first started this work we simply thought it was impossible.
Unless of course you are Matthew and you believed hard in your work.

The progress, which you don't see, is that steps towards fixing fsx
issues have been logarithmic. Days, weeks, months before decent
progress, but the progress was steady...

And so to get to where we are today only just shows, well this is
actually not impossible, and Matthew did the right thing with the
right data structure, and the changes to the page cache with multi
index array stuff, it seems to be able to also be used for LBS.

At this point, from a logarithmic perspective, we have huge progress,
and I don't think it will stop. It gives us confidence Matthew was
right and LBS is possible indeed with the multi-index stuff.

It's not about, can this crash. Yes, we know, it can crash. It's about
how many different ways, and how many fixes left. Because clearly the
multi-index stuff is working well. The code feedback so far on this
patch series has mostly been "I don't think this patch is needed" or
"perhaps this way is better", and that's the kind of feedback we're
looking for. Because *each* new patch adds a huge a milestone. And
it seems the progress has been logarithmic. It is exactly why this
series went out with a few patches which ... we felt safer with them
than without. For instance the batch delete.. I still am suspicious
about us not needing as Hannes' patches also seem to rely on similer
rounding on the wait stuff, and it seems to bring back memories
on issues found on permissions. But anyway, the point is that, this
is clearly not ready. But try to think of progress here as logarithmic,
and any *dent* we make on the page cache to fix the last corner cases
will be huge, not small.

If you want to try, you can see for yourself, what's the next fix? :)
And if found, was it logarithmic? How do we polish this? That's the
goal of this patch series.

  Luis
