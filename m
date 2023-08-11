Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89782778B24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHKKKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjHKKKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:10:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280130F8;
        Fri, 11 Aug 2023 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XS+CdlPa8tKa487hp4Qha77KSBNKRcJ6rt1gq/j585k=; b=y6q/GXfKNrc73CmPgU/0v1vaSD
        SgeQHi6ZEDzl4EF/bA0PYph5ooOTx19V22p8u0lTU84Qnt5NuMAcM6YjznaBMV174hVHA4hQg7pvS
        GHJz+iVCNNxrK1ELvgpjMTWO7ukfMaMmfSt+ABJ5kI8KP3zABhHMV4zpj9lNfhC1Hgh+x3yHH3Vet
        0F9ZWA/AKMM3KO77xZeTiszWznPsWQFQZ8sIobkGxhNMwlwOZB5QaJe9+UAjHlcXuw1lhztJDbWGn
        BhkcIlhZanc68c/eFzRo5+TlVzk+CdHgc8yK4+Fw8onNsG5QR6iq7LD1Ij9KZCUDUy70FxtE5hj6i
        Ii5UDasg==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4q-00A5o2-2G;
        Fri, 11 Aug 2023 10:09:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/17] dasd: also call __invalidate_device when setting the device offline
Date:   Fri, 11 Aug 2023 12:08:22 +0200
Message-Id: <20230811100828.1897174-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't just write out the data, but also invalidate all caches when setting
the device offline.  Stop canceling the offlining when writeback fails
as there is no way to recover from that anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index edcbf77852c31f..675b38ad00dc9e 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3627,9 +3627,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		 * empty
 		 */
 		if (device->block) {
-			rc = fsync_bdev(device->block->bdev);
-			if (rc != 0)
-				goto interrupted;
+			fsync_bdev(device->block->bdev);
+			__invalidate_device(device->block->bdev, true);
 		}
 		dasd_schedule_device_bh(device);
 		rc = wait_event_interruptible(shutdown_waitq,
-- 
2.39.2

