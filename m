Return-Path: <linux-fsdevel+bounces-54278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C20AFD262
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09838164F89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196B2E540D;
	Tue,  8 Jul 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dzCuC2vO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D022E337A;
	Tue,  8 Jul 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992995; cv=none; b=nmmD4uUNal+eLvElXQTVHgEchxo4zm8933YisBAVzCfj1f2GFIqEBihsN2s+wThVMQ2jRTiJvnzMrfcM1oQZB/wSfWGeZzn8ulmu2iTBAiIvl2k1q3dZjM2wq/n2cdfd09MSHHbryeTTFslpD/k2z+c9aj4BHD4kYnsJdRBSnYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992995; c=relaxed/simple;
	bh=IKNCQMFSy/+vys7ZqtIGDE3JNL+s+xsJEgG5sYesM10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Arp1QWDItpYwicJU1NmhK+GbNPQVKkk3SPQjBQHff47f+OX4ZZGRpdZCjJ2XrZKQ5ztQcsUmAxSrEFtYRhK7GRtcvzjw+cwka7/rBpVRo/ltfCe4WH0XtY6koOZWyWf0FC9jiBsL8LKebOE6xM+skuPVpHJUn6bx0KXN6+Fn57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dzCuC2vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6B6C4CEED;
	Tue,  8 Jul 2025 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992995;
	bh=IKNCQMFSy/+vys7ZqtIGDE3JNL+s+xsJEgG5sYesM10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzCuC2vOBJ0SX97PGF1NPdpG9dZ1tZe3k/h7K/Gfb3GaIE6lxPH+LM7cs6hGXtST8
	 UktnieAfef+8M/0L8WWsewcDYwuiPGkUjEtfD2GTBNFeND59PidiUhtQURPdg+umSb
	 qQtO0mN3+4gcsT4K04F6ZjtikzJ81x69g71cBD0A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 151/232] netfs: Fix oops in write-retry from mis-resetting the subreq iterator
Date: Tue,  8 Jul 2025 18:22:27 +0200
Message-ID: <20250708162245.390650881@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 4481f7f2b3df123ec77e828c849138f75cff2bf2 ]

Fix the resetting of the subrequest iterator in netfs_retry_write_stream()
to use the iterator-reset function as the iterator may have been shortened
by a previous retry.  In such a case, the amount of data to be written by
the subrequest is not "subreq->len" but "subreq->len -
subreq->transferred".

Without this, KASAN may see an error in iov_iter_revert():

   BUG: KASAN: slab-out-of-bounds in iov_iter_revert lib/iov_iter.c:633 [inline]
   BUG: KASAN: slab-out-of-bounds in iov_iter_revert+0x443/0x5a0 lib/iov_iter.c:611
   Read of size 4 at addr ffff88802912a0b8 by task kworker/u32:7/1147

   CPU: 1 UID: 0 PID: 1147 Comm: kworker/u32:7 Not tainted 6.15.0-rc6-syzkaller-00052-g9f35e33144ae #0 PREEMPT(full)
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
   Workqueue: events_unbound netfs_write_collection_worker
   Call Trace:
    <TASK>
    __dump_stack lib/dump_stack.c:94 [inline]
    dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
    print_address_description mm/kasan/report.c:408 [inline]
    print_report+0xc3/0x670 mm/kasan/report.c:521
    kasan_report+0xe0/0x110 mm/kasan/report.c:634
    iov_iter_revert lib/iov_iter.c:633 [inline]
    iov_iter_revert+0x443/0x5a0 lib/iov_iter.c:611
    netfs_retry_write_stream fs/netfs/write_retry.c:44 [inline]
    netfs_retry_writes+0x166d/0x1a50 fs/netfs/write_retry.c:231
    netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
    netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
    process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
    process_scheduled_works kernel/workqueue.c:3319 [inline]
    worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
    kthread+0x3c2/0x780 kernel/kthread.c:464
    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
    </TASK>

Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
Reported-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=25b83a6f2c702075fcbc
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250519090707.2848510-2-dhowells@redhat.com
Tested-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/write_collect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 412d4da742270..7cb21da40a0a4 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -176,9 +176,10 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				struct iov_iter source = subreq->io_iter;
+				struct iov_iter source;
 
-				iov_iter_revert(&source, subreq->len - source.count);
+				netfs_reset_iter(subreq);
+				source = subreq->io_iter;
 				__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 				netfs_reissue_write(stream, subreq, &source);
-- 
2.39.5




