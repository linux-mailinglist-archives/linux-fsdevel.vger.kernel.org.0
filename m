Return-Path: <linux-fsdevel+bounces-547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539177CCB0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269DDB2128B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB144487;
	Tue, 17 Oct 2023 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SfCbzY8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA642BFF
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 18:48:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E53B92;
	Tue, 17 Oct 2023 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3p4oO3bOXrhbykt9aeueJv3mlaSlSZVuqrgRI70Z3n8=; b=SfCbzY8znMcuOv5VNgHyY+biQY
	p6t02rycUvs0jSeqmIaPRyf8SaAeE1kyDbpncHpx47/XZogN88cEkUYcbKe9+dqxEAHVqVSNqibbU
	RrhyjhPgpBmYTFWO/h/Pm87q/nkj9jD66p3V3ZeUo8KG5lEDAnx61/NPfWAT2kQfrG/ILtJWv36Zf
	XvFD+SgML9ux/P3GQ0ksyNSxe5TBY5MVcSeKMnDVHmhoJ7iVn9yRBHPOwsU09k1DN1OeruWBDkgik
	JMZd8KtC+L8cfQiUknwiHVJE1OvzDddWM4tMyZweAIx5GYre2vVm0kRRaoUfKQPibnXhiM3P+z62v
	2WrgfhNw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsp7G-00D0Kj-24;
	Tue, 17 Oct 2023 18:48:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>,
	Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] block: simplify bdev_del_partition()
Date: Tue, 17 Oct 2023 20:48:19 +0200
Message-Id: <20231017184823.1383356-2-hch@lst.de>
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

BLKPG_DEL_PARTITION refuses to delete partitions that still have
openers, i.e., that has an elevated @bdev->bd_openers count. If a device
is claimed by setting @bdev->bd_holder and @bdev->bd_holder_ops
@bdev->bd_openers and @bdev->bd_holders are incremented.
@bdev->bd_openers is effectively guaranteed to be >= @bdev->bd_holders.
So as long as @bdev->bd_openers isn't zero we know that this partition
is still in active use and that there might still be @bdev->bd_holder
and @bdev->bd_holder_ops set.

The only current example is @fs_holder_ops for filesystems. But that
means bdev_mark_dead() which calls into
bdev->bd_holder_ops->mark_dead::fs_bdev_mark_dead() is a nop. As long as
there's an elevated @bdev->bd_openers count we can't delete the
partition and if there isn't an elevated @bdev->bd_openers count then
there's no @bdev->bd_holder or @bdev->bd_holder_ops.

So simply open-code what we need to do. This gets rid of one more
instance where we acquire s_umount under @disk->open_mutex.

Link: https://lore.kernel.org/r/20231016-fototermin-umriss-59f1ea6c1fe6@brauner
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e137a87f4db0d3..b0585536b407a5 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -485,7 +485,18 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 	if (atomic_read(&part->bd_openers))
 		goto out_unlock;
 
-	delete_partition(part);
+	/*
+	 * We verified that @part->bd_openers is zero above and so
+	 * @part->bd_holder{_ops} can't be set. And since we hold
+	 * @disk->open_mutex the device can't be claimed by anyone.
+	 *
+	 * So no need to call @part->bd_holder_ops->mark_dead() here.
+	 * Just delete the partition and invalidate it.
+	 */
+
+	remove_inode_hash(part->bd_inode);
+	invalidate_bdev(part);
+	drop_partition(part);
 	ret = 0;
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
-- 
2.39.2


