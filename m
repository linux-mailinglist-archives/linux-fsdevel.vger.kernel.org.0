Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429CB4D69B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 21:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiCKUxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 15:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiCKUxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:53:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7271DA60
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 12:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p9YPbzPzuQ4pAFDmITOigHOI0CNOBi444MQVcUikK44=; b=ITn7CtoHxHgxvk+MzAaqmiEPqe
        GPhIqztDBcBO0wv0hBSwQeMAA6K2Pr3I+dNb3Yv5nKGZZU3ShQSXYKpQ+Eb74YD82QrOpCY4LqVO+
        z/XnkDvtrm9aIEhcoAwWGixlpIEz0WCOOWxhm/5CEkz3rInOAL/1KV8hoMSyWxirl9O+hu3gVwTte
        lBKm5/JqFJx4rBqKXCE1sROEH2MD9MzyD4iG6aj6tKq7ytb87i99cNSYQR7wYnpqtygXvSuPvgev2
        Ah58AM9rNrWNkZ1mbTm7VZl2hFW7O5BB0Eeq4NySasH9ekVvcD/cjvrjJLf2eEaTyAQ6G1USzsozs
        Bue+Zcsw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSmFd-000FbK-Ae; Fri, 11 Mar 2022 20:52:41 +0000
Date:   Fri, 11 Mar 2022 12:52:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
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
Message-ID: <Yiu2mRwguHhbVpLJ@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
 <Yij4lD19KGloWPJw@bombadil.infradead.org>
 <Yirc69JyH5N/pXKJ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yirc69JyH5N/pXKJ@mit.edu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:23:55AM -0500, Theodore Ts'o wrote:
> On Wed, Mar 09, 2022 at 10:57:24AM -0800, Luis Chamberlain wrote:
> > On Tue, Mar 08, 2022 at 02:06:57PM -0500, Sasha Levin wrote:
> > > What we can't do is invest significant time into doing the testing work
> > > ourselves for each and every subsystem in the kernel.
> > 
> > I think this experience helps though, it gives you I think a better
> > appreciation for what concerns we have to merge any fix and the effort
> > and dilligence required to ensure we don't regress. I think the
> > kernel-ci steady state goal takes this a bit further.
> 
> Different communities seem to have different goals that they believe
> the stable kernels should be aiming for.  Sure, if you never merge any
> fix, you can guarantee that there will be no regressions.  However,
> the question is whether the result is a better quality kernel.  For
> example, there is a recent change to XFS which fixes a security bug
> which allows an attacker to gain access to deleted data.  How do you
> balance the tradeoff of "no regressions, ever", versus, "we'll leave a
> security bug in XFS which is fixed in mainline linux, but we fear
> regressions so much that we won't even backport a single-line fix to
> the stable kernel?"

That patch should just be applied, thanks for the heads up, I'll go try
to spin some resources to test if this is not merged already.

And perhaps in such cases the KERNEL_CI_STEADY_STATE_GOAL can be reduced.

> In my view, the service which Greg, Sasha and the other stable
> maintainers provide is super-valuable, and I am happy that ext4
> changes are automatically cherry-picked into the stable kernel.  Have
> there been times when this has resulted in regressions in ext4 for the
> stable kernel?  Sure!  It's only been a handful of a times, though,
> and the number of bug fixes that users using stable kernels have _not_
> seen *far* outweighs the downsides of the occasional regressions
> (which gets found and then reverted).

I think by now the community should know I'm probably one of the biggest
advocates of kernel automation. Whether that be kernel testing or kernel
code generation... the reason I've started dabbling into the automation
part of testing is that they go hand in hand. So while I value the
stable process, I think it should be respected if subsystems with a
higher threshold than others for testing / review is kept.

The only way to move forward with enabling more automation for kernel
code integration is through better and improved kernel test automation.
And it is *exactly* why I've been working so hard on that problem.

> > Perhaps the one area that might interest folks is the test setup,
> > using loopback drives and truncated files, if you find holes in
> > this please let me know:
> > 
> > https://github.com/mcgrof/kdevops/blob/master/docs/testing-with-loopback.md
> > 
> > In my experience this setup just finds *more* issues, rather than less,
> > and in my experience as well none of these issues found were bogus, they
> > always lead to real bugs:
> > 
> > https://github.com/mcgrof/kdevops/blob/master/docs/seeing-more-issues.md
> 
> Different storage devices --- Google Cloud Persistent Disks, versus
> single spindle HDD's, SSD's,

<-- Insert tons of variability requirements on test drives -->
<-- Insert tons of variability requirements on confidence in testing -->
<-- Insert tons of variability requirements on price / cost assessment -->
<-- Insert tons of variability requirements on business case -->

What you left out in terms of variability was you use GCE, and yes
others will want to use AWS, OpenStack, etc as well. So that's another
variability aspect too.

What's the common theme here? Variability!

And what is the most respectable modeling variability language? Kconfig!

It is why the way I've designed kdevops was to embrace kconfig. It
enables you to test however you want, using whatever test devices,
with whatever test criteria you might have and on any cloud or local
virt solution.

Yes, some of the variability things in kdevops are applicable only to
kdevops, but since I picked up kconfig it meant I also adopted it for
variability for fstest and blktests. It should be possible to move that
to fstests / blktests if we wanted to, and for kdevops to just use it.

And if you are thinking:

   why shucks.. but I don't want to deal with the complexity of
   integrating kconfig into a new project. That sounds difficult.

Yes I hear you, and to help with that I've created a git tree which can
be used as a git subtree (note: different than the stupid git
submodules) to let you easily integrate kconfig adoption into any
project with only a few lines of code differences:

https://github.com/mcgrof/kconfig

Also let's recall that just because you have your own test framework
it does not mean we could not benefit from others testing our
filesystems on their own silly hardware at home as well. Yes tons
of projects can be used which wrap fstests... but I never found one
as easy to use as compiling the kernel and running a few make commands.
So my goal was not just addressing the variability aspect for fstests
and blktests, but also enabling the average user to also easily help
test as well.

There is the concept of results too and a possible way to share things..
but this is getting a bit off topic and I don't want to bore people more.

  Luis
