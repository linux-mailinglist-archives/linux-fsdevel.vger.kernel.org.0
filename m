Return-Path: <linux-fsdevel+bounces-35211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326C9D287E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4AFB28F5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C571CF28C;
	Tue, 19 Nov 2024 14:46:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67291CC174;
	Tue, 19 Nov 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027599; cv=none; b=Fal9I8LzKKL0rNruyX/x1/JohW5juBfiFLO9D9Sqefb3DdNKSLXkpP2RLXMZBGsrNSlMh4DnRqXQ5zpaWDamJTkYgv3MpVsPTzFSdK5Z+Do9GdzI6LaQfTvBnIRDiWDPiBFdmeqZDBe0x/CQcnIMC12UbfhU2kuv5fVLWoxCXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027599; c=relaxed/simple;
	bh=lRSgxDGGlWLJ/B/qkh7AVttXoTuu5ra6roLtOVhvZnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ofw2KWF1sUG0bw1NgvgMPQk17b+xZRh7YkXrtspfxG4acl2T2bGoU1NClWi1VJNoyhDMj2GYGysKjthjpAOedXplwdaZrKMBZ7mQVeXz9gaUcpDCyCDAJL7C/wX95B/maCOQ43CizftInJI5YcHvr7al3++4HQC2Qog0gXSCc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 679C12051589;
	Tue, 19 Nov 2024 23:46:35 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4AJEkYRt056398
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:46:35 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4AJEkYWs352030
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:46:34 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4AJEkXwk352026;
	Tue, 19 Nov 2024 23:46:33 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        syzbot
 <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
In-Reply-To: <74141e63-d946-421a-be4e-4823944dd8c9@kernel.dk> (Jens Axboe's
	message of "Tue, 19 Nov 2024 07:18:12 -0700")
References: <67313d9e.050a0220.138bd5.0054.GAE@google.com>
	<8734jxsyuu.fsf@mail.parknet.co.jp>
	<CAFj5m9+FmQLLQkO7EUKnuuj+mpSUOY3EeUxSpXjJUvWtKfz26w@mail.gmail.com>
	<74141e63-d946-421a-be4e-4823944dd8c9@kernel.dk>
Date: Tue, 19 Nov 2024 23:46:33 +0900
Message-ID: <87wmgz8enq.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jens Axboe <axboe@kernel.dk> writes:

> On 11/19/24 5:10 AM, Ming Lei wrote:
>> On Tue, Nov 12, 2024 at 12:44=E2=80=AFAM OGAWA Hirofumi
>> <hirofumi@mail.parknet.co.jp> wrote:
>>>
>>> Hi,
>>>
>>> syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com> writes:
>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
>>>> git tree:       linux-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1621bd8798=
0000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D75175323f2=
078363
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da5d8c609c02f=
508672cc
>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for =
Debian) 2.40

[...]

>>=20
>> Looks fine,
>>=20
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> The patch doesn't apply to the for-6.13/block tree, Ogawa can you send
> an updated one please?

Updated the patch for linux-block:for-6.13/block. Please apply.

Thanks.


From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] loop: Fix ABBA locking race
Date: Tue, 19 Nov 2024 23:42:23 +0900

Current loop calls vfs_statfs() while holding the q->limits_lock. If
FS takes some locking in vfs_statfs callback, this may lead to ABBA
locking bug (at least, FAT fs has this issue actually).

So this patch calls vfs_statfs() outside q->limits_locks instead,
because looks like no reason to hold q->limits_locks while getting
discord configs.

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
Closes: https://syzkaller.appspot.com/bug?extid=3Da5d8c609c02f508672cc
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 drivers/block/loop.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fe9bb4f..8f6761c 100644
--- a/drivers/block/loop.c	2024-11-19 23:37:54.760751014 +0900
+++ b/drivers/block/loop.c	2024-11-19 23:38:55.645461107 +0900
@@ -770,12 +770,11 @@ static void loop_sysfs_exit(struct loop_
 				   &loop_attribute_group);
 }
=20
-static void loop_config_discard(struct loop_device *lo,
-		struct queue_limits *lim)
+static void loop_get_discard_config(struct loop_device *lo,
+				    u32 *granularity, u32 *max_discard_sectors)
 {
 	struct file *file =3D lo->lo_backing_file;
 	struct inode *inode =3D file->f_mapping->host;
-	u32 granularity =3D 0, max_discard_sectors =3D 0;
 	struct kstatfs sbuf;
=20
 	/*
@@ -788,24 +787,17 @@ static void loop_config_discard(struct l
 	if (S_ISBLK(inode->i_mode)) {
 		struct block_device *bdev =3D I_BDEV(inode);
=20
-		max_discard_sectors =3D bdev_write_zeroes_sectors(bdev);
-		granularity =3D bdev_discard_granularity(bdev);
+		*max_discard_sectors =3D bdev_write_zeroes_sectors(bdev);
+		*granularity =3D bdev_discard_granularity(bdev);
=20
 	/*
 	 * We use punch hole to reclaim the free space used by the
 	 * image a.k.a. discard.
 	 */
 	} else if (file->f_op->fallocate && !vfs_statfs(&file->f_path, &sbuf)) {
-		max_discard_sectors =3D UINT_MAX >> 9;
-		granularity =3D sbuf.f_bsize;
+		*max_discard_sectors =3D UINT_MAX >> 9;
+		*granularity =3D sbuf.f_bsize;
 	}
-
-	lim->max_hw_discard_sectors =3D max_discard_sectors;
-	lim->max_write_zeroes_sectors =3D max_discard_sectors;
-	if (max_discard_sectors)
-		lim->discard_granularity =3D granularity;
-	else
-		lim->discard_granularity =3D 0;
 }
=20
 struct loop_worker {
@@ -991,6 +983,7 @@ static int loop_reconfigure_limits(struc
 	struct inode *inode =3D file->f_mapping->host;
 	struct block_device *backing_bdev =3D NULL;
 	struct queue_limits lim;
+	u32 granularity =3D 0, max_discard_sectors =3D 0;
=20
 	if (S_ISBLK(inode->i_mode))
 		backing_bdev =3D I_BDEV(inode);
@@ -1000,6 +993,8 @@ static int loop_reconfigure_limits(struc
 	if (!bsize)
 		bsize =3D loop_default_blocksize(lo, backing_bdev);
=20
+	loop_get_discard_config(lo, &granularity, &max_discard_sectors);
+
 	lim =3D queue_limits_start_update(lo->lo_queue);
 	lim.logical_block_size =3D bsize;
 	lim.physical_block_size =3D bsize;
@@ -1009,7 +1004,12 @@ static int loop_reconfigure_limits(struc
 		lim.features |=3D BLK_FEAT_WRITE_CACHE;
 	if (backing_bdev && !bdev_nonrot(backing_bdev))
 		lim.features |=3D BLK_FEAT_ROTATIONAL;
-	loop_config_discard(lo, &lim);
+	lim.max_hw_discard_sectors =3D max_discard_sectors;
+	lim.max_write_zeroes_sectors =3D max_discard_sectors;
+	if (max_discard_sectors)
+		lim.discard_granularity =3D granularity;
+	else
+		lim.discard_granularity =3D 0;
 	return queue_limits_commit_update(lo->lo_queue, &lim);
 }
=20
_
--=20
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

