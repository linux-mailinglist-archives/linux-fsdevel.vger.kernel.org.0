Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D156F614F71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 17:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiKAQeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 12:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKAQcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4102B1CFF8
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667320312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X51EyFUvOmEvcZccdqS2/I+LfY9L6+1ziyD7WILqxHo=;
        b=Q/BChjW5f5kGMkAAD6K30bPlnVkQxhSszSN1tYWnXBlAJCqCMqyiqn6z98j6heIPH1CTIT
        PdiC/PMz7eE0fu2upA0a5D8SOeKztmJVtE5MhbUpT3TBHLJ1fCAdWhUUQQ66HD+eK32zHa
        y7SQ9wirqDidzw3qyRcVHiE9Tk4wCCE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-yLBm5npaO76JS2HvgMrwtg-1; Tue, 01 Nov 2022 12:31:46 -0400
X-MC-Unique: yLBm5npaO76JS2HvgMrwtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DB283C138A6;
        Tue,  1 Nov 2022 16:31:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53884EA5D;
        Tue,  1 Nov 2022 16:31:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 08/12] cifs: Add some helper functions
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Nov 2022 16:31:43 +0000
Message-ID: <166732030314.3186319.9209944805565413627.stgit@warthog.procyon.org.uk>
In-Reply-To: <166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk>
References: <166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---

 fs/cifs/cifsfs.h |    3 ++
 fs/cifs/file.c   |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index c0b5e861771f..dad77b2ed7c5 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -113,6 +113,9 @@ extern int cifs_file_strict_mmap(struct file * , struct vm_area_struct *);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_dir_open(struct inode *inode, struct file *file);
 extern int cifs_readdir(struct file *file, struct dir_context *ctx);
+extern void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len);
+extern void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len);
+extern void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len);
 
 /* Functions related to dir entries */
 extern const struct dentry_operations cifs_dentry_ops;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index cd72736c19a6..481656aaae23 100644
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


