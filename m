Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731ED52029F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiEIQki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 12:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbiEIQke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 12:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE942FD376
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652114194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvSke8qPQBT5pvEODPiuBsSWIpHLQSifRWt63HjSc0I=;
        b=EksPY+t03HTsXGI3lcAZNz2cvgIVWWjDfQhoipW1IqjFodlWscrogvY7K4CIhcC8wTbg22
        tLk+l/w8+m/ic4288PDhQOSIvYrIc68weS+Jt6jpvR/1YlBnIUkw0jQvDvcX1l6xoAkzy6
        dUt2SnOBeENWreIpb+cUKRLVLY5kWjs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-mySr6U0wP3ysm3kt_-06IA-1; Mon, 09 May 2022 12:36:31 -0400
X-MC-Unique: mySr6U0wP3ysm3kt_-06IA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 738F0100BAB2;
        Mon,  9 May 2022 16:36:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14B694643C5;
        Mon,  9 May 2022 16:36:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/6] cifs: Add some helper functions
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 May 2022 17:36:28 +0100
Message-ID: <165211418840.3154751.3090684430628501879.stgit@warthog.procyon.org.uk>
In-Reply-To: <165211416682.3154751.17287804906832979514.stgit@warthog.procyon.org.uk>
References: <165211416682.3154751.17287804906832979514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/cifsfs.h  |    3 ++
 fs/cifs/cifssmb.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index c0542bdcd06b..34ad965cde21 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -110,6 +110,9 @@ extern int cifs_file_strict_mmap(struct file * , struct vm_area_struct *);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_dir_open(struct inode *inode, struct file *file);
 extern int cifs_readdir(struct file *file, struct dir_context *ctx);
+extern void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len);
+extern void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len);
+extern void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len);
 
 /* Functions related to dir entries */
 extern const struct dentry_operations cifs_dentry_ops;
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 47e927c4ff8d..88e2de74f74f 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -27,6 +27,7 @@
 #include "cifsglob.h"
 #include "cifsacl.h"
 #include "cifsproto.h"
+#include "cifsfs.h"
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
 #include "smb2proto.h"
@@ -1928,6 +1929,90 @@ cifs_writedata_release(struct kref *refcount)
 	kfree(wdata);
 }
 
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
+	rcu_read_lock();
+
+	end = (start + len - 1) / PAGE_SIZE;
+	xas_for_each(&xas, folio, end) {
+		if (!folio_test_writeback(folio)) {
+			pr_err("bad %x @%llx page %lx %lx\n",
+			       len, start, folio_index(folio), end);
+			BUG();
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
+	rcu_read_lock();
+
+	end = (start + len - 1) / PAGE_SIZE;
+	xas_for_each(&xas, folio, end) {
+		if (!folio_test_writeback(folio)) {
+			pr_err("bad %x @%llx page %lx %lx\n",
+			       len, start, folio_index(folio), end);
+			BUG();
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
+	rcu_read_lock();
+
+	end = (start + len - 1) / PAGE_SIZE;
+	xas_for_each(&xas, folio, end) {
+		if (!folio_test_writeback(folio)) {
+			pr_err("bad %x @%llx page %lx %lx\n",
+			       len, start, folio_index(folio), end);
+			BUG();
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
  * Write failed with a retryable error. Resend the write request. It's also
  * possible that the page was redirtied so re-clean the page.


