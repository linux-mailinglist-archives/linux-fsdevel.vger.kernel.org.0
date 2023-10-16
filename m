Return-Path: <linux-fsdevel+bounces-413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD97CAD78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 17:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB8E2815CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4A29427;
	Mon, 16 Oct 2023 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIXmVES6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0F17EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 15:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A5AC433C8;
	Mon, 16 Oct 2023 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697470054;
	bh=0p5ibjI3L65yu+TDLMnTfKjYY+zkHDI3/EjMYE1CLoY=;
	h=From:To:Cc:Subject:Date:From;
	b=mIXmVES6h1fs6R76W/ab2Qt4Xk3slQuMD2qmprmVNDzP9qcM78GJ7rX7V/5IwJAY8
	 Xk/wfEdSrJJZizgqRj6ClCh3xb0/69uwxqlnvkhmGlFh/y+BZ8eVEjsO71TLPr0onj
	 UrxMOhYNz/BHsFUhp3oiGl8kvWlVM4R9OGRkoclyCuhqSatWEsHFHY3xqGq99OyaH4
	 NCcDhdboScIv1DbLnayRQErKwEZHfDv9aSc+kJIZCrb5SIqhKb6QUA+gsoH4D4u4cy
	 6DQMLWPDfqFixi1Ih24WEQZ4Q53bF4Jxc/upWUPJJdFsln3z60zr84Jw9yly/+OoOJ
	 /9wvDhAT6MnoQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] block: simplify bdev_del_partition()
Date: Mon, 16 Oct 2023 17:27:18 +0200
Message-Id: <20231016-fototermin-umriss-59f1ea6c1fe6@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=brauner@kernel.org; h=from:subject:message-id; bh=0p5ibjI3L65yu+TDLMnTfKjYY+zkHDI3/EjMYE1CLoY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTqhvl84vvyk3OLr+WqKeFX7nbOsfD4720zZ5qLmYXQ0diq r4x1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJ4mJkWBP3/crh+soijd4JG/dlKX vUHc/WPiH3jjl5w82ioHDZa4wMrzVVzVyD9Fpq9q7VXD5nk9XfA2mzLMy5D02e99V7qTUrEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey Jens,

This came out of an ongoing locking design discussion and is related
to what we currently have in vfs.super. So if everyone still agrees my
reasoning is right and you don't have big objections I'd take it through
there.

As usual, thanks to Jan and Christoph for good discussions here.

Thanks!
Christian
---
 block/partitions/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e137a87f4db0..b0585536b407 100644
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
2.34.1


