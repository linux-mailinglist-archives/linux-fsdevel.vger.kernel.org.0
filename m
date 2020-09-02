Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4D25AD94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgIBOlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgIBONl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B14C06125F;
        Wed,  2 Sep 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qYKl1qvW+oZB7H4Eg4mySB0HdI5GaU5c+ZiBZZ0yxcM=; b=AmzkX2Yu0z+aZrD5f6YHrfpL3Y
        zHD2maNr33SF3n/YbUTJgaduaR46qG9nXIDLkrpOqJ6yFd80rTZuRWCKzfUQgVrw4Cp1Z9KzIJGIl
        bFSXF0J06iLG5HXRHC387BuMozGmnDHaHrA5BVbr5fJcakeM5aZ2EbWffVLSVGsSyqbjh0z7o0DBZ
        jEkI46mBUS5lxTvW/2hsRdDse/kDy7bcxfHXSr9oZiKa5QB3DUR4lByrpZpJMt3LENV5zPQSvJOh3
        A7qCWwoFc6JNBNl5ohIkPcT2Zl/QZsCcdK8EeXs5adD4mliKTwZbHg0fqsue58kZamAunNlGvSAqo
        l0GbvbYA==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTUp-0005ci-Fw; Wed, 02 Sep 2020 14:12:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: rework check_disk_change()
Date:   Wed,  2 Sep 2020 16:11:59 +0200
Message-Id: <20200902141218.212614-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series replaced the not very nice check_disk_change() function with
a new bdev_media_changed that avoids having the ->revalidate_disk call
at its end.  As a result ->revalidate_disk can be removed from a lot of
drivers.

Diffstat:
 block/genhd.c              |   29 ++++++++++++++++++++++++++-
 drivers/block/amiflop.c    |    2 -
 drivers/block/ataflop.c    |    7 +++---
 drivers/block/floppy.c     |    8 ++++---
 drivers/block/paride/pcd.c |    2 -
 drivers/block/swim.c       |   22 +-------------------
 drivers/block/swim3.c      |    4 +--
 drivers/block/xsysace.c    |   26 +++++++++---------------
 drivers/cdrom/gdrom.c      |    2 -
 drivers/ide/ide-cd.c       |   16 ++++-----------
 drivers/ide/ide-disk.c     |    5 ----
 drivers/ide/ide-floppy.c   |    2 -
 drivers/ide/ide-gd.c       |   48 +++++----------------------------------------
 drivers/md/md.c            |    2 -
 drivers/scsi/sd.c          |    7 +++---
 drivers/scsi/sr.c          |   36 +++++++++++++--------------------
 fs/block_dev.c             |   31 -----------------------------
 include/linux/genhd.h      |    3 --
 include/linux/ide.h        |    2 -
 19 files changed, 86 insertions(+), 168 deletions(-)
