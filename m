Return-Path: <linux-fsdevel+bounces-5941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DEA811735
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCAB1F21033
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9967B63;
	Wed, 13 Dec 2023 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czx8iCXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE1188
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcUt6Wlq9qFzNGrM+VViKKkJSoOctikTKew3FuWO+5w=;
	b=czx8iCXfmnLA4VgkLVR8x2LfHLu8tLtQf8fZjx0/MFASfb+2gl7lBEtnTVSLafskVU3B/Q
	3vFZzCC2I01r54ftWITupxgVdYpZg810KnTV4POFoRsf8mxGFHPTzvioBViv3PPVAysPgh
	geL33xcoPclTOTwftTjOWPi2oqcEA1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-izgs5zPOPzO_FpSrM-V7uQ-1; Wed, 13 Dec 2023 10:26:13 -0500
X-MC-Unique: izgs5zPOPzO_FpSrM-V7uQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD5CC890FCD;
	Wed, 13 Dec 2023 15:26:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EE7F40C6EB9;
	Wed, 13 Dec 2023 15:26:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 31/39] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
Date: Wed, 13 Dec 2023 15:23:41 +0000
Message-ID: <20231213152350.431591-32-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Provide an entry point to delegate a filesystem's ->page_mkwrite() to.
This checks for conflicting writes, then attached any netfs-specific group
marking (e.g. ceph snap) to the page to be considered dirty.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c | 59 +++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h     |  4 +++
 2 files changed, 63 insertions(+)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index f244123ab568..70cb8e98d068 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -416,3 +416,62 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 EXPORT_SYMBOL(netfs_file_write_iter);
+
+/*
+ * Notification that a previously read-only page is about to become writable.
+ * Note that the caller indicates a single page of a multipage folio.
+ */
+vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
+{
+	struct folio *folio = page_folio(vmf->page);
+	struct file *file = vmf->vma->vm_file;
+	struct inode *inode = file_inode(file);
+	vm_fault_t ret = VM_FAULT_RETRY;
+	int err;
+
+	_enter("%lx", folio->index);
+
+	sb_start_pagefault(inode->i_sb);
+
+	if (folio_wait_writeback_killable(folio))
+		goto out;
+
+	if (folio_lock_killable(folio) < 0)
+		goto out;
+
+	/* Can we see a streaming write here? */
+	if (WARN_ON(!folio_test_uptodate(folio))) {
+		ret = VM_FAULT_SIGBUS | VM_FAULT_LOCKED;
+		goto out;
+	}
+
+	if (netfs_folio_group(folio) != netfs_group) {
+		folio_unlock(folio);
+		err = filemap_fdatawait_range(inode->i_mapping,
+					      folio_pos(folio),
+					      folio_pos(folio) + folio_size(folio));
+		switch (err) {
+		case 0:
+			ret = VM_FAULT_RETRY;
+			goto out;
+		case -ENOMEM:
+			ret = VM_FAULT_OOM;
+			goto out;
+		default:
+			ret = VM_FAULT_SIGBUS;
+			goto out;
+		}
+	}
+
+	if (folio_test_dirty(folio))
+		trace_netfs_folio(folio, netfs_folio_trace_mkwrite_plus);
+	else
+		trace_netfs_folio(folio, netfs_folio_trace_mkwrite);
+	netfs_set_group(folio, netfs_group);
+	file_update_time(file);
+	ret = VM_FAULT_LOCKED;
+out:
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_page_mkwrite);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 702b864a4993..46c0a6b45bb8 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -403,6 +403,10 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 
+/* VMA operations API. */
+vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
+
+/* (Sub)request management API. */
 void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);


