Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2E588F79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiHCPgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiHCPgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8763C13F92;
        Wed,  3 Aug 2022 08:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E4E6171D;
        Wed,  3 Aug 2022 15:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766A8C433C1;
        Wed,  3 Aug 2022 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659540970;
        bh=wJv8MzMWPy/43LAR/Bf81dgt0Pb1oEPnrqlJGe2lp9k=;
        h=Date:From:To:Cc:Subject:From;
        b=YcHCSRXZrUTUq7tftRirD+Cp7OJOhB5kkU1MqxhDFHpWBwoyqSRfeeTvG93g3x8Yw
         rNRca4iRetEkO1KvW93bNXrgkF2g3d8AYFoEuxMmTci8u4IxIy5HwuThJOBf1L19yB
         Aaj2DERFzIaFxPWBPWPXkM3oZpJGaGyLju18VVMKGbwPFAKj6s+kVJMGuiQZaF1epW
         TC+KNJpVF/o6O/nd8GLahQEElSv+u6DJhzNIm43QrgLHAjZIvHZgiL9HAbEzTa4bA7
         fiez1Dvu7ireftrQipIBR8YWq5HPonl3vK0KxFIsrs4T5802UN9Yy6pdQlcH+Q7Ik4
         HaDu/Zm2U4Pjw==
Date:   Wed, 3 Aug 2022 08:36:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] iomap: new code for 5.20, part 1
Message-ID: <YuqV6qB/p69HL3yR@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this first branch containing new code for iomap for
5.20.  The most notable change in the first batch is that we no longer
schedule pages beyond i_size for writeback, preferring instead to let
truncate deal with those pages.

Next week, there may be a second pull request to remove iomap_writepage
from the other two filesystems (gfs2/zonefs) that use iomap for buffered
IO.  This follows in the same vein as the recent removal of writepage
from XFS, since it hasn't been triggered in a few years; it does nothing
during direct reclaim; and as far as the people who examined the
patchset can tell, it's moving the codebase in the right direction.
However, as it was a late addition to for-next, I'm holding off on that
section for another week of testing to see if anyone can come up with a
solid reason for holding off in the meantime.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.20-merge-1

for you to fetch changes up to f8189d5d5fbf082786fb91c549f5127f23daec09:

  dax: set did_zero to true when zeroing successfully (2022-06-30 10:05:11 -0700)

----------------------------------------------------------------
New code for 5.20:
 - Skip writeback for pages that are completely beyond EOF
 - Minor code cleanups

----------------------------------------------------------------
Chris Mason (1):
      iomap: skip pages past eof in iomap_do_writepage()

Kaixu Xia (2):
      iomap: set did_zero to true when zeroing successfully
      dax: set did_zero to true when zeroing successfully

 fs/dax.c               |  4 ++--
 fs/iomap/buffered-io.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)
