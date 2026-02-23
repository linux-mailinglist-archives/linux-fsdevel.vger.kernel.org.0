Return-Path: <linux-fsdevel+bounces-77960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBxINEtenGmkEwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:03:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF8177ADF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA8E4302E116
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08527EFF7;
	Mon, 23 Feb 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="U1sIG9Kx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0B25CC63;
	Mon, 23 Feb 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855428; cv=none; b=Esau6fJj2AjnZ8Nf7+V43hs09TqUxr32xtycKnyVI7imjIEVNs98msGD1Je1VqtF9ZwxhiReZ5tO875WOBOEdf0ThNy0MzdX6ji4zEBmWk6/nIATtAaOfXBGlmSOchUudAfZKFs4ez039RKkgQCnKTwFGPMbW6BxekP3PSnH1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855428; c=relaxed/simple;
	bh=PHhibRiWtOMhWdLvwu7KSdJkmjux9bknEzRlXW/0YIw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kvxw3nodNZdXq/5IOcxmH1jxcnbVhlV28g3WXV9ZY0XSX8Bwzm2h53VAqfsOQaAJx8Cz6e4kmGdBV87uP0h4atZquYltvv/CrjPf3p8JzTiv4+6jnG6VFZO6+FijDIPXVVKwBRo7xiXTUNtgLAR00Z2rWW56GjL965S3Q4rV+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=U1sIG9Kx; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771855427; x=1803391427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lwLULFijd/Kg2LAqEMzyjJw0jiVZEmm09jejetpA0CA=;
  b=U1sIG9Kxm0AAgzMJeBU2AEAiEaJqhzBLCHDiagW3qmzI+rc89usQCFTn
   wY35F9GuzYtBoknFXvGlEwuVlYzdvh/jdhktWRMWp/WSeBi5MPpKNwn5M
   1CVjeOjIQt5zvXrf0Ag2UNub7bt4vHhINTa2ntQy7DKzSx4jpvF7KMqpW
   L30Up1BWHx1783Dddk84/mBTQyIjs4PeqA9Mfu9c574CoXzRzgeb8LQ7e
   4rUMw1wUeBjdglbYyiZ3ePBIHEfjGIYTDoGrHqkBzoW7VtspnvU6TI2pr
   JCA6qObdDEzFu/OinXZrOOD0A4fEBU6L+fEvREtF8r403PHwKaWbtFnoA
   w==;
X-CSE-ConnectionGUID: vNwxqNXaSBCne2ZaTsWyPQ==
X-CSE-MsgGUID: ZrxQ855HRLCHIKpWiROpXQ==
X-IronPort-AV: E=Sophos;i="6.21,306,1763424000"; 
   d="scan'208";a="13399707"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:03:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:27928]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.129:2525] with esmtp (Farcaster)
 id 545c3670-1318-4c06-a980-32fa72933b7b; Mon, 23 Feb 2026 14:03:44 +0000 (UTC)
X-Farcaster-Flow-ID: 545c3670-1318-4c06-a980-32fa72933b7b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 23 Feb 2026 14:03:42 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 23 Feb 2026 14:03:41 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH] fuse: refactor duplicate queue teardown operation
Date: Mon, 23 Feb 2026 14:03:33 +0000
Message-ID: <20260223140332.36618-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77960-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,async_teardown_work.work:url];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 72AF8177ADF
X-Rspamd-Action: no action

Extract common queue iteration and teardown logic into
fuse_uring_teardown_all_queues() helper function to eliminate code
duplication between fuse_uring_async_stop_queues() and
fuse_uring_stop_queues().

This is a pure refactoring with no functional changes, intended to
improve maintainability.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/fuse/dev_uring.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 3a38b61aac26..7b9822e8837b 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -397,6 +397,20 @@ static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
 				     FRRS_AVAILABLE);
 }
 
+static void fuse_uring_teardown_all_queues(struct fuse_ring *ring)
+{
+	int qid;
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
+
+		if (!queue)
+			continue;
+
+		fuse_uring_teardown_entries(queue);
+	}
+}
+
 /*
  * Log state debug info
  */
@@ -431,19 +445,10 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 
 static void fuse_uring_async_stop_queues(struct work_struct *work)
 {
-	int qid;
 	struct fuse_ring *ring =
 		container_of(work, struct fuse_ring, async_teardown_work.work);
 
-	/* XXX code dup */
-	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
-
-		if (!queue)
-			continue;
-
-		fuse_uring_teardown_entries(queue);
-	}
+	fuse_uring_teardown_all_queues(ring);
 
 	/*
 	 * Some ring entries might be in the middle of IO operations,
@@ -469,16 +474,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
  */
 void fuse_uring_stop_queues(struct fuse_ring *ring)
 {
-	int qid;
-
-	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
-
-		if (!queue)
-			continue;
-
-		fuse_uring_teardown_entries(queue);
-	}
+	fuse_uring_teardown_all_queues(ring);
 
 	if (atomic_read(&ring->queue_refs) > 0) {
 		ring->teardown_time = jiffies;
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




