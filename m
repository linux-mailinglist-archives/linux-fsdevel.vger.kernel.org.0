Return-Path: <linux-fsdevel+bounces-15355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9811688C812
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99DE1C2E17A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E235713C908;
	Tue, 26 Mar 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr3YSTrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2AFC0E;
	Tue, 26 Mar 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467995; cv=none; b=N/FuM6vt/zsXXFFSWS1vAUIwMToVS+wth2DTelLNSeLEbwyxSQfzBV8jij6I+hkU0ZvB4zn7F4KfiuUe4tq4zURHMXQjTp76ZI/piy4DdKvzNSOJD7KyIeqauzRTYsyrWBVX7h0saJlA9o26T5XPuxwHgyxGjO0go+9Db1+0daw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467995; c=relaxed/simple;
	bh=GNKUnehNUWWq14j2h7gVQLCTnR8U3oHCcrr43xdM+qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEOnhPubYIusPy9asaWY6cN/Gbm6uaZOcefA/OagfOY7f6HAdJUX6FAiT1UpiD7RT8FOYzwrN2BYpPhub+3jeKTuuVVxSirFlMYBi1j2ZR3z3aYT9ZWsg5GkJcXpwpJgHOvWtAYyRUrWBGmJMXDJ/GemHWBCOkgrw0LnZwtLXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr3YSTrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39534C433A6;
	Tue, 26 Mar 2024 15:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467994;
	bh=GNKUnehNUWWq14j2h7gVQLCTnR8U3oHCcrr43xdM+qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nr3YSTrfH5duhoQKB+iYXcVk2dXD9crtjbBjthK2U/f3FNA3Mjyf35AXnoUemV7j8
	 zKq/NTTOQI5kE23FU+wH8SUYOCVOFqf7Wgyc6gErzGzKd46DBeKZUqWiJ03ryiOsbc
	 OUnjG/Zsq7LRkC3xxGEHGySJfqWNuQKYOm48Njs+QMj6MBGgdfQI9TSm7Tpv/F4/US
	 iixX2aAiTg0QVNOqCz0ZFIfZoJgpLd2zq/aXe10DDRunZKrzcSMsXUKTUlmwBKaHT5
	 E9BRx4Et0Gr2HmXm5KLOucCGgWhcByOcYhuzG4QK5P/ZUaR76LKoNJNqkcaL5ZzJ4B
	 R2zAjvudRJQNQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Date: Tue, 26 Mar 2024 16:46:19 +0100
Message-ID: <20240326-lehrkraft-messwerte-e3895039e63b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326133107.bnjx2rjf5l6yijgz@quack3>
References: <20240326133107.bnjx2rjf5l6yijgz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=brauner@kernel.org; h=from:subject:message-id; bh=GNKUnehNUWWq14j2h7gVQLCTnR8U3oHCcrr43xdM+qw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQxvT2fGMYok8m4XsUyrNGyq1NAWl/yq375EsvO7ndHf QoyP/p0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATGSOMMN/F7v4DFfZms5r/daZ z3qcjgqU3Qx/IrNu1qot8fe5J8toMvwPzH92Loj16qOovCNyau2iS6Zlnffie/PmtblV2nXVrCk MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
default this option is set. When it is set the long-standing behavior
of being able to write to mounted block devices is enabled.

But in order to guard against unintended corruption by writing to the
block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
off. In that case it isn't possible to write to mounted block devices
anymore.

A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
which disallows concurrent BLK_OPEN_WRITE access. When we still had the
bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
the mode was passed around. Since we managed to get rid of the bdev
handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
on whether the file was opened writable and writes to that block device
are blocked. That logic doesn't work because we do allow
BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.

Fix the detection logic and use one of the FMODE_* bits we freed up a
while ago. We could've also abused O_EXCL as an indicator that
BLK_OPEN_RESTRICT_WRITES has been requested. For userspace open paths
O_EXCL will never be retained but for internal opens where we open files
that are never installed into a file descriptor table this is fine. But
it would be a gamble that this doesn't cause bugs. Note that
BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot directly
be raised by userspace. It is implicitly raised during mounting.

Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
unset.

Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
Link: https://lore.kernel.org/r/20240323-zielbereich-mittragen-6fdf14876c3e@brauner
Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c       | 14 +++++++-------
 include/linux/fs.h |  2 ++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 070890667563..6955693e4bcd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -814,13 +814,11 @@ static void bdev_yield_write_access(struct file *bdev_file)
 		return;
 
 	bdev = file_bdev(bdev_file);
-	/* Yield exclusive or shared write access. */
-	if (bdev_file->f_mode & FMODE_WRITE) {
-		if (bdev_writes_blocked(bdev))
-			bdev_unblock_writes(bdev);
-		else
-			bdev->bd_writers--;
-	}
+
+	if (bdev_file->f_mode & FMODE_WRITE_RESTRICTED)
+		bdev_unblock_writes(bdev);
+	else if (bdev_file->f_mode & FMODE_WRITE)
+		bdev->bd_writers--;
 }
 
 /**
@@ -900,6 +898,8 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
 	if (bdev_nowait(bdev))
 		bdev_file->f_mode |= FMODE_NOWAIT;
+	if (mode & BLK_OPEN_RESTRICT_WRITES)
+		bdev_file->f_mode |= FMODE_WRITE_RESTRICTED;
 	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
 	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
 	bdev_file->private_data = holder;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0..8dfd53b52744 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -121,6 +121,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_PWRITE		((__force fmode_t)0x10)
 /* File is opened for execution with sys_execve / sys_uselib */
 #define FMODE_EXEC		((__force fmode_t)0x20)
+/* File writes are restricted (block device specific) */
+#define FMODE_WRITE_RESTRICTED  ((__force fmode_t)0x40)
 /* 32bit hashes as llseek() offset (for directories) */
 #define FMODE_32BITHASH         ((__force fmode_t)0x200)
 /* 64bit hashes as llseek() offset (for directories) */
-- 
2.43.0


