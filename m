Return-Path: <linux-fsdevel+bounces-51944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887FADD95A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDFF406C4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC02EA748;
	Tue, 17 Jun 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0mNSyfEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15C2E8DE4;
	Tue, 17 Jun 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178449; cv=none; b=d5F8HzlsLtOr1PBCdvld7PG6VpstTl4LCuyRr2Zufb9fcNasvMi0pdaP4Kyv5nFTuIUDuAP4KpKtRH5//KzNL+3amegCcc+locvHcBduzAkLBZEjeeRGy1BRA274MwnvZ+/0WsydstNU4+4angBhnC9CUWwwaSsISKG4aAzVG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178449; c=relaxed/simple;
	bh=hYfsZ+h97b8SSCcK8Ze2SD1mhLygdwMfpK9oq0VwKTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBsG5T/PSDMVGTrdpMsA7lsTpUvwTtEKYtZjaHAGHpNwiWFUlEZqRHTA2UxRWmEJI9pEequA2vW801U6gGvLsdF4h27fkg8Sd22AAyNjQDBiRGr9pHl8Y1SGrC20zsOUum3IB6Vh97PGANLlXFUPasaCJj4zsNtyWEXZ83lX+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0mNSyfEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A49BC4CEE3;
	Tue, 17 Jun 2025 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178449;
	bh=hYfsZ+h97b8SSCcK8Ze2SD1mhLygdwMfpK9oq0VwKTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0mNSyfEtckwG/mGjGLJz6e/PSC944bXgzGUbTbgwQSQ+wSxd9w9vO2B9/9U91XrkJ
	 ykgP3zlA3Q6gBfH3DR0+XA4HZml7/cXmL4W4cyig3hkJUkR65VYS7BnJXAl21IB8c2
	 hVunMatEIAio6KBa29gT5KYByd374Mt7KHPPVJB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Steve French <sfrench@samba.org>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 461/780] netfs: Fix undifferentiation of DIO reads from unbuffered reads
Date: Tue, 17 Jun 2025 17:22:49 +0200
Message-ID: <20250617152510.251693779@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit db26d62d79e4068934ad0dccdb92715df36352b9 ]

On cifs, "DIO reads" (specified by O_DIRECT) need to be differentiated from
"unbuffered reads" (specified by cache=none in the mount parameters).  The
difference is flagged in the protocol and the server may behave
differently: Windows Server will, for example, mandate that DIO reads are
block aligned.

Fix this by adding a NETFS_UNBUFFERED_READ to differentiate this from
NETFS_DIO_READ, parallelling the write differentiation that already exists.
cifs will then do the right thing.

Fixes: 016dc8516aec ("netfs: Implement unbuffered/DIO read support")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/3444961.1747987072@warthog.procyon.org.uk
Reviewed-by: "Paulo Alcantara (Red Hat)" <pc@manguebit.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_addr.c             | 3 ++-
 fs/afs/write.c               | 1 +
 fs/ceph/addr.c               | 4 +++-
 fs/netfs/direct_read.c       | 3 ++-
 fs/netfs/main.c              | 1 +
 fs/netfs/misc.c              | 1 +
 fs/netfs/objects.c           | 1 +
 fs/netfs/read_collect.c      | 7 +++++--
 fs/nfs/fscache.c             | 1 +
 fs/smb/client/file.c         | 3 ++-
 include/linux/netfs.h        | 1 +
 include/trace/events/netfs.h | 1 +
 12 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index b5a4a28e0fe79..e4420591cf354 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -77,7 +77,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
-	if (subreq->rreq->origin != NETFS_DIO_READ)
+	if (subreq->rreq->origin != NETFS_UNBUFFERED_READ &&
+	    subreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	if (pos + total >= i_size_read(rreq->inode))
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 7df7b2f5e7b29..2e7526ea883ae 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -202,6 +202,7 @@ void afs_retry_request(struct netfs_io_request *wreq, struct netfs_io_stream *st
 	case NETFS_READ_GAPS:
 	case NETFS_READ_SINGLE:
 	case NETFS_READ_FOR_WRITE:
+	case NETFS_UNBUFFERED_READ:
 	case NETFS_DIO_READ:
 		return;
 	default:
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 557c326561fdc..b95c4cb21c13f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -238,6 +238,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 		if (sparse && err > 0)
 			err = ceph_sparse_ext_map_end(op);
 		if (err < subreq->len &&
+		    subreq->rreq->origin != NETFS_UNBUFFERED_READ &&
 		    subreq->rreq->origin != NETFS_DIO_READ)
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 		if (IS_ENCRYPTED(inode) && err > 0) {
@@ -281,7 +282,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	size_t len;
 	int mode;
 
-	if (rreq->origin != NETFS_DIO_READ)
+	if (rreq->origin != NETFS_UNBUFFERED_READ &&
+	    rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a24e63d2c8186..9902766195d7b 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -188,7 +188,8 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 
 	rreq = netfs_alloc_request(iocb->ki_filp->f_mapping, iocb->ki_filp,
 				   iocb->ki_pos, orig_count,
-				   NETFS_DIO_READ);
+				   iocb->ki_flags & IOCB_DIRECT ?
+				   NETFS_DIO_READ : NETFS_UNBUFFERED_READ);
 	if (IS_ERR(rreq))
 		return PTR_ERR(rreq);
 
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 70ecc8f5f2103..3db401d269e7b 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -39,6 +39,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READ_GAPS]		= "RG",
 	[NETFS_READ_SINGLE]		= "R1",
 	[NETFS_READ_FOR_WRITE]		= "RW",
+	[NETFS_UNBUFFERED_READ]		= "UR",
 	[NETFS_DIO_READ]		= "DR",
 	[NETFS_WRITEBACK]		= "WB",
 	[NETFS_WRITEBACK_SINGLE]	= "W1",
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 77e7f7c79d27c..43b67a28a8fa0 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -461,6 +461,7 @@ static ssize_t netfs_wait_for_request(struct netfs_io_request *rreq,
 		case NETFS_DIO_READ:
 		case NETFS_DIO_WRITE:
 		case NETFS_READ_SINGLE:
+		case NETFS_UNBUFFERED_READ:
 		case NETFS_UNBUFFERED_WRITE:
 			break;
 		default:
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index d3eb9ba3013a7..31fa0c81e2a43 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -59,6 +59,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	    origin == NETFS_READ_GAPS ||
 	    origin == NETFS_READ_SINGLE ||
 	    origin == NETFS_READ_FOR_WRITE ||
+	    origin == NETFS_UNBUFFERED_READ ||
 	    origin == NETFS_DIO_READ) {
 		INIT_WORK(&rreq->work, netfs_read_collection_worker);
 		rreq->io_streams[0].avail = true;
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 900dd51c3b941..bad677e58a423 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -342,7 +342,8 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 {
 	unsigned int i;
 
-	if (rreq->origin == NETFS_DIO_READ) {
+	if (rreq->origin == NETFS_UNBUFFERED_READ ||
+	    rreq->origin == NETFS_DIO_READ) {
 		for (i = 0; i < rreq->direct_bv_count; i++) {
 			flush_dcache_page(rreq->direct_bv[i].bv_page);
 			// TODO: cifs marks pages in the destination buffer
@@ -360,7 +361,8 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 	}
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);
-	if (rreq->origin == NETFS_DIO_READ)
+	if (rreq->origin == NETFS_UNBUFFERED_READ ||
+	    rreq->origin == NETFS_DIO_READ)
 		inode_dio_end(rreq->inode);
 }
 
@@ -416,6 +418,7 @@ bool netfs_read_collection(struct netfs_io_request *rreq)
 	//netfs_rreq_is_still_valid(rreq);
 
 	switch (rreq->origin) {
+	case NETFS_UNBUFFERED_READ:
 	case NETFS_DIO_READ:
 	case NETFS_READ_GAPS:
 		netfs_rreq_assess_dio(rreq);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index e278a1ad1ca3e..8b07851787312 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -367,6 +367,7 @@ void nfs_netfs_read_completion(struct nfs_pgio_header *hdr)
 
 	sreq = netfs->sreq;
 	if (test_bit(NFS_IOHDR_EOF, &hdr->flags) &&
+	    sreq->rreq->origin != NETFS_UNBUFFERED_READ &&
 	    sreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &sreq->flags);
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 3000c8a9d3ea5..d2df10b8e6fd8 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -219,7 +219,8 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 			goto failed;
 	}
 
-	if (subreq->rreq->origin != NETFS_DIO_READ)
+	if (subreq->rreq->origin != NETFS_UNBUFFERED_READ &&
+	    subreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c3f230732f51d..1464b3a104989 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -206,6 +206,7 @@ enum netfs_io_origin {
 	NETFS_READ_GAPS,		/* This read is a synchronous read to fill gaps */
 	NETFS_READ_SINGLE,		/* This read should be treated as a single object */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
+	NETFS_UNBUFFERED_READ,		/* This is an unbuffered read */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
 	NETFS_WRITEBACK_SINGLE,		/* This monolithic write was triggered by writepages */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 402c5e82e7b8d..4175eec40048a 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -39,6 +39,7 @@
 	EM(NETFS_READ_GAPS,			"RG")		\
 	EM(NETFS_READ_SINGLE,			"R1")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
+	EM(NETFS_UNBUFFERED_READ,		"UR")		\
 	EM(NETFS_DIO_READ,			"DR")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
 	EM(NETFS_WRITEBACK_SINGLE,		"W1")		\
-- 
2.39.5




