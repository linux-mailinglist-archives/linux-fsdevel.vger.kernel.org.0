Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF82769B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgIXGxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgIXGv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:51:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F282C0613D3;
        Wed, 23 Sep 2020 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5cv5XM1WbeIcMKM5m6HEEjDcYpaEJfjGWw9dDjM6nfI=; b=r2w8hhD+ZBoRdDKl0qZXo3vF81
        hM/13MLXzpPkHMHSdkeatYWtW/3Rk3FztSV6U5y+CbAh6t7JHsfTFWVb3fcVheFT1g+IP1CUvdL/M
        qf6RvhVVVcfKzIDmXfduJ5W90Ne2Xmv0UFnYt+mp024P858pnetDNMffHtNWZutPuWI481/Ixizft
        VzlRi+PBja8K/ca/ZHfPdeq8UXLIZ3VY+HnhwsTOu5umASFwHza1/IftOvz3nrDcW8iJ2OvWsxcVr
        FHnaTnZTbgNXfbL0liL+h4MJ2F/DEq8P/XjVxB+RLUSVk0zwY6gebGFkYLAM8tqFMr4ps3to5Wmm/
        AERB55ug==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLL6T-00019A-6Y; Thu, 24 Sep 2020 06:51:41 +0000
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
Subject: bdi cleanups v7
Date:   Thu, 24 Sep 2020 08:51:27 +0200
Message-Id: <20200924065140.726436-1-hch@lst.de>
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

Changes since v6:
 - add a new blk_queue_update_readahead helper and use it in stacking
   drivers
 - improve another commit log

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
