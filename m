Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3314CDBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 16:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgA2PoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 10:44:10 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:43794 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgA2PoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:44:10 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 02E022E14E1;
        Wed, 29 Jan 2020 18:44:07 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id nn7RLD3EXz-i63W54mO;
        Wed, 29 Jan 2020 18:44:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1580312646; bh=0jW6t+ksq3AyJDbN3e/NgjTwllbzze9cvhKWBhAewXM=;
        h=Message-ID:Date:To:From:Subject;
        b=ZP4xZQA3zhPFSasiI9+ba/q+k4mBN4vp9NzjWdDtJa4oFUOF/uoUue9C59LJnKSe7
         X59e7xTDFBoeTveNmoEyofhNLL1CJo/7ahb83/8uQv3BTRIU2PTW7WpFlpy2r6dAHj
         2EQ9Y4yAYVkJz3Bo5BhtdNHqgHzVpErU99UnZllI=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id f3Omvi9QUt-i5VOvHST;
        Wed, 29 Jan 2020 18:44:05 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH RFC] ext4: skip concurrent inode updates in lazytime
 optimization
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Wed, 29 Jan 2020 18:44:05 +0300
Message-ID: <158031264567.6836.126132376018905207.stgit@buzz>
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

For now	concurrent inode lookup by number does not scale well because
inode hash table is protected with single spinlock. It could become very
hot at concurrent writes to fast nvme when inode cache has enough inodes.

Probably someday inode hash will become searchable under RCU.
(see linked patchset by David Howells)

Let's skip concurrent updates instead of wasting cpu time at spinlock.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/155620449631.4720.8762546550728087460.stgit@warthog.procyon.org.uk/
---
 fs/ext4/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 629a25d999f0..dc3e1b38e3ed 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4849,11 +4849,16 @@ static int other_inode_match(struct inode * inode, unsigned long ino,
 static void ext4_update_other_inodes_time(struct super_block *sb,
 					  unsigned long orig_ino, char *buf)
 {
+	static DEFINE_SPINLOCK(lock);
 	struct other_inode oi;
 	unsigned long ino;
 	int i, inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
 	int inode_size = EXT4_INODE_SIZE(sb);
 
+	/* Don't bother inode_hash_lock with concurrent updates. */
+	if (!spin_trylock(&lock))
+		return;
+
 	oi.orig_ino = orig_ino;
 	/*
 	 * Calculate the first inode in the inode table block.  Inode
@@ -4867,6 +4872,8 @@ static void ext4_update_other_inodes_time(struct super_block *sb,
 		oi.raw_inode = (struct ext4_inode *) buf;
 		(void) find_inode_nowait(sb, ino, other_inode_match, &oi);
 	}
+
+	spin_unlock(&lock);
 }
 
 /*

