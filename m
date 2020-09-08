Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70C261FAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgIHUFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbgIHPV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:21:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3EC0A3BE8;
        Tue,  8 Sep 2020 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ik1nskp4UUIa9huUq3TidG8Ju0niiHJiTpvYtnudikY=; b=YL8KsrxeI7tCv1WURY1i6FflSc
        VTi648vPAzQ2Ypf02N1dEmIcx1t2yDB42y9xiUgMitpsB1OEiuFGxCevytdkUOxIG1/wcIZD2bnkq
        ZhfB9q4LMCP/w4rBQA1KF0gn2t5nZY4TuHfRNVqxrWx53WmCmveXWp283Ar4ZqC+zil0ns44UWPHw
        bDIUoWAw+V2Aizmn2VPcI8i/nzzirrGOMTLrx5uuZZ4antZmpqtoKfODJe/rD8bS5DTrwPRXYxz1R
        lFH5Qf8Wf78PPBfMXySfdLM8CwFqMgOdxY7ZzSVkPykoaWl7vlvWrsIJvwKag1t8QeusFKcjgP94A
        lMMA01bg==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf0H-0002uU-Kp; Tue, 08 Sep 2020 14:53:51 +0000
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
Subject: rework check_disk_change() v2
Date:   Tue,  8 Sep 2020 16:53:28 +0200
Message-Id: <20200908145347.2992670-1-hch@lst.de>
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

Changes since v1:
 - minor changelog spelling fixes

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
