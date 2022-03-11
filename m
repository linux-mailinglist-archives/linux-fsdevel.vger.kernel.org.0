Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734DD4D5A99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 06:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiCKF0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 00:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiCKF0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:26:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481FE1ACA1C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 21:25:29 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22B5Ntj6004124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 00:23:56 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 429C315C00DD; Fri, 11 Mar 2022 00:23:55 -0500 (EST)
Date:   Fri, 11 Mar 2022 00:23:55 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Yirc69JyH5N/pXKJ@mit.edu>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
 <Yij4lD19KGloWPJw@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yij4lD19KGloWPJw@bombadil.infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:57:24AM -0800, Luis Chamberlain wrote:
> On Tue, Mar 08, 2022 at 02:06:57PM -0500, Sasha Levin wrote:
> > What we can't do is invest significant time into doing the testing work
> > ourselves for each and every subsystem in the kernel.
> 
> I think this experience helps though, it gives you I think a better
> appreciation for what concerns we have to merge any fix and the effort
> and dilligence required to ensure we don't regress. I think the
> kernel-ci steady state goal takes this a bit further.

Different communities seem to have different goals that they believe
the stable kernels should be aiming for.  Sure, if you never merge any
fix, you can guarantee that there will be no regressions.  However,
the question is whether the result is a better quality kernel.  For
example, there is a recent change to XFS which fixes a security bug
which allows an attacker to gain access to deleted data.  How do you
balance the tradeoff of "no regressions, ever", versus, "we'll leave a
security bug in XFS which is fixed in mainline linux, but we fear
regressions so much that we won't even backport a single-line fix to
the stable kernel?"

In my view, the service which Greg, Sasha and the other stable
maintainers provide is super-valuable, and I am happy that ext4
changes are automatically cherry-picked into the stable kernel.  Have
there been times when this has resulted in regressions in ext4 for the
stable kernel?  Sure!  It's only been a handful of a times, though,
and the number of bug fixes that users using stable kernels have _not_
seen *far* outweighs the downsides of the occasional regressions
(which gets found and then reverted).

> 
> Perhaps the one area that might interest folks is the test setup,
> using loopback drives and truncated files, if you find holes in
> this please let me know:
> 
> https://github.com/mcgrof/kdevops/blob/master/docs/testing-with-loopback.md
> 
> In my experience this setup just finds *more* issues, rather than less,
> and in my experience as well none of these issues found were bogus, they
> always lead to real bugs:
> 
> https://github.com/mcgrof/kdevops/blob/master/docs/seeing-more-issues.md

Different storage devices --- Google Cloud Persistent Disks, versus
single spindle HDD's, SSD's, eMMC flash, iSCSI devices --- will have
different timing characteristics, and this will affect what failures
you are likely to find.

So if most of the developers for a particular file system tend to use
a particular kind of hardware --- say, HDD's and SSD's --- and you use
something different, such as file-based loopback drives, it's not
surprising that you'll find a different set of failures more often.
It's not that loopback drives are inherently better at finding
problems --- it's just that all of the bugs that are easily findable
on HDD and SSD devices have already been fixed, and so the first
person to test using loopback will find a bunch of new bugs.

This is why I consider myself very lucky that one of the ext4
developers had been testing on Rasberry PI, and they found bugs that
was missed on my GCE setup, and vice versa.  And when he moved to a
newer test rig, which had a faster CPU and faster SSD, he found a
different set of flaky test failures that he couldn't reproduce on his
older test system.

So having a wide diversity of test rigs is really important.  Another
take home is that if you are responsible for a vast number of data
center servers, there isn't a real substitute for running tests on the
hardware that you are using in production.  One of the reasons why we
created android-xfstests was that there were some bugs that weren't
found when testing using KVM, but were much more easily found when
running xfstests on an actual Android device.  And it's why we run
continuous test spinners running xfstests using data center HDD's,
data center SSD's, iSCSI, iBlock (basically something like FUSE but
for block devices, that we'd love to get upstreamed someday), etc.
And these tests are run using the exact file system configuration that
we use in production.

Different people will have different test philosophies, but mine is
that I'm not looking for absolute perfection on upstream kernels.  I
get much better return on investment if I do basic testing for
upstream, but reserve the massive, continuous test spinning, on the
hardware platforms that my employer cares the most about from a $$$
perspective.

And it's actually not about the hardware costs.  The hardware costs
are actually pretty cheap, at least from a company's perspective.
What's actually super-duper expensive is the engineering time to
monitor the test results; to anaylze and root cause flaky test
failures, etc.  In general, "People time" >>> "hardware costs", by two
orders of magnitude.

So ultimately, it's going to be about the business case.  If I can
justify to my company why investing a portion of an engineer to setup
a dedicated test spinner on a particular hardware / software
combination, I can generally get the head count.  But if it's to do
massive testing and on an LTS kernel or a file system that doesn't
have commercial value for many company, it's going to be a tough slog.

Fortunately, though, I claim that we don't need to run xfstests a
thousand times before a commit is deemed "safe" for backporting to LTS
kernels.  (I'm pretty sure we aren't doing that during our upstream
development.)

It makes more sense to reserve that kind of intensive testing for
product kernels which are downstream of LTS, and if they find
problems, they can report that back to the stable kernel maintainers,
and if necessary, we can revert a commit.  In fact, I suspect that
when we *do* that kind of intensive testing, we'll probably find that
the problem still exists in upstream, it's just no one had actually
noticed.

That's certainly been my experience.  When we first deployed ext4 to
Google Data Centers, ten years ago, the fact that we had extensive
monitoring meant that we found a data corruption bug that was
ultimately root caused to a spinlock being released one line too
early.  Not only was the bug not fixed in upstream, it had turned out
that the bug had been in upstream for ten years before *that*, and it
had not been detected in multiple Red Hat and SuSE "golden master"
release testing, and all of the enterprise users of RHEL and SLES

(My guess is that people had written off the failure to cosmic rays,
or unreproducible hardware flakiness.  It was only when we ran at
scale, on millions of file systems under high stress, with
sufficiently automated monitoring of our production servers, that we
were able to detect it.)

So that's why I'm a bit philosophical about testing.  More testing is
always good, but perfection is not attainable.  So we test up to where
it makes business sense, and we accept that there may be some bug
escapes.  That's OK, though, since I'd much rather make sure security
bugs and other stability bugs get backported, even if that means that
once in a blue moon, there is a regression that requires a revert in
the LTS kernel.

Cheers,

					- Ted
