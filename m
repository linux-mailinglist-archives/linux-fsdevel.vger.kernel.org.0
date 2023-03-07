Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA166AD3E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCGBar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCGBap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:30:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B71D64228;
        Mon,  6 Mar 2023 17:30:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81028B8129F;
        Tue,  7 Mar 2023 01:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D3C43444;
        Tue,  7 Mar 2023 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678152611;
        bh=RHWipRF89sHCcqpAEX7+jZhNP3YnsZ1tdaty4ukY1+Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Oxh4uMHVXNidllUJrZ/meHhLdGGjvxBQ/+tBelhISivUnOtAftea5Ag0vQ2t1LP/B
         klVV7qsClNhUKFaJ8+O4iXIa4qoENPC3FVJ8QnZ39MY1YvXPbp8lc/f3TEqZL1cFao
         oL3nkqYMdPYcdHeHC5rk7MfgrGmTxhot83unAh6l2u0A+L1+U3InA/1Ms4OW+ETeAz
         Ofi/Mt/spKpcd0gZXGE8mTOVz3gvzIje6oC4tyPaw6rDGUg2uTEj1vcsPz6MXffRT4
         k1ZYVS7wE9UzjfIF5RRCLHmDZEO6tm0xMTU+EyJ1neFw+BNX+4xaLAmBaSYwRb33mx
         e0eIR7huHlhlQ==
Subject: [PATCHSET v24.3 00/14] xfs: design documentation for online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Mon, 06 Mar 2023 17:30:10 -0800
Message-ID: <167815261056.3749904.7416638466709813374.stgit@magnolia>
In-Reply-To: <167243825144.682859.12802259329489258661.stgit@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
    plan for this megapatchset.  Bump to v24 to match the kernel code

v24.3: add review comments from Allison Henderson

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=docs-online-fsck-design
---
 Documentation/filesystems/index.rst                |    1 
 .../filesystems/xfs-online-fsck-design.rst         | 5315 ++++++++++++++++++++
 .../filesystems/xfs-self-describing-metadata.rst   |    1 
 3 files changed, 5317 insertions(+)
 create mode 100644 Documentation/filesystems/xfs-online-fsck-design.rst

