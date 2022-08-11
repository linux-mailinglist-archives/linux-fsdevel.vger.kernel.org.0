Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624AA590334
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiHKQUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbiHKQTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E75A190;
        Thu, 11 Aug 2022 09:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9305D60F39;
        Thu, 11 Aug 2022 16:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6006C433C1;
        Thu, 11 Aug 2022 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660233671;
        bh=UzrS/HZAJKizBF3ite1S+z/TkQWsUij3s+m9X2OLZ6s=;
        h=Date:From:To:Cc:Subject:From;
        b=oDFPXfSKtFXFH/uhXqorxPyiG9OeSvrNODDHBChvIOoP7aziyHnNg7U8uqOGhKavp
         q51ohS7lvnfEAca+L7cB4yc8kgRuOAvaD0duaqJdnL0f3qG2VfPWckqbmhe+n2QOX+
         snCYHmFh7Z6zaz4Z0RBPMKAgJFpQXfx/XB7+yXwTKf3gGgxU2dMCW4phqa0x23r4qx
         peNUCIZgaI+0A0/cWxK6MmbpLMBu23gAF6+8fhViyplqIc3a7LC4yL4o8T6y11emMo
         ZDDZb+liA+FNx8dFG5oqnace/YHkZlIC6uumzUs85McEkip4cRoeMgOSZdgsYHA5EB
         gGYCUNyHsjf5w==
Date:   Thu, 11 Aug 2022 09:01:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: [GIT PULL] iomap: new code for 5.20/6.0, part 2
Message-ID: <YvUnxjj5ktXpwGj9@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second branch containing new code for iomap for
5.20^W6.0.  In the past 10 days or so I've not heard any ZOMG STOP style
complaints about removing ->writepage support from gfs2 or zonefs, so
here's the pull request removing them (and the underlying fs iomap
support) from the kernel.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit f8189d5d5fbf082786fb91c549f5127f23daec09:

  dax: set did_zero to true when zeroing successfully (2022-06-30 10:05:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.0-merge-2

for you to fetch changes up to 478af190cb6c501efaa8de2b9c9418ece2e4d0bd:

  iomap: remove iomap_writepage (2022-07-22 10:59:17 -0700)

----------------------------------------------------------------
New code for 6.0:
 - Remove iomap_writepage and all callers, since the mm apparently never
   called the zonefs or gfs2 writepage functions.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (4):
      gfs2: stop using generic_writepages in gfs2_ail1_start_one
      gfs2: remove ->writepage
      zonefs: remove ->writepage
      iomap: remove iomap_writepage

 fs/gfs2/aops.c         | 26 --------------------------
 fs/gfs2/log.c          |  5 ++---
 fs/iomap/buffered-io.c | 15 ---------------
 fs/zonefs/super.c      |  8 --------
 include/linux/iomap.h  |  3 ---
 5 files changed, 2 insertions(+), 55 deletions(-)
