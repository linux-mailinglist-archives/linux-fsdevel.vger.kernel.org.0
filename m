Return-Path: <linux-fsdevel+bounces-33777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A259BEB04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B2B283715
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B2F1F4FCA;
	Wed,  6 Nov 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S47X/qCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C6202648
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896812; cv=none; b=NVB/kqpr5J05KtEE1e0GpGZBi8+77rTn1stjTZno3WtqVoVv+3j9OzLKOlQxgtiW7wqUA8Zibw+BjmYKKzNYRKdTg8twE+7PJqf1gQt4Wd/mKX32Rst0w74/3/CwMZgHQIsGTJEkNKaMpDcTPXdYFd0sVNB5ZnJpBvHCtLh5AKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896812; c=relaxed/simple;
	bh=D7anUsMS0SN7WCI0w7fmn3gk4LOmdSs8m+vQmsd2V/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mp8H0J1CzY/4P0OfjE6vS1qjs98c0hCD8HaxMQ/zx/DDn9fLMt94RMgkYx1Odtsanhur88s4gi6i8rFEMgWUUBSm7MukDTE87p+c4mSkazVuDLaM7Fz/OZgsJ7Tpig8gKuerQn/TvG0KYHzQaAoL7dzSkaHRqZotk66geilalFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S47X/qCY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXoKBAczFzEdxforFlZoT0jqB8v2JMkojevHnwPW6bc=;
	b=S47X/qCYgDWM5mdgs341JSMJLFODEbCqeNkNCI2/ibHnej43wrHEZ3uGWxglU+UblpcVmZ
	zwmdM6lunKT7r/WW91iKAc5D6n+LvGXJklJeESKFlV4naMOawuhQq9zF3mBJp14kSe41Y+
	UnDhywUHoJKt6qrtUcD1X9XTynHoy6Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-lO_jK5jjM1WCcN-ItRvP8g-1; Wed,
 06 Nov 2024 07:40:03 -0500
X-MC-Unique: lO_jK5jjM1WCcN-ItRvP8g-1
X-Mimecast-MFC-AGG-ID: lO_jK5jjM1WCcN-ItRvP8g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF90719560A2;
	Wed,  6 Nov 2024 12:40:00 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 268B319560AD;
	Wed,  6 Nov 2024 12:39:54 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 31/33] afs: Locally initialise the contents of a new symlink on creation
Date: Wed,  6 Nov 2024 12:35:55 +0000
Message-ID: <20241106123559.724888-32-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Since we know what the contents of a symlink will be when we create it on
the server, initialise its contents locally too to avoid the need to
download it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c             |  2 ++
 fs/afs/inode.c           | 44 ++++++++++++++++++++++++++++++++++------
 fs/afs/internal.h        |  1 +
 fs/netfs/buffered_read.c |  2 +-
 fs/netfs/read_single.c   |  2 +-
 5 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 6a4fc1cffb7e..663a212964d8 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1270,6 +1270,8 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 	set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	if (S_ISDIR(inode->i_mode))
 		afs_mkdir_init_dir(vnode, dvp->vnode);
+	else if (S_ISLNK(inode->i_mode))
+		afs_init_new_symlink(vnode, op);
 	if (!afs_op_error(op))
 		afs_cache_permit(vnode, op->key, vnode->cb_break, &vp->scb);
 	d_instantiate(op->dentry, inode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index c3b720fda525..f5618564b3fc 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -25,6 +25,23 @@
 #include "internal.h"
 #include "afs_fs.h"
 
+void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation *op)
+{
+	size_t size = strlen(op->create.symlink) + 1;
+	size_t dsize = 0;
+	char *p;
+
+	if (netfs_alloc_folioq_buffer(NULL, &vnode->directory, &dsize, size,
+				      mapping_gfp_mask(vnode->netfs.inode.i_mapping)) < 0)
+		return;
+
+	vnode->directory_size = dsize;
+	p = kmap_local_folio(folioq_folio(vnode->directory, 0), 0);
+	memcpy(p, op->create.symlink, size);
+	kunmap_local(p);
+	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
+}
+
 static void afs_put_link(void *arg)
 {
 	struct folio *folio = virt_to_folio(arg);
@@ -41,15 +58,30 @@ const char *afs_get_link(struct dentry *dentry, struct inode *inode,
 	char *content;
 	ssize_t ret;
 
-	if (atomic64_read(&vnode->cb_expires_at) == AFS_NO_CB_PROMISE ||
-	    !vnode->directory) {
-		if (!dentry)
+	if (!dentry) {
+		/* RCU pathwalk. */
+		if (!vnode->directory || !afs_check_validity(vnode))
 			return ERR_PTR(-ECHILD);
-		ret = afs_read_single(vnode, NULL);
-		if (ret < 0)
-			return ERR_PTR(ret);
+		goto good;
 	}
 
+	if (!vnode->directory)
+		goto fetch;
+
+	ret = afs_validate(vnode, NULL);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (!test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags) &&
+	    vnode->directory)
+		goto good;
+
+fetch:
+	ret = afs_read_single(vnode, NULL);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+good:
 	folio = folioq_folio(vnode->directory, 0);
 	folio_get(folio);
 	content = kmap_local_folio(folio, 0);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 8a2daa75b095..a5da0dd8e9cc 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1220,6 +1220,7 @@ extern void afs_fs_probe_cleanup(struct afs_net *);
  */
 extern const struct afs_operation_ops afs_fetch_status_operation;
 
+void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation *op);
 const char *afs_get_link(struct dentry *dentry, struct inode *inode,
 			 struct delayed_call *callback);
 int afs_readlink(struct dentry *dentry, char __user *buffer, int buflen);
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7036e9f12b07..65d9dd71f65d 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -210,7 +210,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 
 	do {
 		struct netfs_io_subrequest *subreq;
-		enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
+		enum netfs_io_source source = NETFS_SOURCE_UNKNOWN;
 		ssize_t slice;
 
 		subreq = netfs_alloc_subrequest(rreq);
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 14bc61107182..fea0ecdecc53 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -97,7 +97,7 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 	if (!subreq)
 		return -ENOMEM;
 
-	subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
+	subreq->source	= NETFS_SOURCE_UNKNOWN;
 	subreq->start	= 0;
 	subreq->len	= rreq->len;
 	subreq->io_iter	= rreq->buffer.iter;


