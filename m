Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABF8271B8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIUHUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgIUHUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5E8C0613D1;
        Mon, 21 Sep 2020 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=uiln3MtorCIt+OqTbXUWnLiMXWC8lUgm2hs2JozLc28=; b=WlAvqo0PcB605+Hw0QLRuD1pQx
        BdyYtsNFPR3wMN5n8f93MPj6oeQPqy60GRR7KR8bYAlYCuZAV8luCL8w+E8yqR9ni0BMRscRRY/iW
        BUZ16kWwXlC+tHFzJzi9sWaMYwaug6V8SIOW0b0kfNVKHHE181qPrix3SHrySoGyTgz1fO3D0O/W9
        eeIwVaKs6zgWS3g2U3WN1SDQBNkp6w54ecHbNf+X36dRXVbSVKkTJOoOuUWusZDlmIpfwewvJnGpm
        EjjwNpfnPKmsjgRiOI+gFhBvsYdAesrUy9JAiGqPs0teXQE5Ceg8fqbMPBSPgzUQ8Sy1TQ1zYmQyy
        CsavluHw==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG73-0003Dm-IT; Mon, 21 Sep 2020 07:19:49 +0000
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
Subject: remove blkdev_get as a public API v2
Date:   Mon, 21 Sep 2020 09:19:44 +0200
Message-Id: <20200921071958.307589-1-hch@lst.de>
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

Changes since v1:
 - fix a mismerged that left a stray bdget_disk around
 - factour the partition scan at registration time code into a new
   helper.

Diffstat:
 block/genhd.c                   |   35 ++++++---------
 block/ioctl.c                   |   13 ++---
 drivers/block/nbd.c             |    8 +--
 drivers/block/pktcdvd.c         |   92 +++++-----------------------------------
 drivers/block/zram/zram_drv.c   |    7 +--
 drivers/char/raw.c              |   51 ++++++++--------------
 drivers/ide/ide-gd.c            |    2 
 drivers/s390/block/dasd_genhd.c |   15 +-----
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
 18 files changed, 130 insertions(+), 239 deletions(-)
