Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C874AA601
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 03:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352644AbiBECqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 21:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiBECqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:46:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32799C061346;
        Fri,  4 Feb 2022 18:46:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C162060C20;
        Sat,  5 Feb 2022 02:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2EFC004E1;
        Sat,  5 Feb 2022 02:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644029174;
        bh=/XpNFrf+BRq3lzjkMIgAOig1pj/vAgZOZPBkKSJfAb0=;
        h=Date:From:To:Cc:Subject:From;
        b=KFFR1fFyUvQygBJQcUX/pLgTU5DhARkmTF/UbXhx6ebI1B1C3mlc1ZikAC78AHQh8
         QN7rTAdGHuWW9T+Ote5oGU+FiavcQX17JAoim9BY3aHm6SKaB7Mr/LQ/7fJhPEU27i
         ISEiJAa0xW9Ob+JEvgayQj4wWNRXvpk21IPmmXWF4V5JUjcN2U330tCqDf/S0AkV7A
         fLoop67L1tiHz3wmSqy0L67XYmuV1hsCM2mT7jnVqdOuC5vEuzbQHgrWstjc1zYpmZ
         JZuV0BOJ46WkpzmVAh+Ji1h+3x5wuqL/arsXW4ch2A0/SHbl+GppBpU6+Nnr7b/3zq
         HkvRgfZwbcWXQ==
Date:   Fri, 4 Feb 2022 18:46:13 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] iomap: fixes for 5.17-rc3
Message-ID: <20220205024613.GV8313@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing a single bugfix for iomap for
5.17-rc3.  The fix should eliminate occasional complaints about stall
warnings when a lot of writeback IO completes all at once and we have to
then go clearing status on a large number of folios.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.17-fixes-1

for you to fetch changes up to ebb7fb1557b1d03b906b668aa2164b51e6b7d19a:

  xfs, iomap: limit individual ioend chain lengths in writeback (2022-01-26 09:19:20 -0800)

----------------------------------------------------------------
Fixes for 5.17-rc2:
 - Limit the length of ioend chains in writeback so that we don't trip
   the softlockup watchdog and to limit long tail latency on clearing
   PageWriteback.

----------------------------------------------------------------
Dave Chinner (1):
      xfs, iomap: limit individual ioend chain lengths in writeback

 fs/iomap/buffered-io.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_aops.c      | 16 +++++++++++++++-
 include/linux/iomap.h  |  2 ++
 3 files changed, 65 insertions(+), 5 deletions(-)
