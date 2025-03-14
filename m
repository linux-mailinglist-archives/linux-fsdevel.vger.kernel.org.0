Return-Path: <linux-fsdevel+bounces-44033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3CA6168E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 17:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DEE19C4CE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB20204693;
	Fri, 14 Mar 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F29DvhTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4F20468A
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970547; cv=none; b=UV3lOZ0N9AFauwz2Ybwq4W+WPmGmnUPWe5EACNVdD3IdAm+X+ZTxL0rIESYZXCODuE4ubyoyzSnPYDTZooOGNn6Av7xuTXudynMHzBmVDUfq2UCQtR2cGTkgPDATiYAib6LZK/7MFj183Ha2JEbiAqjlt/t1T1iwii+GaPCnWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970547; c=relaxed/simple;
	bh=bcuzJjM92SaHRB6hoSe8xIWoPbg8ScRbZsayAknw+7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIh5SfiEgeRNVW67RDM6r6+7vroufgc5Qia/8Ce4bn7B8M2oUb9ZvDDvo9g5hk+L+ZW0XpOfzSLhKyC5s8Lbl4XH0vMyz3BsHyQ+n5eeznIr7+aZl4s3gHw0Y6nyySPmI25naLnjuckM7mJTWn/BMKfoeQ29L+Ov3p6Bm2WahEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F29DvhTm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741970544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/cafhc4nnnQEwFVw0Q6oJte6Nc/tJJuXAQXURFTgx8=;
	b=F29DvhTmAWIPOkl1MTp+dxv1M6f9wKiQRhmnYbmsgxt/w6XLcpKaL39Lr+L5zukb7YHSSk
	3viehAfSHeaqfMtYECUGQKw6uop63BOVbzYtmqPKbaCTvuEsgi2mrOHm5Eh97Wf/b+zWST
	ItS6GuTXEwrPfc8EfBI5wIpZa1tclig=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-2zuPdtzHNfyUoe7oIN-B_Q-1; Fri,
 14 Mar 2025 12:42:20 -0400
X-MC-Unique: 2zuPdtzHNfyUoe7oIN-B_Q-1
X-Mimecast-MFC-AGG-ID: 2zuPdtzHNfyUoe7oIN-B_Q_1741970538
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C82C61956087;
	Fri, 14 Mar 2025 16:42:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DA851955F2D;
	Fri, 14 Mar 2025 16:42:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] netfs: Call `invalidate_cache` only if implemented
Date: Fri, 14 Mar 2025 16:41:57 +0000
Message-ID: <20250314164201.1993231-3-dhowells@redhat.com>
In-Reply-To: <20250314164201.1993231-1-dhowells@redhat.com>
References: <20250314164201.1993231-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Max Kellermann <max.kellermann@ionos.com>

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
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/netfs/write_collect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 294f67795f79..3fca59e6475d 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -400,7 +400,8 @@ void netfs_write_collection_worker(struct work_struct *work)
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
-	    wreq->io_streams[1].failed) {
+	    wreq->io_streams[1].failed &&
+	    ictx->ops->invalidate_cache) {
 		/* Cache write failure doesn't prevent writeback completion
 		 * unless we're in disconnected mode.
 		 */


