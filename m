Return-Path: <linux-fsdevel+bounces-49337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C51ABB843
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4993A3B3C2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6826D4EB;
	Mon, 19 May 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8UNBFIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB426D4C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645651; cv=none; b=ZjPEhG7n/zgd92ZGTnv2xCMbpAwUNBWttGDGkZXxG1RAk7Cxtt+pVAFqgnuNH3HCZGlfACbSiA9tA9psBKqOIQRsywh7UK52Qq0APX80yW9JnXboeieFGMo+QtB9n9Zd39+AEwqQ8QQ3wBF0wssNi056zPPjPEYVGDHPhO/U3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645651; c=relaxed/simple;
	bh=TyMbGUc0NIxWw5jPqDY5YUYMibjLe2wfCWCjl4Q1/So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uviJ6bFSdfeK8b9cxM8fqCplgVE1p2E4k0Yb24/fDlbcHsHd0cH2GL6wLdADx94vBZoWKaNGdwCeco2aGYcMXWIfBvFlDT0pAilkmRdxvetNNhfA1kZdsUWm2EXlbInjp7gyUXtdTSA3Pk1QPkMdoh2atKUemaGn7/U3CPusKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8UNBFIu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747645649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7NoGK/UkY9P77xY9HAxaBjiugg5P4jBijBVSqvocLo=;
	b=A8UNBFIunzhTKbdwsHUNDowCjYDwxrnH47pAtMl7mbDraAbtHBqu4zQMXesE7MeV6BYVvs
	JuNBLsx790Dua0BUMY+HpGMJk6vFMo9eJKN2R052lBU8+GZqGKZxYcZZY92qeJOskJez4F
	SNMrfrufUu0IaUq2kJc7rQvhKAUfpFE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-hmpMr3VbP4eHBUm5Ufc0LQ-1; Mon,
 19 May 2025 05:07:25 -0400
X-MC-Unique: hmpMr3VbP4eHBUm5Ufc0LQ-1
X-Mimecast-MFC-AGG-ID: hmpMr3VbP4eHBUm5Ufc0LQ_1747645644
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74B481954236;
	Mon, 19 May 2025 09:07:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70A711956095;
	Mon, 19 May 2025 09:07:19 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com
Subject: [PATCH 1/4] netfs: Fix oops in write-retry from mis-resetting the subreq iterator
Date: Mon, 19 May 2025 10:07:01 +0100
Message-ID: <20250519090707.2848510-2-dhowells@redhat.com>
In-Reply-To: <20250519090707.2848510-1-dhowells@redhat.com>
References: <20250519090707.2848510-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Tested-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com
---
 fs/netfs/write_retry.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 545d33079a77..9b1ca8b0f4dd 100644
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


