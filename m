Return-Path: <linux-fsdevel+bounces-34267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A59C42F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BF0B24C0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CCF1A726B;
	Mon, 11 Nov 2024 16:43:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D771A3A80;
	Mon, 11 Nov 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343438; cv=none; b=NfpL9ejVcjvQ2Maptd6suCJOedIkc8DtXAoSVv62+ok86SmE3ZbMNuaSFpGPY40Q+8MxcYTGSJ0IcwzIegW+FgsrogrBmzjJ8pRfvUN3KByzsg+8uNv6QlTk7yAdWvA4mWK0JBAvixN+KQAZq+1GDi/z7Aif2c0QAfiOFAAjO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343438; c=relaxed/simple;
	bh=nknNO/X4QZPpB3akptkMCCcdCYltGPKsxIrYle5JUFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TLSwFpZyqMrGCZPLY6E2ah7usjCwZbVlktJtZmN4qUvDqvGn+YMkBpRfyPtMgkuHA8EirYBvEakJ0GI6iDCCFsFJg3hJE2+KRqhELkY/1h69VNC3wqYVGxYe2xFIApZM2mhG+iKF3ofGifFdq+uhJ8FElwXHEXAaERHsskQ80C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 5FFDA284C597;
	Mon, 11 Nov 2024 22:07:24 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4ABD7NTb073975
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 22:07:24 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4ABD7NOK740352
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 22:07:23 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4ABD7Lwo740344;
	Mon, 11 Nov 2024 22:07:21 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
        syzbot
 <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
In-Reply-To: <67313d9e.050a0220.138bd5.0054.GAE@google.com> (syzbot's message
	of "Sun, 10 Nov 2024 15:11:26 -0800")
References: <67313d9e.050a0220.138bd5.0054.GAE@google.com>
Date: Mon, 11 Nov 2024 22:07:21 +0900
Message-ID: <8734jxsyuu.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com> writes:

> syzbot found the following issue on:
>
> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1621bd87980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
> dashboard link: https://syzkaller.appspot.com/bug?extid=a5d8c609c02f508672cc
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

This patch is to fix the above race. Please check this.

Thanks


From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] loop: Fix ABBA locking race
Date: Mon, 11 Nov 2024 21:53:36 +0900

Current loop calls vfs_statfs() while holding the q->limits_lock. If
FS takes some locking in vfs_statfs callback, this may lead to ABBA
locking bug (at least, FAT fs has this issue actually).

So this patch calls vfs_statfs() outside q->limits_locks instead,
because looks like there is no reason to hold q->limits_locks while
getting discard configs.

Chain exists of:
  &sbi->fat_lock --> &q->q_usage_counter(io)#17 --> &q->limits_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->limits_lock);
                               lock(&q->q_usage_counter(io)#17);
                               lock(&q->limits_lock);
  lock(&sbi->fat_lock);

 *** DEADLOCK ***

Reported-by: syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a5d8c609c02f508672cc
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 drivers/block/loop.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 78a7bb2..5f3ce51 100644
--- a/drivers/block/loop.c	2024-09-16 13:45:20.253220178 +0900
+++ b/drivers/block/loop.c	2024-11-11 21:51:00.910135443 +0900
@@ -770,12 +770,11 @@ static void loop_sysfs_exit(struct loop_
 				   &loop_attribute_group);
 }
 
-static void loop_config_discard(struct loop_device *lo,
-		struct queue_limits *lim)
+static void loop_get_discard_config(struct loop_device *lo,
+				    u32 *granularity, u32 *max_discard_sectors)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
-	u32 granularity = 0, max_discard_sectors = 0;
 	struct kstatfs sbuf;
 
 	/*
@@ -788,8 +787,9 @@ static void loop_config_discard(struct l
 	if (S_ISBLK(inode->i_mode)) {
 		struct request_queue *backingq = bdev_get_queue(I_BDEV(inode));
 
-		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
-		granularity = bdev_discard_granularity(I_BDEV(inode)) ?:
+		*max_discard_sectors =
+			backingq->limits.max_write_zeroes_sectors;
+		*granularity = bdev_discard_granularity(I_BDEV(inode)) ?:
 			queue_physical_block_size(backingq);
 
 	/*
@@ -797,16 +797,9 @@ static void loop_config_discard(struct l
 	 * image a.k.a. discard.
 	 */
 	} else if (file->f_op->fallocate && !vfs_statfs(&file->f_path, &sbuf)) {
-		max_discard_sectors = UINT_MAX >> 9;
-		granularity = sbuf.f_bsize;
+		*max_discard_sectors = UINT_MAX >> 9;
+		*granularity = sbuf.f_bsize;
 	}
-
-	lim->max_hw_discard_sectors = max_discard_sectors;
-	lim->max_write_zeroes_sectors = max_discard_sectors;
-	if (max_discard_sectors)
-		lim->discard_granularity = granularity;
-	else
-		lim->discard_granularity = 0;
 }
 
 struct loop_worker {
@@ -992,6 +985,7 @@ static int loop_reconfigure_limits(struc
 	struct inode *inode = file->f_mapping->host;
 	struct block_device *backing_bdev = NULL;
 	struct queue_limits lim;
+	u32 granularity = 0, max_discard_sectors = 0;
 
 	if (S_ISBLK(inode->i_mode))
 		backing_bdev = I_BDEV(inode);
@@ -1001,6 +995,8 @@ static int loop_reconfigure_limits(struc
 	if (!bsize)
 		bsize = loop_default_blocksize(lo, backing_bdev);
 
+	loop_get_discard_config(lo, &granularity, &max_discard_sectors);
+
 	lim = queue_limits_start_update(lo->lo_queue);
 	lim.logical_block_size = bsize;
 	lim.physical_block_size = bsize;
@@ -1010,7 +1006,12 @@ static int loop_reconfigure_limits(struc
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 	if (backing_bdev && !bdev_nonrot(backing_bdev))
 		lim.features |= BLK_FEAT_ROTATIONAL;
-	loop_config_discard(lo, &lim);
+	lim.max_hw_discard_sectors = max_discard_sectors;
+	lim.max_write_zeroes_sectors = max_discard_sectors;
+	if (max_discard_sectors)
+		lim.discard_granularity = granularity;
+	else
+		lim.discard_granularity = 0;
 	return queue_limits_commit_update(lo->lo_queue, &lim);
 }
 
_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

