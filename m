Return-Path: <linux-fsdevel+bounces-51945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56BADD89F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514C43B1D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5EA28507D;
	Tue, 17 Jun 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kzLVlFE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737171ADC97;
	Tue, 17 Jun 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178513; cv=none; b=s+XLA4nXev+a2MzfjFFPSwZWYfWEKk5DMXjpliZBSAqLxKGV8AIzHX5GOsOUaJ+vFZ4Bap7tX6aE/6U9CBysTg4ha+MCXKGi4I8uXtB6z3wuuwvD4SAN+5H37oumuoFllJqi1i25RinqMmJiIBoBKT5NAblZDHmCX5PsGQi2O2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178513; c=relaxed/simple;
	bh=abDzn3/HuW9FrQlHz+9AyJ3SUWrN2ItQN3YuRAJJunI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni30HnxxCU6mscxj/pkaGSaTyUKa2hcNEDKj2E7+uWcxTmsosKU8rcHZMQLmq3yPRBXLBAWKHVveIZGyFskG4pyejtiYcn2sYvMLNn0tX7/5IPOPBOF4WHhSW2fFoTFNDdZePaZ2RK2fvxBIqf3MyHSkO38WYo9whh+vjbGqJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kzLVlFE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6427C4CEE3;
	Tue, 17 Jun 2025 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178513;
	bh=abDzn3/HuW9FrQlHz+9AyJ3SUWrN2ItQN3YuRAJJunI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzLVlFE+goJp6k6TODFuAuRDbdR0A/yjmr5jpb0TTm05DykqnRDAEOQTBUHc3PJb+
	 59ytng4Y76t4W1pEJUTRqA2VNnNeTuKz1O0kQ3Fj3douica7mVPI+6ETnlIG0IOIlH
	 16bjuoH4Q621orYX6+J3ajfKCEvAP8bEsVE1JQuI=
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
Subject: [PATCH 6.15 453/780] netfs: Fix oops in write-retry from mis-resetting the subreq iterator
Date: Tue, 17 Jun 2025 17:22:41 +0200
Message-ID: <20250617152509.915938838@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

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
 fs/netfs/write_retry.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 545d33079a77d..9b1ca8b0f4dd6 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -39,9 +39,10 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				struct iov_iter source = subreq->io_iter;
+				struct iov_iter source;
 
-				iov_iter_revert(&source, subreq->len - source.count);
+				netfs_reset_iter(subreq);
+				source = subreq->io_iter;
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 				netfs_reissue_write(stream, subreq, &source);
 			}
-- 
2.39.5




