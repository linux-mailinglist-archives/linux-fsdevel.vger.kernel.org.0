Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CA564788
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiGCNc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCNc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:32:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3363EC;
        Sun,  3 Jul 2022 06:32:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 263DW3EE030648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Jul 2022 09:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656855127; bh=L+Hz99xOt45QvdSxLGEvpYQPTANWobOaJHGCr2gbev0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NPkc71lo7lSlzXn3ei16G/3G00s2LODNpq7e3kfGKBMhhiRr3bqdQs0NNEY0FNRFj
         xgoD29Sp2nk+QMCsFyfb5dSsARP+vcTjglCnfALIPgWpZ1Sg/PuH7CVqlUIvBkTCpu
         KxHmUXvAgl+HozpRRj9ugtfcYPb9V+gxz7CPPmxi1FPFxJvQcL7dBjY1pKhunS90bM
         j0ZGs1PJ21BVyd2pS0FI9SRYTCYFkShupzb3dXSVb3WGnLJ/lrOxWhmE4PgWKJzLu2
         od8NGWAruJjTiDs9pQWK8xpZIjKciiR7mFuF+kglcbtl4awayx9jMTr3TZ2Ss5jr1z
         PnvxLnWX/+orA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8B1C715C3E94; Sun,  3 Jul 2022 09:32:03 -0400 (EDT)
Date:   Sun, 3 Jul 2022 09:32:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        amir73il@gmail.com, pankydev8@gmail.com, josef@toxicpanda.com,
        jmeneghi@redhat.com, Jan Kara <jack@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YsGaU4lFjR5Gh29h@mit.edu>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 02, 2022 at 02:48:12PM -0700, Bart Van Assche wrote:
> 
> I strongly disagree with annotating tests with failure rates. My opinion is
> that on a given test setup a test either should pass 100% of the time or
> fail 100% of the time.

My opinion is also that no child should ever go to bed hungry, and we
should end world hunger.

However, meanwhile, in the real world, while we can *strive* to
eliminate all flaky tests, whether it is caused by buggy tests, or
buggy kernel code, there's an old saying that the only time code is
bug-free is when it is no longer being used.

That being said, I completely agree that annotating failure rates in
xfstesets-dev upstream probably doesn't make much sense.  As we've
stated before, it is highly dependent on the hardware configuration,
and kernel version (remember, sometimes flaky tests are caused by bugs
in other kernel subsystems --- including the loop device, which has
not historically been bug-free(tm) either, and so bugs come and go
across the entire kernel surface).

I believe the best way to handle this is to have better test results
analysis tools.  We can certainly consider having some shared test
results database, but I'm not convinced that flat text files shared
via git is sufficiently scalable.


The final thing I'll note it that we've lived with low probability
flakes for a very long time, and it hasn't been the end of the world.
Sometime in 2011 or 2012, when I first started at Google and when we
first started rolling out ext4 to the all of our data centers, once or
twice a month --- across the entire world-wide fleet --- there would
be an unexplained file system corruption that had remarkably similar
characteristics.  It took us several months to run it down, and it
turned out to be a lock getting released one C statement too soon.
When I did some further archeological research, it turned out it had
been in upstream for well over a *decade* --- in ext3 and ext4 --- and
had not been noticed in at least 3 or 4 enterprise distro GA
testing/qualification cycles.  Or rather, it might have been noticed,
but since it couldn't be replicated, I'm guessing the QA testers
shrugged, assumed that it *must* have been due to some cosmic ray, or
some such, and moved on.

> If a test is flaky I think that the root cause of the flakiness must
> be determined and fixed.  

In the ideal world, sure.  Then again, in the ideal world, we wouldn't
have thousands of people getting killed over border disputes and
because some maniacal world leader thinks that it's A-OK to overrun
the borders of adjacent countries.

However, until we have infinite resources available to us, the reality
is that we need to live with the fact that life is imperfect, despite
all of our efforts to reduce these sort of flaky tests --- especially
when we're talking about esoteric test configurations that most users
won't be using.  (Or when they are triggered by test code that is not
used in production, but for which the error injection or shutdown
simuilation code is itself not perfect.)

Cheers,

					- Ted
