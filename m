Return-Path: <linux-fsdevel+bounces-27383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA1961017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DCD1F23E31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162771C86EA;
	Tue, 27 Aug 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQjOz17B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC041B4C4E;
	Tue, 27 Aug 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771089; cv=none; b=QrXcFp0n5zRpRzNC+y/UNr1rp0kKHyiXpfjVlX3IeBMev64bvgPQIvpSVhoe5egxi5Z/Jh5kufv2/H58fpjI6fLx2tOUHr4CRhRkLvk4HPYAdryWeq9eLovrsFO4sUD2P6yPasiN493GKtFkoWkWGuX+7nG8n0nt4Pu9xqYK3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771089; c=relaxed/simple;
	bh=wDYW8gW0iFD4ucJiSk3Ju6zNrQakk8Q6mFCoh2H18vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfuQ8FyABtTiyVqG6mMGNJIkSD0ifg8U3ha5DD9t9k9JM1YH9SLifUtcxl41BrHfsG9kAIMvYVanP/B/RRuQQPo+rwT5DIOhm9YVmeBvgRE+fZCQor2VKWOEPnZhBnZs7eLXcMhXMKyHkg7v9SgbkS432Pc/uv60psQhBelsoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQjOz17B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B375C6105B;
	Tue, 27 Aug 2024 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771089;
	bh=wDYW8gW0iFD4ucJiSk3Ju6zNrQakk8Q6mFCoh2H18vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQjOz17Bu6fuo1pppSU9uwYM2mRL/QC6yAZDV1PpUywYl2OaRSLOyWaS9sP8AIho5
	 A73XRUm5zTZPtdjW2poQUXvBUTo074gWdqIW4FQC/a8URx9RVXX41lyAEm3zaYmAUJ
	 bPwCS8VkPR6+05dwBTzp8K2RCmmlAHc5M1MrCWXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 083/273] 9p: Fix DIO read through netfs
Date: Tue, 27 Aug 2024 16:36:47 +0200
Message-ID: <20240827143836.571273512@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

From: Dominique Martinet <asmadeus@codewreck.org>

[ Upstream commit e3786b29c54cdae3490b07180a54e2461f42144c ]

If a program is watching a file on a 9p mount, it won't see any change in
size if the file being exported by the server is changed directly in the
source filesystem, presumably because 9p doesn't have change notifications,
and because netfs skips the reads if the file is empty.

Fix this by attempting to read the full size specified when a DIO read is
requested (such as when 9p is operating in unbuffered mode) and dealing
with a short read if the EOF was less than the expected read.

To make this work, filesystems using netfslib must not set
NETFS_SREQ_CLEAR_TAIL if performing a DIO read where that read hit the EOF.
I don't want to mandatorily clear this flag in netfslib for DIO because,
say, ceph might make a read from an object that is not completely filled,
but does not reside at the end of file - and so we need to clear the
excess.

This can be tested by watching an empty file over 9p within a VM (such as
in the ktest framework):

        while true; do read content; if [ -n "$content" ]; then echo $content; break; fi; done < /host/tmp/foo

then writing something into the empty file.  The watcher should immediately
display the file content and break out of the loop.  Without this fix, it
remains in the loop indefinitely.

Fixes: 80105ed2fd27 ("9p: Use netfslib read/write_iter")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218916
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/1229195.1723211769@warthog.procyon.org.uk
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_addr.c     |  3 ++-
 fs/afs/file.c        |  3 ++-
 fs/ceph/addr.c       |  6 ++++--
 fs/netfs/io.c        | 17 +++++++++++------
 fs/nfs/fscache.c     |  3 ++-
 fs/smb/client/file.c |  3 ++-
 6 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a97ceb105cd8d..24fdc74caeba4 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -75,7 +75,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (subreq->rreq->origin != NETFS_DIO_READ)
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
 	netfs_subreq_terminated(subreq, err ?: total, false);
 }
diff --git a/fs/afs/file.c b/fs/afs/file.c
index c3f0c45ae9a9b..ec1be0091fdb5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -242,7 +242,8 @@ static void afs_fetch_data_notify(struct afs_operation *op)
 
 	req->error = error;
 	if (subreq) {
-		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		if (subreq->rreq->origin != NETFS_DIO_READ)
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 		netfs_subreq_terminated(subreq, error ?: req->actual_len, false);
 		req->subreq = NULL;
 	} else if (req->done) {
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 73b5a07bf94de..d2194022132ec 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -246,7 +246,8 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	if (err >= 0) {
 		if (sparse && err > 0)
 			err = ceph_sparse_ext_map_end(op);
-		if (err < subreq->len)
+		if (err < subreq->len &&
+		    subreq->rreq->origin != NETFS_DIO_READ)
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 		if (IS_ENCRYPTED(inode) && err > 0) {
 			err = ceph_fscrypt_decrypt_extents(inode,
@@ -282,7 +283,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	size_t len;
 	int mode;
 
-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (rreq->origin != NETFS_DIO_READ)
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 
 	if (subreq->start >= inode->i_size)
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index f3abc5dfdbc0c..19ec6990dc91e 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -530,7 +530,8 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 
 	if (transferred_or_error == 0) {
 		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
-			subreq->error = -ENODATA;
+			if (rreq->origin != NETFS_DIO_READ)
+				subreq->error = -ENODATA;
 			goto failed;
 		}
 	} else {
@@ -601,9 +602,14 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 			}
 			if (subreq->len > ictx->zero_point - subreq->start)
 				subreq->len = ictx->zero_point - subreq->start;
+
+			/* We limit buffered reads to the EOF, but let the
+			 * server deal with larger-than-EOF DIO/unbuffered
+			 * reads.
+			 */
+			if (subreq->len > rreq->i_size - subreq->start)
+				subreq->len = rreq->i_size - subreq->start;
 		}
-		if (subreq->len > rreq->i_size - subreq->start)
-			subreq->len = rreq->i_size - subreq->start;
 		if (rreq->rsize && subreq->len > rreq->rsize)
 			subreq->len = rreq->rsize;
 
@@ -739,11 +745,10 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	do {
 		kdebug("submit %llx + %llx >= %llx",
 		       rreq->start, rreq->submitted, rreq->i_size);
-		if (rreq->origin == NETFS_DIO_READ &&
-		    rreq->start + rreq->submitted >= rreq->i_size)
-			break;
 		if (!netfs_rreq_submit_slice(rreq, &io_iter))
 			break;
+		if (test_bit(NETFS_SREQ_NO_PROGRESS, &rreq->flags))
+			break;
 		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
 		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
 			break;
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index ddc1ee0319554..bc20ba50283c8 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -361,7 +361,8 @@ void nfs_netfs_read_completion(struct nfs_pgio_header *hdr)
 		return;
 
 	sreq = netfs->sreq;
-	if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
+	if (test_bit(NFS_IOHDR_EOF, &hdr->flags) &&
+	    sreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &sreq->flags);
 
 	if (hdr->error)
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 2e3c4d0277dbb..9e4f4e67768b9 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -196,7 +196,8 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 			goto out;
 	}
 
-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (subreq->rreq->origin != NETFS_DIO_READ)
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
 	rc = rdata->server->ops->async_readv(rdata);
 out:
-- 
2.43.0




