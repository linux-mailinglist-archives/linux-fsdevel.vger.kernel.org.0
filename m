Return-Path: <linux-fsdevel+bounces-27641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B8963370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949FD1C237D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9A1ACDF0;
	Wed, 28 Aug 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgU9OYNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEB1ACE0D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879003; cv=none; b=tlF9b8ihy2TdPB/gApu2vjphLhNjBty4Q70PFI0vc8/+DhruZi5KxDdRlMZuLTM8XcjE2ZWWRFThtIsn9N8WiYZQiozi7SGxynK2VzcQff6T4PehWwFxIhLe25l84uzJNSUkBpMsJkkhByLrazQApdQktnW4WPnWi/KfU7JXIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879003; c=relaxed/simple;
	bh=Oue0inctX0/cTL9pCaZyUkqL42nsO/MfL2hESc+0uP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaOmNAO7gs0w7WTGVmgZsyeqTtpRf5Cs7Q+52URx6jpUpxR3g0Ny5tpR944X2u65WPocjOoKfDscvPAjVXZUV0YE9hLX4H8u/A31MQxBZpyctC7hC8WDMwSPoIYbLm2y3j8T9qOcjwe07WHtgfjHcWtReH8fXsUx9nPfx835jDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgU9OYNa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SffgkMs/hp1KXQEZaoQRSa21BzPv6+eMsTbdq3Ogtdc=;
	b=BgU9OYNab1j4s3DaYEo70LHwq19/x7cDc1LKNOjzarcYdjf2Fs9B3nsfKlaUDTSMjFPnWV
	9eM4wRLCYGjMupO3+vfJG9rru1PRc2exskVSdCBYwnnnGfGlM+IYw4AJXOhm7k4PIJ5Ttp
	5H2dW70SvDHWtjMFuP60dKPoo+UdDIw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-vTkglQjNNRCmXpRkS29Zvg-1; Wed,
 28 Aug 2024 17:03:18 -0400
X-MC-Unique: vTkglQjNNRCmXpRkS29Zvg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A8181955D4E;
	Wed, 28 Aug 2024 21:03:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 115191955BF2;
	Wed, 28 Aug 2024 21:03:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] netfs, cifs: Fix handling of short DIO read
Date: Wed, 28 Aug 2024 22:02:43 +0100
Message-ID: <20240828210249.1078637-3-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
---
 fs/netfs/io.c           | 17 +++++++++++------
 fs/smb/client/smb2pdu.c | 13 +++++++++----
 include/linux/netfs.h   |  1 +
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 3303b515b536..943128507af5 100644
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
@@ -782,10 +784,13 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
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
index be7a1a9c691d..88dc49d67037 100644
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
@@ -4599,11 +4600,15 @@ smb2_readv_callback(struct mid_q_entry *mid)
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


