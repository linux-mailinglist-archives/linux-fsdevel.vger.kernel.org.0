Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066670C057
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjEVNyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjEVNww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B51BE
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biWhCp40UoPe+CyS0Ztg+L+BfqL/s+IwYQGGzgJK6kA=;
        b=VWBIqExrad4G/Wc0VAU4B2XRW4IOGgMr2u+u9fLJoCRoIQWo83ow5RwXvdlRExU+gJSZNE
        IqBlYKuJkizs9qWoufM3ejIWkE3+Qm/DKlZUO3a8YuMpmpneuI7oQyhkD1lnZtB6nBlOsu
        uHzfzPB/ekHa2zc8N1dgBVshpApqdxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-pS6JrZMuO7KdRfWYxzCxgw-1; Mon, 22 May 2023 09:51:33 -0400
X-MC-Unique: pS6JrZMuO7KdRfWYxzCxgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0380C800BFF;
        Mon, 22 May 2023 13:51:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3683C1ED99;
        Mon, 22 May 2023 13:51:28 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH v22 17/31] ecryptfs: Provide a splice-read wrapper
Date:   Mon, 22 May 2023 14:50:04 +0100
Message-Id: <20230522135018.2742245-18-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read wrapper for ecryptfs to update the access time on the
lower file after the operation.  Splicing from a direct I/O fd will update
the access time when ->read_iter() is called.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Tyler Hicks <code@tyhicks.com>
cc: ecryptfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ecryptfs/file.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 268b74499c28..284395587be0 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -44,6 +44,31 @@ static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
 	return rc;
 }
 
+/*
+ * ecryptfs_splice_read_update_atime
+ *
+ * generic_file_splice_read updates the atime of upper layer inode.  But, it
+ * doesn't give us a chance to update the atime of the lower layer inode.  This
+ * function is a wrapper to generic_file_read.  It updates the atime of the
+ * lower level inode if generic_file_read returns without any errors. This is
+ * to be used only for file reads.  The function to be used for directory reads
+ * is ecryptfs_read.
+ */
+static ssize_t ecryptfs_splice_read_update_atime(struct file *in, loff_t *ppos,
+						 struct pipe_inode_info *pipe,
+						 size_t len, unsigned int flags)
+{
+	ssize_t rc;
+	const struct path *path;
+
+	rc = generic_file_splice_read(in, ppos, pipe, len, flags);
+	if (rc >= 0) {
+		path = ecryptfs_dentry_to_lower_path(in->f_path.dentry);
+		touch_atime(path);
+	}
+	return rc;
+}
+
 struct ecryptfs_getdents_callback {
 	struct dir_context ctx;
 	struct dir_context *caller;
@@ -414,5 +439,5 @@ const struct file_operations ecryptfs_main_fops = {
 	.release = ecryptfs_release,
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
-	.splice_read = generic_file_splice_read,
+	.splice_read = ecryptfs_splice_read_update_atime,
 };

