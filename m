Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4C234951
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 18:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgGaQoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 12:44:05 -0400
Received: from m15111.mail.126.com ([220.181.15.111]:44032 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgGaQoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:44:05 -0400
X-Greylist: delayed 1922 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2020 12:44:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eWSI7
        L8NGq/27v/T6lDLZQTISBFxShctwfHHbupILPw=; b=qTCDi5DHFwHcZrKqLpf2a
        j7v+1QUAZke/Rm8d+7cQnzgAKFyvy2IYZ6oGugY4xEHzruyTdE6voPY3ZJL9z15C
        dmn9JeDjPKT78uudy9Ye6733lPZzZFG4maT+VPX/Vf2CRngnviFZ1I3ymqKduAMF
        ajBpExJvLuZ5XYSqNdvP6w=
Received: from 192.168.137.249 (unknown [112.10.84.202])
        by smtp1 (Coremail) with SMTP id C8mowACHv0dxQiRfuzR5IA--.15697S3;
        Sat, 01 Aug 2020 00:10:28 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: move buffer_mapped() to proper position
Date:   Fri, 31 Jul 2020 12:10:25 -0400
Message-Id: <1596211825-8750-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowACHv0dxQiRfuzR5IA--.15697S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw17Aw1furW7CF1fCryxGrg_yoW7tF47pr
        nIkFWjgF4kJ3W29rsFvF4Yq3WrX3ZxZFyxWrnagr47ZFnrGF1aqryUtF48GFW5Xws7X342
        qr15Gw18Kw1rJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jw-B_UUUUU=
X-Originating-IP: [112.10.84.202]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiwRRypFpD+6DxHgAAsu
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As you know, commit a17712c8 has added below code to aviod a
crash( 'BUG_ON(!buffer_mapped(bh))' in submit_bh_wbc) when
device hot-removed(a physical device is unpluged from pcie slot
or a nbd device's network is shutdown).
static int ext4_commit_super():
 	if (!sbh || block_device_ejected(sb))
 		return error;
+
+	/*
+	 * The superblock bh should be mapped, but it might not be if the
+	 * device was hot-removed. Not much we can do but fail the I/O.
+	 */
+	if (!buffer_mapped(sbh))
+		return error;

And the call trace, which leads to the crash, as below:
ext4_commit_super()
  __sync_dirty_buffer()
    submit_bh()
      submit_bh_wbc()
        BUG_ON(!buffer_mapped(bh));

But recently we met the same crash(with very low probability) when
device hot-removed even though the kernel already contained
above exception protection code. Still, the crash is caused by
'BUG_ON(!buffer_mapped(bh))' in submit_bh_wbc(), and the same
call trace as below.

As my understanding and below code，there are still some more
codes needs to run between 'buffer_mapped(sbh)'(which is added
by commit a17712c8) and 'BUG_ON(!buffer_mapped(bh))' in
submit_bh_wbc(), especially lock_buffer is called two times(sometimes,
it may take more times to get the lock). So when do the test of
device hot-remove, there is low probability that the sbh is mapped
when executing 'buffer_mapped(sbh)'(which is added by commit a17712c8)
but sbh is not mapped when executing 'BUG_ON(!buffer_mapped(bh))'
in submit_bh_wbc().
Code path:
ext4_commit_super
    judge if 'buffer_mapped(sbh)' is false, return <== commit a17712c8
          lock_buffer(sbh)
          ...
          unlock_buffer(sbh)
               __sync_dirty_buffer(sbh,...
                    lock_buffer(sbh)
                        judge if 'buffer_mapped(sbh))' is false, return <== added by this patch
                            submit_bh(...,sbh)
                                submit_bh_wbc(...,sbh,...)

This patch is to move the check of 'buffer_mapped(sbh)' to the place just
before calling 'BUG_ON(!buffer_mapped(bh))' in submit_bh_wbc().

[100722.966497] kernel BUG at fs/buffer.c:3095! <== BUG_ON(!buffer_mapped(bh))' in submit_bh_wbc()
[100722.966503] invalid opcode: 0000 [#1] SMP
[100722.966566] task: ffff8817e15a9e40 task.stack: ffffc90024744000
[100722.966574] RIP: 0010:submit_bh_wbc+0x180/0x190
[100722.966575] RSP: 0018:ffffc90024747a90 EFLAGS: 00010246
[100722.966576] RAX: 0000000000620005 RBX: ffff8818a80603a8 RCX: 0000000000000000
[100722.966576] RDX: ffff8818a80603a8 RSI: 0000000000020800 RDI: 0000000000000001
[100722.966577] RBP: ffffc90024747ac0 R08: 0000000000000000 R09: ffff88207f94170d
[100722.966578] R10: 00000000000437c8 R11: 0000000000000001 R12: 0000000000020800
[100722.966578] R13: 0000000000000001 R14: 000000000bf9a438 R15: ffff88195f333000
[100722.966580] FS:  00007fa2eee27700(0000) GS:ffff88203d840000(0000) knlGS:0000000000000000
[100722.966580] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[100722.966581] CR2: 0000000000f0b008 CR3: 000000201a622003 CR4: 00000000007606e0
[100722.966582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[100722.966583] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[100722.966583] PKRU: 55555554
[100722.966583] Call Trace:
[100722.966588]  __sync_dirty_buffer+0x6e/0xd0
[100722.966614]  ext4_commit_super+0x1d8/0x290 [ext4]
[100722.966626]  __ext4_std_error+0x78/0x100 [ext4]
[100722.966635]  ? __ext4_journal_get_write_access+0xca/0x120 [ext4]
[100722.966646]  ext4_reserve_inode_write+0x58/0xb0 [ext4]
[100722.966655]  ? ext4_dirty_inode+0x48/0x70 [ext4]
[100722.966663]  ext4_mark_inode_dirty+0x53/0x1e0 [ext4]
[100722.966671]  ? __ext4_journal_start_sb+0x6d/0xf0 [ext4]
[100722.966679]  ext4_dirty_inode+0x48/0x70 [ext4]
[100722.966682]  __mark_inode_dirty+0x17f/0x350
[100722.966686]  generic_update_time+0x87/0xd0
[100722.966687]  touch_atime+0xa9/0xd0
[100722.966690]  generic_file_read_iter+0xa09/0xcd0
[100722.966694]  ? page_cache_tree_insert+0xb0/0xb0
[100722.966704]  ext4_file_read_iter+0x4a/0x100 [ext4]
[100722.966707]  ? __inode_security_revalidate+0x4f/0x60
[100722.966709]  __vfs_read+0xec/0x160
[100722.966711]  vfs_read+0x8c/0x130
[100722.966712]  SyS_pread64+0x87/0xb0
[100722.966716]  do_syscall_64+0x67/0x1b0
[100722.966719]  entry_SYSCALL64_slow_path+0x25/0x25

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 fs/buffer.c     | 9 +++++++++
 fs/ext4/super.c | 7 -------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 64fe82e..75a8849 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3160,6 +3160,15 @@ int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)
 	WARN_ON(atomic_read(&bh->b_count) < 1);
 	lock_buffer(bh);
 	if (test_clear_buffer_dirty(bh)) {
+		/*
+		 * The bh should be mapped, but it might not be if the
+		 * device was hot-removed. Not much we can do but fail the I/O.
+		 */
+		if (!buffer_mapped(bh)) {
+			unlock_buffer(bh);
+			return -EIO;
+		}
+
 		get_bh(bh);
 		bh->b_end_io = end_buffer_write_sync;
 		ret = submit_bh(REQ_OP_WRITE, op_flags, bh);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957e..1c22044 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5171,13 +5171,6 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 		return error;
 
 	/*
-	 * The superblock bh should be mapped, but it might not be if the
-	 * device was hot-removed. Not much we can do but fail the I/O.
-	 */
-	if (!buffer_mapped(sbh))
-		return error;
-
-	/*
 	 * If the file system is mounted read-only, don't update the
 	 * superblock write time.  This avoids updating the superblock
 	 * write time when we are mounting the root file system
-- 
1.8.3.1

