Return-Path: <linux-fsdevel+bounces-51946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609DADD8EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12C64A2F4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8352E9753;
	Tue, 17 Jun 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scHwE7hM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A612E8E1D;
	Tue, 17 Jun 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178541; cv=none; b=KpIZHMuyede1gyqBld3R8Aj+16C+wdQ4xrzcQT5MtKdYPoZLLSsHscxvORzkyNN88DenyjGjAUFkPONCC02L44kBH/DnGw6782bGLnIpwzjoxdiBNY6VzJ26Wa+KzwlFN1zMv4uU6zWNZdfLHK0qaDT8p+6UFIK24+mK6w+yNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178541; c=relaxed/simple;
	bh=s3sT5tqV4KSvRGzgT7da1+aDqIQONUjI4Y56+5Ovx34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cmx4bleSlB8lWt+wlcs6c5nHqBvCNSQycUFshX+pLABZrzbp+VRbk5I0uxJWtCAHanDuTe6VIF7KGuoKjTdoqn+suYDYNBn9CRuKI9BUYavuTqIrx1j5oGWJXpi2mfQg95ZU4HQRxtXCJThVxmAgUThnogPrJ0Cgwnev6fwAFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scHwE7hM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47C3C4CEE3;
	Tue, 17 Jun 2025 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178541;
	bh=s3sT5tqV4KSvRGzgT7da1+aDqIQONUjI4Y56+5Ovx34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scHwE7hM9xnVx10QHdid91z8YgclY4it2hAVTI4/Cm5mRXzCM2johD5ro9M1Kmmby
	 OFPnXPuB1dNuoyxWHu0xZpPhaGEZw5nr86LeutuWIbDKQqNJkB+ZlFR5fd8bujq166
	 kCyl2k+GmQXbgZ7xEWA9liO6vElRyQAGTrxOfBts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Baranger <nicolas.baranger@3xo.fr>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	David Howells <dhowells@redhat.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 454/780] netfs: Fix setting of transferred bytes with short DIO reads
Date: Tue, 17 Jun 2025 17:22:42 +0200
Message-ID: <20250617152509.955808478@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 34eb98c6598c4057640ca56dd1fad6555187473a ]

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
Signed-off-by: "Paulo Alcantara (Red Hat)" <pc@manguebit.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250519090707.2848510-3-dhowells@redhat.com
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_collect.c | 21 +++++----------------
 include/linux/netfs.h   |  1 +
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 23c75755ad4ed..d3cf27b2697c3 100644
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
index c86a11cfc4a36..497c4f4698f6e 100644
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
2.39.5




