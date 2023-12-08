Return-Path: <linux-fsdevel+bounces-5386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB380AFBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 23:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C91C20B19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA53359B6A;
	Fri,  8 Dec 2023 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="28YeX5OM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BCCC3;
	Fri,  8 Dec 2023 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Sa/Z8aByGHxa+3BKe3cRTTzGHVJcJWowKfiUXyt02pg=; b=28YeX5OMNOyYdf3DyfVdGTEstN
	f0P4THzRQPbprxfO1Bh952D9MGZwGI0He4KFAZRrHe3wP9men6GoHz6ES8f8RMa/hhpjoDXTYwAb2
	Bp1c0x9yiOBjo7GaZ78l/Y1ofhPgPE76UOqT58Qjgkc4PBMb72R+dUI9xhNnD5g/ZlFQBM2Ocu+jL
	JdUSqX9FA3kL+OINWlHvNHlPWY4f4sGo5CNttqRsSqa727QX5Z3iW0D5P+i5Ydg5baBuPGswVMvii
	66JDTaMTUEkN8+o0tzQHVtXFkh3zDlSHKe3Crxp0hJHZcDTO7s8AdjQW9hxSB6JnMp+CqHJ99u0Vj
	9jJxBmBA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rBjVQ-00Ghiq-3A;
	Fri, 08 Dec 2023 22:39:36 +0000
Date: Fri, 8 Dec 2023 14:39:36 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-mm@kvack.org, xfs <linux-xfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: mm/truncate.c:669 VM_BUG_ON_FOLIO() - hit on XFS on different tests
Message-ID: <ZXObKBfw/0bcRQNr@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>

Commit aa5b9178c0190 ("mm: invalidation check mapping before folio_contains")
added on v6.6-rc1 moved the VM_BUG_ON_FOLIO() on invalidate_inode_pages2_range()
after the truncation check.

We managed to hit this VM_BUG_ON_FOLIO() a few times on v6.6-rc5 with a slew
of fstsets tests on kdevops [0] on the following XFS config as defined by
kdevops XFS's configurations [1] for XFS with the following failure rates
annotated:

  * xfs_reflink_4k: F:1/278 - one out of 278 times
    - generic/451: (trace pasted below after running test over 17 hours)
  * xfs_nocrc_4k: F:1/1604 - one ou tof 1604 times
     - generic/451: https://gist.github.com/mcgrof/2c40a14979ceeb7321d2234a525c32a6

To be clear F:1/1604 means you can run the test in a loop and on test number
about 1604 you may run into the bug. It would seem Zorro had hit also
with a 64k directory size (mkfs.xfs -n size=65536) on v5.19-rc2, so prior 
to Hugh's move of the VM_BUG_ON_FOLIO() while testing generic/132 [0].

My hope is that this could help those interested in reproducing, to
spawn up kdevops and just run the test in a loop in the same way.
Likewise, if you have a fix to test we can test it as well, but it will
take a while as we want to run the test in a loop over and over many
times.

[0] https://github.com/linux-kdevops/
[1] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/fstests/templates/xfs/xfs.config
[2] https://bugzilla.kernel.org/show_bug.cgi?id=216114

  Luis

Nov 05 23:20:54 r451-xfs-reflink-4k unknown: run fstests generic/451 at 2023-11-05 23:20:54
Nov 05 23:21:25 r451-xfs-reflink-4k kernel: XFS (loop16): EXPERIMENTAL online scrub feature in use. Use at your own risk!
Nov 05 23:21:25 r451-xfs-reflink-4k kernel: XFS (loop16): Unmounting Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 05 23:21:25 r451-xfs-reflink-4k kernel: XFS (loop16): Mounting V5 Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 05 23:21:25 r451-xfs-reflink-4k kernel: XFS (loop16): Ending clean mount
Nov 05 23:21:26 r451-xfs-reflink-4k kernel: kmemleak: 14 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
Nov 05 23:21:26 r451-xfs-reflink-4k kernel: XFS (loop16): Unmounting Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 05 23:21:27 r451-xfs-reflink-4k kernel: XFS (loop16): Mounting V5 Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 05 23:21:27 r451-xfs-reflink-4k kernel: XFS (loop16): Ending clean mount
Nov 05 23:21:28 r451-xfs-reflink-4k kernel: XFS (loop5): Mounting V5 Filesystem c1814fb4-5f79-4274-96fa-7bf6fabe0ee8
Nov 05 23:21:28 r451-xfs-reflink-4k kernel: XFS (loop5): Ending clean mount
Nov 05 23:21:28 r451-xfs-reflink-4k kernel: XFS (loop5): Unmounting Filesystem c1814fb4-5f79-4274-96fa-7bf6fabe0ee8
Nov 05 23:21:28 r451-xfs-reflink-4k kernel: XFS (loop16): EXPERIMENTAL online scrub feature in use. Use at your own risk!
Nov 05 23:21:28 r451-xfs-reflink-4k kernel: XFS (loop16): Unmounting Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 05 23:21:29 r451-xfs-reflink-4k kernel: XFS (loop16): Mounting V5 Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 05 23:21:29 r451-xfs-reflink-4k kernel: XFS (loop16): Ending clean mount
Nov 05 23:21:29 r451-xfs-reflink-4k unknown: run fstests generic/451 at 2023-11-05 23:21:29

... over 17 hours later ...

Nov 06 16:06:07 r451-xfs-reflink-4k unknown: run fstests generic/451 at 2023-11-06 16:06:07
Nov 06 16:06:38 r451-xfs-reflink-4k kernel: XFS (loop16): EXPERIMENTAL online scrub feature in use. Use at your own risk!
Nov 06 16:06:38 r451-xfs-reflink-4k kernel: XFS (loop16): Unmounting Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 06 16:06:38 r451-xfs-reflink-4k kernel: XFS (loop16): Mounting V5 Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 06 16:06:38 r451-xfs-reflink-4k kernel: XFS (loop16): Ending clean mount
Nov 06 16:06:41 r451-xfs-reflink-4k kernel: kmemleak: 9 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
Nov 06 16:06:42 r451-xfs-reflink-4k kernel: XFS (loop16): Unmounting Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 06 16:06:42 r451-xfs-reflink-4k kernel: XFS (loop16): Mounting V5 Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 06 16:06:42 r451-xfs-reflink-4k kernel: XFS (loop16): Ending clean mount
Nov 06 16:06:47 r451-xfs-reflink-4k kernel: XFS (loop5): Mounting V5 Filesystem 6a017bf9-aa36-474a-af1b-670d8bae14cf
Nov 06 16:06:47 r451-xfs-reflink-4k kernel: XFS (loop5): Ending clean mount
Nov 06 16:06:47 r451-xfs-reflink-4k kernel: XFS (loop5): Unmounting Filesystem 6a017bf9-aa36-474a-af1b-670d8bae14cf
Nov 06 16:06:47 r451-xfs-reflink-4k kernel: XFS (loop16): EXPERIMENTAL online scrub feature in use. Use at your own risk!
Nov 06 16:06:47 r451-xfs-reflink-4k kernel: XFS (loop16): Unmounting Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 06 16:06:47 r451-xfs-reflink-4k kernel: XFS (loop16): Mounting V5 Filesystem 2ed74cf8-8238-4817-bc04-d9b3f4f79275
Nov 06 16:06:47 r451-xfs-reflink-4k kernel: XFS (loop16): Ending clean mount
Nov 06 16:06:47 r451-xfs-reflink-4k unknown: run fstests generic/451 at 2023-11-06 16:06:47
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: page:00000000bda16be1 refcount:8 mapcount:0 mapping:00000000258b6ed6 index:0x5c pfn:0x19728
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: head:00000000bda16be1 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: memcg:ffff987b9ecec000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: aops:xfs_address_space_operations [xfs] ino:83 dentry name:"tst-aio-dio-cycle-write.451"
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: flags: 0xffffce0000826d(locked|referenced|uptodate|lru|workingset|private|head|node=0|zone=1|lastcpupid=0x1ffff)
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: page_type: 0xffffffff()
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: raw: 00ffffce0000826d ffffdce9c08b6048 ffff987b9eced120 ffff987b83ef0ab8
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: raw: 000000000000005c ffff987b94c07620 00000007ffffffff ffff987b9ecec000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: page dumped because: VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]))
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: ------------[ cut here ]------------
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: kernel BUG at mm/truncate.c:662!
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: CPU: 2 PID: 2235189 Comm: kworker/2:0 Not tainted 6.6.0-rc5 #1
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: Workqueue: dio/loop16 iomap_dio_complete_work
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RIP: 0010:invalidate_inode_pages2_range+0x258/0x4b0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: Code: e8 ad f9 ff ff 48 8b 00 f6 c4 01 0f 84 ab fe ff ff 4c 3b 6b 20 0f 84 e3 fe ff ff 48 c7 c6 20 b8 43 92 48 89 df e8 c8 74 03 00 <0f> 0b 8b 43>
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RSP: 0018:ffffb5cd81fa7cd0 EFLAGS: 00010246
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RAX: 0000000000000048 RBX: ffffdce9c065ca00 RCX: 0000000000000000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb5cd81fa7b80
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: R10: 0000000000000003 R11: ffffffff926b5520 R12: ffff987b83ef0ab8
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: R13: ffffffffffffffa4 R14: 0000000000000000 R15: 0000000000000000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: FS:  0000000000000000(0000) GS:ffff987bfbc80000(0000) knlGS:0000000000000000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: CR2: 00007ffcdc8e98f0 CR3: 000000005c438003 CR4: 0000000000770ee0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: PKRU: 55555554
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: Call Trace:
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  <TASK>
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? die+0x32/0x80
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? do_trap+0xd6/0x100
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? invalidate_inode_pages2_range+0x258/0x4b0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? do_error_trap+0x6a/0x90
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? invalidate_inode_pages2_range+0x258/0x4b0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? exc_invalid_op+0x4c/0x60
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? invalidate_inode_pages2_range+0x258/0x4b0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? asm_exc_invalid_op+0x16/0x20
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? invalidate_inode_pages2_range+0x258/0x4b0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? update_load_avg+0x7e/0x780
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? update_load_avg+0x7e/0x780
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? dequeue_entity+0x133/0x4a0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? _raw_spin_unlock+0x15/0x30
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  kiocb_invalidate_post_direct_write+0x39/0x50
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  iomap_dio_complete+0x12a/0x1a0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? __pfx_aio_complete_rw+0x10/0x10
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  iomap_dio_complete_work+0x17/0x30
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  process_one_work+0x171/0x340
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  worker_thread+0x277/0x3a0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? __pfx_worker_thread+0x10/0x10
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  kthread+0xf0/0x120
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? __pfx_kthread+0x10/0x10
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ret_from_fork+0x2d/0x50
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ? __pfx_kthread+0x10/0x10
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  ret_from_fork_asm+0x1b/0x30
Nov 06 16:07:16 r451-xfs-reflink-4k kernel:  </TASK>
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: Modules linked in: xfs sunrpc nvme_fabrics nvme_core t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel kvm irqbypass crct10dif_pclmul >
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: ---[ end trace 0000000000000000 ]---
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RIP: 0010:invalidate_inode_pages2_range+0x258/0x4b0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: Code: e8 ad f9 ff ff 48 8b 00 f6 c4 01 0f 84 ab fe ff ff 4c 3b 6b 20 0f 84 e3 fe ff ff 48 c7 c6 20 b8 43 92 48 89 df e8 c8 74 03 00 <0f> 0b 8b 43>
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RSP: 0018:ffffb5cd81fa7cd0 EFLAGS: 00010246
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RAX: 0000000000000048 RBX: ffffdce9c065ca00 RCX: 0000000000000000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb5cd81fa7b80
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: R10: 0000000000000003 R11: ffffffff926b5520 R12: ffff987b83ef0ab8
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: R13: ffffffffffffffa4 R14: 0000000000000000 R15: 0000000000000000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: FS:  0000000000000000(0000) GS:ffff987bfbc80000(0000) knlGS:0000000000000000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: CR2: 00007fa1980081d8 CR3: 000000010c812006 CR4: 0000000000770ee0
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Nov 06 16:07:16 r451-xfs-reflink-4k kernel: PKRU: 55555554

