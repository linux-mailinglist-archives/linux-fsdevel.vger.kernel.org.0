Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E10C5641BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiGBRCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 13:02:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543AFDFEC;
        Sat,  2 Jul 2022 10:02:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 262H1Mcw005085
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 2 Jul 2022 13:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656781287; bh=YP1/tEtj9VsIJb/YIEUR2pIcNgtT3bFvYv3Fm1d9240=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dJFOSUIIKSktp2BGhJUbbk9/eKhfPkuallTgI21xVjs/4px1B7XIc1cUapo4ESae0
         G1QEAmgGTHHd2lyWP2Z2Ajw+M9nlYudU4pTkFN+71zfudqmy41U6ROy9XxjnPgkkUr
         UpxDJljyT5nA9vHzdyEUGyCzARkGln8yGSxrd7gOFE7AOGno1oFH0Bx3bG/T46ZFtm
         f9TryQ6GPX/ZAC9u56PLh/+vMheqGX1kUsGTGzTfvjAgKHQsL4s0xOTWLVCznLeLrv
         TdZ4bjSDXmUdXHUXvFw99zQV9oZtEWKPr/9EhLFukivnj5nYlyUp9if9jKYJ+03t4v
         pv3Q0S8KwYE6w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B343315C3E94; Sat,  2 Jul 2022 13:01:22 -0400 (EDT)
Date:   Sat, 2 Jul 2022 13:01:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <YsB54p1vpBg4v2Xd@mit.edu>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
 <YoZbF90qS+LlSDfS@casper.infradead.org>
 <20220519154419.ziy4esm4tgikejvj@zlang-mailbox>
 <YoZq7/lr8hvcs9T3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZq7/lr8hvcs9T3@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 05:06:07PM +0100, Matthew Wilcox wrote:
> 
> Right, but that's the personal perspective of an expert tester.  I don't
> particularly want to build that expertise myself; I want to write patches
> which touch dozens of filesystems, and I want to be able to smoke-test
> those patches.  Maybe xfstests or kdevops doesn't want to solve that
> problem, but that would seem like a waste of other peoples time.

Willy,

For your use case I'm guessing that you have two major concerns:

  * bugs that you may have introduced when "which touch dozens of
    filesystems"

  * bugs in the core mm and fs-writeback code which may be much
    more substantive/complex changes.

Would you say that is correct?

At least for ext4 and xfs, it's probably quite sufficient just to run
the -g auto group for the ext4/4k and xfs/4k test configs --- that is
the standard default file system configs using the 4k block size.
Both of these currently don't require any test exclusions for
kvm-xfstests or gce-xfstests when running the auto group.  And so for
the purposes of catching bugs in the core MM/VFS layer and any changes
that the folio patches are likely to touch for ext4 and xfs, it's the
auto group for ext4/4k and xfs/4k is probably quite sufficient.
Testing the more exotic test configs, such as bigalloc for ext4, or
realtime for xfs, or the external log configs, are not likely to be
relevant for the folio patches.

Note: I recommend that you skip using the loop device xfstests
strategy, which Luis likes to advocate.  For the perspective of
*likely* regressions caused by the Folio patches, I claim they are
going to cause you more pain than they are worth.  If there are some
strange Folio/loop device interactions, they aren't likely going to be
obvious/reproduceable failures that will cause pain to linux-next
testers.  While it would be nice to find **all** possible bugs before
patches go usptream to Linus, if it slows down your development
velocity to near-standstill, it's not worth it.  We have to be
realistic about things.


What about other file systems?  Well, first of all, xfstests only has
support for the following file systems:

	9p btrfs ceph cifs exfat ext2 ext4 f2fs gfs glusterfs jfs msdos
	nfs ocfs2 overlay pvfs2 reiserfs tmpfs ubifs udf vfat virtiofs xfs

{kvm,gce}-xfstests supports these 16 file systems:

	9p btrfs exfat ext2 ext4 f2fs jfs msdos nfs overlay reiserfs
	tmpfs ubifs udf vfat xfs

kdevops has support for these file systems:

	btrfs ext4 xfs

So realistically, you're not going to have *full* test coverage for
all of the file systems you might want to touch, no matter what you
do.  And even for those file systems that are technically supported by
xfstests and kvm-xfstests, if they aren't being regularly run (for
example, exfat, 9p, ubifs, udf, etc.) there may be bitrot and very
likely there is no one actively *to* maintain exclude files.  For that
matter, there might not be anyone you could turn to for help
interpreting the test results.

So....  I believe the most realistic thing is to do is to run xfstests
on a simple set of configs --- using no special mkfs or mount options
--- first against the baseline, and then after you've applied your
folio patches.  If there are any new test failures, do something like:

   kvm-xfstests -c f2fs/default -C 10 generic/013

to check to see whether it's a hard failure or not.  If it's a hard
failure, then it's a problem with your patches.  If it's a flaky
failure, it's possible you'll need to repeat the test against the baseline:

   git checkout origin; kbuild
   kvm-xfstests -c f2fs/default -C 10 generic/013

If it's also flaky on the baseline, you can ignore the test failure
for the purposes of folio development.

There are more complex things you could do, such as running a baseline
set of tests 500 times (as Luis suggests), but I believe that for your
use case, it's not a good use of your time.  You'd need to speed
several weeks finding *all* the flaky tests up front, especially if
you want to do this for a large set of file systems.  It's much more
efficient to check if a suspetected test regression is really a flaky
test result when you come across them.

I'd also suggest using the -g quick tests for file systems other than
ext4 and xfs.  That's probably going to be quite sufficient for
finding obvious problems that might be introduced when you're making
changes to f2fs, btrfs, etc., and it will reduce the number of
potential flaky tests that you might have to handle.


It should be possible to automate this, and Leah and I have talked
about designs to automate this process.  Leah has some rough scripts
that do a semantic-style diff for the baseline and after applying the
proposed xfs backports.  So it operates on something like this:

f2fs/default: 868 tests, 10 failures, 217 skipped, 6899 seconds
  Failures: generic/050 generic/064 generic/252 generic/342
    generic/383 generic/502 generic/506 generic/526 generic/527
    generic/563

In theory, we could also have automated tools that look for the
suspected test regressions, and then try running those test
regressions 20 or 25 times on the baseline and after applying the
patch series.  Those don't exist yet, but it's just a Mere Matter of
Programming.  :-)

I can't promise anything, especially with dates, but developing better
automation tools to support the xfs stable backports is on our
near-term roadmap --- and that would probably be applicable for for
folio development usecase.

Cheers,

					- Ted
