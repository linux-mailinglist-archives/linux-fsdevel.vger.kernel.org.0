Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1465F2497
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJBSX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJBSXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0250D25295;
        Sun,  2 Oct 2022 11:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69FD960EFD;
        Sun,  2 Oct 2022 18:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2336C433D6;
        Sun,  2 Oct 2022 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664735002;
        bh=R5rco/Adg7gtF7f1H6/jhwzvu66VL8b5efPjc60F8JE=;
        h=Subject:From:To:Cc:Date:From;
        b=Ob/+xzT+puItAXkn3G1LgEB/mHyeM2CuDLUMw/XWX1r0Nn/yIO3dhH7LfJEaidM7J
         Mb42PVC1LpqE+vhqPKXg4yYpbdpMAiBqtaZ7QMtp6OTZ9cBoKMzdy1syL3EHq43hhx
         nyQzyYUKw6PpFGiTloexLSOGV3dYMOTwDbLXcI0StrbW5qXjdAQDY7HVD/zymD7rhm
         ObFmFZwNs+qzsCTnkJzXT93Xv+9uIFEQUvGignDolefD32ZeTHvAOwKWMZwdwUjZgJ
         ETMj47uj4rGWFdHGj2a+sHvhOHr216bIaGyLJzK98b3169KXvCnJi5H0gYd+KPrV7D
         XaQnHtcnMp/Ow==
Subject: [PATCHSET v23.3 00/14] xfs: design documentation for online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Sun, 02 Oct 2022 11:19:43 -0700
Message-ID: <166473478338.1082796.8807888906305023929.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

After six years of development and a nearly two year hiatus from
patchbombing, I think it is time to resume the process of merging the
online fsck feature into XFS.  The full patchset comprises 105 separate
patchsets that capture 470 patches across the kernel, xfsprogs, and
fstests projects.

I would like to merge this feature into upstream in time for the 2023
LTS kernel.  As of 5.15 (aka last year's LTS), we have merged all
generally useful infrastructure improvements into the regular
filesystem.  The only changes to the core filesystem that remain are the
ones that are only useful to online fsck itself.  In other words, the
vast majority of the new code in the patchsets comprising the online
fsck feature are is mostly self contained and can be turned off via
Kconfig.

Many of you readers might be wondering -- why have I chosen to make one
large submission with 100+ patchsets comprising ~500 patches?  Why
didn't I merge small pieces of functionality bit by bit and revise
common code as necessary?  Well, the simple answer is that in the past
six years, the fundamental algorithms have been revised repeatedly as
I've built out the functionality.  In other words, the codebase as it is
now has the benefit that I now know every piece that's necessary to get
the job done in a reasonable manner and within the constraints laid out
by community reviews.  I believe this has reduced code churn in mainline
and freed up my time so that I can iterate faster.

As a concession to the mail servers, I'm breaking up the submission into
smaller pieces; I'm only pushing the design document and the revisions
to the existing scrub code, which is the first 20% of the patches.
Also, I'm arbitrarily restarting the version numbering by reversioning
all patchsets from version 22 to epoch 23, version 1.

The big question to everyone reading this is: How might I convince you
that there is more merit in merging the whole feature and dealing with
the consequences than continuing to maintain it out of tree?

---------

To prepare the XFS community and potential patch reviewers for the
upstream submission of the online fsck feature, I decided to write a
document capturing the broader picture behind the online repair
development effort.  The document begins by defining the problems that
online fsck aims to solve and outlining specific use cases for the
functionality.

Using that as a base, the rest of the design document presents the high
level algorithms that fulfill the goals set out at the start and the
interactions between the large pieces of the system.  Case studies round
out the design documentation by adding the details of exactly how
specific parts of the online fsck code integrate the algorithms with the
filesystem.

The goal of this effort is to help the XFS community understand how the
gigantic online repair patchset works.  The questions I submit to the
community reviewers are:

1. As you read the design doc (and later the code), do you feel that you
   understand what's going on well enough to try to fix a bug if you
   found one?

2. What sorts of interactions between systems (or between scrub and the
   rest of the kernel) am I missing?

3. Do you feel confident enough in the implementation as it is now that
   the benefits of merging the feature (as EXPERIMENTAL) outweigh any
   potential disruptions to XFS at large?

4. Are there problematic interactions between subsystems that ought to
   be cleared up before merging?

I intend to commit this document to the kernel's documentation directory
when we start merging the patchset, albeit without the links to
git.kernel.org.  A much more readable version of this is posted at:
https://djwong.org/docs/xfs-online-fsck-design/

v2: add missing sections about: all the in-kernel data structures and
    new apis that the scrub and repair functions use; how xattrs and
    directories are checked; how space btree records are checked; and
    add more details to the parts where all these bits tie together.
    Proofread for verb tense inconsistencies and eliminate vague 'we'
    usage.  Move all the discussion of what we can do with pageable
    kernel memory into a single source file and section.  Document where
    log incompat feature locks fit into the locking model.

v3: resync with 6.0, fix a few typos, begin discussion of the merging
    plan for this megapatchset.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=online-fsck-design
---
 Documentation/filesystems/index.rst                |    1 
 .../filesystems/xfs-online-fsck-design.rst         | 4979 ++++++++++++++++++++
 .../filesystems/xfs-self-describing-metadata.rst   |    1 
 3 files changed, 4981 insertions(+)
 create mode 100644 Documentation/filesystems/xfs-online-fsck-design.rst

