Return-Path: <linux-fsdevel+bounces-24471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B895793FAB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73174286A89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504161891A3;
	Mon, 29 Jul 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyFFDq1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB48188CBB
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270071; cv=none; b=qw3LRmtCxJowLVstdnfsAFx7ob/TPguicQSZRlRz6n/U71EHl/BKVV5VrCdUJZj421aL2X5k6NxF85K97DLQ4i80r5pUL3g1/8IJADandhLCVYLRtCcajSapiuZZH3ygpfUY7YjqNY4vY17K2kXCwC/g34ni67qFxqv4SrkvmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270071; c=relaxed/simple;
	bh=RGvJodJwVYeagmFdINh8R+zs2093g2pN4oJmJ6CXOCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8YKd+P/mDPIzkrPOi5E+pmyI+gcGOvatFtD2t9OrpoBYQEwRxXtC54oTcduOGla4z8OhQ9AwRv1egmydqdpqs006ascTdDWt8CDv78i5vIc03C5oLW0gt+1QPrYgk/mf0ggqnxwFd75IF4+v1de6B+iCtU73O9yyaqLbvHc6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyFFDq1R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsLWP+6oHHQR8BoWVXvRdRgXKHN2l9YwS7BTP0t5yr8=;
	b=CyFFDq1ROjM5AAyLVjQnUGzq5c6k65mlOxuuHWf1ZIaK6W/iMJLV5oHX6PMYJ28FZBjnPR
	mg4YKMyUh4j0R+tRaOenKAXLlEeuAurqWR8423ImCZf6J3QLo8zIzU7Dk3PVWG7X9bMVmO
	ukv5bRfFvPCTtMUjX/0awCoX4aCQ5iA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-Qmgpn1yYMICXSDFDQoCngg-1; Mon,
 29 Jul 2024 12:21:05 -0400
X-MC-Unique: Qmgpn1yYMICXSDFDQoCngg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6FF219560A2;
	Mon, 29 Jul 2024 16:21:00 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C6101955D42;
	Mon, 29 Jul 2024 16:20:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>
Subject: [PATCH 06/24] netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
Date: Mon, 29 Jul 2024 17:19:35 +0100
Message-ID: <20240729162002.3436763-7-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move CIFS_INO_MODIFIED_ATTR to netfs_inode as NETFS_ICTX_MODIFIED_ATTR and
then make netfs_perform_write() set it.  This means that cifs doesn't need
to implement the ->post_modify() hook.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 10 ++++++++--
 fs/smb/client/cifsglob.h  |  1 -
 fs/smb/client/file.c      |  9 +--------
 include/linux/netfs.h     |  1 +
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index fba5b238455b..7ecae5392a1f 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -372,8 +372,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter));
 
 out:
-	if (likely(written) && ctx->ops->post_modify)
-		ctx->ops->post_modify(inode);
+	if (likely(written)) {
+		/* Set indication that ctime and mtime got updated in case
+		 * close is deferred.
+		 */
+		set_bit(NETFS_ICTX_MODIFIED_ATTR, &ctx->flags);
+		if (unlikely(ctx->ops->post_modify))
+			ctx->ops->post_modify(inode);
+	}
 
 	if (unlikely(wreq)) {
 		ret2 = netfs_end_writethrough(wreq, &wbc, writethrough);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 8e86fec7dcd2..85e6495dc440 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1573,7 +1573,6 @@ struct cifsInodeInfo {
 #define CIFS_INO_DELETE_PENDING		  (3) /* delete pending on server */
 #define CIFS_INO_INVALID_MAPPING	  (4) /* pagecache is invalid */
 #define CIFS_INO_LOCK			  (5) /* lock bit for synchronization */
-#define CIFS_INO_MODIFIED_ATTR            (6) /* Indicate change in mtime/ctime */
 #define CIFS_INO_CLOSE_ON_LOCK            (7) /* Not to defer the close when lock is set */
 	unsigned long flags;
 	spinlock_t writers_lock;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b2405dd4d4d4..fd9f82ff44b8 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -286,12 +286,6 @@ static void cifs_rreq_done(struct netfs_io_request *rreq)
 		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 }
 
-static void cifs_post_modify(struct inode *inode)
-{
-	/* Indication to update ctime and mtime as close is deferred */
-	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
-}
-
 static void cifs_free_request(struct netfs_io_request *rreq)
 {
 	struct cifs_io_request *req = container_of(rreq, struct cifs_io_request, rreq);
@@ -338,7 +332,6 @@ const struct netfs_request_ops cifs_req_ops = {
 	.clamp_length		= cifs_clamp_length,
 	.issue_read		= cifs_req_issue_read,
 	.done			= cifs_rreq_done,
-	.post_modify		= cifs_post_modify,
 	.begin_writeback	= cifs_begin_writeback,
 	.prepare_write		= cifs_prepare_write,
 	.issue_write		= cifs_issue_write,
@@ -1362,7 +1355,7 @@ int cifs_close(struct inode *inode, struct file *file)
 		dclose = kmalloc(sizeof(struct cifs_deferred_close), GFP_KERNEL);
 		if ((cfile->status_file_deleted == false) &&
 		    (smb2_can_defer_close(inode, dclose))) {
-			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
+			if (test_and_clear_bit(NETFS_ICTX_MODIFIED_ATTR, &cinode->netfs.flags)) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
 			}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5d0288938cc2..2d438aaae685 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -73,6 +73,7 @@ struct netfs_inode {
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 #define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
+#define NETFS_ICTX_MODIFIED_ATTR 3		/* Indicate change in mtime/ctime */
 #define NETFS_ICTX_USE_PGPRIV2	31		/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 };


