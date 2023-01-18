Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04293671142
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 03:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjARCiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 21:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjARCix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:38:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298DD4FCF0;
        Tue, 17 Jan 2023 18:38:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50E0BB81A3D;
        Wed, 18 Jan 2023 02:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E354CC433D2;
        Wed, 18 Jan 2023 02:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674009527;
        bh=RCaC9ZBWKlyghYvcm99QSQPUb+L+JOUFGH09vUmXACw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlLLs8BGBBcHsP15uZ2JQ692jyhRJs/4a5n31xktNOGWBxYOgqAbjLnGHIojiUdli
         tg30BJJTN7l3+hS9NcHKHJ+oPcmkjfUxdBBQ8NGvc5s9grvSG43SMpDKEXiJjMpGTw
         rqFeNNTlWq5w+P+ie2VJgj83qq0OBz/hBijup6JVo4G96wn8rjoNBMnDHS6bKMXhb6
         cJck8eVVNh4M+1x5+MFoMsKqDLMyeR0bgLrZJZDnPSXP3is+DJl8L9V3tegIH49FX5
         WrHByEQgk55OJaMk5jzSwzt/cAh5Qkmm3OPKTZ2XaLoCGvAwIKFY9/HSQ3YQiEPDWS
         UWClTW6PHfN8g==
Date:   Tue, 17 Jan 2023 18:38:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 03/14] xfs: document the testing plan for online fsck
Message-ID: <Y8dbt1g7SS6P3kKA@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825203.682859.1144819928544539264.stgit@magnolia>
 <77b0b494dc2a78c14805c2d9300f839ec25f0330.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77b0b494dc2a78c14805c2d9300f839ec25f0330.camel@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:03:17AM +0000, Allison Henderson wrote:
> On Fri, 2022-12-30 at 14:10 -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Start the third chapter of the online fsck design documentation. 
> > This
> > covers the testing plan to make sure that both online and offline
> > fsck
> > can detect arbitrary problems and correct them without making things
> > worse.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  187
> > ++++++++++++++++++++
> >  1 file changed, 187 insertions(+)
> > 
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index a03a7b9f0250..d630b6bdbe4a 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -563,3 +563,190 @@ functionality.
> >  Many of these risks are inherent to software programming.
> >  Despite this, it is hoped that this new functionality will prove
> > useful in
> >  reducing unexpected downtime.
> > +
> > +3. Testing Plan
> > +===============
> > +
> > +As stated before, fsck tools have three main goals:
> > +
> > +1. Detect inconsistencies in the metadata;
> > +
> > +2. Eliminate those inconsistencies; and
> > +
> > +3. Minimize further loss of data.
> > +
> > +Demonstrations of correct operation are necessary to build users'
> > confidence
> > +that the software behaves within expectations.
> > +Unfortunately, it was not really feasible to perform regular
> > exhaustive testing
> > +of every aspect of a fsck tool until the introduction of low-cost
> > virtual
> > +machines with high-IOPS storage.
> > +With ample hardware availability in mind, the testing strategy for
> > the online
> > +fsck project involves differential analysis against the existing
> > fsck tools and
> > +systematic testing of every attribute of every type of metadata
> > object.
> > +Testing can be split into four major categories, as discussed below.
> > +
> > +Integrated Testing with fstests
> > +-------------------------------
> > +
> > +The primary goal of any free software QA effort is to make testing
> > as
> > +inexpensive and widespread as possible to maximize the scaling
> > advantages of
> > +community.
> > +In other words, testing should maximize the breadth of filesystem
> > configuration
> > +scenarios and hardware setups.
> > +This improves code quality by enabling the authors of online fsck to
> > find and
> > +fix bugs early, and helps developers of new features to find
> > integration
> > +issues earlier in their development effort.
> > +
> > +The Linux filesystem community shares a common QA testing suite,
> > +`fstests
> > <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/>`_, for
> > +functional and regression testing.
> > +Even before development work began on online fsck, fstests (when run
> > on XFS)
> > +would run both the ``xfs_check`` and ``xfs_repair -n`` commands on
> > the test and
> > +scratch filesystems between each test.
> > +This provides a level of assurance that the kernel and the fsck
> > tools stay in
> > +alignment about what constitutes consistent metadata.
> > +During development of the online checking code, fstests was modified
> > to run
> > +``xfs_scrub -n`` between each test to ensure that the new checking
> > code
> > +produces the same results as the two existing fsck tools.
> > +
> > +To start development of online repair, fstests was modified to run
> > +``xfs_repair`` to rebuild the filesystem's metadata indices between
> > tests.
> > +This ensures that offline repair does not crash, leave a corrupt
> > filesystem
> > +after it exists, or trigger complaints from the online check.
> > +This also established a baseline for what can and cannot be repaired
> > offline.
> > +To complete the first phase of development of online repair, fstests
> > was
> > +modified to be able to run ``xfs_scrub`` in a "force rebuild" mode.
> > +This enables a comparison of the effectiveness of online repair as
> > compared to
> > +the existing offline repair tools.
> > +
> > +General Fuzz Testing of Metadata Blocks
> > +---------------------------------------
> > +
> > +XFS benefits greatly from having a very robust debugging tool,
> > ``xfs_db``.
> > +
> > +Before development of online fsck even began, a set of fstests were
> > created
> > +to test the rather common fault that entire metadata blocks get
> > corrupted.
> > +This required the creation of fstests library code that can create a
> > filesystem
> > +containing every possible type of metadata object.
> > +Next, individual test cases were created to create a test
> > filesystem, identify
> > +a single block of a specific type of metadata object, trash it with
> > the
> > +existing ``blocktrash`` command in ``xfs_db``, and test the reaction
> > of a
> > +particular metadata validation strategy.
> > +
> > +This earlier test suite enabled XFS developers to test the ability
> > of the
> > +in-kernel validation functions and the ability of the offline fsck
> > tool to
> > +detect and eliminate the inconsistent metadata.
> > +This part of the test suite was extended to cover online fsck in
> > exactly the
> > +same manner.
> > +
> > +In other words, for a given fstests filesystem configuration:
> > +
> > +* For each metadata object existing on the filesystem:
> > +
> > +  * Write garbage to it
> > +
> > +  * Test the reactions of:
> > +
> > +    1. The kernel verifiers to stop obviously bad metadata
> > +    2. Offline repair (``xfs_repair``) to detect and fix
> > +    3. Online repair (``xfs_scrub``) to detect and fix
> > +
> > +Targeted Fuzz Testing of Metadata Records
> > +-----------------------------------------
> > +
> > +A quick conversation with the other XFS developers revealed that the
> > existing
> > +test infrastructure could be extended to provide 
> 
> "The testing plan for ofsck includes extending the existing test 
> infrastructure to provide..."
> 
> Took me a moment to notice we're not talking about history any more....

Ah.  Sorry about that.  The sentence now reads:

"The testing plan for online fsck includes extending the existing fs
testing infrastructure to provide a much more powerful facility:
targeted fuzz testing of every metadata field of every metadata object
in the filesystem."

> > a much more powerful
> > +facility: targeted fuzz testing of every metadata field of every
> > metadata
> > +object in the filesystem.
> > +``xfs_db`` can modify every field of every metadata structure in
> > every
> > +block in the filesystem to simulate the effects of memory corruption
> > and
> > +software bugs.
> > +Given that fstests already contains the ability to create a
> > filesystem
> > +containing every metadata format known to the filesystem, ``xfs_db``
> > can be
> > +used to perform exhaustive fuzz testing!
> > +
> > +For a given fstests filesystem configuration:
> > +
> > +* For each metadata object existing on the filesystem...
> > +
> > +  * For each record inside that metadata object...
> > +
> > +    * For each field inside that record...
> > +
> > +      * For each conceivable type of transformation that can be
> > applied to a bit field...
> > +
> > +        1. Clear all bits
> > +        2. Set all bits
> > +        3. Toggle the most significant bit
> > +        4. Toggle the middle bit
> > +        5. Toggle the least significant bit
> > +        6. Add a small quantity
> > +        7. Subtract a small quantity
> > +        8. Randomize the contents
> > +
> > +        * ...test the reactions of:
> > +
> > +          1. The kernel verifiers to stop obviously bad metadata
> > +          2. Offline checking (``xfs_repair -n``)
> > +          3. Offline repair (``xfs_repair``)
> > +          4. Online checking (``xfs_scrub -n``)
> > +          5. Online repair (``xfs_scrub``)
> > +          6. Both repair tools (``xfs_scrub`` and then
> > ``xfs_repair`` if online repair doesn't succeed)
> I like the indented bullet list format tho

Thanks!  I'm pleased that ... whatever renders this stuff ... actually
supports nested lists.

> > +
> > +This is quite the combinatoric explosion!
> > +
> > +Fortunately, having this much test coverage makes it easy for XFS
> > developers to
> > +check the responses of XFS' fsck tools.
> > +Since the introduction of the fuzz testing framework, these tests
> > have been
> > +used to discover incorrect repair code and missing functionality for
> > entire
> > +classes of metadata objects in ``xfs_repair``.
> > +The enhanced testing was used to finalize the deprecation of
> > ``xfs_check`` by
> > +confirming that ``xfs_repair`` could detect at least as many
> > corruptions as
> > +the older tool.
> > +
> > +These tests have been very valuable for ``xfs_scrub`` in the same
> > ways -- they
> > +allow the online fsck developers to compare online fsck against
> > offline fsck,
> > +and they enable XFS developers to find deficiencies in the code
> > base.
> > +
> > +Proposed patchsets include
> > +`general fuzzer improvements
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.g
> > it/log/?h=fuzzer-improvements>`_,
> > +`fuzzing baselines
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.g
> > it/log/?h=fuzz-baseline>`_,
> > +and `improvements in fuzz testing comprehensiveness
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.g
> > it/log/?h=more-fuzz-testing>`_.
> > +
> > +Stress Testing
> > +--------------
> > +
> > +A unique requirement to online fsck is the ability to operate on a
> > filesystem
> > +concurrently with regular workloads.
> > +Although it is of course impossible to run ``xfs_scrub`` with *zero*
> > observable
> > +impact on the running system, the online repair code should never
> > introduce
> > +inconsistencies into the filesystem metadata, and regular workloads
> > should
> > +never notice resource starvation.
> > +To verify that these conditions are being met, fstests has been
> > enhanced in
> > +the following ways:
> > +
> > +* For each scrub item type, create a test to exercise checking that
> > item type
> > +  while running ``fsstress``.
> > +* For each scrub item type, create a test to exercise repairing that
> > item type
> > +  while running ``fsstress``.
> > +* Race ``fsstress`` and ``xfs_scrub -n`` to ensure that checking the
> > whole
> > +  filesystem doesn't cause problems.
> > +* Race ``fsstress`` and ``xfs_scrub`` in force-rebuild mode to
> > ensure that
> > +  force-repairing the whole filesystem doesn't cause problems.
> > +* Race ``xfs_scrub`` in check and force-repair mode against
> > ``fsstress`` while
> > +  freezing and thawing the filesystem.
> > +* Race ``xfs_scrub`` in check and force-repair mode against
> > ``fsstress`` while
> > +  remounting the filesystem read-only and read-write.
> > +* The same, but running ``fsx`` instead of ``fsstress``.  (Not done
> > yet?)
> > +
> > +Success is defined by the ability to run all of these tests without
> > observing
> > +any unexpected filesystem shutdowns due to corrupted metadata,
> > kernel hang
> > +check warnings, or any other sort of mischief.
> 
> Seems reasonable.  Other than the one nit, I think this section reads
> pretty well.
> Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

Woo!

--D

> Allison
> > +
> > +Proposed patchsets include `general stress testing
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.g
> > it/log/?h=race-scrub-and-mount-state-changes>`_
> > +and the `evolution of existing per-function stress testing
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.g
> > it/log/?h=refactor-scrub-stress>`_.
> > 
> 
