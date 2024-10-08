Return-Path: <linux-fsdevel+bounces-31332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA7994B1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774261C24D06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B71DE3AE;
	Tue,  8 Oct 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zdKSjkxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4621779B1;
	Tue,  8 Oct 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391220; cv=none; b=Raa81CXtvodiWlB3qO/rAysorWcKdr2EeZ9viA35MVDGcwL2uUan1YrS7oo5+t9onrQefWjoJkgAvCprOSZzvjMLLZOi8C55tOdRrAkjKfVBU/PjL3EdeNj2CbSqErrPK/0kFoFFHLwjWn8oZpuuquYvx8ggt/qJiq+morzJOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391220; c=relaxed/simple;
	bh=aUiYHLp/o8JLjU62RMmPFXZDYB4HPfzQzoDzzMWrvLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shd5v46X8UY2n2gW0S01uHYBHrj9g62mB/p/bOwP5/u55KCODDQjriDs9qM1i/GyuRiUBpNlX7z1fhCY0WxKS5kt69i2GnnpOFKj2QafAfLSFub5ahiWixGjyB9Wy2F9G85O2e9xKd4WkUhT+g0SQKdfd1eh14nAjHGso3qMgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zdKSjkxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AA7C4CEC7;
	Tue,  8 Oct 2024 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391220;
	bh=aUiYHLp/o8JLjU62RMmPFXZDYB4HPfzQzoDzzMWrvLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zdKSjkxYzDzodRW0PRYSBcdBobLIryTIWfsh0G/ufZ9HKUPEbmn+YzeYIJd3wwn3N
	 T2p8VKlEleaMKmZH1+g/traQHAm9X/K7nfzvnZoQi1jji5pMo++UHgc14QdCCoixm0
	 swk1DV6IF0MhrrTPdCRFIkBVS+6GF1TzPJCABMZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 046/558] netfs: Fix missing wakeup after issuing writes
Date: Tue,  8 Oct 2024 14:01:16 +0200
Message-ID: <20241008115704.035944529@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 1ca4169c391c370e0f3a92938df2862900575096 ]

After dividing up a proposed write into subrequests, netfslib sets
NETFS_RREQ_ALL_QUEUED to indicate to the collector that it can move on to
the final cleanup once it has emptied the subrequest queues.

Now, whilst the collector will normally end up running at least once after
this bit is set just because it takes a while to process all the write
subrequests before the collector runs out of subrequests, there exists the
possibility that the issuing thread will be forced to sleep and the
collector thread will clean up all the subrequests before ALL_QUEUED gets
set.

In such a case, the collector thread will not get triggered again and will
never clear NETFS_RREQ_IN_PROGRESS thus leaving a request uncompleted and
causing a potential futute hang.

Fix this by scheduling the write collector if all the subrequest queues are
empty (and thus no writes pending issuance).

Note that we'd do this ideally before queuing the subrequest, but in the
case of buffered writeback, at least, we can't find out that we've run out
of folios until after we've called writeback_iter() and it has returned
NULL - at which point we might not actually have any subrequests still
under construction.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/3317784.1727880350@warthog.procyon.org.uk
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/write_issue.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 3f7e37e50c7d0..9486e54b1e563 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -494,6 +494,30 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	return 0;
 }
 
+/*
+ * End the issuing of writes, letting the collector know we're done.
+ */
+static void netfs_end_issue_write(struct netfs_io_request *wreq)
+{
+	bool needs_poke = true;
+
+	smp_wmb(); /* Write subreq lists before ALL_QUEUED. */
+	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_io_stream *stream = &wreq->io_streams[s];
+
+		if (!stream->active)
+			continue;
+		if (!list_empty(&stream->subrequests))
+			needs_poke = false;
+		netfs_issue_write(wreq, stream);
+	}
+
+	if (needs_poke)
+		netfs_wake_write_collector(wreq, false);
+}
+
 /*
  * Write some of the pending data back to the server
  */
@@ -541,10 +565,7 @@ int netfs_writepages(struct address_space *mapping,
 			break;
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
 
-	for (int s = 0; s < NR_IO_STREAMS; s++)
-		netfs_issue_write(wreq, &wreq->io_streams[s]);
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+	netfs_end_issue_write(wreq);
 
 	mutex_unlock(&ictx->wb_lock);
 
@@ -632,10 +653,7 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_contr
 	if (writethrough_cache)
 		netfs_write_folio(wreq, wbc, writethrough_cache);
 
-	netfs_issue_write(wreq, &wreq->io_streams[0]);
-	netfs_issue_write(wreq, &wreq->io_streams[1]);
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+	netfs_end_issue_write(wreq);
 
 	mutex_unlock(&ictx->wb_lock);
 
@@ -680,13 +698,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t
 			break;
 	}
 
-	netfs_issue_write(wreq, upload);
-
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
-	if (list_empty(&upload->subrequests))
-		netfs_wake_write_collector(wreq, false);
-
+	netfs_end_issue_write(wreq);
 	_leave(" = %d", error);
 	return error;
 }
-- 
2.43.0




