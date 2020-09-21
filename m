Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A523271D6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 10:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgIUII6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 04:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUIH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:07:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81EC0613CF;
        Mon, 21 Sep 2020 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VM2ZDhyOxyQ2Y1dDHiBEPye1qG1o//V0l6TNm5Sr/FU=; b=t0/fR3slvRiXSRxi1ANdVCAPYJ
        cTpjX/9/46DAos1ZZSmSu9iT0bOAPH4s2IIQBYnzF5i80UAkswyyGMaX0ZSmgY9fkoz8dCCpQ3+7h
        Adb3hpLeikh8u7CgrIF0WEBhX1fEIUEBxABgoXVNxCW1d5j5AJgOmtKyCBBj6KDhXKtSvy1xIZBCc
        IWeakTABDNWW43uVABcmb9AXarhhnZYbB4WsyHg0bVqgcTwp9gTxUmvPRwOHYCv4yoky6MCSu5YHs
        0Dz4Pd9AlW7rqDQtJJ5kr4i2Iv7QuEQOFdXgfTL2W5GuhU2d2n8/lsi8Wix4SdH3T6pdRU7OWXlMJ
        GBC1k5xQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKGr6-0006Vp-FM; Mon, 21 Sep 2020 08:07:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: bdi cleanups v6
Date:   Mon, 21 Sep 2020 10:07:21 +0200
Message-Id: <20200921080734.452759-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series contains a bunch of different BDI cleanups.  The biggest item
is to isolate block drivers from the BDI in preparation of changing the
lifetime of the block device BDI in a follow up series.

Changes since v5:
 - improve a commit message
 - improve the stable_writes deprecation printk
 - drop "drbd: remove RB_CONGESTED_REMOTE"
 - drop a few hunks that add a local variable in a otherwise unchanged
   file due to changes in the previous revisions
 - keep updating ->io_pages in queue_max_sectors_store
 - set an optimal I/O size in aoe
 - inherit the optimal I/O size in bcache

Changes since v4:
 - add a back a prematurely removed assignment in dm-table.c
 - pick up a few reviews from Johannes that got lost

Changes since v3:
 - rebased on the lasted block tree, which has some of the prep
   changes merged
 - extend the ->ra_pages changes to ->io_pages
 - move initializing ->ra_pages and ->io_pages for block devices to
   blk_register_queue

Changes since v2:
 - fix a rw_page return value check
 - fix up various changelogs

Changes since v1:
 - rebased to the for-5.9/block-merge branch
 - explicitly set the readahead to 0 for ubifs, vboxsf and mtd
 - split the zram block_device operations
 - let rw_page users fall back to bios in swap_readpage


Diffstat:
