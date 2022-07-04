Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7852564C04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 05:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiGDDZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 23:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDDZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:25:27 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 315892BCC;
        Sun,  3 Jul 2022 20:25:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C4E585ECF40;
        Mon,  4 Jul 2022 13:25:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o8Ci4-00EIM4-Gy; Mon, 04 Jul 2022 13:25:16 +1000
Date:   Mon, 4 Jul 2022 13:25:16 +1000
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
Message-ID: <20220704032516.GC3237952@dread.disaster.area>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62c25da2
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=N54-gffFAAAA:8 a=NEAV23lmAAAA:8
        a=7-415B0cAAAA:8 a=dyNEn9B-Op_u5ZtGAXkA:9 a=CjuIK1q_8ugA:10
        a=6l0D2HzqY3Epnrm8mE3f:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 03, 2022 at 08:56:54AM +0300, Amir Goldstein wrote:
> On Sun, Jul 3, 2022 at 12:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 5/18/22 20:07, Luis Chamberlain wrote:
> > > I've been promoting the idea that running fstests once is nice,
> > > but things get interesting if you try to run fstests multiple
> > > times until a failure is found. It turns out at least kdevops has
> > > found tests which fail with a failure rate of typically 1/2 to
> > > 1/30 average failure rate. That is 1/2 means a failure can happen
> > > 50% of the time, whereas 1/30 means it takes 30 runs to find the
> > > failure.
> > >
> > > I have tried my best to annotate failure rates when I know what
> > > they might be on the test expunge list, as an example:
> > >
> > > workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> > >
> > > The term "failure rate 1/15" is 16 characters long, so I'd like
> > > to propose to standardize a way to represent this. How about
> > >
> > > generic/530 # F:1/15
> > >
> > > Then we could extend the definition. F being current estimate, and this
> > > can be just how long it took to find the first failure. A more valuable
> > > figure would be failure rate avarage, so running the test multiple
> > > times, say 10, to see what the failure rate is and then averaging the
> > > failure out. So this could be a more accurate representation. For this
> > > how about:
> > >
> > > generic/530 # FA:1/15
> > >
> > > This would mean on average there failure rate has been found to be about
> > > 1/15, and this was determined based on 10 runs.
> > >
> > > We should also go extend check for fstests/blktests to run a test
> > > until a failure is found and report back the number of successes.
> > >
> > > Thoughts?
> > >
> > > Note: yes failure rates lower than 1/100 do exist but they are rare
> > > creatures. I love them though as my experience shows so far that they
> > > uncover hidden bones in the closet, and they they make take months and
> > > a lot of eyeballs to resolve.
> >
> > I strongly disagree with annotating tests with failure rates. My opinion
> > is that on a given test setup a test either should pass 100% of the time
> > or fail 100% of the time. If a test passes in one run and fails in
> > another run that either indicates a bug in the test or a bug in the
> > software that is being tested. Examples of behaviors that can cause
> > tests to behave unpredictably are use-after-free bugs and race
> > conditions. How likely it is to trigger such behavior depends on a
> > number of factors. This could even depend on external factors like which
> > network packets are received from other systems. I do not expect that
> > flaky tests have an exact failure rate. Hence my opinion that flaky
> > tests are not useful and also that it is not useful to annotate flaky
> > tests with a failure rate. If a test is flaky I think that the root
> > cause of the flakiness must be determined and fixed.
> >
> 
> That is true for some use cases, but unfortunately, the flaky
> fstests are way too valuable and too hard to replace or improve,
> so practically, fs developers have to run them, but not everyone does.

Everyone *should* be running them. They find *new bugs*, and it
doesn't matter how old the kernel is. e.g. if you're backporting XFS
log changes and you aren't running the "flakey" recoveryloop group
tests, then you are *not testing failure handling log recovery
sufficiently*.

Where do you draw the line? recvoeryloop tests that shutdown and
recover the filesystem will find bugs, they are guaranteed to be
flakey, and they are *absolutely necessary* to be run because they
are the only tests that exercise that critical filesysetm crash
recovery functionality.

What do we actually gain by excluding these "non-deterministic"
tests from automated QA environments?

> Zorro has already proposed to properly tag the non deterministic tests
> with a specific group and I think there is really no other solution.
> 
> The only question is whether we remove them from the 'auto' group
> (I think we should).

As per above, this shows that many people simply don't understand
what many of these non-determinsitic tests are actually exercising,
and hence what they fail to test by excluding them from automated
testing.

> There is probably a large overlap already between the 'stress' 'soak' and
> 'fuzzers' test groups and the non-deterministic tests.
> Moreover, if the test is not a stress/fuzzer test and it is not deterministic
> then the test is likely buggy.
> 
> There is only one 'stress' test not in 'auto' group (generic/019), only two
> 'soak' tests not in the 'auto' group (generic/52{1,2}).
> There are only three tests in 'soak' group and they are also exactly
> the same three tests in the 'long_rw' group.
> 
> So instead of thinking up a new 'flaky' 'random' 'stochastic' name
> we may just repurpose the 'soak' group for this matter and start
> moving known flaky tests from 'auto' to 'soak'.

Please, no. The policy for the auto group is inclusive, not
exclusive. It is based on the concept that every test is valuable
and should be run if possible. Hence any test that generally
passes, does not run forever and does not endanger the system should
be a member of the auto group. That effectively only rules out
fuzzer and dangerous tests from being in the auto group, as long
running tests should be scaled by TIME_FACTOR/LOAD_FACTOR and hence
the default test behaviour results in only a short time run time.

If someone wants to *reduce their test coverage* for whatever reason
(e.g. runtime, want to only run pass/fail tests, etc) then the
mechanism we already have in place for this is for that person to
use *exclusion groups*. i.e. we exclude subsets of tests from the
default set, we don't remove them from the default set.

Such an environment would run:

./check -g auto -x soak

So that the test environment doesn't run the "non-determinisitic"
tests in the 'soak' group. i.e. the requirements of this test
environment do not dictate the tests that every other test
environment runs by default.

> generic/52{1,2} can be removed from 'soak' group and remain
> in 'long_rw' group, unless filesystem developers would like to
> add those to the stochastic test run.
> 
> filesystem developers that will run ./check -g auto -g soak
> will get the exact same test coverage as today's -g auto
> and the "commoners" that run ./check -g auto will enjoy blissful
> determitic test results, at least for the default config of regularly
> tested filesystems (a.k.a, the ones tested by kernet test bot).?

An argument that says "everyone else has to change what they do so I
don't have to change" means that the person making the argument
thinks their requirements are more important than the requirements
of anyone else. The test run policy mechanisms we already have avoid
this whole can of worms - we don't need to care about the specific
test requirements of any specific test enviroment because the
default is inclusive and it is trivial to exclude tests from that
default set if needed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
