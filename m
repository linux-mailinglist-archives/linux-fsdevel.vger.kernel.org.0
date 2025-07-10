Return-Path: <linux-fsdevel+bounces-54549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B83B00DEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720A41C267A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 21:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660B242D73;
	Thu, 10 Jul 2025 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="gFUeqHdy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857F1E520B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183454; cv=none; b=fcJ2AbMf4Q6RqrNyIWijyKxnxxiyRiBe2P0a3tYxba+ne0i1oY3+uoFZ9b+sXlFW83qKHX9Xni3BCqzyfK0lIqdC0oyIZMLNmMNi2kJqMw7CxSpR+rDgFFmyulOOVZawyAmNTxBZcvPYUHUPoilD1ab7IDD8xj9TFF5Ktb5H8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183454; c=relaxed/simple;
	bh=tj2mF+HjtmZMuFLfZ9pQwTCGsBF0yDt7IpnCIFHpkbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNPvtft3atO8fRpzhZQ6TQKJA1t4Q2jeiTISLYeakMdr6L0Fyt4zpx1rvAHdh2m6HhZvlTfmarVLQEMA5NOPViN6KG5DrasnD6EQu19da6QZIah9K8RwrbZUVe3pM1jU19VJbPQ+fPxYyqOS1MTdSlDvCGt/p3ApiyC7Sp7i5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=gFUeqHdy; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e73e9e18556so1594198276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752183451; x=1752788251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ/QLQkf3Npt4h17YaII8g8WSIup+fFQSuLIox6KIuI=;
        b=gFUeqHdy4u29NVS/X1Dio7FV5YJGTptHd2q9X2yv4jQ1HmnyZFermHDWtq27DofCHs
         SxcQzp2Khv+cJASgqbS+n8O11VKkr8IbL1Ve5KcC89/ACHpRHojGEGA4lgnzTEcl7JoE
         uJ4sg9CQ3Hha5QlQRbQ6+NMumjY3/vQ0K++GPHJSgr/rolWCD32N0GGVa0+oLPtyX/n5
         qHqXRv17EkVP5XU+yWJIZyE2unA9wbEeApAQW9BEwo0+Visnuk5eLDf1xPC707K6b04q
         6liuXI5Yneljiy26v9v3jUnn/6xodkGhXCq7uUIKUWQkqSDA58PzXlD1GaeyJe6XHGb2
         zreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183451; x=1752788251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQ/QLQkf3Npt4h17YaII8g8WSIup+fFQSuLIox6KIuI=;
        b=riERT8jEB/kYf+sCVpOpoKu7/fiam9atydGS00RwWKWwoK54PlTP9CkLrodZ9q1pR8
         TUF3dPh0HEfleoQGG0xVYkU8F8j0fRHL5nloYW0q/P0cwF8VaPeaHymj7pJ9EKwPyY9t
         3RAlHoE4hNaJUQpIjr9cm40cToaLfgK+qoTF1MbPy3rBS7vWtSYObpeFBJ02Sc5RU8/g
         rqnT04f0+h4+ZaCagEAoRh7aZmjKXUt4NyEj8OK7LpHTpW6uBf0nU/iyxUGE4HpVgWT+
         BGuhfkUsjThCdgIJGZNhlMIE+A+05jqMb4VXM5ej0MjAq+WIkoQglJ3BQeqqKmExcSiz
         EDvw==
X-Forwarded-Encrypted: i=1; AJvYcCUmzMdUwKkktqCyveko40nLua4RMdSTOdEsKAi0JBFa7DLyqp3+t7IGhtnSDE5/qrU7cFzGhn4BvIHW63Nc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzji89AbGvCP6npg1xqTrvFZcF18YhRUnJEiQxcR2nG/BjmmYcS
	WBvm2NPbtvSg9ZHHXoZxwZtCtEQsFhkWrvu9nDzyT7oE0vHXWkX6Ld5ZZNHivY1LPoQ=
X-Gm-Gg: ASbGnctxcYs5gElZV+SE/NTnf1JmHvYRAWe2/ICQxLOYkCmYF6dX0L4L/5CGxhXYOA/
	wnDuqBKHkqhunB4Hm2RboU5h9epdvFXZxV7AecpnKLzd+LqtBcBSXwZlFH8ibCgge6TN5eLH0A1
	mR4n0HtvuFxSHlLf24SyF1aKw4Lr6I4aD0czN+xp4rZPPb0b904F0Yk6ZSR6xtL4/zdro3LXGah
	RNwfacnmfBj0aYVgbtECDm35V57mS6qJWDlHHV4Z94LJc/R80whs/jOpT613yxLsOb+6x2grwpu
	qz83GKntz4W24YzsYXlro3WIvNtZdq3HVmoNmwS4nKWE3NgRzB3vtVMuniiKZ5NKLczag7b/H2W
	KAtrOAi2xv6N+UHkPbDHPl1XSsM/hSZxUIg==
X-Google-Smtp-Source: AGHT+IFQ5wu0jMpuHscSB/SB+WVX+eZpPyDtedPn+xTxC9NLRor6mQM/mfUnJrEJ1C4KpHo6k/YH/w==
X-Received: by 2002:a05:6902:4805:b0:e84:4abe:3a26 with SMTP id 3f1490d57ef6-e8b850c1c00mr1232257276.5.1752183450493;
        Thu, 10 Jul 2025 14:37:30 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9e89:c5b3:9b71:4f51])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7ae2a448sm679063276.10.2025.07.10.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:37:29 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	wenzhi.wang@uwaterloo.ca
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: fix general protection fault in hfs_find_init()
Date: Thu, 10 Jul 2025 14:36:57 -0700
Message-Id: <20250710213657.108285-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hfs_find_init() method can trigger the crash
if tree pointer is NULL:

[   45.746290][ T9787] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KAI
[   45.747287][ T9787] KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
[   45.748716][ T9787] CPU: 2 UID: 0 PID: 9787 Comm: repro Not tainted 6.16.0-rc3 #10 PREEMPT(full)
[   45.750250][ T9787] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   45.751983][ T9787] RIP: 0010:hfs_find_init+0x86/0x230
[   45.752834][ T9787] Code: c1 ea 03 80 3c 02 00 0f 85 9a 01 00 00 4c 8d 6b 40 48 c7 45 18 00 00 00 00 48 b8 00 00 00 00 00 fc
[   45.755574][ T9787] RSP: 0018:ffffc90015157668 EFLAGS: 00010202
[   45.756432][ T9787] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff819a4d09
[   45.757457][ T9787] RDX: 0000000000000008 RSI: ffffffff819acd3a RDI: ffffc900151576e8
[   45.758282][ T9787] RBP: ffffc900151576d0 R08: 0000000000000005 R09: 0000000000000000
[   45.758943][ T9787] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000004
[   45.759619][ T9787] R13: 0000000000000040 R14: ffff88802c50814a R15: 0000000000000000
[   45.760293][ T9787] FS:  00007ffb72734540(0000) GS:ffff8880cec64000(0000) knlGS:0000000000000000
[   45.761050][ T9787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.761606][ T9787] CR2: 00007f9bd8225000 CR3: 000000010979a000 CR4: 00000000000006f0
[   45.762286][ T9787] Call Trace:
[   45.762570][ T9787]  <TASK>
[   45.762824][ T9787]  hfs_ext_read_extent+0x190/0x9d0
[   45.763269][ T9787]  ? submit_bio_noacct_nocheck+0x2dd/0xce0
[   45.763766][ T9787]  ? __pfx_hfs_ext_read_extent+0x10/0x10
[   45.764250][ T9787]  hfs_get_block+0x55f/0x830
[   45.764646][ T9787]  block_read_full_folio+0x36d/0x850
[   45.765105][ T9787]  ? __pfx_hfs_get_block+0x10/0x10
[   45.765541][ T9787]  ? const_folio_flags+0x5b/0x100
[   45.765972][ T9787]  ? __pfx_hfs_read_folio+0x10/0x10
[   45.766415][ T9787]  filemap_read_folio+0xbe/0x290
[   45.766840][ T9787]  ? __pfx_filemap_read_folio+0x10/0x10
[   45.767325][ T9787]  ? __filemap_get_folio+0x32b/0xbf0
[   45.767780][ T9787]  do_read_cache_folio+0x263/0x5c0
[   45.768223][ T9787]  ? __pfx_hfs_read_folio+0x10/0x10
[   45.768666][ T9787]  read_cache_page+0x5b/0x160
[   45.769070][ T9787]  hfs_btree_open+0x491/0x1740
[   45.769481][ T9787]  hfs_mdb_get+0x15e2/0x1fb0
[   45.769877][ T9787]  ? __pfx_hfs_mdb_get+0x10/0x10
[   45.770316][ T9787]  ? find_held_lock+0x2b/0x80
[   45.770731][ T9787]  ? lockdep_init_map_type+0x5c/0x280
[   45.771200][ T9787]  ? lockdep_init_map_type+0x5c/0x280
[   45.771674][ T9787]  hfs_fill_super+0x38e/0x720
[   45.772092][ T9787]  ? __pfx_hfs_fill_super+0x10/0x10
[   45.772549][ T9787]  ? snprintf+0xbe/0x100
[   45.772931][ T9787]  ? __pfx_snprintf+0x10/0x10
[   45.773350][ T9787]  ? do_raw_spin_lock+0x129/0x2b0
[   45.773796][ T9787]  ? find_held_lock+0x2b/0x80
[   45.774215][ T9787]  ? set_blocksize+0x40a/0x510
[   45.774636][ T9787]  ? sb_set_blocksize+0x176/0x1d0
[   45.775087][ T9787]  ? setup_bdev_super+0x369/0x730
[   45.775533][ T9787]  get_tree_bdev_flags+0x384/0x620
[   45.775985][ T9787]  ? __pfx_hfs_fill_super+0x10/0x10
[   45.776453][ T9787]  ? __pfx_get_tree_bdev_flags+0x10/0x10
[   45.776950][ T9787]  ? bpf_lsm_capable+0x9/0x10
[   45.777365][ T9787]  ? security_capable+0x80/0x260
[   45.777803][ T9787]  vfs_get_tree+0x8e/0x340
[   45.778203][ T9787]  path_mount+0x13de/0x2010
[   45.778604][ T9787]  ? kmem_cache_free+0x2b0/0x4c0
[   45.779052][ T9787]  ? __pfx_path_mount+0x10/0x10
[   45.779480][ T9787]  ? getname_flags.part.0+0x1c5/0x550
[   45.779954][ T9787]  ? putname+0x154/0x1a0
[   45.780335][ T9787]  __x64_sys_mount+0x27b/0x300
[   45.780758][ T9787]  ? __pfx___x64_sys_mount+0x10/0x10
[   45.781232][ T9787]  do_syscall_64+0xc9/0x480
[   45.781631][ T9787]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   45.782149][ T9787] RIP: 0033:0x7ffb7265b6ca
[   45.782539][ T9787] Code: 48 8b 0d c9 17 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48
[   45.784212][ T9787] RSP: 002b:00007ffc0c10cfb8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[   45.784935][ T9787] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffb7265b6ca
[   45.785626][ T9787] RDX: 0000200000000240 RSI: 0000200000000280 RDI: 00007ffc0c10d100
[   45.786316][ T9787] RBP: 00007ffc0c10d190 R08: 00007ffc0c10d000 R09: 0000000000000000
[   45.787011][ T9787] R10: 0000000000000048 R11: 0000000000000206 R12: 0000560246733250
[   45.787697][ T9787] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   45.788393][ T9787]  </TASK>
[   45.788665][ T9787] Modules linked in:
[   45.789058][ T9787] ---[ end trace 0000000000000000 ]---
[   45.789554][ T9787] RIP: 0010:hfs_find_init+0x86/0x230
[   45.790028][ T9787] Code: c1 ea 03 80 3c 02 00 0f 85 9a 01 00 00 4c 8d 6b 40 48 c7 45 18 00 00 00 00 48 b8 00 00 00 00 00 fc
[   45.792364][ T9787] RSP: 0018:ffffc90015157668 EFLAGS: 00010202
[   45.793155][ T9787] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff819a4d09
[   45.794123][ T9787] RDX: 0000000000000008 RSI: ffffffff819acd3a RDI: ffffc900151576e8
[   45.795105][ T9787] RBP: ffffc900151576d0 R08: 0000000000000005 R09: 0000000000000000
[   45.796135][ T9787] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000004
[   45.797114][ T9787] R13: 0000000000000040 R14: ffff88802c50814a R15: 0000000000000000
[   45.798024][ T9787] FS:  00007ffb72734540(0000) GS:ffff8880cec64000(0000) knlGS:0000000000000000
[   45.799019][ T9787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.799822][ T9787] CR2: 00007f9bd8225000 CR3: 000000010979a000 CR4: 00000000000006f0
[   45.800747][ T9787] Kernel panic - not syncing: Fatal exception

The hfs_fill_super() calls hfs_mdb_get() method that tries
to construct Extents Tree and Catalog Tree:

HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
if (!HFS_SB(sb)->ext_tree) {
	pr_err("unable to open extent tree\n");
	goto out;
}
HFS_SB(sb)->cat_tree = hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycmp);
if (!HFS_SB(sb)->cat_tree) {
	pr_err("unable to open catalog tree\n");
	goto out;
}

However, hfs_btree_open() calls read_mapping_page() that
calls hfs_get_block(). And this method calls hfs_ext_read_extent():

static int hfs_ext_read_extent(struct inode *inode, u16 block)
{
	struct hfs_find_data fd;
	int res;

	if (block >= HFS_I(inode)->cached_start &&
	    block < HFS_I(inode)->cached_start + HFS_I(inode)->cached_blocks)
		return 0;

	res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
	if (!res) {
		res = __hfs_ext_cache_extent(&fd, inode, block);
		hfs_find_exit(&fd);
	}
	return res;
}

The problem here that hfs_find_init() is trying to use
HFS_SB(inode->i_sb)->ext_tree that is not initialized yet.
It will be initailized when hfs_btree_open() finishes
the execution.

The patch adds checking of tree pointer in hfs_find_init()
and it reworks the logic of hfs_btree_open() by reading
the b-tree's header directly from the volume. The read_mapping_page()
is exchanged on filemap_grab_folio() that grab the folio from
mapping. Then, sb_bread() extracts the b-tree's header
content and copy it into the folio.

Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/bfind.c  |  3 +++
 fs/hfs/btree.c  | 57 +++++++++++++++++++++++++++++++++++++++----------
 fs/hfs/extent.c |  2 +-
 fs/hfs/hfs_fs.h |  1 +
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..34e9804e0f36 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 {
 	void *ptr;
 
+	if (!tree || !fd)
+		return -EINVAL;
+
 	fd->tree = tree;
 	fd->bnode = NULL;
 	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2fa4b1f8cc7f..e86e1e235658 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -21,8 +21,12 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	struct hfs_btree *tree;
 	struct hfs_btree_header_rec *head;
 	struct address_space *mapping;
-	struct page *page;
+	struct folio *folio;
+	struct buffer_head *bh;
 	unsigned int size;
+	u16 dblock;
+	sector_t start_block;
+	loff_t offset;
 
 	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
 	if (!tree)
@@ -75,12 +79,40 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	unlock_new_inode(tree->inode);
 
 	mapping = tree->inode->i_mapping;
-	page = read_mapping_page(mapping, 0, NULL);
-	if (IS_ERR(page))
+	folio = filemap_grab_folio(mapping, 0);
+	if (IS_ERR(folio))
 		goto free_inode;
 
+	folio_zero_range(folio, 0, folio_size(folio));
+
+	dblock = hfs_ext_find_block(HFS_I(tree->inode)->first_extents, 0);
+	start_block = HFS_SB(sb)->fs_start + (dblock * HFS_SB(sb)->fs_div);
+
+	size = folio_size(folio);
+	offset = 0;
+	while (size > 0) {
+		size_t len;
+
+		bh = sb_bread(sb, start_block);
+		if (!bh) {
+			pr_err("unable to read tree header\n");
+			goto put_folio;
+		}
+
+		len = min_t(size_t, folio_size(folio), sb->s_blocksize);
+		memcpy_to_folio(folio, offset, bh->b_data, sb->s_blocksize);
+
+		brelse(bh);
+
+		start_block++;
+		offset += len;
+		size -= len;
+	}
+
+	folio_mark_uptodate(folio);
+
 	/* Load the header */
-	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
+	head = (struct hfs_btree_header_rec *)(kmap_local_folio(folio, 0) +
 					       sizeof(struct hfs_bnode_desc));
 	tree->root = be32_to_cpu(head->root);
 	tree->leaf_count = be32_to_cpu(head->leaf_count);
@@ -95,22 +127,22 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 
 	size = tree->node_size;
 	if (!is_power_of_2(size))
-		goto fail_page;
+		goto fail_folio;
 	if (!tree->node_count)
-		goto fail_page;
+		goto fail_folio;
 	switch (id) {
 	case HFS_EXT_CNID:
 		if (tree->max_key_len != HFS_MAX_EXT_KEYLEN) {
 			pr_err("invalid extent max_key_len %d\n",
 			       tree->max_key_len);
-			goto fail_page;
+			goto fail_folio;
 		}
 		break;
 	case HFS_CAT_CNID:
 		if (tree->max_key_len != HFS_MAX_CAT_KEYLEN) {
 			pr_err("invalid catalog max_key_len %d\n",
 			       tree->max_key_len);
-			goto fail_page;
+			goto fail_folio;
 		}
 		break;
 	default:
@@ -121,12 +153,15 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->pages_per_bnode = (tree->node_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	kunmap_local(head);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return tree;
 
-fail_page:
+fail_folio:
 	kunmap_local(head);
-	put_page(page);
+put_folio:
+	folio_unlock(folio);
+	folio_put(folio);
 free_inode:
 	tree->inode->i_mapping->a_ops = &hfs_aops;
 	iput(tree->inode);
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 4a0ce131e233..580c62981dbd 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -71,7 +71,7 @@ int hfs_ext_keycmp(const btree_key *key1, const btree_key *key2)
  *
  * Find a block within an extent record
  */
-static u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off)
+u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off)
 {
 	int i;
 	u16 count;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index a0c7cb0f79fc..732c5c4c7545 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -190,6 +190,7 @@ extern const struct inode_operations hfs_dir_inode_operations;
 
 /* extent.c */
 extern int hfs_ext_keycmp(const btree_key *, const btree_key *);
+extern u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off);
 extern int hfs_free_fork(struct super_block *, struct hfs_cat_file *, int);
 extern int hfs_ext_write_extent(struct inode *);
 extern int hfs_extend_file(struct inode *);
-- 
2.43.0


