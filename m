Return-Path: <linux-fsdevel+bounces-49338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3819ABB849
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7418F3B3716
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6434126E159;
	Mon, 19 May 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4wisn7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE726B0B2
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645657; cv=none; b=Fl1Q2n7iFESByyr5V8HXFI/pU+vk5hsce4hsA9VMIKnCCqIXQ3DJmSgMeL0Rsn+XukVoTFLuWHXsZAkOkIZjoTV/4o+/NjPpTas1yCa3mc20LLHrIZoj/0qHiVs6YiEo0b54tiR9poZjad0GBdsd3p0rWXyZYz71EkLxdNQiBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645657; c=relaxed/simple;
	bh=ncEkC3aH0ZNbwQGs78ANJk57LMkt2WLIf6EZt7TSauc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAg5VLzkFFIjswlE3pa7cFV/AQuypkaGCnjTTZ4CI3nq3fSV6yT3p8++X8Zu0UDmC27rbwlpBUXSzks7oi3SuxFgpdgsxHkX1o9uPOPw/dAoFAqr/WtxTycl8y9VYoADk/CT1bIgAjVPcYz/8TQext2hnCSDwHu8qp5zHDXD9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4wisn7a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747645654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnAApEBOj4PhwBDwW7kuKK7utDLajmYgVrOrBosmfXY=;
	b=A4wisn7agfuypy003lb/BwYuZNbqgG0CtzWni33Zm3c2Vuhd3LyoTnsoQADBwBjwbGiuYM
	cGnPYLy2k/PU+4NPv1lZ3ZfwbBSuU0CQG7RvV/UIGWZIlNK2nQFT4YNPth0SSPqiH+eNqo
	hOQ6NJpljGGEpjNkcf71Pw+E35H3V5M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-eOlAI18_Nxm80Pe90ggXkQ-1; Mon,
 19 May 2025 05:07:31 -0400
X-MC-Unique: eOlAI18_Nxm80Pe90ggXkQ-1
X-Mimecast-MFC-AGG-ID: eOlAI18_Nxm80Pe90ggXkQ_1747645649
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3BBA195608C;
	Mon, 19 May 2025 09:07:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77FA419560AB;
	Mon, 19 May 2025 09:07:25 +0000 (UTC)
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
	Nicolas Baranger <nicolas.baranger@3xo.fr>
Subject: [PATCH 2/4] netfs: Fix setting of transferred bytes with short DIO reads
Date: Mon, 19 May 2025 10:07:02 +0100
Message-ID: <20250519090707.2848510-3-dhowells@redhat.com>
In-Reply-To: <20250519090707.2848510-1-dhowells@redhat.com>
References: <20250519090707.2848510-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Paulo Alcantara <pc@manguebit.com>

A netfslib request comprises an ordered stream of subrequests that, when
doing an unbuffered/DIO read, are contiguous.  The subrequests may be
performed in parallel, but may not be fully completed.

For instance, if we try and make a 256KiB DIO read from a 3-byte file with
a 64KiB rsize and 256KiB bsize, netfslib will attempt to make a read of
256KiB, broken up into four 64KiB subreads, with the expectation that the
first will be short and the subsequent three be completely devoid - but we
do all four on the basis that the file may have been changed by a third
party.

The read-collection code, however, walks through all the subreqs and
advances the notion of how much data has been read in the stream to the
start of each subreq plus its amount transferred (which are 3, 0, 0, 0 for
the example above) - which gives an amount apparently read of 3*64KiB -
which is incorrect.

Fix the collection code to cut short the calculation of the transferred
amount with the first short subrequest in an unbuffered read; everything
beyond that must be ignored as there's a hole that cannot be filled.  This
applies both to shortness due to hitting the EOF and shortness due to an
error.

This is achieved by setting a flag on the request when we collect the first
short subrequest (collection is done in ascending order).

This can be tested by mounting a cifs volume with rsize=65536,bsize=262144
and doing a 256k DIO read of a very small file (e.g. 3 bytes).  read()
should return 3, not >3.

This problem came in when netfs_read_collection() set rreq->transferred to
stream->transferred, even for DIO.  Prior to that, netfs_rreq_assess_dio()
just went over the list and added up the subreqs till it met a short one -
but now the subreqs are discarded earlier.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Nicolas Baranger <nicolas.baranger@3xo.fr>
Closes: https://lore.kernel.org/all/10bec2430ed4df68bde10ed95295d093@3xo.fr/
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
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


