Return-Path: <linux-fsdevel+bounces-25968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1D9523A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725E028506D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B061D1F6D;
	Wed, 14 Aug 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOErFEzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC001C7B9B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667999; cv=none; b=KXEwGG76mJbT2BqUIZXcQhGaa9Mk5WU3nnK0SPFP5Y47Mom1ikk1sUOxYbMop/TE4LHKSyiJewWsljLHRYoPQfha70bGiGotryyjLRsqEsZVd1TRXX/ZSf7MnMjMTNYkrQ+K/497WYqZ8f+aqEICCjO76649kce57M5TYZ9e79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667999; c=relaxed/simple;
	bh=NBXCa2jTcfUQsea1nGxVfygU/pmMVngyepOKcbBlYbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXeLbA3kVG33IZ6rjf6mEqHRMnUNj7nxW1p51rmmR4tappsPaJ5vAHFllRmg3AWvOJHI8lGItr16LhLcGsTdjKM4kVhvCv+pkkRSz5FSdNFwPfPdWI0e9ykBGq1OYSgxPxdzrO+BcqVJLVMweisQf1Yo0zZXEMClzMF4XGoIQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOErFEzY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723667996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvg09nAt+yf4NVEcyGTKLEn8Q0Nrtw1zYvLWuxTLRzA=;
	b=bOErFEzY8TMEzGvYf0c4m9GHAG7XYm7A763rU5DSDLNzo2quf39F9WhZD2+vmoT3i0TZIV
	iSmlPMNU1b0Hjc/jB+w481shpz2TuJyOtI5SjuiEbSsuK68U5nqCSYSyJ/QlJH1do4tHuR
	cDW96QhRmwVQOcbMzTmn+Z2j5VJTsVw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-3rHT-gkeNMqsiQLJWGWckw-1; Wed,
 14 Aug 2024 16:39:52 -0400
X-MC-Unique: 3rHT-gkeNMqsiQLJWGWckw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E154819373D7;
	Wed, 14 Aug 2024 20:39:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1245C1955F6B;
	Wed, 14 Aug 2024 20:39:43 +0000 (UTC)
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
Subject: [PATCH v2 06/25] netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
Date: Wed, 14 Aug 2024 21:38:26 +0100
Message-ID: <20240814203850.2240469-7-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index 327e5904b090..d7eae597e54d 100644
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
index 5c9b3e6cd95f..1028881098e1 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1550,7 +1550,6 @@ struct cifsInodeInfo {
 #define CIFS_INO_DELETE_PENDING		  (3) /* delete pending on server */
 #define CIFS_INO_INVALID_MAPPING	  (4) /* pagecache is invalid */
 #define CIFS_INO_LOCK			  (5) /* lock bit for synchronization */
-#define CIFS_INO_MODIFIED_ATTR            (6) /* Indicate change in mtime/ctime */
 #define CIFS_INO_CLOSE_ON_LOCK            (7) /* Not to defer the close when lock is set */
 	unsigned long flags;
 	spinlock_t writers_lock;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 3f3842e7b44a..419bfd0c0cbb 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -287,12 +287,6 @@ static void cifs_rreq_done(struct netfs_io_request *rreq)
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
@@ -339,7 +333,6 @@ const struct netfs_request_ops cifs_req_ops = {
 	.clamp_length		= cifs_clamp_length,
 	.issue_read		= cifs_req_issue_read,
 	.done			= cifs_rreq_done,
-	.post_modify		= cifs_post_modify,
 	.begin_writeback	= cifs_begin_writeback,
 	.prepare_write		= cifs_prepare_write,
 	.issue_write		= cifs_issue_write,
@@ -1363,7 +1356,7 @@ int cifs_close(struct inode *inode, struct file *file)
 		dclose = kmalloc(sizeof(struct cifs_deferred_close), GFP_KERNEL);
 		if ((cfile->status_file_deleted == false) &&
 		    (smb2_can_defer_close(inode, dclose))) {
-			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
+			if (test_and_clear_bit(NETFS_ICTX_MODIFIED_ATTR, &cinode->netfs.flags)) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
 			}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 983816608f15..574df0402c44 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -73,6 +73,7 @@ struct netfs_inode {
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 #define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
+#define NETFS_ICTX_MODIFIED_ATTR 3		/* Indicate change in mtime/ctime */
 };
 
 /*


