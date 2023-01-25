Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9167BF11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 22:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjAYVsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 16:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjAYVrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524C58971
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 13:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674683171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aefve6Ka+D1DY08qo11GFYpZjNndB8+EcNsEcGovUCk=;
        b=W27CwAw3oe+qm/2P28Y0/FQ8z5hm2p8dirDFhjBqLv20VhYquCLVWdI35EWflvGekTi/Lo
        7f8v991xvDAcmPnIjkEptRgYABatugmy3CxX2USmylWVOM3SZdbTG5hBVOXU3Mi37PJW03
        Ag9aX2Cj7MG95qloKce0TYRzxGnnXE0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-pGqFahG-M4mSx0kqAzIipg-1; Wed, 25 Jan 2023 16:46:06 -0500
X-MC-Unique: pGqFahG-M4mSx0kqAzIipg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCC4F85CBE3;
        Wed, 25 Jan 2023 21:46:05 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03DB74014CE2;
        Wed, 25 Jan 2023 21:46:03 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: [RFC 07/13] cifs: Add some helper functions
Date:   Wed, 25 Jan 2023 21:45:37 +0000
Message-Id: <20230125214543.2337639-8-dhowells@redhat.com>
In-Reply-To: <20230125214543.2337639-1-dhowells@redhat.com>
References: <20230125214543.2337639-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some helper functions to manipulate the folio marks by iterating
through a list of folios held in an xarray rather than using a page list.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org

Link: https://lore.kernel.org/r/164928616583.457102.15157033997163988344.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165211418840.3154751.3090684430628501879.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165348878940.2106726.204291614267188735.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165364825674.3334034.3356201708659748648.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/166126394799.708021.10637797063862600488.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/166697258147.61150.9940790486999562110.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732030314.3186319.9209944805565413627.stgit@warthog.procyon.org.uk/ # rfc
---
 fs/cifs/cifsfs.h |  3 ++
 fs/cifs/file.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 25decebbc478..ea628da503c6 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -113,6 +113,9 @@ extern int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_dir_open(struct inode *inode, struct file *file);
 extern int cifs_readdir(struct file *file, struct dir_context *ctx);
+extern void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len);
+extern void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len);
+extern void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len);
 
 /* Functions related to dir entries */
 extern const struct dentry_operations cifs_dentry_ops;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 30d01b236f77..74097ac5a32c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -36,6 +36,99 @@
 #include "cifs_ioctl.h"
 #include "cached_dir.h"
 
+/*
+ * Completion of write to server.
+ */
+void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio;
+	pgoff_t end;
+
+	XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
+
+	if (!len)
+		return;
+
+	rcu_read_lock();
+
+	end = (start + len - 1) / PAGE_SIZE;
+	xas_for_each(&xas, folio, end) {
+		if (!folio_test_writeback(folio)) {
+			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
+				  len, start, folio_index(folio), end);
+			continue;
+		}
+
+		folio_detach_private(folio);
+		folio_end_writeback(folio);
+	}
+
+	rcu_read_unlock();
+}
+
+/*
+ * Failure of write to server.
+ */
+void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio;
+	pgoff_t end;
+
+	XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
+
+	if (!len)
+		return;
+
+	rcu_read_lock();
+
+	end = (start + len - 1) / PAGE_SIZE;
+	xas_for_each(&xas, folio, end) {
+		if (!folio_test_writeback(folio)) {
+			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
+				  len, start, folio_index(folio), end);
+			continue;
+		}
+
+		folio_set_error(folio);
+		folio_end_writeback(folio);
+	}
+
+	rcu_read_unlock();
+}
+
+/*
+ * Redirty pages after a temporary failure.
+ */
+void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio;
+	pgoff_t end;
+
+	XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
+
+	if (!len)
+		return;
+
+	rcu_read_lock();
+
+	end = (start + len - 1) / PAGE_SIZE;
+	xas_for_each(&xas, folio, end) {
+		if (!folio_test_writeback(folio)) {
+			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
+				  len, start, folio_index(folio), end);
+			continue;
+		}
+
+		filemap_dirty_folio(folio->mapping, folio);
+		folio_end_writeback(folio);
+	}
+
+	rcu_read_unlock();
+}
+
 /*
  * Mark as invalid, all open files on tree connections since they
  * were closed when session to server was lost.

