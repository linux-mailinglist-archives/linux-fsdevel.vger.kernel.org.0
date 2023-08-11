Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D1778B20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjHKKKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHKKKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:10:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36554448B;
        Fri, 11 Aug 2023 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y0aq5oBkHJsvXg0ECqI6wIhwCUIqs6QSxIJwZB5Tg0o=; b=FjkKB5xIPgNLh//E/xqOQFA45R
        VSP+UeoBUaF9btYuhIjqqy0u83JMqFCgg2weFALy38TtLThLceZzvbP2t1wBtMyf+55MYxNQ8Eveb
        AwIwn3qFWLzfz1VCe4o3ExmAAqa/gCJXcK2iawdvzkOzL6+sj9fCAgBnQD2KMMOakDHVl8WlKE5n4
        KhykANnyuCdYsCm/vVwFGpBxVvS0hBxd6gSfLKBj2S7UCxjoiJoJHJDO3t7lYe7SEhgS8mpQ/HW2k
        UUQ7EeGntgFYboYtc1SGDh4rcpg9343vfuLbK4jJQtSTD0mWNyfKSD59b14AYGOcMBMmiV5pe6Ps/
        34ePRnBw==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4t-00A5p2-20;
        Fri, 11 Aug 2023 10:09:08 +0000
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
Subject: [PATCH 12/17] block: drop the "busy inodes on changed media" log message
Date:   Fri, 11 Aug 2023 12:08:23 +0200
Message-Id: <20230811100828.1897174-13-hch@lst.de>
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

This message isn't exactly helpful, and file systems already print way more
useful messages when shut down while active.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/disk-events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index 6189b819b2352e..6b858d3504772c 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -281,9 +281,7 @@ bool disk_check_media_change(struct gendisk *disk)
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
 		return false;
 
-	if (__invalidate_device(disk->part0, true))
-		pr_warn("VFS: busy inodes on changed media %s\n",
-			disk->disk_name);
+	__invalidate_device(disk->part0, true);
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	return true;
 }
@@ -302,9 +300,7 @@ void disk_force_media_change(struct gendisk *disk)
 {
 	disk_event_uevent(disk, DISK_EVENT_MEDIA_CHANGE);
 	inc_diskseq(disk);
-	if (__invalidate_device(disk->part0, true))
-		pr_warn("VFS: busy inodes on changed media %s\n",
-			disk->disk_name);
+	__invalidate_device(disk->part0, true);
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 }
 EXPORT_SYMBOL_GPL(disk_force_media_change);
-- 
2.39.2

