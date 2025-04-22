Return-Path: <linux-fsdevel+bounces-46984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDEA971C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C95417FD36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF528FFF3;
	Tue, 22 Apr 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="qSTBfM5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352B28FFCE;
	Tue, 22 Apr 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337476; cv=none; b=JZ0AlqqZgmfNfnWr7wcL3bjZYqAP0hOEMJvH4NgELZrAJxn6qNK6Aoq+nrfDUJipUOVAU/Fetiwqm19qH8Bowx7JaXTgIIm+UqFL+t9ZPHnuX3VLX4pYuHz21kR/byP2r3sKXSpDDRd3/T1e5f4ry2cO+RbNxMKtOFOBHa7DP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337476; c=relaxed/simple;
	bh=nOVpKy3jqx62b5bOmiRTyMPuQ10tlaPUBxG7nY/4zF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVylgalTqkpeTL+djmy6up/mNLFobWL4Mbf1OFPaiMoySVrkegB6XAgSPBgtfyPv/GyU6RxTTXUVmHf3ORxYv8vQFUnUpmznZZiGxLaOz+LfanKkFZk2AxA2khXVfPydZ3Trhd9Jgn25crLIy1GLPkaKqMTCRcqBh5t5swquxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=qSTBfM5M; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1745337472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zpPkMc+aX6PvkAKJO9eveJu/BgjOWzCS8iVQd+mjHdE=;
	b=qSTBfM5MgmyRaoB3Y3yK4RUzGGbTTs6ZxohlW4DgErw50Iih5+cVDGRN7kQm+FYkxyeQ4V
	7uFOpeevBStdpDJ2sDCE2BAITyDKZ4C5bFhvheLkajNh+4tv3tldP4QMjW6rrQkrbqCIuc
	t5Fndq/L8jCii6HmyIuHSEv4EDIU3bEs7zNNtW4YsKchCTg7h5BWx+n+P11m62GOu/TSxN
	jP6C5dADJcW7FZRQ9PUJCWGroSGpP3PRMllXEWb9ZpYKspTIqkgvfh0t+HLPp/hAuK60Hf
	CgWgK4Tx2FuGXTXnxF+LZyJZWPeCZQVAKvwwIKZrYiW106ocmG+PO3dOW9jMpg==
To: brauner@kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Nicolas Baranger <nicolas.baranger@3xo.fr>
Subject: [PATCH] netfs: Fix setting of transferred bytes with short DIO reads
Date: Tue, 22 Apr 2025 12:57:49 -0300
Message-ID: <20250422155749.344136-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A netfslib request comprises an ordered stream of subrequests that,
when doing an unbuffered/DIO read, are contiguous.  The subrequests
may be performed in parallel, but may not be fully completed.

For instance, if we try and make a 256KiB DIO read from a 3-byte file
with a 64KiB rsize and 256KiB bsize, netfslib will attempt to make a
read of 256KiB, broken up into four 64KiB subreads, with the
expectation that the first will be short and the subsequent three be
completely devoid - but we do all four on the basis that the file may
have been changed by a third party.

The read-collection code, however, walks through all the subreqs and
advances the notion of how much data has been read in the stream to
the start of each subreq plus its amount transferred (which are 3, 0,
0, 0 for the example above) - which gives an amount apparently read of
3*64KiB - which is incorrect.

Fix the collection code to cut short the calculation of the
transferred amount with the first short subrequest in an unbuffered
read; everything beyond that must be ignored as there's a hole that
cannot be filled.  This applies both to shortness due to hitting the
EOF and shortness due to an error.

This is achieved by setting a flag on the request when we collect the
first short subrequest (collection is done in ascending order).

This can be tested by mounting a cifs volume with
rsize=65536,bsize=262144 and doing a 256k DIO read of a very small
file (e.g. 3 bytes).  read() should return 3, not >3.

This problem came in when netfs_read_collection() set
rreq->transferred to stream->transferred, even for DIO.  Prior to
that, netfs_rreq_assess_dio() just went over the list and added up the
subreqs till it met a short one - but now the subreqs are discarded
earlier.

Cc: netfs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Reported-by: Nicolas Baranger <nicolas.baranger@3xo.fr>
Closes: https://lore.kernel.org/all/10bec2430ed4df68bde10ed95295d093@3xo.fr/
Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/read_collect.c | 21 +++++----------------
 include/linux/netfs.h   |  1 +
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 23c75755ad4e..d3cf27b2697c 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -280,9 +280,13 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 			stream->need_retry = true;
 			notes |= NEED_RETRY | MADE_PROGRESS;
 			break;
+		} else if (test_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags)) {
+			notes |= MADE_PROGRESS;
 		} else {
 			if (!stream->failed)
-				stream->transferred = stream->collected_to - rreq->start;
+				stream->transferred += transferred;
+			if (front->transferred < front->len)
+				set_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags);
 			notes |= MADE_PROGRESS;
 		}
 
@@ -342,23 +346,8 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
  */
 static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 {
-	struct netfs_io_subrequest *subreq;
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	unsigned int i;
 
-	/* Collect unbuffered reads and direct reads, adding up the transfer
-	 * sizes until we find the first short or failed subrequest.
-	 */
-	list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-		rreq->transferred += subreq->transferred;
-
-		if (subreq->transferred < subreq->len ||
-		    test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
-			rreq->error = subreq->error;
-			break;
-		}
-	}
-
 	if (rreq->origin == NETFS_DIO_READ) {
 		for (i = 0; i < rreq->direct_bv_count; i++) {
 			flush_dcache_page(rreq->direct_bv[i].bv_page);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c86a11cfc4a3..497c4f4698f6 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -279,6 +279,7 @@ struct netfs_io_request {
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
 #define NETFS_RREQ_ALL_QUEUED		13	/* All subreqs are now queued */
 #define NETFS_RREQ_RETRYING		14	/* Set if we're in the retry path */
+#define NETFS_RREQ_SHORT_TRANSFER	15	/* Set if we have a short transfer */
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
-- 
2.49.0


