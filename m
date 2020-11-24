Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07BF2C2764
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbgKXN2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388122AbgKXN2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF96C0613D6;
        Tue, 24 Nov 2020 05:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xb3N2WAG9okvbjUfnpwdPBpAQhXn4NZ0O9b+iLQ2eLQ=; b=CD/Zu5S2v7JQL86T+0gRFtsLfM
        kUwH6dfh/CUdlgUxbwmElUz1fNicSaXpuoV30QiF0OgxlWK+j2EQGIY98jL+xCm41ZUs+ViX+4lbj
        llVEfGhPh4OpwiirW/phioWj5T3r2yQ0gr6vFtAr06LZvYhNT0W/ToEJaw6bUZy8/QSzbAoLJ2UC2
        QBgLCJI2097N6fhHep3+PhoV8nL1LM5nsWvpDoUPBnB//Qcb6h/ul/dvjIH2tAZVhJ1IXEJkOYBJS
        i/4l9EYviSTH0C4sbrZzfFcEyr70QHVgNDAlvJ0U7h2bfcMEoxnQVw6Zb5q1tzhzSoYmcYIu7Wg3G
        DywyGKyA==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYMt-0006ZX-Sm; Tue, 24 Nov 2020 13:28:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 22/45] block: opencode devcgroup_inode_permission
Date:   Tue, 24 Nov 2020 14:27:28 +0100
Message-Id: <20201124132751.3747337-23-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just call devcgroup_check_permission to avoid various superflous checks
and a double conversion of the access flags.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2ffa11a95f10db..1e35faf6dad42c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1515,15 +1515,13 @@ static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 	struct block_device *claiming;
 	bool unblock_events = true;
 	struct gendisk *disk;
-	int perm = 0;
 	int partno;
 	int ret;
 
-	if (mode & FMODE_READ)
-		perm |= MAY_READ;
-	if (mode & FMODE_WRITE)
-		perm |= MAY_WRITE;
-	ret = devcgroup_inode_permission(bdev->bd_inode, perm);
+	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
+			imajor(bdev->bd_inode), iminor(bdev->bd_inode),
+			((mode & FMODE_READ) ? DEVCG_ACC_READ : 0) |
+			((mode & FMODE_WRITE) ? DEVCG_ACC_WRITE : 0));
 	if (ret)
 		goto bdput;
 
-- 
2.29.2

