Return-Path: <linux-fsdevel+bounces-550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D217CCB0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7A4281A57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF89CA66;
	Tue, 17 Oct 2023 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UYWaETAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B849CA5B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 18:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F43D3;
	Tue, 17 Oct 2023 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cl8di6G3DxLLFf5MtSBQgO7MOKUrZZ/L+falVxOQuKg=; b=UYWaETAjbVF1TF5AWFnEd2BOv1
	UYLxmX1xpq33/xS5o+//DLjuFFRDybdy6/xDYyukec8TdQo1RhAHTXlBwSR4HLxpakXzKc6KCGhIZ
	TtYs/1Izxqoqt1KutZNfApLPSUQpUhf5rSRksn+sJ7hpgnLU/FSDAo3gSlKmcpMVHxZ6b3VXKegSx
	on7F9aMyj+JdT73fT827+VJ0t0qMOzljjgz5quwpQxfRTCaqW0QeEO+Q18/QOp73uoByRImHln4/S
	9pIsPL/RmV+Mmmma1r8dEhrcRDTTJxjDdVdChuGWFQuPk9e4SkhzE1CYB28dg6RIV3IzoNZS/dpiQ
	0zysKpyA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsp7P-00D0Le-0h;
	Tue, 17 Oct 2023 18:48:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>,
	Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] block: assert that we're not holding open_mutex over blk_report_disk_dead
Date: Tue, 17 Oct 2023 20:48:22 +0200
Message-Id: <20231017184823.1383356-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017184823.1383356-1-hch@lst.de>
References: <20231017184823.1383356-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Christian Brauner <brauner@kernel.org>

blk_report_disk_dead() has the following major callers:

(1) del_gendisk()
(2) blk_mark_disk_dead()

Since del_gendisk() acquires disk->open_mutex it's clear that all
callers are assumed to be called without disk->open_mutex held.
In turn, blk_report_disk_dead() is called without disk->open_mutex held
in del_gendisk().

All callers of blk_mark_disk_dead() call it without disk->open_mutex as
well.

Ensure that it is clear that blk_report_disk_dead() is called without
disk->open_mutex on purpose by asserting it and a comment in the code.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 4a16a424f57d4f..c9d06f72c587e8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -559,6 +559,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 	struct block_device *bdev;
 	unsigned long idx;
 
+	/*
+	 * On surprise disk removal, bdev_mark_dead() may call into file
+	 * systems below. Make it clear that we're expecting to not hold
+	 * disk->open_mutex.
+	 */
+	lockdep_assert_not_held(&disk->open_mutex);
+
 	rcu_read_lock();
 	xa_for_each(&disk->part_tbl, idx, bdev) {
 		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
-- 
2.39.2


