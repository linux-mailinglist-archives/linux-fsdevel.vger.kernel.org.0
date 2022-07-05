Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E54156613B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 04:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiGECaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 22:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiGECaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:30:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359BD12B;
        Mon,  4 Jul 2022 19:30:15 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2652T3Eb014803
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Jul 2022 22:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656988148; bh=vkToY3+0z2gJ/zZAIOzcr5HC/HYL/fc9AWQRgjk7pyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Tvc+I/agdb1zplF1kXuCvZ7fGcjg+Hm7PFnvPp6XKACnKp1vD0AXrIV+ibEcg8aVI
         0BE7Ot3na4nhDWnRgcWB7YhTOILP+mC5D/BJBiqBTJ7vueC9J7DP2Y92CFwCRYnf4i
         q26iT3aR2mcysUzyi3OBzJL820Xxln6AiEZKjn/E5dT+85hcj7kiM3qHYic8ZM5x1I
         EgIkSxGQHyeaTN8CcatHp8TbjgFfjfUYbjM16xaRIDuGo9Uwfnl/02GbVChhfkv9uh
         HXPwXOZqPGP05oJK4DciaFBmMpLlqsUQOPROIG7XGUNdYPnJrf++F0XB3z8wnfoQ+z
         c/oKTgrk8ftAg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 021B015C4331; Mon,  4 Jul 2022 22:29:02 -0400 (EDT)
Date:   Mon, 4 Jul 2022 22:29:02 -0400
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
Message-ID: <YsOh7tbbAiNW/1Jx@mit.edu>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
 <20220704032516.GC3237952@dread.disaster.area>
 <CAOQ4uxj5wabQvsGELS7t_Z9Z4Z2ZUHAR8d+LBao89ANErwZ95g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj5wabQvsGELS7t_Z9Z4Z2ZUHAR8d+LBao89ANErwZ95g@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:58:22AM +0300, Amir Goldstein wrote:
> I had the humble notion that we should make running fstests to
> passing-by developers as easy as possible, because I have had the
> chance to get feedback from some developers on their first time
> attempt to run fstests and it wasn't pleasant, but nevermind.
> -g auto -x soak is fine.

I really don't think using some kind of group exclusion is the right
way to go.  First of all, the definition "determinism" keeps shifting
around.  The most recent way you've used it, it's for "passing-by
developers" to be able to tell if their patches may have caused a
regression.  Is that right.

Secondly, a group-based exclusion list is problematic because groups
are fixed with respect to a kernel version (and therefore will very
easily go out of date), and they are fixed with respect to a file
system type, and which tests will either fail or be flaky will vary,
widly, by file system type.

For example to the "fixed in time" problem, I had a global exclude for
the following tests: generic/471 generic/484 generic/554.  That's
because they were failing for me all the time, with various resources
that made them test or global kernel bugs.  But unless you regularly
check to see whether a test which is on a particular exclusion list or
in some magic "soak" group (and "soak is a ***massive*** misnomer ---
the group as you've proposed it should really be named
"might-fail-perhaps-on-some-fs-type-or-config"), the tests could
remain on the list long after the test bug or the kernel bug has been
addressed.

So as of commit 7fd7c21547a1 ("test-appliance: add kernel version
conditionals using cpp to exclude files") in xfstests-bld, generic/471
and generic/484 are only excluded when testing LTS kernels older than
5.10, and generic/554 is only excluded when testing LTS kernels older
than 5.4.  The point is (a) you can't easily do version-specific
exclusions with xfstests group declarations, and (b) someone needs to
periodically sweep through the tests to see if tests should be in the
soak or "might-fail-perhaps-on-some-fs-type-or-config" group.

As an example of why you're going to want to do the exclusions on a
per-file system basis, consider the tests that would have to be added
to the "might-fail-perhaps-on-some-fs-type-or-config".  If the goal is
to let "drive-by developer to know whether their has caused a
regression", especially someone like Willy who might be modifying a
large number of testers, then you would need to add at *least* 135
tests to the "soak" or "might-fail-perhaps-on-some-fs-type-or-config"
group:

(These are current test failures that I have observed using
v4.19-rc4.)

btrfs/default: 1176 tests, 7 failures, 244 skipped, 8937 seconds
  Failures: btrfs/012 btrfs/219 btrfs/235 generic/041 generic/297
    generic/298 shared/298
exfat/default: 1222 tests, 23 failures, 552 skipped, 1561 seconds
  Failures: generic/013 generic/309 generic/310 generic/394
    generic/409 generic/410 generic/411 generic/428 generic/430
    generic/431 generic/432 generic/433 generic/438 generic/443
    generic/465 generic/490 generic/519 generic/563 generic/565
    generic/591 generic/633 generic/639 generic/676
ext2/default: 1188 tests, 4 failures, 472 skipped, 2803 seconds
  Failures: generic/347 generic/607 generic/614 generic/631
f2fs/default: 877 tests, 5 failures, 217 skipped, 4249 seconds
  Failures: generic/050 generic/064 generic/252 generic/506
    generic/563
jfs/default: 1074 tests, 62 failures, 404 skipped, 3695 seconds
  Failures: generic/015 generic/034 generic/039 generic/040
    generic/041 generic/056 generic/057 generic/065 generic/066
    generic/073 generic/079 generic/083 generic/090 generic/101
    generic/102 generic/104 generic/106 generic/107 generic/204
    generic/226 generic/258 generic/260 generic/269 generic/288
    generic/321 generic/322 generic/325 generic/335 generic/336
    generic/341 generic/342 generic/343 generic/348 generic/376
    generic/405 generic/416 generic/424 generic/427 generic/467
    generic/475 generic/479 generic/480 generic/481 generic/489
    generic/498 generic/502 generic/510 generic/520 generic/526
    generic/527 generic/534 generic/535 generic/537 generic/547
    generic/552 generic/557 generic/563 generic/607 generic/614
    generic/629 generic/640 generic/690
nfs/loopback: 818 tests, 2 failures, 345 skipped, 9365 seconds
  Failures: generic/426 generic/551
reiserfs/default: 1076 tests, 25 failures, 413 skipped, 3368 seconds
  Failures: generic/102 generic/232 generic/235 generic/258
    generic/321 generic/355 generic/381 generic/382 generic/383
    generic/385 generic/386 generic/394 generic/418 generic/520
    generic/533 generic/535 generic/563 generic/566 generic/594
    generic/603 generic/614 generic/620 generic/634 generic/643
    generic/691
vfat/default: 1197 tests, 42 failures, 528 skipped, 4616 seconds
  Failures: generic/003 generic/130 generic/192 generic/213
    generic/221 generic/258 generic/309 generic/310 generic/313
    generic/394 generic/409 generic/410 generic/411 generic/428
    generic/430 generic/431 generic/432 generic/433 generic/438
    generic/443 generic/465 generic/467 generic/477 generic/495
    generic/519 generic/563 generic/565 generic/568 generic/569
    generic/589 generic/632 generic/633 generic/637 generic/638
    generic/639 generic/644 generic/645 generic/656 generic/676
    generic/683 generic/688 generic/689

This is not *all* of the tests.  There are a number of file system
types that are causing the VM to crash.  I haven't had time this
weekend to figure out what tests need to be added to the exclude group
for udf, ubifs, overlayfs, etc.  So there might be even *more* tests
that we would need to be added to the
"might-fail-perhaps-on-some-fs-type-or-config" group.

It *could* be fewer, if we want to exclude reiserfs and jfs, on the
theory that they might be deprecated soon.  But there are still some
very commonly used file systems, such as vfat, exfat, etc., that have
a *huge* number of failing tests that is going to make life unpleasant
for the drive-by developer/tester.  And there are other file systems
which will cause a kernel crash or lockup on v4.19-rc4, which
certainly will give trouble for the drive-by tester.

Which is why I argue that using a group, whether it's called soak, or
something else, to exclude all of the tests that might fail and thus
confuse the passing-by fs testers is the best way to go.

> The reason I suggested that *we* change our habits is because
> we want to give passing-by fs testers an easier experience.

Realistically, if we want to give passing-by fs testers an easier
experience, we need to give these testers more turn-key experience.
This was part of my original goals when I created kvm-xfstests and
gce-xfstests.  This is why I upload pre-created VM images for
kvm-xfstests and gce-xfstests --- so people don't have to build
xfstests and all their dependencies, and to figure out how to set up
and configure it.  For example, it means that I can tell ext4
developers to just run "kvm-xfstests smoke" as a bare minimum before
sending me a patch for review.  

There is more that we clearly need to do if we want to make something
which is completely turn-key for a drive-by tester, especially if they
need to test more than just ext4 and xfs.  I have some ideas, and this
is something that I'm hoping to do more work in the next few months.
If someone is interested in contributing some time and energy to this
project, please give me a ring.  Many hands make light work, and all that.

Cheers,

	 	     	  	      	    - Ted


