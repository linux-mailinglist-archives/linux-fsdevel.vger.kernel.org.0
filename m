Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73969535E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 12:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350997AbiE0Kpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351106AbiE0KpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 06:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1FC712AB3E
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653648290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QyGPhoteRB66pPS/Qe92E/99kN2ZDUg4LmKXSkDegYg=;
        b=GCo5r43WlJ9XeVZ2ARSuNpWe3z3NFWgbxNTO3+iC21xMSvlHIWIoCKNEh6/x78NeHN/hnC
        bKYl7ibcRAgpqZc4NNISQqX/rCNdO3itg7r36k8wrxt2RunhEYegMoH3OfpXTH5/t4AvFK
        bJFOAeaXzowAlB3v4+jRlcKrBUfnWhs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-q268ok7bNTO52vJujFo73Q-1; Fri, 27 May 2022 06:44:48 -0400
X-MC-Unique: q268ok7bNTO52vJujFo73Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3132C18A6523;
        Fri, 27 May 2022 10:44:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4B2A2026D64;
        Fri, 27 May 2022 10:44:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 7/9] cifs: Trace writedata page wrangling
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 May 2022 11:44:46 +0100
Message-ID: <165364828612.3334034.9708930432198654847.stgit@warthog.procyon.org.uk>
In-Reply-To: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
References: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/cifs/cifsfs.h   |    9 +++++--
 fs/cifs/cifsglob.h |    1 +
 fs/cifs/cifssmb.c  |   46 ++++++++++++++++++++++++++++++------
 fs/cifs/file.c     |    9 +++++--
 fs/cifs/trace.h    |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 14 deletions(-)

diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 34ad965cde21..51905a999f92 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -110,9 +110,12 @@ extern int cifs_file_strict_mmap(struct file * , struct vm_area_struct *);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_dir_open(struct inode *inode, struct file *file);
 extern int cifs_readdir(struct file *file, struct dir_context *ctx);
-extern void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len);
-extern void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len);
-extern void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len);
+extern void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len,
+				    unsigned int wdata_debug_id);
+extern void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len,
+				    unsigned int wdata_debug_id);
+extern void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len,
+				     unsigned int wdata_debug_id);
 
 /* Functions related to dir entries */
 extern const struct dentry_operations cifs_dentry_ops;
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 06e0dd2c408d..9b39f920d5a0 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1351,6 +1351,7 @@ struct cifs_writedata {
 	pid_t				pid;
 	unsigned int			bytes;
 	int				result;
+	unsigned int			debug_id;
 	struct TCP_Server_Info		*server;
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	struct smbd_mr			*mr;
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 865fb679cbee..fbb9ae267757 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1959,7 +1959,8 @@ static void cifs_undirty_folios(struct inode *inode, loff_t start, unsigned int
 /*
  * Completion of write to server.
  */
-void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len)
+void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len,
+			     unsigned int wdata_debug_id)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
@@ -1970,11 +1971,14 @@ void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len
 	if (!len)
 		return;
 
+	trace_smb3_pages_written_back(inode, start, len, 0, wdata_debug_id);
+
 	rcu_read_lock();
 
 	end = (start + len - 1) / PAGE_SIZE;
 	xas_for_each(&xas, folio, end) {
 		if (!folio_test_writeback(folio)) {
+			trace_smb3_pages_write_bad(inode, start, len, 0, wdata_debug_id);
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
 				  len, start, folio_index(folio), end);
 			continue;
@@ -1990,7 +1994,8 @@ void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len
 /*
  * Failure of write to server.
  */
-void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len)
+void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len,
+			     unsigned int wdata_debug_id)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
@@ -2001,11 +2006,14 @@ void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len
 	if (!len)
 		return;
 
+	trace_smb3_pages_write_failed(inode, start, len, 0, wdata_debug_id);
+
 	rcu_read_lock();
 
 	end = (start + len - 1) / PAGE_SIZE;
 	xas_for_each(&xas, folio, end) {
 		if (!folio_test_writeback(folio)) {
+			trace_smb3_pages_write_bad(inode, start, len, 0, wdata_debug_id);
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
 				  len, start, folio_index(folio), end);
 			continue;
@@ -2021,7 +2029,8 @@ void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len
 /*
  * Redirty pages after a temporary failure.
  */
-void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len)
+void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len,
+			      unsigned int wdata_debug_id)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
@@ -2032,11 +2041,14 @@ void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int le
 	if (!len)
 		return;
 
+	trace_smb3_pages_write_redirty(inode, start, len, 0, wdata_debug_id);
+
 	rcu_read_lock();
 
 	end = (start + len - 1) / PAGE_SIZE;
 	xas_for_each(&xas, folio, end) {
 		if (!folio_test_writeback(folio)) {
+			trace_smb3_pages_write_bad(inode, start, len, 0, wdata_debug_id);
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
 				  len, start, folio_index(folio), end);
 			continue;
@@ -2109,10 +2121,17 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 				rc = -EBADF;
 		} else {
 			wdata2->pid = wdata2->cfile->pid;
+
+			trace_smb3_pages_write_requeue(inode, fpos, cur_len,
+						       wdata->debug_id,
+						       wdata2->debug_id);
 			rc = server->ops->async_writev(wdata2,
 						       cifs_writedata_release);
 		}
 
+		trace_smb3_pages_write_done(inode, wdata->offset, wdata->bytes,
+					    rc, wdata2->debug_id);
+
 		kref_put(&wdata2->refcount, cifs_writedata_release);
 		if (rc) {
 			if (is_retryable_error(rc))
@@ -2127,8 +2146,10 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 	} while (rest_len > 0);
 
 	/* Clean up remaining pages from the original wdata */
-	if (iov_iter_is_xarray(&wdata->iter))
-		cifs_pages_write_failed(inode, fpos, rest_len);
+	if (iov_iter_is_xarray(&wdata->iter)) {
+		trace_smb3_pages_write_cleanup(inode, fpos, rest_len, rc, wdata->debug_id);
+		cifs_pages_write_failed(inode, fpos, rest_len, wdata->debug_id);
+	}
 
 	if (rc != 0 && !is_retryable_error(rc))
 		mapping_set_error(inode->i_mapping, rc);
@@ -2142,6 +2163,9 @@ cifs_writev_complete(struct work_struct *work)
 						struct cifs_writedata, work);
 	struct inode *inode = d_inode(wdata->cfile->dentry);
 
+	trace_smb3_pages_writev_complete(inode, wdata->offset, wdata->bytes, wdata->result,
+					 wdata->debug_id);
+
 	if (wdata->result == 0) {
 		spin_lock(&inode->i_lock);
 		cifs_update_eof(CIFS_I(inode), wdata->offset, wdata->bytes);
@@ -2151,18 +2175,23 @@ cifs_writev_complete(struct work_struct *work)
 	} else if (wdata->sync_mode == WB_SYNC_ALL && wdata->result == -EAGAIN)
 		return cifs_writev_requeue(wdata);
 
+
+	trace_smb3_pages_write_complete(inode, wdata->offset, wdata->bytes,
+					wdata->result, wdata->debug_id);
 	if (wdata->result == -EAGAIN)
-		cifs_pages_write_redirty(inode, wdata->offset, wdata->bytes);
+		cifs_pages_write_redirty(inode, wdata->offset, wdata->bytes, wdata->debug_id);
 	else if (wdata->result < 0)
-		cifs_pages_write_failed(inode, wdata->offset, wdata->bytes);
+		cifs_pages_write_failed(inode, wdata->offset, wdata->bytes, wdata->debug_id);
 	else
-		cifs_pages_written_back(inode, wdata->offset, wdata->bytes);
+		cifs_pages_written_back(inode, wdata->offset, wdata->bytes, wdata->debug_id);
 
 	if (wdata->result != -EAGAIN)
 		mapping_set_error(inode->i_mapping, wdata->result);
 	kref_put(&wdata->refcount, cifs_writedata_release);
 }
 
+static atomic_t cifs_writedata_debug_counter;
+
 struct cifs_writedata *
 cifs_writedata_alloc(work_func_t complete)
 {
@@ -2174,6 +2203,7 @@ cifs_writedata_alloc(work_func_t complete)
 		INIT_LIST_HEAD(&wdata->list);
 		init_completion(&wdata->done);
 		INIT_WORK(&wdata->work, complete);
+		wdata->debug_id = atomic_inc_return(&cifs_writedata_debug_counter);
 	}
 	return wdata;
 }
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index e72059e002f2..881065e38a0b 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2467,6 +2467,7 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 		if (rc)
 			goto err_wdata;
 
+		trace_smb3_pages_write_back(inode, start, len, 0, wdata->debug_id);
 		if (wdata->cfile->invalidHandle)
 			rc = -EAGAIN;
 		else
@@ -2478,7 +2479,8 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 		}
 	} else {
 		/* The dirty region was entirely beyond the EOF. */
-		cifs_pages_written_back(inode, start, len);
+		trace_smb3_pages_write_beyond(inode, start, len, rc, wdata->debug_id);
+		cifs_pages_written_back(inode, start, len, wdata->debug_id);
 		rc = 0;
 	}
 
@@ -2491,12 +2493,13 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 		cifsFileInfo_put(cfile);
 err_xid:
 	free_xid(xid);
+	trace_smb3_pages_write_end(inode, start, len, rc, wdata->debug_id);
 	if (rc == 0) {
 		wbc->nr_to_write = count;
 	} else if (is_retryable_error(rc)) {
-		cifs_pages_write_redirty(inode, start, len);
+		cifs_pages_write_redirty(inode, start, len, wdata->debug_id);
 	} else {
-		cifs_pages_write_failed(inode, start, len);
+		cifs_pages_write_failed(inode, start, len, wdata->debug_id);
 		mapping_set_error(mapping, rc);
 	}
 	/* Indication to update ctime and mtime as close is deferred */
diff --git a/fs/cifs/trace.h b/fs/cifs/trace.h
index bc279616c513..d73d3093b67b 100644
--- a/fs/cifs/trace.h
+++ b/fs/cifs/trace.h
@@ -1015,6 +1015,72 @@ DEFINE_SMB3_CREDIT_EVENT(waitff_credits);
 DEFINE_SMB3_CREDIT_EVENT(overflow_credits);
 DEFINE_SMB3_CREDIT_EVENT(set_credits);
 
+DECLARE_EVENT_CLASS(smb3_pages_written_class,
+	TP_PROTO(struct inode *inode, loff_t start, unsigned int len, int rc,
+		 unsigned int wdata_debug_id),
+	TP_ARGS(inode, start, len, rc, wdata_debug_id),
+	TP_STRUCT__entry(
+		__field(__u64, ino)
+		__field(__u64, start)
+		__field(__u32, len)
+		__field(int, rc)
+		__field(unsigned int, wdata_debug_id)
+	),
+	TP_fast_assign(
+		__entry->wdata_debug_id = wdata_debug_id;
+		__entry->ino = inode->i_ino;
+		__entry->start = start;
+		__entry->len = len;
+		__entry->rc = rc;
+	),
+	TP_printk("W=%x ino=%llx %llx-%llx rc=%d",
+		  __entry->wdata_debug_id, __entry->ino,
+		  __entry->start, __entry->start + __entry->len,
+		  __entry->rc)
+)
+
+#define DEFINE_SMB3_PAGES_WRITTEN_EVENT(name)          \
+DEFINE_EVENT(smb3_pages_written_class, smb3_##name,    \
+	TP_PROTO(struct inode *inode, loff_t start, unsigned int len, int rc, \
+		 unsigned int wdata_debug_id), \
+	TP_ARGS(inode, start, len, rc, wdata_debug_id))
+
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_back);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_bad);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_beyond);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_complete);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_cleanup);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_done);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_end);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_failed);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_write_redirty);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_writev_complete);
+DEFINE_SMB3_PAGES_WRITTEN_EVENT(pages_written_back);
+
+TRACE_EVENT(smb3_pages_write_requeue,
+	TP_PROTO(struct inode *inode, loff_t start, unsigned int len,
+		 unsigned int wdata_debug_id, unsigned int wdata_debug_id2),
+	TP_ARGS(inode, start, len, wdata_debug_id, wdata_debug_id2),
+	TP_STRUCT__entry(
+		__field(__u64, ino)
+		__field(__u64, start)
+		__field(__u32, len)
+		__field(unsigned int, wdata_debug_id)
+		__field(unsigned int, wdata_debug_id2)
+	),
+	TP_fast_assign(
+		__entry->wdata_debug_id = wdata_debug_id;
+		__entry->wdata_debug_id2 = wdata_debug_id2;
+		__entry->ino = inode->i_ino;
+		__entry->start = start;
+		__entry->len = len;
+	),
+	TP_printk("W=%x ino=%llx %llx-%llx NW=%x",
+		  __entry->wdata_debug_id, __entry->ino,
+		  __entry->start, __entry->start + __entry->len,
+		  __entry->wdata_debug_id2)
+)
+
 #endif /* _CIFS_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


