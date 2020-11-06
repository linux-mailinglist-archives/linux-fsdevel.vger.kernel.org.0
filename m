Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C823E2A9D74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 20:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKFTGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 14:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFTEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:04:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E556FC0613D2;
        Fri,  6 Nov 2020 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KZOj2ixaxfr+x29An18oeDfaJx3FSv//8uc71Hhn2A0=; b=snjJGRx7qVkoWA28XGyBSN/FU5
        1P5/6U8yQxPbAyQppy+ZGNo7hD7TWcSzoG9wJV5MoXxMDDYieBlcG6uvG1NU21CqTnxt3WKQtAuJf
        UqKqna1ID0lcpQmhrivJzFz3YtmWKpZm0KUamzMFajaTMK5TOilliU8pAMmZ7jcA4xKsEPe9u9FQe
        QLgag4ggR9M8REy4gaAzi95ookXu/+vKsN1gxvlBcIDCNpbUaA+k+bepajweHAsKHRlnIci3X0/gt
        +qiwIBcx7dd+5GmJaUUfQwr2V0s1euix28lr0Y0k8IK6gPjGXKGEZvDvsOwgNI/M1zhmywSH4Q6X6
        FMOFWKCQ==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb71P-0000t7-34; Fri, 06 Nov 2020 19:03:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: cleanup updating the size of block devices
Date:   Fri,  6 Nov 2020 20:03:12 +0100
Message-Id: <20201106190337.1973127-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series builds on top of the work that went into the last merge window,
and make sure we have a single coherent interfac for updating the size of a
block device.

Diffstat:
 block/genhd.c                  |   16 +++----
 drivers/block/aoe/aoecmd.c     |   15 +-----
 drivers/block/drbd/drbd_main.c |    6 --
 drivers/block/loop.c           |   36 ++--------------
 drivers/block/nbd.c            |   88 +++++++++++++----------------------------
 drivers/block/pktcdvd.c        |    3 -
 drivers/block/rbd.c            |    3 -
 drivers/block/rnbd/rnbd-clt.c  |    3 -
 drivers/block/virtio_blk.c     |    3 -
 drivers/block/xen-blkfront.c   |    2 
 drivers/block/zram/zram_drv.c  |    7 ---
 drivers/md/dm-raid.c           |    3 -
 drivers/md/dm.c                |    3 -
 drivers/md/md-cluster.c        |    8 ---
 drivers/md/md-linear.c         |    3 -
 drivers/md/md.c                |   24 ++++-------
 drivers/nvme/host/core.c       |   18 --------
 drivers/scsi/sd.c              |    9 +---
 fs/block_dev.c                 |    7 ---
 include/linux/genhd.h          |    3 -
 20 files changed, 76 insertions(+), 184 deletions(-)
