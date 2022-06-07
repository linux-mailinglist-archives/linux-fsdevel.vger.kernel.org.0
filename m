Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526553F379
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiFGBsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiFGBsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFF764D18;
        Mon,  6 Jun 2022 18:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB604611FC;
        Tue,  7 Jun 2022 01:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38305C3411C;
        Tue,  7 Jun 2022 01:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654566523;
        bh=OhFWOiULGdFJOLNoMsLgKX/jomUXp+7M1pjYewkWYW0=;
        h=Subject:From:To:Cc:Date:From;
        b=PBmphX8BPcDPRKwdss7X/jcSXhhmxXTnYOKs9ji/UcZ7EZqy+nMm/8VH4Y05AoNwD
         8HZXK32dJzXufXkIaxI5dtrzunix152RQcGyw3zZ4S7jcdkev0c5JZv8lvpeEq1swO
         5QbJgcRWZnmKUrufkk/lZnSdL9+w4o0wsOzGCxhsV/Zl8G4OvrdnI0/j0xNvg5ejMH
         VxLCNjA8241zMqHY2Nlf74TA1pqYpWQbV3SOGxJA/gWX2w7cMBpi2ib+er56/ssRNg
         lMEpXOYloaDaNotfqUny3W2iRhZNHO1Sv5EbhGjcwQM8FOyglwgAFmgcA1w+dJmT4H
         gqkGwCAkAr7Aw==
Subject: [PATCHSET 0/8] xfs: design documentation for online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Mon, 06 Jun 2022 18:48:42 -0700
Message-ID: <165456652256.167418.912764930038710353.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

2. Do you feel confident enough in the implementation as it is now that
   the benefits of merging the feature (as EXPERIMENTAL) outweigh any
   potential disruptions to XFS at large?

3. Are there problematic interactions between subsystems that ought to
   be cleared up before merging?

I intend to commit this document to the kernel's documentation directory
around the time we start merging the patchset, albeit without the links
to git.kernel.org.  A much more readable version of this is posted at:
https://djwong.org/docs/xfs-online-fsck-design/

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=online-fsck-design
---
 Documentation/filesystems/index.rst                |    1 
 .../filesystems/xfs-online-fsck-design.rst         | 3864 ++++++++++++++++++++
 .../filesystems/xfs-self-describing-metadata.rst   |    1 
 3 files changed, 3866 insertions(+)
 create mode 100644 Documentation/filesystems/xfs-online-fsck-design.rst

