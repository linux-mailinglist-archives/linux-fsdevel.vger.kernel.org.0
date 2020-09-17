Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66A626E185
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgIQQ7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgIQQ7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:59:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947EC06174A;
        Thu, 17 Sep 2020 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HSelo8V/K+50+NYuLpI9PLlnsmvIK7gx8VI0Sz6V4PU=; b=vGDEFPJ707ptXPX4+9i9781old
        xsNpeVCD4XZDVGcYjA+MbX7KhnFmO2+Yd5n3Vf0yEESEKcsLUbPxWwT15jA3buY1zl2MK6FfS0ROG
        DZUMm0K5g0YSc9P06hadFGy4ElAsekq4P3uCLR9redzUX1H6V5ppdPeHjga6HRevxK+UAaYumvD8o
        R5K7DdkgyGf6GvPxLtWtBVeQWFoLGRZBOJTo44ytDXTkLWYOsxYjrnPmoMNQVn2ULA+FN5FXWvO3M
        cN0C195atpvFDiNWRYEw+cffFy3bh6UD8Gmx+H0YzX1600akIqtqGsy5vnbcTdZL0KnAsu+TLFfRq
        x88nyRIw==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxFq-0000Af-QF; Thu, 17 Sep 2020 16:59:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: remove blkdev_get as a public API
Date:   Thu, 17 Sep 2020 18:57:06 +0200
Message-Id: <20200917165720.3285256-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series removes blkdev_get as a public API, leaving it as just an
implementation detail of blkdev_get_by_path and blkdev_get_by_dev.  The
reason for that is that blkdev_get is a very confusing API that requires
a struct block_device to be fed in, but then actually consumes the
reference.  And it turns out just using the two above mentioned APIs
actually significantly simplifies the code as well.

Diffstat:
 block/genhd.c                   |   11 ++--
 block/ioctl.c                   |   13 ++---
 drivers/block/nbd.c             |    8 +--
 drivers/block/pktcdvd.c         |   92 +++++-----------------------------------
 drivers/block/zram/zram_drv.c   |    7 +--
 drivers/char/raw.c              |   51 ++++++++--------------
 drivers/ide/ide-gd.c            |    2 
 drivers/s390/block/dasd_genhd.c |   13 +----
 fs/block_dev.c                  |   12 ++---
 fs/ocfs2/cluster/heartbeat.c    |   28 ++++--------
 include/linux/blk_types.h       |    4 -
 include/linux/blkdev.h          |    1 
 include/linux/genhd.h           |    2 
 include/linux/suspend.h         |    4 -
 include/linux/swap.h            |    3 -
 kernel/power/swap.c             |   21 +++------
 kernel/power/user.c             |   26 +++--------
 mm/swapfile.c                   |   45 ++++++++++---------
 18 files changed, 119 insertions(+), 224 deletions(-)
