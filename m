Return-Path: <linux-fsdevel+bounces-29007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F434972F1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EA61C24ACB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790B418C928;
	Tue, 10 Sep 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1YbDw80B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47F186E4B;
	Tue, 10 Sep 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961696; cv=none; b=sXeZcvs24KumWCnvwDIYhipIs+0wJ9QnoK6i8cophisqz28Px994VdfAd021OrD1kyAd33pgQ8NKaPYj8FiPPy0z0feyYhaxI3MeNrkX/np4vQtWKG5TBlBDg889yCMWN9sp739jYm2KnNW1iwlff2vnCIE4aYdHYQ3Z5wu9hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961696; c=relaxed/simple;
	bh=NssVglAnEpOf7wNBYzta/B/OgCViezTjeBIvIZNA6ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhVYh9SGgkLltTcG9hF7XLCgdZ+D3u+lpad4SIwasR9D70zfuXxhVkifygYO1KU+Y2mjm5DnH6NO3CSCozzo/CWCTWSQgKkS+XmZupvaBewsnsI8Hm3tgGekEM3hFfFxcAx+yvGqP4ID608H9zyyCuwu5E6GYjT7gyrv3niUwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1YbDw80B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA94C4CEC3;
	Tue, 10 Sep 2024 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961696;
	bh=NssVglAnEpOf7wNBYzta/B/OgCViezTjeBIvIZNA6ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1YbDw80Bs9w+k7OA/kG9JH6/3M9FuX9TJ5b8kDQQj9Us46WX5FuLQN/RR1hAwcwbm
	 udHROjRTHH9afPEbNc46ohPg0fFR5snpCfkR56vGHIuf7YJuXrQcbdKqwW9Wm1Exqr
	 Tg7+A0f0ZgcN/dNWv0NR1Iu70wKwSu/91ujQwWbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 157/375] netfs, cifs: Fix handling of short DIO read
Date: Tue, 10 Sep 2024 11:29:14 +0200
Message-ID: <20240910092627.745601984@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 1da29f2c39b67b846b74205c81bf0ccd96d34727 ]

Short DIO reads, particularly in relation to cifs, are not being handled
correctly by cifs and netfslib.  This can be tested by doing a DIO read of
a file where the size of read is larger than the size of the file.  When it
crosses the EOF, it gets a short read and this gets retried, and in the
case of cifs, the retry read fails, with the failure being translated to
ENODATA.

Fix this by the following means:

 (1) Add a flag, NETFS_SREQ_HIT_EOF, for the filesystem to set when it
     detects that the read did hit the EOF.

 (2) Make the netfslib read assessment stop processing subrequests when it
     encounters one with that flag set.

 (3) Return rreq->transferred, the accumulated contiguous amount read to
     that point, to userspace for a DIO read.

 (4) Make cifs set the flag and clear the error if the read RPC returned
     ENODATA.

 (5) Make cifs set the flag and clear the error if a short read occurred
     without error and the read-to file position is now at the remote inode
     size.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/io.c           | 17 +++++++++++------
 fs/smb/client/smb2pdu.c | 13 +++++++++----
 include/linux/netfs.h   |  1 +
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 2a5c22606fb1..c91e7b12bbf1 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -368,7 +368,8 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 		if (subreq->error || subreq->transferred == 0)
 			break;
 		transferred += subreq->transferred;
-		if (subreq->transferred < subreq->len)
+		if (subreq->transferred < subreq->len ||
+		    test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags))
 			break;
 	}
 
@@ -503,7 +504,8 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 
 	subreq->error = 0;
 	subreq->transferred += transferred_or_error;
-	if (subreq->transferred < subreq->len)
+	if (subreq->transferred < subreq->len &&
+	    !test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags))
 		goto incomplete;
 
 complete:
@@ -777,10 +779,13 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 			    TASK_UNINTERRUPTIBLE);
 
 		ret = rreq->error;
-		if (ret == 0 && rreq->submitted < rreq->len &&
-		    rreq->origin != NETFS_DIO_READ) {
-			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
-			ret = -EIO;
+		if (ret == 0) {
+			if (rreq->origin == NETFS_DIO_READ) {
+				ret = rreq->transferred;
+			} else if (rreq->submitted < rreq->len) {
+				trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
+				ret = -EIO;
+			}
 		}
 	} else {
 		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 5f5f51bf9850..8e02e9f45e0e 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4501,6 +4501,7 @@ static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
@@ -4593,11 +4594,15 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				     rdata->got_bytes);
 
 	if (rdata->result == -ENODATA) {
-		/* We may have got an EOF error because fallocate
-		 * failed to enlarge the file.
-		 */
-		if (rdata->subreq.start < rdata->subreq.rreq->i_size)
+		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+		rdata->result = 0;
+	} else {
+		if (rdata->got_bytes < rdata->actual_len &&
+		    rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes ==
+		    ictx->remote_i_size) {
+			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
+		}
 	}
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
 			      server->credits, server->in_flight,
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5d0288938cc2..d8892b1a2dd7 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -200,6 +200,7 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
 #define NETFS_SREQ_RETRYING		10	/* Set if we're retrying */
 #define NETFS_SREQ_FAILED		11	/* Set if the subreq failed unretryably */
+#define NETFS_SREQ_HIT_EOF		12	/* Set if we hit the EOF */
 };
 
 enum netfs_io_origin {
-- 
2.43.0




