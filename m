Return-Path: <linux-fsdevel+bounces-45004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3E4A7002E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662E217B160
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B17268FEE;
	Tue, 25 Mar 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fgaHN1tV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76F1DD9D3;
	Tue, 25 Mar 2025 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905971; cv=none; b=GBxs4P6l9dUpg4OJfMFjkTvkF5Q8HW9+SNahHd/fnvSBzGbuSDMoAQe57NedQMmVM6S+mD+xcZFSi5yqbczPjnjsxhRhEfviMVKAAyYRF8+U4NUvekgNacgBgCywo05IUM1YdV2RWWacSOmeJQcRAlwW/uV5ADSM6EEkSU1IIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905971; c=relaxed/simple;
	bh=2CNd3Rknkdg7eU4W7zZ58Mhb5X4t5PmEEQK/wbRZsms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKE2DgmCGEqEwPapRwjdAjzvChae8SSiE5zfkVXyePJKTEdAtTjE8ad7B05L6QZ+fqIlPaB5yHgZlaIZTiWxBNMHB5N3ww11Zxj0bfheAcgtAAoI+RKqzWRoFpyi+Y1+s+JUHtSTlxOhDF47K+1p7YqhM0/+DuZZ6CEJgToNExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fgaHN1tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F967C4CEE4;
	Tue, 25 Mar 2025 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905971;
	bh=2CNd3Rknkdg7eU4W7zZ58Mhb5X4t5PmEEQK/wbRZsms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgaHN1tVyRYj32kHHcV6fOOAr7wTmfSOBuC02w0257ik1dT5G2pcLwOqLoy1LWg0c
	 UYzRTG7J3h2ZU37XGMK735xhClBPWaeR4n1WKagNx1Y1605p7gAQx0suLjabxDeoHN
	 SP/HAM0t+QmeM1tTaa+SLja7+XMUb9yX3HCEo+g8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.13 065/119] netfs: Call `invalidate_cache` only if implemented
Date: Tue, 25 Mar 2025 08:22:03 -0400
Message-ID: <20250325122150.721104001@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
References: <20250325122149.058346343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Kellermann <max.kellermann@ionos.com>

commit 344b7ef248f420ed4ba3a3539cb0a0fc18df9a6c upstream.

Many filesystems such as NFS and Ceph do not implement the
`invalidate_cache` method.  On those filesystems, if writing to the
cache (`NETFS_WRITE_TO_CACHE`) fails for some reason, the kernel
crashes like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0010 [#1] SMP PTI
 CPU: 9 UID: 0 PID: 3380 Comm: kworker/u193:11 Not tainted 6.13.3-cm4all1-hp #437
 Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
 Workqueue: events_unbound netfs_write_collection_worker
 RIP: 0010:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0018:ffff9b86e2ca7dc0 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 7fffffffffffffff
 RDX: 0000000000000001 RSI: ffff89259d576a18 RDI: ffff89259d576900
 RBP: ffff89259d5769b0 R08: ffff9b86e2ca7d28 R09: 0000000000000002
 R10: ffff89258ceaca80 R11: 0000000000000001 R12: 0000000000000020
 R13: ffff893d158b9338 R14: ffff89259d576900 R15: ffff89259d5769b0
 FS:  0000000000000000(0000) GS:ffff893c9fa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffffffffd6 CR3: 000000054442e003 CR4: 00000000001706f0
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x15c/0x460
  ? try_to_wake_up+0x2d2/0x530
  ? exc_page_fault+0x5e/0x100
  ? asm_exc_page_fault+0x22/0x30
  netfs_write_collection_worker+0xe9f/0x12b0
  ? xs_poll_check_readable+0x3f/0x80
  ? xs_stream_data_receive_workfn+0x8d/0x110
  process_one_work+0x134/0x2d0
  worker_thread+0x299/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 CR2: 0000000000000000

This patch adds the missing `NULL` check.

Fixes: 0e0f2dfe880f ("netfs: Dispatch write requests to process a writeback slice")
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20250314164201.1993231-3-dhowells@redhat.com
Acked-by: "Paulo Alcantara (Red Hat)" <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/write_collect.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -575,7 +575,8 @@ void netfs_write_collection_worker(struc
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
-	    wreq->io_streams[1].failed) {
+	    wreq->io_streams[1].failed &&
+	    ictx->ops->invalidate_cache) {
 		/* Cache write failure doesn't prevent writeback completion
 		 * unless we're in disconnected mode.
 		 */



