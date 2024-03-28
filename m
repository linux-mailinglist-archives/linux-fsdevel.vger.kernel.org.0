Return-Path: <linux-fsdevel+bounces-15573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC98905FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69AB1C26F00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6513BC34;
	Thu, 28 Mar 2024 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhY3Q6Ka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65513BC35
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643912; cv=none; b=sXKQPgqNn0hBwfej8aToQz8w+P12Qy0nJyvcR8GxnkV+dTp93QfMk9l0TxiJqRIBbogUQgV3AxsT4rivx4yVYbn722kHcy4fD+2xcqfRuwC78hoMtn8Vq41vGr9F4IA+1g3Y2Lb6Yr46B8qmk/OMG9Oyuoh43iGUAUiSAjpMCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643912; c=relaxed/simple;
	bh=ZHer5lBdtvALDuMFH2wxDgdMkLBv4TEQJRmyQoctO08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWLcYFcKq1UoIfeYerzGFUhEm+xmT6vRoihvfKBA3J3oDZaaG5i/6wjXrvzTZbOQJ209dzvFhWmvdTw8l3PgVLjiijNzFVIzY1dwizMBADyznT+5KiqUxJsnCrADog9ypGLIAr0dSm+Z9phrvF4uiXYBbdWPKWwML2MWd7vIF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhY3Q6Ka; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtpBbjrD+Slaag5TH6kef/+TLI8uFihL8QWdtpo1kX0=;
	b=OhY3Q6Ka5FXIs3VMY6/9zq8uzuEFaU5u2BVv4reMaoh9v+aT+z2gVo7x5FS8L77ECdyzvH
	ht0lxPwKdXkJ4YQJQT+00nzvfCmsVU0W9kQ0RDy6amoHFK4GkjMXAVmUpyIm6yJXSvCBcM
	CFkemv6PIPq3dHi0c6IACrQDW7bVqUc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-Lg6OOJb5N_K3mFAM9aV-nw-1; Thu,
 28 Mar 2024 12:38:24 -0400
X-MC-Unique: Lg6OOJb5N_K3mFAM9aV-nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC9A629AC002;
	Thu, 28 Mar 2024 16:38:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EED572166B35;
	Thu, 28 Mar 2024 16:38:20 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/26] netfs, afs: Implement helpers for new write code
Date: Thu, 28 Mar 2024 16:34:12 +0000
Message-ID: <20240328163424.2781320-21-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Implement the helpers for the new write code in afs.  There's now an
optional ->prepare_write() that allows the filesystem to set the parameters
for the next write, such as maximum size and maximum segment count, and an
->issue_write() that is called to initiate an (asynchronous) write
operation.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c     |  3 +++
 fs/afs/internal.h |  3 +++
 fs/afs/write.c    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index dfd8f60f5e1f..db9ebae84fa2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -400,6 +400,9 @@ const struct netfs_request_ops afs_req_ops = {
 	.update_i_size		= afs_update_i_size,
 	.invalidate_cache	= afs_netfs_invalidate_cache,
 	.create_write_requests	= afs_create_write_requests,
+	.begin_writeback	= afs_begin_writeback,
+	.prepare_write		= afs_prepare_write,
+	.issue_write		= afs_issue_write,
 };
 
 static void afs_add_open_mmap(struct afs_vnode *vnode)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b93aa026daa4..dcf0ae0323d3 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1598,6 +1598,9 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 /*
  * write.c
  */
+void afs_prepare_write(struct netfs_io_subrequest *subreq);
+void afs_issue_write(struct netfs_io_subrequest *subreq);
+void afs_begin_writeback(struct netfs_io_request *wreq);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 1bc26466eb72..89b073881cac 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -194,6 +194,52 @@ void afs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size
 		netfs_queue_write_request(subreq);
 }
 
+/*
+ * Writeback calls this when it finds a folio that needs uploading.  This isn't
+ * called if writeback only has copy-to-cache to deal with.
+ */
+void afs_begin_writeback(struct netfs_io_request *wreq)
+{
+	wreq->io_streams[0].avail = true;
+}
+
+/*
+ * Prepare a subrequest to write to the server.  This sets the max_len
+ * parameter.
+ */
+void afs_prepare_write(struct netfs_io_subrequest *subreq)
+{
+	//if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags))
+	//	subreq->max_len = 512 * 1024;
+	//else
+	subreq->max_len = 256 * 1024 * 1024;
+}
+
+/*
+ * Issue a subrequest to write to the server.
+ */
+void afs_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
+	ssize_t ret;
+
+	_enter("%x[%x],%zx",
+	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.count);
+
+#if 0 // Error injection
+	if (subreq->debug_index == 3)
+		return netfs_write_subrequest_terminated(subreq, -ENOANO, false);
+
+	if (!test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
+		set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
+	}
+#endif
+
+	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start);
+	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len, false);
+}
+
 /*
  * write some of the pending data back to the server
  */


