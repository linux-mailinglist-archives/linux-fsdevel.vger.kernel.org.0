Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD544568B46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiGFOb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 10:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiGFOb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:31:26 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445A20182;
        Wed,  6 Jul 2022 07:31:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 266ETwXl010753
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Jul 2022 10:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657117802; bh=NUUsO3D1IV2NnscRXQ3iW7vDLpbznJlBJF/3puoiFlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ByMVPDFr5R8Axivia9yVVNfmFzr4obgpDayheOHhBGP5rmhlYUHdlEHTNapSRSbf5
         aU9t1GR/wcQgSFL/PlOl2xi1rRKoVFUsw1meRM189aCKKaCoVCnEzjCQIBLCcfNayW
         9PwiaPAWermMd6xdFujtqUTzfOK5GZTYQA/CIOGTogVSfOo5KvlPGWBAQd6HlJWEPJ
         NoVB7juD+bkcdYyzBN4rS3qExjK+32bsNAtI/b71wChegqKDeqd/obsyme4fYlmG3h
         NPJ7v6IORhwbj8MAsfVR8BBTSDAnYqaxo9BAgZNJXifHiqbuItiJXN/+d8oCe4h0nJ
         Aek0hE4Sl/5iw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DD1BA15C3E94; Wed,  6 Jul 2022 10:29:57 -0400 (EDT)
Date:   Wed, 6 Jul 2022 10:29:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YsWcZbBALgWKS88+@mit.edu>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
 <20220704032516.GC3237952@dread.disaster.area>
 <CAOQ4uxj5wabQvsGELS7t_Z9Z4Z2ZUHAR8d+LBao89ANErwZ95g@mail.gmail.com>
 <20220705031133.GD3237952@dread.disaster.area>
 <CAOQ4uxi2rBGqmtXghFJ+frDORETum+4KOKEg0oeX-woPXLNxTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi2rBGqmtXghFJ+frDORETum+4KOKEg0oeX-woPXLNxTw@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 06, 2022 at 01:11:16PM +0300, Amir Goldstein wrote:
> 
> So I am wondering what is the status today, because I rarely
> see fstests failure reports from kernel test bot on the list, but there
> are some reports.
> 
> Does anybody have a clue what hw/fs/config/group of fstests
> kernel test bot is running on linux-next?

Te zero-day test bot only reports test regressions.  So they have some
list of tests that have failed in the past, and they only report *new*
test failures.  This is not just true for fstests, but it's also true
for things like check and compiler warnings warnings --- and I suspect
it's for those sorts of reports that caused the zero-day bot to keep
state, and to filter out test failures and/or check warnings and/or
compiler warnings, so that only new test failures and/or new compiler
warnigns are reported.  If they didn't, they would be spamming kernel
developers, and given how.... "kind and understanding" kernel
developers are at getting spammed, especially when sometimes the
complaints are bogus ones (either test bugs or compiler bugs), my
guess is that they did the filtering out of sheer self-defense.  It
certainly wasn't something requested by a file system developer as far
as I know.


So this is how I think an automated system for "drive-by testers"
should work.  First, the tester would specify the baseline/origin tag,
and the testing system would run the tests on the baseline once.
Hopefully, the test runner already has exclude files so that kernel
bugs that cause an immediate kernel crash or deadlock would be already
be in the exclude list.  But as I've discovered this weekend, for file
systems that I haven't tried in a few yeas, like udf, or
ubifs. etc. there may be missing tests that result in the test VM to
stop responding and/or crash.

I have a planned improvement where if you are using the gce-xfstests's
lightweight test manager, since the LTM is constantly reading the
serial console, a deadlock can be detected and the LTM can restart the
VM.  The VM can then disambiguate from a forced reboot caused by the
LTM, or a forced shutdown caused by the use of a preemptible VM (a
planned feature not yet fully implemented yet), and the test runner
can skip the tests already run, and skip the test which caused the
crash or deadlock, and this could be reported so that eventually, the
test could be added to the exclude file to benefit thouse people who
are using kvm-xfstests.  (This is an example of a planned improvement
in xfstests-bld which if someone is interested in helping to implement
it, they should give me a ring.)

Once the tests which are failing given a particular baseline are
known, this state would then get saved, and then now the tests can be
run on the drive-by developer's changes.  We can now compare the known
failures for the baseline, with the changed kernels, and if there are
any new failures, there are two possibilities: (a) this was a new
feailure caused by the drive-by developer's changes, (b) this was a
pre-existing known flake.

To disambiguate between these two cases, we now run the failed test N
times (where N is probably something like 10-50 times; I normally use
25 times) on the changed kernel, and get the failure rate.  If the
failure rate is 100%, then this is almost certainly (a).  If the
failure rate is < 100% (and greater than 0%), then we need to rerun
the failed test on the baseline kernel N times, and see if the failure
rate is 0%, then we should do a bisection search to determine the
guilty commit.

If the failure rate is 0%, then this is either an extremely rare
flake, in which case we might need to increase N --- or it's an
example of a test failure which is sensitive to the order of tests
which are failed, in which case we may need to reun all of the tests
in order up to the failed test.

This is right now what I do when processing patches for upstream.
It's also rather similar to what we're doing for the XFS stable
backports, because it's much more efficient than running the baseline
tests 100 times (which can take a week of continuous testing per
Luis's comments) --- we only tests dozens (or more) times where a
potential flake has been found, as opposed to *all* tests.  It's all
done manually, but it would be great if we could automate this to make
life easier for XFS stable backporters, and *also* for drive-by
developers.

And again, if anyone is interested in helping with this, especially if
you're familiar with shell, python 3, and/or the Go language, please
contact me off-line.

Cheers,

						- Ted
