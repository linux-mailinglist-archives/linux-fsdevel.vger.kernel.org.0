Return-Path: <linux-fsdevel+bounces-34034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370379C2326
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF79828395B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622421FD92;
	Fri,  8 Nov 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZW0MyjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E421F4CF
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087197; cv=none; b=HcnIjcU+Rz07sYgg3n079a6L2dtE96xprbqH+cRqyKSa5Iw8hof881Mc4pjdpKwrKvdZcS51DAlM3dZrYxVaFLcg0qV91crpF9DHJF0/LMWl4Mvdt8BMFGQm8vGABKV0OVo/5aaqtfLoCv2udu8glqDkE3ahF6JsNFCWnZGx5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087197; c=relaxed/simple;
	bh=IB2Hra3PbQqimrEPUTwV6xl6xpFuitl8Oqr5TkFFgbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqbyEbPsPYYmofACldUBXCdiuGM2nRft6JTnBXAzDY1zvju64GUlPdr+Oo64nQYArGS2f3ylGwGbquhxaWQ252ZvedcxsoaSaIkqmjYXYMii40EVqHVtWLjzbysY1m0NhhbUC4GZc82qmm9NbE/jqw+P75hPXEYLAPvK40vblOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZW0MyjA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRktXy0njOtGduc146rNPLaeznRZ8wjmjmNrqe7WMw8=;
	b=MZW0MyjAOBaH+dKX85Qhe+Vx5NlqkshlAhUnWr1SK3r35ekdtj3uUcs58tMPEUO8HhL+sc
	+nS1Jv9Yc3P42WnmnMMMbSvsyuwNE1eUmjfknBob1O8h7BVWg9YO7nZXoRnzKeynjrTMaT
	tLDSRZBfh5eB3xZHTeTj4NvRIywNesY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-uCukTaVKP9aVL2dtzxjKJg-1; Fri,
 08 Nov 2024 12:33:11 -0500
X-MC-Unique: uCukTaVKP9aVL2dtzxjKJg-1
X-Mimecast-MFC-AGG-ID: uCukTaVKP9aVL2dtzxjKJg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4876819540F1;
	Fri,  8 Nov 2024 17:33:08 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7704E300019E;
	Fri,  8 Nov 2024 17:33:02 +0000 (UTC)
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
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 03/33] netfs: Fix a few minor bugs in netfs_page_mkwrite()
Date: Fri,  8 Nov 2024 17:32:04 +0000
Message-ID: <20241108173236.1382366-4-dhowells@redhat.com>
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We can't return with VM_FAULT_SIGBUS | VM_FAULT_LOCKED; the core
code will not unlock the folio in this instance.  Introduce a new
"unlock" error exit to handle this case.  Use it to handle
the "folio is truncated" check, and change the "writeback interrupted
by a fatal signal" to do a NOPAGE exit instead of letting the core
code install the folio currently under writeback before killing the
process.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20241005182307.3190401-3-willy@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/netfs/buffered_write.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b3910dfcb56d..ff2814da88b1 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -491,7 +491,9 @@ EXPORT_SYMBOL(netfs_file_write_iter);
 
 /*
  * Notification that a previously read-only page is about to become writable.
- * Note that the caller indicates a single page of a multipage folio.
+ * The caller indicates the precise page that needs to be written to, but
+ * we only track group on a per-folio basis, so we block more often than
+ * we might otherwise.
  */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
 {
@@ -501,7 +503,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = file_inode(file);
 	struct netfs_inode *ictx = netfs_inode(inode);
-	vm_fault_t ret = VM_FAULT_RETRY;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	int err;
 
 	_enter("%lx", folio->index);
@@ -510,21 +512,15 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (folio_lock_killable(folio) < 0)
 		goto out;
-	if (folio->mapping != mapping) {
-		folio_unlock(folio);
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
-	if (folio_wait_writeback_killable(folio)) {
-		ret = VM_FAULT_LOCKED;
-		goto out;
-	}
+	if (folio->mapping != mapping)
+		goto unlock;
+	if (folio_wait_writeback_killable(folio) < 0)
+		goto unlock;
 
 	/* Can we see a streaming write here? */
 	if (WARN_ON(!folio_test_uptodate(folio))) {
-		ret = VM_FAULT_SIGBUS | VM_FAULT_LOCKED;
-		goto out;
+		ret = VM_FAULT_SIGBUS;
+		goto unlock;
 	}
 
 	group = netfs_folio_group(folio);
@@ -559,5 +555,8 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 out:
 	sb_end_pagefault(inode->i_sb);
 	return ret;
+unlock:
+	folio_unlock(folio);
+	goto out;
 }
 EXPORT_SYMBOL(netfs_page_mkwrite);


