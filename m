Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684F6DE9F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 05:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDLDpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLDpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18E40D7;
        Tue, 11 Apr 2023 20:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C20B36101C;
        Wed, 12 Apr 2023 03:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236ABC433EF;
        Wed, 12 Apr 2023 03:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681271104;
        bh=3jTdlLsyChWM8y6Aveuf5s29ciELZbaW/aXxDAg/ROc=;
        h=Date:Subject:From:To:Cc:From;
        b=HrcwzEZDay384BSyK/lW278fMMupHDNOmg0Extxl44wG23LftWvmn8RKmJH9kIz60
         C2uFQVTKAsjB8I6r9Xm4q5jxnxVvxsqXpSGSNESo39Db6IKy+1Alsn7VgqPyFvHvw/
         hH6ZZXpEoWnu0+LiB6iw+fpzX6GAImWErdYcnN5wO0m/pSFkSvPndQZQvja07dBSpF
         7JdMkWfw//BiY9N5IUUtS+TEyZPlrMEMbG8OvI8npKOmQDf9Qct8mBPYpHQejgC2AM
         niSSrOpB5WbNGLCDQGqu/XmmAX5zvcu/h5MD8LZy06BK+yflRS1VOLde1/IpD70xAj
         0CUmkKF1FheFw==
Date:   Tue, 11 Apr 2023 20:45:03 -0700
Subject: [GIT PULL 1/22] xfs: design documentation for online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     dchinner@fromorbit.com, djwong@kernel.org
Cc:     allison.henderson@oracle.com, catherine.hoang@oracle.com,
        chandan.babu@oracle.com, david@fromorbit.com, dchinner@redhat.com,
        hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, willy@infradead.org
Message-ID: <168127093760.417736.12181322234550374115.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

Please pull this branch with changes for xfs.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/online-fsck-design-6.4_2023-04-11

for you to fetch changes up to 03786f0afb2ed5705a0478e14fea50a7f1a44f7e:

xfs: document future directions of online fsck (2023-04-11 18:59:52 -0700)

----------------------------------------------------------------
xfs: design documentation for online fsck [v24.5]

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
to the existing scrub code, which is the first 20%% of the patches.
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

5. Can I just merge all of this?

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

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (14):
xfs: document the motivation for online fsck design
xfs: document the general theory underlying online fsck design
xfs: document the testing plan for online fsck
xfs: document the user interface for online fsck
xfs: document the filesystem metadata checking strategy
xfs: document how online fsck deals with eventual consistency
xfs: document pageable kernel memory
xfs: document btree bulk loading
xfs: document online file metadata repair code
xfs: document full filesystem scans for online fsck
xfs: document metadata file repair
xfs: document directory tree repairs
xfs: document the userspace fsck driver program
xfs: document future directions of online fsck

Documentation/filesystems/index.rst                |    1 +
.../filesystems/xfs-online-fsck-design.rst         | 5315 ++++++++++++++++++++
.../filesystems/xfs-self-describing-metadata.rst   |    1 +
3 files changed, 5317 insertions(+)
create mode 100644 Documentation/filesystems/xfs-online-fsck-design.rst

