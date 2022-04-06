Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15EB4F6E2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiDFXFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiDFXE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E29DF32BF
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdY7fXraB+kYCaafZemuyrgRrpIvDIqLb0inRFdnagc=;
        b=eo9+AEOzwKngKZnZXRN2ZdxyD+KvfRyt70I8S9sFC/+1JLSuAzZ51oQ0dTBTnAJSX3uT3x
        HSHGGIMXOXsKhy5N3FTut84w6ffotBsyB+dRMA6GEym/HKc0KwmETCk4s8QKZF37dcYTA0
        JXsHL06HAT1lpd3upsLbu2e468I/HiE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-53uIWRzFO6qrdoNzavT4tw-1; Wed, 06 Apr 2022 19:02:57 -0400
X-MC-Unique: 53uIWRzFO6qrdoNzavT4tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3F6D1C05ED9;
        Wed,  6 Apr 2022 23:02:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E54E145BA41;
        Wed,  6 Apr 2022 23:02:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/14] cifs: Add some helper functions
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@redhat.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 07 Apr 2022 00:02:45 +0100
Message-ID: <164928616583.457102.15157033997163988344.stgit@warthog.procyon.org.uk>
In-Reply-To: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 15a5c5db038b..1c77bbc0815f 100644
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


