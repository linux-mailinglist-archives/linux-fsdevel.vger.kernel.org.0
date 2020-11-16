Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAA2B4802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgKPPAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbgKPPAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:00:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDA2C0613CF;
        Mon, 16 Nov 2020 07:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9s01ven/lnjzAuhlV063ntSY/vXy7NuM1J7SpBiZFfk=; b=Iz0K1z2gG+m/yrqS3PHmWRLoWX
        iQ2r9VCIRC1F/onM60kJvAH6c1Mq4RlXW7ec+E4URlz5EGNYvgdquPHqNY52gjE8nE20X9RXX7VMi
        1DOJ7Vtr4lrIBJ7aVOvb8UqrR2nwcvWP6ZnS5k2cLIXw3A5Dbiaen1+C+S/XhWHMOfqQAtP9C+gT2
        bC1yTTqhuANia6Zl9uBJicixvJBbdGfQlRzf4UsN7IZa6iajX16uM9PSh5wgGK5K5zsV7yVWM/HD7
        +fT3KXcxxU4zJu5OS1H+5N5e66rH7O41GjcCcL5p8HAE3cZQ+D+MIf49gWr+tF6YubeZAmAdPRe+t
        MQay8zLg==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefz1-0004IE-BR; Mon, 16 Nov 2020 14:59:55 +0000
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
Subject: [PATCH 73/78] block: use put_device in put_disk
Date:   Mon, 16 Nov 2020 15:58:04 +0100
Message-Id: <20201116145809.410558-74-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use put_device to put the device instead of poking into the internals
and using kobject_put.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 56bc37e98ed852..f1e20ec1b62887 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1659,7 +1659,7 @@ EXPORT_SYMBOL(__alloc_disk_node);
 void put_disk(struct gendisk *disk)
 {
 	if (disk)
-		kobject_put(&disk_to_dev(disk)->kobj);
+		put_device(disk_to_dev(disk));
 }
 EXPORT_SYMBOL(put_disk);
 
-- 
2.29.2

