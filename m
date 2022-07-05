Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53FB5661AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 05:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiGEDLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 23:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGEDLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:11:42 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0D3F101DB;
        Mon,  4 Jul 2022 20:11:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 04E2A5ED0D4;
        Tue,  5 Jul 2022 13:11:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o8YyL-00EgSt-PA; Tue, 05 Jul 2022 13:11:33 +1000
Date:   Tue, 5 Jul 2022 13:11:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <20220705031133.GD3237952@dread.disaster.area>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
 <20220704032516.GC3237952@dread.disaster.area>
 <CAOQ4uxj5wabQvsGELS7t_Z9Z4Z2ZUHAR8d+LBao89ANErwZ95g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj5wabQvsGELS7t_Z9Z4Z2ZUHAR8d+LBao89ANErwZ95g@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62c3abec
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8 a=N54-gffFAAAA:8
        a=NEAV23lmAAAA:8 a=OFeBVxtZYzNL8miIrAsA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=6l0D2HzqY3Epnrm8mE3f:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:58:22AM +0300, Amir Goldstein wrote:
> On Mon, Jul 4, 2022 at 6:25 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Sun, Jul 03, 2022 at 08:56:54AM +0300, Amir Goldstein wrote:
> > > On Sun, Jul 3, 2022 at 12:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > >
> > > > On 5/18/22 20:07, Luis Chamberlain wrote:
> > > > > I've been promoting the idea that running fstests once is nice,
> > > > > but things get interesting if you try to run fstests multiple
> > > > > times until a failure is found. It turns out at least kdevops has
> > > > > found tests which fail with a failure rate of typically 1/2 to
> > > > > 1/30 average failure rate. That is 1/2 means a failure can happen
> > > > > 50% of the time, whereas 1/30 means it takes 30 runs to find the
> > > > > failure.
> > > > >
> > > > > I have tried my best to annotate failure rates when I know what
> > > > > they might be on the test expunge list, as an example:
> > > > >
> > > > > workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> > > > >
> > > > > The term "failure rate 1/15" is 16 characters long, so I'd like
> > > > > to propose to standardize a way to represent this. How about
> > > > >
> > > > > generic/530 # F:1/15
> > > > >
> > > > > Then we could extend the definition. F being current estimate, and this
> > > > > can be just how long it took to find the first failure. A more valuable
> > > > > figure would be failure rate avarage, so running the test multiple
> > > > > times, say 10, to see what the failure rate is and then averaging the
> > > > > failure out. So this could be a more accurate representation. For this
> > > > > how about:
> > > > >
> > > > > generic/530 # FA:1/15
> > > > >
> > > > > This would mean on average there failure rate has been found to be about
> > > > > 1/15, and this was determined based on 10 runs.
> > > > >
> > > > > We should also go extend check for fstests/blktests to run a test
> > > > > until a failure is found and report back the number of successes.
> > > > >
> > > > > Thoughts?
> > > > >
> > > > > Note: yes failure rates lower than 1/100 do exist but they are rare
> > > > > creatures. I love them though as my experience shows so far that they
> > > > > uncover hidden bones in the closet, and they they make take months and
> > > > > a lot of eyeballs to resolve.
> > > >
> > > > I strongly disagree with annotating tests with failure rates. My opinion
> > > > is that on a given test setup a test either should pass 100% of the time
> > > > or fail 100% of the time. If a test passes in one run and fails in
> > > > another run that either indicates a bug in the test or a bug in the
> > > > software that is being tested. Examples of behaviors that can cause
> > > > tests to behave unpredictably are use-after-free bugs and race
> > > > conditions. How likely it is to trigger such behavior depends on a
> > > > number of factors. This could even depend on external factors like which
> > > > network packets are received from other systems. I do not expect that
> > > > flaky tests have an exact failure rate. Hence my opinion that flaky
> > > > tests are not useful and also that it is not useful to annotate flaky
> > > > tests with a failure rate. If a test is flaky I think that the root
> > > > cause of the flakiness must be determined and fixed.
> > > >
> > >
> > > That is true for some use cases, but unfortunately, the flaky
> > > fstests are way too valuable and too hard to replace or improve,
> > > so practically, fs developers have to run them, but not everyone does.
> >
> > Everyone *should* be running them. They find *new bugs*, and it
> > doesn't matter how old the kernel is. e.g. if you're backporting XFS
> > log changes and you aren't running the "flakey" recoveryloop group
> > tests, then you are *not testing failure handling log recovery
> > sufficiently*.
> >
> > Where do you draw the line? recvoeryloop tests that shutdown and
> > recover the filesystem will find bugs, they are guaranteed to be
> > flakey, and they are *absolutely necessary* to be run because they
> > are the only tests that exercise that critical filesysetm crash
> > recovery functionality.
> >
> > What do we actually gain by excluding these "non-deterministic"
> > tests from automated QA environments?
> >
> 
> Automated QA environment is a broad term.
> We all have automated QA environments.
> But there is a specific class of automated test env, such as CI build bots
> that do not tolerate human intervention.

Those environments need curated test lists because of the fact
that failures gate progress. They also tend to run in resource
limited environments as fstests is not the only set of tests that
are run. Hence, generally speaking, CI is not an environment you'd
be running a full "auto" group set of tests. Even the 'quick' group
(which take an hour to run here) is often far too time and resource
intensive for a CI system to use effectively.

IOWs, we can't easily curate a set of tests that are appropriate for
all CI environments - it's up to the people running the CI
enviroment to determine what level of testing is appropriate for
gating commits to their source tree, not the fstests maintainers or
developers...

> Is it enough to run only the deterministic tests to validate xfs code?
> No it is not.
> 
> My LTS environment is human monitored - I look at every failure and
> analyse the logs and look at historic data to decide if they are regressions
> or not. A bot simply cannot do that.
> The bot can go back and run the test N times on baseline vs patch.
> 
> The question is, do we want kernel test bot to run -g auto -x soak
> on linux-next and report issues to us?
> 
> I think the answer to this question should be yes.
> 
> Do we want kernel test bot to run -g auto and report flaky test
> failures to us?
> 
> I am pretty sure that the answer is no.

My answer to both is *yes, absolutely*.

The zero-day kernel test bot runs all sorts of non-deterministic
tests, including performance regression testing. We want these
flakey/non-deterministic tests run in such environments, because
they are often configurations we do not ahve access to and/or would
never even consider. e.g. 128p server with a single HDD running IO
scalability tests like AIM7...

This is exactly where such automated testing provides developers
with added value - it covers both hardware and software configs that
indvidual developers cannot exercise themselves. Developers may or
may not pay attention to those results depending on the test that
"fails" and the hardware it "failed' on, but the point is that it
got tested on something we'd never get coverage on otherwise.

> > The test run policy mechanisms we already have avoid
> > this whole can of worms - we don't need to care about the specific
> > test requirements of any specific test enviroment because the
> > default is inclusive and it is trivial to exclude tests from that
> > default set if needed.
> >
> 
> I had the humble notion that we should make running fstests to
> passing-by developers as easy as possible, because I have had the
> chance to get feedback from some developers on their first time
> attempt to run fstests and it wasn't pleasant, but nevermind.
> -g auto -x soak is fine.

I think that the way to do this is the way Ted has described - wrap
fstests in an environment where all the required knowledge is
already encapsulated and the "drive by testers" just need to crank
the handle and it churns out results.

As it is, I don't think making things easier for "drive-by" testing
at the expense of making things arbitrarily different and/or harder
for people who use it every day is a good trade-off. The "target
market" for fstests is *filesystem developers* and people who spend
their working life *testing filesystems*. The number of people who
do *useful* "drive-by" testing of filesystems is pretty damn small,
and IMO that niche is nowhere near as important as making things
better for the people who use fstests every day....

> When you think about it, many fs developrs run ./check -g auto,
> so we should not interfere with that, but I bet very few run './check'?
> so we could make the default for './check' some group combination
> that is as deterministic as possible.

Bare ./check invocations are designed to run every test, regardless
of what group they are in.

Stop trying to redefine longstanding existing behaviour - if you
want to define "deterministic" tests so that you can run just those
tests, define a group for it, add all the tests to it, and then
document it in the README as "if you have no experience with
fstests, this is where you should start".

Good luck keeping that up to date, though, as you're now back to the
same problem that Ted describes, which is the "deterministic" group
changes based on kernel, filesystem, config, etc.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
