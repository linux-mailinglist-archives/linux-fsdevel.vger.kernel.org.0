Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CF8659C6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 22:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiL3VOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 16:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiL3VOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:14:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127121C917;
        Fri, 30 Dec 2022 13:14:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C57FEB81B92;
        Fri, 30 Dec 2022 21:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6402BC433F1;
        Fri, 30 Dec 2022 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672434846;
        bh=973hIYWP6eAHqnngY5o23SwPcOWYj0/yiqEtAI9T6zk=;
        h=Date:From:To:Cc:Subject:From;
        b=MrHnL6Jwe802GSyKIvZ5xiMROqNFyhffibiP5O2ReLcv2q3J6HB6BxzTYPT2W0vLC
         xoSAMSvbi458Yo+akVvGz0dNB9Ll92qOlfkhUSKGpkLVtVzCJO2UX8hzjsgHyA50Fy
         qkcHE+uqMZq4+MkvR1yTL2/gZJgS4k4yoBrHkVeWaZz9yFMVqadTkz8blcft3jFfXv
         RU4/rGIlCwvv9upk609eGy5SZbzdNPxeaMU8waWDRcFUmcL+czZtxeWC5mo8XlyV8q
         xKtwJoYaIOD7fD7b5bFymmn5ZDJgUF43ukkwFn9YvoUNMCn9rfjS4SPxf+CFgpEG6T
         1SEiJPXdCpp4w==
Date:   Fri, 30 Dec 2022 13:14:05 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Catherine Hoang <catherine.hoang@oracle.com>, djwong@kernel.org
Cc:     xfs <linux-xfs@vger.kernel.org>, greg.marsden@oracle.com,
        shirley.ma@oracle.com, konrad.wilk@oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, tpkelly@eecs.umich.edu,
        smahar@ucsd.edu, Christoph Hellwig <hch@infradead.org>,
        fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [NYE DELUGE 2/4] xfs: online repair in its entirety
Message-ID: <Y69Unb7KRM5awJoV@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone,

As I've mentioned several times throughout 2022, I would like to merge
the online fsck feature in time for the 2023 LTS kernel.  This is the
second part of that effort.

This deluge contains all of the online repair kernel code, a significant
amount of restructuring of how repairs work in the userspace driver
program, and a ton of fstests updates to provide automated fuzz testing
and stress testing of forced repairs.

Within the kernel section, the major pieces are the use of tmpfs files
to provide pageable kernel memory for staging repair information;
lightweight hooks into the main xfs filesystem for scrub via jump
labels; coordinated inode scans for live index construction; and the
atomic file mapping swap feature.

Changes to the userspace driver program fall into two main categories:
restructuring how repairs are scheduled so that they're tracked by inode
or AG; establishing data dependency chains so that we scan and repair
things in the correct order; and reworking the systemd background
services to be more secure, enable periodic media scans, and provide
some semblance of fs corruption reporting.

The fstests changes are a substantial reworking of the fuzzing code to
fit the testing described in the design documentation; adding stress
testing of online repairs vs. fsstress; and functional tests for all the
new features that ride in with online repair.

For this review, I would like people to focus the following:

- Are the major subsystems sufficiently documented that you could figure
  out what the code does?

- Do you see any problems that are severe enough to cause long term
  support hassles? (e.g. bad API design, writing weird metadata to disk)

- Can you spot mis-interactions between the subsystems?

- What were my blind spots in devising this feature?

- Are there missing pieces that you'd like to help build?

- Can I just merge all of this?

The one thing that is /not/ in scope for this review are requests for
more refactoring of existing subsystems.  While there are usually valid
arguments for performing such cleanups, those are separate tasks to be
prioritized separately.  I will get to them after merging online fsck,
because revising existing subsystems generally involves rebasing work
in this patchset, which means the affected patches need re-reviewing.
Unless it's absolutely necessary, this just creates more work for
everybody.

I've been running daily online **repairs** of every computer I own for
the last eight months.  All modifications so far have been to optimize
data structures (holes in the xattr structures, excessively large rmap
btrees, and bugs in quota resource counter updates).  So far, no damage
has resulted from these operations.  All issues observed in that time
have been corrected in this submission.

Fuzz and stress testing of online repairs have been running well for a
year now.  As of this writing, online repair can fix slightly more
things than offline repair, and the fsstress+repair long soak test has
passed 100 million repairs with zero problems observed.

(For comparison, the long soak fsx test recently passed 92 billion file
operations, so online fsck has a ways to go...)

As a warning, the patches will likely take several days to trickle in.
While everyone else looks at this, I plan to prototype directory tree
reconstruction with Allison's parent pointers v27 patchset.  Having a
user of that functionality is (I think) the last major hurdle to
ensuring that parent pointers are a good fit for the problems that need
solving, which in turn is the last requirement for merging that feature.

--D
