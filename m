Return-Path: <linux-fsdevel+bounces-59465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E3B393A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 08:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2683B9692
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 06:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A42727F4;
	Thu, 28 Aug 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XY5IxvJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F98B4A02;
	Thu, 28 Aug 2025 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361463; cv=none; b=IcoBafjHNRCbPknn3K2cpvYFxL3rLfPMtAHDbBN2xgtS1ENYvSrvFrmf819bbzdRZy+8NVlewS2MF8kVFakLW0L9ltNpbicLoIm1bFshYxBgf/jFXODyQsXHMW3KdrQ7kEpbTqgeDCwkyEFIcXFjz3o5F/h/F4kyF3J+TNBYtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361463; c=relaxed/simple;
	bh=GH1MnD9kkTN4c+3cTT8CmEeQjchnw3Uvm2OEhs8UdpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MiKOW14TiplavwnAA0t1Dmjks+2qI/9cRpgDz7TI1dQezly6IUuKtyeNRFSD51YH63tkcrqQA1BxhRdW1CXQLowc+iWsMD9vTEd5/ctcFEgH3G816skBssvy6CjXzxTzTPmP2iJDSsB4D2VpWoKRj7LMMuCaGZ+E4/i7jC/n31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XY5IxvJq; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=A4
	M/POHWuLvUOmb8o4PVnu3p+ruDnZJl5Jdp4rRP8EA=; b=XY5IxvJqiXf4+4BKz0
	DPF9whEe6YZsu7u8wp7bsG2+kBaxq+kv3A9mQNzfKGdpM9P/bU61AUpyAl7YBDeh
	GvfGkyef9wgkvCaL2s7t7UG4DvX5URxKfdv5F13nkB1FEY3u6QKRyzgNKDW7MCVM
	fqBwC0BLZPoN26clTe4TFnwCg=
Received: from haiyue-pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCnAafU8q9o4zdvEw--.31954S2;
	Thu, 28 Aug 2025 14:10:29 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Haiyue Wang <haiyuewa@163.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	virtualization@lists.linux.dev (open list:VIRTIO FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] virtio_fs: fix page fault for DAX page address
Date: Thu, 28 Aug 2025 14:10:13 +0800
Message-ID: <20250828061023.877-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnAafU8q9o4zdvEw--.31954S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWUtw1Utw1kZF1kAFykAFb_yoW7Jw17pF
	1Utr18Gr4kXr1UJF10vr1UXr13twsrAF18XrWxAr1kZF1UW3WDJr1kJrWUtr4UXryjqry7
	trs8Gw1xtryDKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEiiSDUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYAO2a2ivSTleAQABsX

The commit ced17ee32a99 ("Revert "virtio: reject shm region if length is zero"")
exposes the following DAX page fault bug:

The commit 21aa65bf82a7 ("mm: remove callers of pfn_t functionality") handles
the DAX physical page address incorrectly: the removed macro 'phys_to_pfn_t()'
should be replaced with 'PHYS_PFN()'.

[    1.390321] BUG: unable to handle page fault for address: ffffd3fb40000008
[    1.390875] #PF: supervisor read access in kernel mode
[    1.391257] #PF: error_code(0x0000) - not-present page
[    1.391509] PGD 0 P4D 0
[    1.391626] Oops: Oops: 0000 [#1] SMP NOPTI
[    1.391806] CPU: 6 UID: 1000 PID: 162 Comm: weston Not tainted 6.17.0-rc3-WSL2-STABLE #2 PREEMPT(none)
[    1.392361] RIP: 0010:dax_to_folio+0x14/0x60
[    1.392653] Code: 52 c9 c3 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 c1 ef 05 48 c1 e7 06 48 03 3d 34 b5 31 01 <48> 8b 57 08 48 89 f8 f6 c2 01 75 2b 66 90 c3 cc cc cc cc f7 c7 ff
[    1.393727] RSP: 0000:ffffaf7d04407aa8 EFLAGS: 00010086
[    1.394003] RAX: 000000a000000000 RBX: ffffaf7d04407bb0 RCX: 0000000000000000
[    1.394524] RDX: ffffd17b40000008 RSI: 0000000000000083 RDI: ffffd3fb40000000
[    1.394967] RBP: 0000000000000011 R08: 000000a000000000 R09: 0000000000000000
[    1.395400] R10: 0000000000001000 R11: ffffaf7d04407c10 R12: 0000000000000000
[    1.395806] R13: ffffa020557be9c0 R14: 0000014000000001 R15: 0000725970e94000
[    1.396268] FS:  000072596d6d2ec0(0000) GS:ffffa0222dc59000(0000) knlGS:0000000000000000
[    1.396715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.397100] CR2: ffffd3fb40000008 CR3: 000000011579c005 CR4: 0000000000372ef0
[    1.397518] Call Trace:
[    1.397663]  <TASK>
[    1.397900]  dax_insert_entry+0x13b/0x390
[    1.398179]  dax_fault_iter+0x2a5/0x6c0
[    1.398443]  dax_iomap_pte_fault+0x193/0x3c0
[    1.398750]  __fuse_dax_fault+0x8b/0x270
[    1.398997]  ? vm_mmap_pgoff+0x161/0x210
[    1.399175]  __do_fault+0x30/0x180
[    1.399360]  do_fault+0xc4/0x550
[    1.399547]  __handle_mm_fault+0x8e3/0xf50
[    1.399731]  ? do_syscall_64+0x72/0x1e0
[    1.399958]  handle_mm_fault+0x192/0x2f0
[    1.400204]  do_user_addr_fault+0x20e/0x700
[    1.400418]  exc_page_fault+0x66/0x150
[    1.400602]  asm_exc_page_fault+0x26/0x30
[    1.400831] RIP: 0033:0x72596d1bf703
[    1.401076] Code: 31 f6 45 31 e4 48 8d 15 b3 73 00 00 e8 06 03 00 00 8b 83 68 01 00 00 e9 8e fa ff ff 0f 1f 00 48 8b 44 24 08 4c 89 ee 48 89 df <c7> 00 21 43 34 12 e8 72 09 00 00 e9 6a fa ff ff 0f 1f 44 00 00 e8
[    1.402172] RSP: 002b:00007ffc350f6dc0 EFLAGS: 00010202
[    1.402488] RAX: 0000725970e94000 RBX: 00005b7c642c2560 RCX: 0000725970d359a7
[    1.402898] RDX: 0000000000000003 RSI: 00007ffc350f6dc0 RDI: 00005b7c642c2560
[    1.403284] RBP: 00007ffc350f6e90 R08: 000000000000000d R09: 0000000000000000
[    1.403634] R10: 00007ffc350f6dd8 R11: 0000000000000246 R12: 0000000000000001
[    1.404078] R13: 00007ffc350f6dc0 R14: 0000725970e29ce0 R15: 0000000000000003
[    1.404450]  </TASK>
[    1.404570] Modules linked in:
[    1.404821] CR2: ffffd3fb40000008
[    1.405029] ---[ end trace 0000000000000000 ]---
[    1.405323] RIP: 0010:dax_to_folio+0x14/0x60
[    1.405556] Code: 52 c9 c3 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 c1 ef 05 48 c1 e7 06 48 03 3d 34 b5 31 01 <48> 8b 57 08 48 89 f8 f6 c2 01 75 2b 66 90 c3 cc cc cc cc f7 c7 ff
[    1.406639] RSP: 0000:ffffaf7d04407aa8 EFLAGS: 00010086
[    1.406910] RAX: 000000a000000000 RBX: ffffaf7d04407bb0 RCX: 0000000000000000
[    1.407379] RDX: ffffd17b40000008 RSI: 0000000000000083 RDI: ffffd3fb40000000
[    1.407800] RBP: 0000000000000011 R08: 000000a000000000 R09: 0000000000000000
[    1.408246] R10: 0000000000001000 R11: ffffaf7d04407c10 R12: 0000000000000000
[    1.408666] R13: ffffa020557be9c0 R14: 0000014000000001 R15: 0000725970e94000
[    1.409170] FS:  000072596d6d2ec0(0000) GS:ffffa0222dc59000(0000) knlGS:0000000000000000
[    1.409608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.409977] CR2: ffffd3fb40000008 CR3: 000000011579c005 CR4: 0000000000372ef0
[    1.410437] Kernel panic - not syncing: Fatal exception
[    1.410857] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Fixes: 21aa65bf82a7 ("mm: remove callers of pfn_t functionality")
Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c826e7ca49f5..76c8fd0bfc75 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1016,7 +1016,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = fs->window_phys_addr + offset;
+		*pfn = PHYS_PFN(fs->window_phys_addr + offset);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
-- 
2.51.0


