Return-Path: <linux-fsdevel+bounces-33898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8099C0456
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6CE281F5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4820B1E7;
	Thu,  7 Nov 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f+wg21Et"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2681D95B0
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979692; cv=none; b=bZlEgfkJfUqXhWlsDQDIMkJuoQOywp0eKot0oGBSM9RzKwlw/ErgiVu6mGS3ZcLxW9MsFYjqVhtNKrv88KC88kGrdEEhq6G6EsyHogqX3Qh9laKFrPkAJC3FUM+mOne/7TcniRx1SRzTw73bbWD9l5jioIrhwumDKDeh0psk+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979692; c=relaxed/simple;
	bh=FBe3MH5pIth0wzzTM/OP4s9XZDun816/JDqaMftxhP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+HMPSpxRzGnKFIanelQiFD+8oKfXk8rP9PC5j+4JuxcJu9bDI2IX86YyBSadh75CQ4fblyvbiXhEV0/6PH4w6ofvWnw+CL469ChlC32+CKZrlzNv3wX9cATSJTYqcPhCzULJetO+LiGuqsdqXOZlUKKCwPmdvyrcH/fzl0/U/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f+wg21Et; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cukh7qnr+59MAhbvDnu7HC2ASb+eBzC4KUqUIiSediM=; b=f+wg21Et6GJDZrRJTHTbR5PXGX
	ZQ2nwXfSgDppugQA8QonTHXl+lNSMXG4UUPvKh9ycc1AjAI22m1MkWO+mS7lmDBn33XxFRf7Wt596
	JpMNkW1AfJ7ddis/Qi4YEIP/gqq4YgGEUCOAj/SGVxgqV3OJVviYc9ZO3zZfnSXpMAyESM6CflU26
	1Jng6oW3kZNkTesrU4RKl+LlUEx/Nid8gLfPoXB0cCQgLAuL1Mh0RdLkXgPAq+9baReA65C8TDk6+
	4C6eTj1cnxrgtO9czG7Ka1Ei0E4YknPOn9+mKT0krUyvvB1GClGHUjwtYRXVDYnFbRSh+Fco/g3LT
	ms4bjJ5Q==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t90t6-003XiQ-Am; Thu, 07 Nov 2024 12:41:20 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH] hfsplus: don't query the device logical block size multiple times
Date: Thu,  7 Nov 2024 08:41:09 -0300
Message-Id: <20241107114109.839253-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices block sizes may change. One of these cases is a loop device by
using ioctl LOOP_SET_BLOCK_SIZE.

While this may cause other issues like IO being rejected, in the case of
hfsplus, it will allocate a block by using that size and potentially write
out-of-bounds when hfsplus_read_wrapper calls hfsplus_submit_bio and the
latter function reads a different io_size.

Using a new min_io_size initally set to sb_min_blocksize works for the
purposes of the original fix, since it will be set to the max between
HFSPLUS_SECTOR_SIZE and the first seen logical block size. We still use the
max between HFSPLUS_SECTOR_SIZE and min_io_size in case the latter is not
initialized.

Tested by mounting an hfsplus filesystem with loop block sizes 512, 1024
and 4096.

The produced KASAN report before the fix looks like this:

[  419.944641] ==================================================================
[  419.945655] BUG: KASAN: slab-use-after-free in hfsplus_read_wrapper+0x659/0xa0a
[  419.946703] Read of size 2 at addr ffff88800721fc00 by task repro/10678
[  419.947612]
[  419.947846] CPU: 0 UID: 0 PID: 10678 Comm: repro Not tainted 6.12.0-rc5-00008-gdf56e0f2f3ca #84
[  419.949007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  419.950035] Call Trace:
[  419.950384]  <TASK>
[  419.950676]  dump_stack_lvl+0x57/0x78
[  419.951212]  ? hfsplus_read_wrapper+0x659/0xa0a
[  419.951830]  print_report+0x14c/0x49e
[  419.952361]  ? __virt_addr_valid+0x267/0x278
[  419.952979]  ? kmem_cache_debug_flags+0xc/0x1d
[  419.953561]  ? hfsplus_read_wrapper+0x659/0xa0a
[  419.954231]  kasan_report+0x89/0xb0
[  419.954748]  ? hfsplus_read_wrapper+0x659/0xa0a
[  419.955367]  hfsplus_read_wrapper+0x659/0xa0a
[  419.955948]  ? __pfx_hfsplus_read_wrapper+0x10/0x10
[  419.956618]  ? do_raw_spin_unlock+0x59/0x1a9
[  419.957214]  ? _raw_spin_unlock+0x1a/0x2e
[  419.957772]  hfsplus_fill_super+0x348/0x1590
[  419.958355]  ? hlock_class+0x4c/0x109
[  419.958867]  ? __pfx_hfsplus_fill_super+0x10/0x10
[  419.959499]  ? __pfx_string+0x10/0x10
[  419.960006]  ? lock_acquire+0x3e2/0x454
[  419.960532]  ? bdev_name.constprop.0+0xce/0x243
[  419.961129]  ? __pfx_bdev_name.constprop.0+0x10/0x10
[  419.961799]  ? pointer+0x3f0/0x62f
[  419.962277]  ? __pfx_pointer+0x10/0x10
[  419.962761]  ? vsnprintf+0x6c4/0xfba
[  419.963178]  ? __pfx_vsnprintf+0x10/0x10
[  419.963621]  ? setup_bdev_super+0x376/0x3b3
[  419.964029]  ? snprintf+0x9d/0xd2
[  419.964344]  ? __pfx_snprintf+0x10/0x10
[  419.964675]  ? lock_acquired+0x45c/0x5e9
[  419.965016]  ? set_blocksize+0x139/0x1c1
[  419.965381]  ? sb_set_blocksize+0x6d/0xae
[  419.965742]  ? __pfx_hfsplus_fill_super+0x10/0x10
[  419.966179]  mount_bdev+0x12f/0x1bf
[  419.966512]  ? __pfx_mount_bdev+0x10/0x10
[  419.966886]  ? vfs_parse_fs_string+0xce/0x111
[  419.967293]  ? __pfx_vfs_parse_fs_string+0x10/0x10
[  419.967702]  ? __pfx_hfsplus_mount+0x10/0x10
[  419.968073]  legacy_get_tree+0x104/0x178
[  419.968414]  vfs_get_tree+0x86/0x296
[  419.968751]  path_mount+0xba3/0xd0b
[  419.969157]  ? __pfx_path_mount+0x10/0x10
[  419.969594]  ? kmem_cache_free+0x1e2/0x260
[  419.970311]  do_mount+0x99/0xe0
[  419.970630]  ? __pfx_do_mount+0x10/0x10
[  419.971008]  __do_sys_mount+0x199/0x1c9
[  419.971397]  do_syscall_64+0xd0/0x135
[  419.971761]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  419.972233] RIP: 0033:0x7c3cb812972e
[  419.972564] Code: 48 8b 0d f5 46 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c2 46 0d 00 f7 d8 64 89 01 48
[  419.974371] RSP: 002b:00007ffe30632548 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
[  419.975048] RAX: ffffffffffffffda RBX: 00007ffe306328d8 RCX: 00007c3cb812972e
[  419.975701] RDX: 0000000020000000 RSI: 0000000020000c80 RDI: 00007ffe306325d0
[  419.976363] RBP: 00007ffe30632720 R08: 00007ffe30632610 R09: 0000000000000000
[  419.977034] R10: 0000000000200008 R11: 0000000000000286 R12: 0000000000000000
[  419.977713] R13: 00007ffe306328e8 R14: 00005a0eb298bc68 R15: 00007c3cb8356000
[  419.978375]  </TASK>
[  419.978589]

Fixes: 6596528e391a ("hfsplus: ensure bio requests are not smaller than the hardware sectors")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/hfsplus/hfsplus_fs.h | 3 ++-
 fs/hfsplus/wrapper.c    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 59ce81dca73f..5389918bbf29 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -156,6 +156,7 @@ struct hfsplus_sb_info {
 
 	/* Runtime variables */
 	u32 blockoffset;
+	u32 min_io_size;
 	sector_t part_start;
 	sector_t sect_count;
 	int fs_shift;
@@ -307,7 +308,7 @@ struct hfsplus_readdir_data {
  */
 static inline unsigned short hfsplus_min_io_size(struct super_block *sb)
 {
-	return max_t(unsigned short, bdev_logical_block_size(sb->s_bdev),
+	return max_t(unsigned short, HFSPLUS_SB(sb)->min_io_size,
 		     HFSPLUS_SECTOR_SIZE);
 }
 
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 9592ffcb44e5..74801911bc1c 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -172,6 +172,8 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	if (!blocksize)
 		goto out;
 
+	sbi->min_io_size = blocksize;
+
 	if (hfsplus_get_last_session(sb, &part_start, &part_size))
 		goto out;
 
-- 
2.34.1


