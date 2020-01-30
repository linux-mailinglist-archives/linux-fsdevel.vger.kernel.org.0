Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC814E03C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgA3Rri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 12:47:38 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56142 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbgA3Rri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:47:38 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2020 12:47:36 EST
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B44FA2E129E;
        Thu, 30 Jan 2020 20:40:35 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id IhTHqh0e8z-eY3CLLiY;
        Thu, 30 Jan 2020 20:40:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1580406035; bh=FvG9RYl7FyNS5K/tl+yfSrh8hxf4XZKmAfbcfhj89qE=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=K/JD9rxdqxGu5KPaQNkzDVylKM9+v1Rore08QtOhY9BikHqPIq10i1VrJjAKuoEyk
         P+d6kMVHkJEdPCb1mBEf6fiodMWR9eAKsOx+2gtyI+p9RVZKmK/D1fq2GhyvNvDqDK
         REW7n5Pztz29BDuTUNLjHT7goCrw929uZ/JzPVDM=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id sG6tGHo0RP-eYVa8kTC;
        Thu, 30 Jan 2020 20:40:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 2/2] ext4: avoid spinlock congestion in lazytime
 optimization
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Thu, 30 Jan 2020 20:40:34 +0300
Message-ID: <158040603451.1879.7954684107752709143.stgit@buzz>
In-Reply-To: <158040603214.1879.6549790415691475804.stgit@buzz>
References: <158040603214.1879.6549790415691475804.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function ext4_update_other_inodes_time() implements optimization which
opportunistically updates times for inodes within same inode table block.

For now concurrent inode lookup by number does not scale well because
inode hash table is protected with single spinlock. It could become very
hot at concurrent writes to fast nvme when inode cache has enough inodes.

Let's use here non-blocking variant of function find_inode_nowait() and
skip opportunistic inode updates if spinlock is congested.


Synthetic testcase by Dmitry Monakhov:

modprobe brd rd_size=10240000 rd_nr=1
mkfs.ext4 -F -I 256 -b 4096 -q /dev/ram0
mkdir -p m
mount /dev/ram0 m -o lazytime,noload,barrier=0
mkdir m/{0..31}
fio --ioengine=ftruncate --direct=1 --bs=4k --filesize=16m --time_based=1 \
--runtime=10 --numjobs=32 --group_reporting --norandommap --name=write-32 \
--rw=randwrite --directory=m --filename_format='$jobnum/t'
umount m
rmdir m
rmmod brd

Before patch:	50k op/s
After patch:	3000k op/s

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/158031264567.6836.126132376018905207.stgit@buzz/T/#u (v1)
---
 fs/ext4/inode.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9512eb771820..3dea7327e7ab 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4853,6 +4853,7 @@ static void ext4_update_other_inodes_time(struct super_block *sb,
 	unsigned long ino;
 	int i, inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
 	int inode_size = EXT4_INODE_SIZE(sb);
+	struct inode *res;
 
 	oi.orig_ino = orig_ino;
 	/*
@@ -4865,7 +4866,10 @@ static void ext4_update_other_inodes_time(struct super_block *sb,
 		if (ino == orig_ino)
 			continue;
 		oi.raw_inode = (struct ext4_inode *) buf;
-		(void)find_inode_nowait(sb, ino, other_inode_match, &oi, false);
+		/* Try to find inode, stop if inode_hash_lock is congested. */
+		res = find_inode_nowait(sb, ino, other_inode_match, &oi, true);
+		if (res == ERR_PTR(-EAGAIN))
+			break;
 	}
 }
 

