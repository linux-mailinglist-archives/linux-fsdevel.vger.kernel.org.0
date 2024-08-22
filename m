Return-Path: <linux-fsdevel+bounces-26843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B18BF95C0A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8790D1F2400D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476DA1D279D;
	Thu, 22 Aug 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6VcskzZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD81D2795
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724364440; cv=none; b=VV2UlnCvWyEu9kYsqgKNCDRwv4/s5KqmlF9gckWLvSUeZgT1HUj31/tkCY7FvCfqIcJTisGFwbluP2YG7NneR91rxT6l8NPUfTYJkl9HQxWMOlQv+MCdkdJzagREh8NFk5mRsPpeKbsQgsBpQl/C0+kiACCr9xz2MU7YtuRH/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724364440; c=relaxed/simple;
	bh=BDYrAsd6P1ev6Wpp5VhwprsXS01M0sKadjGZCpGaMhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kywq96ldS5NDNMPCVhXA0Eyw5qTlFK1BzNaE6DIKChQRbacA+uxCVxrnEY+yrOzV3QDqOVHp4ZK69lkfcUKRyc1H52ahgUg8IZhgbsIC6X6BjsI0KROkAZwb1Fm0xBvvq9AYP1AE0Et9RoSZvsxVvg4ZE04s0MLSnuZxbp+ISS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6VcskzZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724364437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4cMR1cPV7JXYWx72h4PebZI2yNIfo6unToml+bPSHM=;
	b=W6VcskzZywatLjfQVtnUtwtKo1JnlTpIVgZyUHEcx3UQXrQg+VHq0DH6w2CpDY3N7xFsKF
	V7EpTCMLK5Xz2rmMlE+TFaBnMUVA5V+IXX49YBY9aEX/fcfoUj3NCY7iRQ3dR9N1XyGZ6L
	4EcmMyuzUVB9BK42AeK27H2xgwP/80s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-bMIxmBy2PluYI0jC0-NnCQ-1; Thu,
 22 Aug 2024 18:07:14 -0400
X-MC-Unique: bMIxmBy2PluYI0jC0-NnCQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8AD61955F40;
	Thu, 22 Aug 2024 22:07:11 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0C2F19560A3;
	Thu, 22 Aug 2024 22:07:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 2/2] netfs, cifs: Fix handling of short DIO read
Date: Thu, 22 Aug 2024 23:06:49 +0100
Message-ID: <20240822220650.318774-3-dhowells@redhat.com>
In-Reply-To: <20240822220650.318774-1-dhowells@redhat.com>
References: <20240822220650.318774-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
     ENODATA and the read-to file position is at or after the remote inode
     size.

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
---
 fs/netfs/io.c           | 17 +++++++++++------
 fs/smb/client/smb2pdu.c | 15 ++++++++++++++-
 include/linux/netfs.h   |  1 +
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index a72bc01b9609..d6510a9385dc 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -367,7 +367,8 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 		if (subreq->error || subreq->transferred == 0)
 			break;
 		transferred += subreq->transferred;
-		if (subreq->transferred < subreq->len)
+		if (subreq->transferred < subreq->len ||
+		    test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags))
 			break;
 	}
 
@@ -502,7 +503,8 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 
 	subreq->error = 0;
 	subreq->transferred += transferred_or_error;
-	if (subreq->transferred < subreq->len)
+	if (subreq->transferred < subreq->len &&
+	    !test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags))
 		goto incomplete;
 
 complete:
@@ -781,10 +783,13 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
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
index d80107d1ba9e..e182fdbec887 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4507,6 +4507,7 @@ static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
@@ -4603,8 +4604,20 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		/* We may have got an EOF error because fallocate
 		 * failed to enlarge the file.
 		 */
-		if (rdata->subreq.start < rdata->subreq.rreq->i_size)
+		if (rdata->subreq.start + rdata->subreq.transferred < rdata->subreq.rreq->i_size)
 			rdata->result = 0;
+		if (rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes >=
+		    ictx->remote_i_size) {
+			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+			rdata->result = 0;
+		}
+	} else {
+		if (rdata->got_bytes < rdata->actual_len &&
+		    rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes ==
+		    ictx->remote_i_size) {
+			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+			rdata->result = 0;
+		}
 	}
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
 			      server->credits, server->in_flight,
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 983816608f15..c47443e7a97e 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -198,6 +198,7 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
 #define NETFS_SREQ_RETRYING		10	/* Set if we're retrying */
 #define NETFS_SREQ_FAILED		11	/* Set if the subreq failed unretryably */
+#define NETFS_SREQ_HIT_EOF		12	/* Set if we hit the EOF */
 };
 
 enum netfs_io_origin {


