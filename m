Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC13E5411
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhHJHDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 03:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237078AbhHJHDR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:03:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A79C60EE7;
        Tue, 10 Aug 2021 07:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628578975;
        bh=dlyaGMkmrRVtNmpE5IsBsQyShzGREegfZIgn+7SmWa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjLTBNeBv8UphLagoTZeiqOCjKAGAbVXB6hKGU4WNNFmOMmsyycmHRTVDkVR4uHxg
         U2SxurRtG+pUNxpTyq/nxLg2SW/RSvzUEV6mLw8iFgagsRMzxkbWNsWdhBH+sb9I2K
         VOG5EaZ/nBmwEP51mmDhL6eAMeKMzcqez3O0UWxlUvJzLrw0/tliRdxH8+WH40EWIJ
         PCuUcQoC/QglWB/bpd0eggh8FOiD1jeEbeVl2uvejGHxYPNQsG6KoqE4p9bSiXTH6D
         CpEW9e8hHZJQOsZ2XkgCwKaum4PIYhQ8jZBHx/MvIROqii/Sn3lDo0KsBq0nZYJARA
         cEGPSFbhkL1Kg==
Date:   Tue, 10 Aug 2021 00:02:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <20210810070255.GJ3601405@magnolia>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu>
 <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu>
 <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
 <YQnkGMxZCgCWXQPf@mit.edu>
 <20210804010351.GM3601466@magnolia>
 <0e175373cef24e2abe76e203bb36d260@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e175373cef24e2abe76e203bb36d260@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 03:48:36PM +0000, Konstantin Komarov wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > Sent: Wednesday, August 4, 2021 4:04 AM
> > To: Theodore Ts'o <tytso@mit.edu>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>; Matthew Wilcox <willy@infradead.org>; Leonidas P. Papadakos
> > <papadakospan@gmail.com>; Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; zajec5@gmail.com; Greg Kroah-
> > Hartman <gregkh@linuxfoundation.org>; Hans de Goede <hdegoede@redhat.com>; linux-fsdevel <linux-fsdevel@vger.kernel.org>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Al Viro <viro@zeniv.linux.org.uk>
> > Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
> > 
> > On Tue, Aug 03, 2021 at 08:49:28PM -0400, Theodore Ts'o wrote:
> > > On Tue, Aug 03, 2021 at 05:10:22PM -0700, Linus Torvalds wrote:
> > > > The user-space FUSE thing does indeed work reasonably well.
> > > >
> > > > It performs horribly badly if you care about things like that, though.
> > > >
> > > > In fact, your own numbers kind of show that:
> > > >
> > > >   ntfs/default: 670 tests, 55 failures, 211 skipped, 34783 seconds
> > > >   ntfs3/default: 664 tests, 67 failures, 206 skipped, 8106 seconds
> > > >
> > > > and that's kind of the point of ntfs3.
> > >
> > > Sure, although if you run fstress in parallel ntfs3 will lock up, the
> > > system hard, and it has at least one lockdep deadlock complaints.
> > > It's not up to me, but personally, I'd feel better if *someone* at
> > > Paragon Software responded to Darrrick and my queries about their
> > > quality assurance, and/or made commitments that they would at least
> > > *try* to fix the problems that about 5 minutes of testing using
> > > fstests turned up trivially.
> > 
> > <cough> Yes, my aim was to gauge their interest in actively QAing the
> > driver's current problems so that it doesn't become one of the shabby
> > Linux filesystem drivers, like <cough>ntfs.
> > 
> > Note I didn't even ask for a particular percentage of passing tests,
> > because I already know that non-Unix filesystems fail the tests that
> > look for the more Unix-specific behaviors.
> > 
> > I really only wanted them to tell /us/ what the baseline is.  IMHO the
> > silence from them is a lot more telling.  Both generic/013 and
> > generic/475 are basic "try to create files and read and write data to
> > them" exercisers; failing those is a red flag.
> > 
> 
> Hi Darrick and Theodore! First of all, apologies for the silence on your questions.
> Let me please clarify and summarize the QA topic for you.
> 
> The main thing to outline is that: we have the number of autotests executed
> for ntfs3 code. More specifically, we are using TeamCity as our CI tool, which
> is handling autotests. Those are being executed against each commit to the
> ntfs3 codebase.
> 
> Autotests are divided into the "promotion" levels, which are quite standard:
> L0, L1, L2. Those levels have the division from the shortest "smoke" (L0)
> to the longest set (L2). This we need to cover the ntfs3 functionality with
> tests under given amount of time (feedback loop for L0 is minutes, while for
> L2 is up to 24hrs).

Sounds comparable to my setup, which has these tiers:

fstests -g quick (~45 minutes) on fast ssds
fstests -g all (~3 hours) on fast ssds
fstests -g all (~12 hours) on slow(er) cheap(er) cloud storage
fstests -g long_soak (~7 days) on aging ssds

(There's also the fifth tier which is spawning dozens of VMs to fuzz
test, but I don't have enough spare time to run that and triage the
results on a regular basis.)

> As for suites we are using - it is the mix of open/well known suites:
> - xfstests, ltp, pjd suite, fsx, dirstress, fstorture - those are of known utilites/suites
> And number of internal autotests which were developed for covering various parts of
> fs specs, regression autotests which are introduced to the infrastructure after bugfixes
> and autotests written to test the driver operation on various data sets.
> 
> This approach is settled in Paragon for years, and ntfs3, from the first line of code written,
> is being developed this way. You may refer the artifacts linked below, where the progress/coverage
> during the last year is spoken by autotest results:
> 
> the 27th patch-series code (July'2021): 
> https://dl.paragon-software.com/ntfs3/p27_tests.tar
> 25th (March'2021):
> https://dl.paragon-software.com/ntfs3/p25_tests.tar
> 2nd (August, 2020):
> https://dl.paragon-software.com/ntfs3/p2_tests.tar
> 
> Those are results on ntfs3 ran within the 'linux-next' (the most recent one given the tests start date)
> As may be observed, we never skipped the "tests day" :)
> 
> There is a note should be provided on xfstests specifically. We have been using this suite
> as a part of our autotests for several years already. However the suite originate for Linux
> native file systems and a lot of cases are not applicable to the NTFS. This is one of the reasons
> why some of "red-flag" failures are there (e.g. generic/475) - they were excluded at some point of time
> and we've missed to enable it back when it was the time :)

generic/019, generic/317, generic/476 (and generic/521 and 522) are
supposed to be stress exercisers of standard functionality (read, write,
mkdir, creat, unlink) which means they ought to pass on any filesystem.

Hmm, we /dont/ have a tag for these generic exercisers.  Maybe we
should, I'll think about that.

(FWIW a minor correction: I meant to reference generic/476 and not 475,
because 475 is a looping test of crash recovery.  475 is notorious for
intermittent failures even on ext4/btrfs/xfs.)

> Thank you all for this effort to run and look closer on our code, on the next patchset, the
> 91, 317 and 475 should be resolved. And now we are looking up to other excluded tests to find out more of such.

Ok, thank you!

> Hope this will resolve some of your concerns.

It does. :)

--D

> > --D
> > 
> > > I can even give them patches and configsto make it trivially easy for
> > > them to run fstests using KVM or GCE....
> > >
> > > 				- Ted
