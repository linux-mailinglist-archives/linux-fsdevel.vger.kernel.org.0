Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02FD52D5CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiESOTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiESOTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 10:19:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CAB72223;
        Thu, 19 May 2022 07:19:12 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24JEImoK027227
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 10:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652969932; bh=uR7LNtTtYP5uzs7OWgks6v34m+NZrTSkmLVmqO1vVRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IQPgP5EAgoxZjC0ZoapHkl+dpzOd8IhR/ZbvTzWvXCxjIRSC328Tw6o947MU38VY/
         Lp9a6ImCCjrMi90Vilh1YqhwxmB9F+hH3yzuA6H2GaMicSUGuc8OqCeV10QVVT3Woe
         o4Gx3ooKepx5Fs64PSnSzxQe4fX5weA6Vxbh48M+xd7nMtONZC9/qX9UK1kjCrUi1o
         gMAM2t5Ogg1EgMdQGVQBWA1v5QpzbJ26eCI1g8jlpROdSiTp3B7RfEai1+gm18VHub
         cMR67SCCjX4j+dYAPV3niQXWCfePhc82F43FD25zs9Mce5hsvivJzrJQrIQjUCQDX/
         DYlKXPCXOfK8Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7F8BA15C3EC0; Thu, 19 May 2022 10:18:48 -0400 (EDT)
Date:   Thu, 19 May 2022 10:18:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YoZRyGOwde+xkK1y@mit.edu>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 07:24:50PM +0800, Zorro Lang wrote:
> 
> Yes, we talked about this, but if I don't rememeber wrong, I recommended each
> downstream testers maintain their own "testing data/config", likes exclude
> list, failed ratio, known failures etc. I think they're not suitable to be
> fixed in the mainline fstests.

Failure ratios are the sort of thing that are only applicable for

* A specific filesystem
* A specific configuration
* A specific storage device / storage device class
* A specific CPU architecture / CPU speed
* A specific amount of memory available

Put another way, there are problems that fail so close to rarely as to
be "hever" on, say, an x86_64 class server with gobs and gobs of
memory, but which can more reliably fail on, say, a Rasberry PI using
eMMC flash.

I don't think that Luis was suggesting that this kind of failure
annotation would go in upstream fstests.  I suspect he just wants to
use it in kdevops, and hope that other people would use it as well in
other contexts.  But even in the context of test runners like kdevops
and {kvm,gce,android}-xfstests, it's going to be very specific to a
particular test environment, and for the global list of excludes for a
particular file system.  So in the gce-xfstests context, this is the
difference between the excludes in the files:

	fs/ext4/excludes
vs
	fs/ext4/cfg/bigalloc.exclude

even if I only cared about, say, how things ran on GCE using
SSD-backed Persistent Disk (never mind that I can only run
gce-xfstests on Local SSD, and PD Extreme, etc.), failure percentages
would never make sense for fs/ext4/excludes, since that covers
multiple file system configs.  And my infrastructure supports kvm,
gce, and Android, as well as some people (such as at $WORK for our
data center kernels) who run the test appliacce directly on bare
metal, so I wouldn't use the failure percentages in these files, etc.

Now, what I *do* is to track this sort of thing in my own notes, e.g:

generic/051	ext4/adv	Failure percentage: 16% (4/25)
    "Basic log recovery stress test - do lots of stuff, shut down in
    the middle of it and check that recovery runs to completion and
    everything can be successfully removed afterwards."

generic/410 nojournal	Couldn't reproduce after running 25 times
     "Test mount shared subtrees, verify the state transitions..."

generic/68[12]	encrypt   Failure percentage: 100%
    The directory does grow, but blocks aren't charged to either root or
    the non-privileged users' quota.  So this appears to be a real bug.


There is one thing that I'd like to add to upstream fstests, and that
is some kind of option so that "check --retry-failures NN" would cause
fstests to automatically, upon finding a test failure, will rerun that
failing test NN aditional times.  Another potential related feature
which we currently have in our daily spinner infrastructure at $WORK
would be to on a test failure, rerun a test up to M times (typically a
small number, such as 3), and if it passes on a retry attempt, declare
the test result as "flaky", and stop running the retries.  If the test
repeatedly fails after M attempts, then the test result is "fail".

These results would be reported in the junit XML file, and would allow
the test runners to annotate their test summaries appropriately.

I'm thinking about trying to implement something like this in my
copious spare time; but before I do, does the general idea seem
acceptable?

Thanks,

					- Ted
