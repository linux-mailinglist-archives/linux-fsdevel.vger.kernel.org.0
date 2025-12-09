Return-Path: <linux-fsdevel+bounces-71026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C1CB1202
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 22:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCEE63022819
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32F30DEB7;
	Tue,  9 Dec 2025 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk4+FpDw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2C30DD10;
	Tue,  9 Dec 2025 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314278; cv=none; b=LngSfZRh6fObkZiCL9sAKJRPxDvDp5tKMu6IUA+AhQ7Ke342U9OOQv4bVnSk3Q8/QTXOONwyCk54mel/A8ubw4Jv2pXuG9WWhJtiEhbjT2+lryvtmfZEmUV3hJUD9hMMrF029+nZjEcGHcUDySXW2o5/BfAur1cK3MS+19bDmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314278; c=relaxed/simple;
	bh=45n/TaYXVYW0YUsZXwIL3jrKNxjzoN/i1MvLA9obkKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pdpVNbfrsPcYJsTdHRXpj+l+cqpOlXV2ZDS/EDK2GCd8ecI1gYmHbQDKlQXPfYrj7gIhIPjT3KFA6tOKcYkRhefVw6eMk188x4Wn59HtQGd/IP0eocsRiylKWRMOr+Hdg4FvVPkWvUlJqZH5PYE57Faw34aBtqW0xKLvqZMmzmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk4+FpDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D009C4CEF5;
	Tue,  9 Dec 2025 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765314277;
	bh=45n/TaYXVYW0YUsZXwIL3jrKNxjzoN/i1MvLA9obkKg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Yk4+FpDwvc9wpnG6UBLpCEKDVGlT7qg78PyqvIjvX9hgCksb0C/UUk9jEY1utl8Qr
	 Y8Ox0K+GI5Ub9QjVvRNu91IANQOOwsvET/wEzWX8hp8zq9rvswVtWIHrx2wLu4IwSb
	 gPKLKin4NCr7xXw8SHUfgFteguNX+6W2xJ3Uw4PW1LMPvIia3pTu2Qoh7XWnRXFFH/
	 AAzIqYOcbf0KIO/0h+Kc/ZZjjhG+Q043wQGzbAuaVoYV4usQ26J4mrjbvaNgSnkCo7
	 EJLcles4zXXwF7AZ0vOJo9OebtUch5nw/Wo1aQ/pubUQ+QaW1Iw0BgBHIpkBoi4xFH
	 d1ArHEYMrF3TA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E446D3B7F6;
	Tue,  9 Dec 2025 21:04:37 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Wed, 10 Dec 2025 06:04:23 +0900
Subject: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBNyRMquEhFWU81GY5QIorsnL
 d/i/wcSCVOCvnpA6OLEMRTouoLl8GEnxWsxYINWo27UxZI5Tll8SBNnEmVdazqH64xkoHSn0Mb
 3/xzG9/0AQkmR4mMAAAA=
X-Change-ID: 20251210-virtio_trans_iter-5973892db2e3
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
 linux-fsdevel@vger.kernel.org, Chris Arges <carges@cloudflare.com>, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8881;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=xNEQgh7o2uR1z6CBHTRUiHJwBQ8STbwtasQdSBM3wAc=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBpOI7gDbHNYEfwQJ8+jaHr7XmI4uhaDSnG75DTh
 +NSiBBJlXOJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaTiO4AAKCRCrTpvsapjm
 cBIzD/9jt0l7eArEe5iQlWAH1x4jiHENmtsp4C9qoKCtch+w0LJFiBtnub+qNg2pmM3dQMsbeBM
 KBVJzunMDL5GobuOpDd3tqLma64MRmdexMj5uJ2mcAJX9WpkLFYd3fflNpnYmlvPLsBkb9lcaFJ
 4/SvPOAMpiVJBzUSwTDSH+adkORG1dWlbMeknz9Ljq86g5ePMRlxrKL18P6ANjNInhQDLEOD4eI
 OMNelaS2362zInJQnBfnn08QGkj+o1/4jDQntBwIce/Zh3ldmwVJP9eI3ld0t07Rek5OMOtlNhL
 2vYlMBltroOhS5E0tkjjOCjUw7Sr5lRXwjbVbWjlGDUncV0ZLc0uaU36A/SOzJBoJICZiPb5WsK
 Wf+YyFQDbIECiIewrC+0hNiIu89zF2cEz3VtaC4+DRDvsamj5t9U3/7LyBvj685G7xRFzsuYkxL
 wg2cDbo7emDr5oy9ny4P7xlFfHCgSNVDmgkAgSWSQCmtbb5je55EavgC59dfi6IweFBlOWpOOqu
 cbvN6hNfnowk84kupbmaBQi4KpLrFJyJWnQg64h/2GxNpfNOgvQcFxS+PhLD/3DuIqdCb6jRKHc
 m2043lNqQykrh3qdgxzS/SYUXOa/hIuVvw6zjrsvX7wC4TF26lxhWTpZu9+plwiLzl7qIJ2JBO3
 k775B81/AJYJFjw==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

When doing a loop mount of a filesystem over 9p, read requests can come
from unexpected places and blow up as reported by Chris Arges with this
reproducer:
```
dd if=/dev/zero of=./xfs.img bs=1M count=300
yes | mkfs.xfs -b size=8192 ./xfs.img
rm -rf ./mount && mkdir -p ./mount
mount -o loop ./xfs.img ./mount
```

The problem is that iov_iter_get_pages_alloc2() apparently cannot be
called on folios (as illustrated by the backtrace below), so limit what
iov we can pin from !iov_iter_is_kvec() to user_backed_iter()

Full backtrace:
```
[   31.276957][  T255] loop0: detected capacity change from 0 to 614400
[   31.286377][  T255] XFS (loop0): EXPERIMENTAL large block size feature enabled.  Use at your own risk!
[   31.286624][  T255] XFS (loop0): Mounting V5 Filesystem fa3c2d3c-b936-4ee3-a5a8-e80ba36298cc
[   31.395721][   T62] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102600
[   31.395833][   T62] head: order:9 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   31.395915][   T62] flags: 0x2ffff800000040(head|node=0|zone=2|lastcpupid=0x1ffff)
[   31.395976][   T62] page_type: f8(unknown)
[   31.396004][   T62] raw: 002ffff800000040 0000000000000000 dead000000000122 0000000000000000
[   31.396092][   T62] raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
[   31.396174][   T62] head: 002ffff800000040 0000000000000000 dead000000000122 0000000000000000
[   31.396251][   T62] head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
[   31.396339][   T62] head: 002ffff800000009 ffffea0004098001 00000000ffffffff 00000000ffffffff
[   31.396425][   T62] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000200
[   31.396523][   T62] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
[   31.396641][   T62] ------------[ cut here ]------------
[   31.396689][   T62] kernel BUG at include/linux/mm.h:1386!
[   31.396748][   T62] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   31.396820][   T62] CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 6.18.0-rc7-cloudflare-2025.11.11-21-gab0ed6ff #1 PREEMPT(voluntary)
[   31.396947][   T62] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 2025.02-8 05/13/2025
[   31.397031][   T62] Workqueue: loop0 loop_rootcg_workfn
[   31.397084][   T62] RIP: 0010:__iov_iter_get_pages_alloc+0x7b6/0x920
[   31.397152][   T62] Code: 08 4c 89 5d 10 44 88 55 20 e9 0d fb ff ff 0f 0b 4d 85 ed 0f 85 fc fb ff ff e9 38 fd ff ff 48 c7 c6 20 88 6d 83 e8 fa 2f b7 ff <0f> 0b 31 f6 b9 c0 0c 00 00 ba 01 00 00 00 4c 89 0c 24 48 8d 3c dd
[   31.397310][   T62] RSP: 0018:ffffc90000257908 EFLAGS: 00010246
[   31.397365][   T62] RAX: 000000000000005c RBX: 0000000000000020 RCX: 0000000000000003
[   31.397424][   T62] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff83f38508
[   31.397498][   T62] RBP: ffff888101af90f8 R08: 0000000000000000 R09: ffffc900002577a0
[   31.397571][   T62] R10: ffffffff83f084c8 R11: 0000000000000003 R12: 0000000000020000
[   31.397654][   T62] R13: ffffc90000257a70 R14: ffffc90000257a68 R15: ffffea0004098000
[   31.397727][   T62] FS:  0000000000000000(0000) GS:ffff8882b3266000(0000) knlGS:0000000000000000
[   31.397819][   T62] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.397890][   T62] CR2: 00007f846eb985a0 CR3: 0000000004620003 CR4: 0000000000772ef0
[   31.397964][   T62] PKRU: 55555554
[   31.398005][   T62] Call Trace:
[   31.398045][   T62]  <TASK>
[   31.398075][   T62]  ? kvm_sched_clock_read+0x11/0x20
[   31.398131][   T62]  ? sched_clock+0x10/0x30
[   31.398179][   T62]  ? sched_clock_cpu+0xf/0x1d0
[   31.398234][   T62]  iov_iter_get_pages_alloc2+0x20/0x50
[   31.398277][   T62]  p9_get_mapped_pages.part.0.constprop.0+0x6f/0x280 [9pnet_virtio]
[   31.398354][   T62]  ? p9pdu_vwritef+0xe0/0x6e0 [9pnet]
[   31.398413][   T62]  ? pdu_write+0x2d/0x40 [9pnet]
[   31.398464][   T62]  p9_virtio_zc_request+0x92/0x69a [9pnet_virtio]
[   31.398530][   T62]  ? p9pdu_vwritef+0xe0/0x6e0 [9pnet]
[   31.398582][   T62]  ? p9pdu_finalize+0x32/0x90 [9pnet]
[   31.398620][   T62]  ? p9_client_prepare_req+0xbe/0x150 [9pnet]
[   31.398693][   T62]  p9_client_zc_rpc.constprop.0+0xf4/0x2f0 [9pnet]
[   31.398768][   T62]  ? p9_client_xattrwalk+0x148/0x1d0 [9pnet]
[   31.398840][   T62]  p9_client_write+0x16a/0x240 [9pnet]
[   31.398887][   T62]  ? __kmalloc_cache_noprof+0x2f3/0x5a0
[   31.398939][   T62]  v9fs_issue_write+0x3a/0x80 [9p]
[   31.399002][   T62]  netfs_advance_write+0xd3/0x2b0 [netfs]
[   31.399069][   T62]  netfs_unbuffered_write+0x66/0xb0 [netfs]
[   31.399131][   T62]  netfs_unbuffered_write_iter_locked+0x1cd/0x220 [netfs]
[   31.399202][   T62]  netfs_unbuffered_write_iter+0x100/0x1d0 [netfs]
[   31.399265][   T62]  lo_rw_aio.isra.0+0x2e7/0x330
[   31.399321][   T62]  loop_process_work+0x86/0x420
[   31.399380][   T62]  process_one_work+0x192/0x350
[   31.399434][   T62]  worker_thread+0x2d3/0x400
[   31.399493][   T62]  ? __pfx_worker_thread+0x10/0x10
[   31.399559][   T62]  kthread+0xfc/0x240
[   31.399605][   T62]  ? __pfx_kthread+0x10/0x10
[   31.399660][   T62]  ? _raw_spin_unlock+0xe/0x30
[   31.399711][   T62]  ? finish_task_switch.isra.0+0x8d/0x280
[   31.399764][   T62]  ? __pfx_kthread+0x10/0x10
[   31.399820][   T62]  ? __pfx_kthread+0x10/0x10
[   31.399878][   T62]  ret_from_fork+0x113/0x130
[   31.399931][   T62]  ? __pfx_kthread+0x10/0x10
[   31.399992][   T62]  ret_from_fork_asm+0x1a/0x30
[   31.400050][   T62]  </TASK>
[   31.400088][   T62] Modules linked in: kvm_intel kvm irqbypass aesni_intel rapl i2c_piix4 i2c_smbus tiny_power_button button configfs virtio_mmio virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio_console 9pnet_virtio virtiofs virtio virtio_ring fuse 9p 9pnet netfs
[   31.400365][   T62] ---[ end trace 0000000000000000 ]---
[   31.405087][   T62] RIP: 0010:__iov_iter_get_pages_alloc+0x7b6/0x920
[   31.405166][   T62] Code: 08 4c 89 5d 10 44 88 55 20 e9 0d fb ff ff 0f 0b 4d 85 ed 0f 85 fc fb ff ff e9 38 fd ff ff 48 c7 c6 20 88 6d 83 e8 fa 2f b7 ff <0f> 0b 31 f6 b9 c0 0c 00 00 ba 01 00 00 00 4c 89 0c 24 48 8d 3c dd
[   31.405281][   T62] RSP: 0018:ffffc90000257908 EFLAGS: 00010246
[   31.405328][   T62] RAX: 000000000000005c RBX: 0000000000000020 RCX: 0000000000000003
[   31.405383][   T62] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff83f38508
[   31.405456][   T62] RBP: ffff888101af90f8 R08: 0000000000000000 R09: ffffc900002577a0
[   31.405516][   T62] R10: ffffffff83f084c8 R11: 0000000000000003 R12: 0000000000020000
[   31.405593][   T62] R13: ffffc90000257a70 R14: ffffc90000257a68 R15: ffffea0004098000
[   31.405665][   T62] FS:  0000000000000000(0000) GS:ffff8882b3266000(0000) knlGS:0000000000000000
[   31.405730][   T62] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.405774][   T62] CR2: 00007f846eb985a0 CR3: 0000000004620004 CR4: 0000000000772ef0
[   31.405837][   T62] PKRU: 55555554
[   31.434509][    C4] ------------[ cut here ]------------
```

Reported-by: Chris Arges <carges@cloudflare.com>
Closes: https://lkml.kernel.org/r/aSR-C4ahmNRoUV58@861G6M3
Tested-by: Chris Arges <carges@cloudflare.com>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Suggested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
This is the patch Chris tested in the linked thread as is

I'll admit I still don't really understand how this even works: the else
branch of the trans_virtio patch assumes it can use data->kvec->iov_base
so it shouldn't work with folio-backed iov?!
(Also: why does iov_iter_get_pages_alloc2() explicitly implement support
for folio if it's just to blow up later)
.. but if it worked for Chris I guess that's good enough for now?

I'm still surprised I can't reproduce this, I'll try to play with the
backing 9p mount options and check these IOs are done properly before
sending to Linus, but any feedback is welcome until then
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 10c2dd48643818907f4370243eb971fceba4d40b..f7ee1f864b03a59568510eb0dd3496bd05b3b8d6 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -318,7 +318,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 	if (!iov_iter_count(data))
 		return 0;
 
-	if (!iov_iter_is_kvec(data)) {
+	if (user_backed_iter(data)) {
 		int n;
 		/*
 		 * We allow only p9_max_pages pinned. We wait for the

---
base-commit: 3e281113f871d7f9c69ca55a4d806a72180b7e8a
change-id: 20251210-virtio_trans_iter-5973892db2e3

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>



