Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872642A9D37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 20:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgKFTEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 14:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgKFTEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:04:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6AC0613D3;
        Fri,  6 Nov 2020 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WS/5HaJpXF8+Aj3VZ2GQ3e6HnWhXjc79y2mDNxe6L1Y=; b=d0t0faqKeh0diZy5D+3oFd7PUF
        TCyCK8sa/DuNKYU0jeT8wTyRvaiEBKDnaS6SEkdUTuybDBsIgoIeRPsAlzl5bKXOe6SmughSQbIEP
        KkykvrhSx4ccDUXIrBKyrD0p4JiXqCPHgPeWfj3mWbknoX/XAnoyioec4TemaKCqv4ah93+QLH5cg
        9/RsZdWQzxsF1SLgUEW0HOn02HqxzKnJlnn0keo28vvDdvLYdDXii4E52+MkqA7lju2awVWXrKJL6
        ATVrFBAnHLMBbHBOSnGGHyMGWAswR83/TC1I7JT5bKbjrfZ4wEjHnEBd8a7RQ1Qnb4mvA0vQ78WTS
        P88M1meg==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb72A-00013z-Vd; Fri, 06 Nov 2020 19:04:27 +0000
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
Subject: [PATCH 20/24] dm-raid: use set_capacity_and_notify
Date:   Fri,  6 Nov 2020 20:03:32 +0100
Message-Id: <20201106190337.1973127-21-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use set_capacity_and_notify to set the size of both the disk and block
device.  This also gets the uevent notifications for the resize for free.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-raid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 9c1f7c4de65b35..294f34d2d61bae 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -700,8 +700,7 @@ static void rs_set_capacity(struct raid_set *rs)
 {
 	struct gendisk *gendisk = dm_disk(dm_table_get_md(rs->ti->table));
 
-	set_capacity(gendisk, rs->md.array_sectors);
-	revalidate_disk_size(gendisk, true);
+	set_capacity_and_notify(gendisk, rs->md.array_sectors);
 }
 
 /*
-- 
2.28.0

