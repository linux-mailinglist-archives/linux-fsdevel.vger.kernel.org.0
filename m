Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366DD58BC57
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Aug 2022 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiHGSaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Aug 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiHGSaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:30:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A6658C;
        Sun,  7 Aug 2022 11:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E099B80DBA;
        Sun,  7 Aug 2022 18:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA641C433D6;
        Sun,  7 Aug 2022 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897006;
        bh=8Vw2YFY5J7koDnNCX/O6grs/EpKphohfXPoo9RuIfNw=;
        h=Subject:From:To:Cc:Date:From;
        b=hGksHiyIbk+AOiFioSc3CrGNCmNfeh08W/2GV4ndjapF+bmczUQGm567nGszZAQAb
         rBptmJAsbJfcXXwmMx3pRdOVeQn4PYNb2dwwDTTntc46ots5UbvAA7OBhPeZ4mva4k
         JMawi/hVxdt8XBPoUA5P5hpaXypTnQUKHNQ7HKRxEHZAPCgfPYrsllFpApEk4thjJY
         f7ZeDpH8pgwAV5z7ZVtLKLnJuk2v3vQz1+EBlauYy/Ac5VfXZhpfOWxGhNhXlpJTxR
         70W/QQ4Stpt4VOAzG8AEf7SPfUcN19iC0b5avBfBFQOt/DCXGagkHQ+wz6SecVebfV
         RGQk+pcSd2tcQ==
Subject: [PATCHSET v2 00/14] xfs: design documentation for online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Sun, 07 Aug 2022 11:30:05 -0700
Message-ID: <165989700514.2495930.13997256907290563223.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

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
around the time we start merging the patchset, albeit without the links
to git.kernel.org.  A much more readable version of this is posted at:
https://djwong.org/docs/xfs-online-fsck-design/

v2: add missing sections about: all the in-kernel data structures and
    new apis that the scrub and repair functions use; how xattrs and
    directories are checked; how space btree records are checked; and
    add more details to the parts where all these bits tie together.
    Proofread for verb tense inconsistencies and eliminate vague 'we'
    usage.  Move all the discussion of what we can do with pageable
    kernel memory into a single source file and section.  Document where
    log incompat feature locks fit into the locking model.

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

