Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DCD7090BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjESHo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjESHni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805291BE3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBG1rbAQ+/pvrFxoUU2GMJeglrqrT3cq++hcE5SQo7w=;
        b=CFt+2DycfciG3nF8c0dAhbWx5yocJxx1ASm7O3bCfvbbZXHcd1tv4YA1pRvr9qTHe4yr20
        5DlnOFbRy1KHntJeB2ZKKzXruMRhQjrw4Iwog8zoD7BEzCS7e2/T3vFTugBAXuN/v2asrH
        2iA0pwEbX8OmJze83Sq6ee6Z3n6jDQw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-_MfV9O_bPYGXDbkMXz1GRA-1; Fri, 19 May 2023 03:42:06 -0400
X-MC-Unique: _MfV9O_bPYGXDbkMXz1GRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0AF585A5BA;
        Fri, 19 May 2023 07:42:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 505E5C0004B;
        Fri, 19 May 2023 07:42:03 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH v20 19/32] ocfs2: Provide a splice-read stub
Date:   Fri, 19 May 2023 08:40:34 +0100
Message-Id: <20230519074047.1739879-20-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read stub for ocfs2.  This emits trace lines and does an
atime lock/update before calling filemap_splice_read().  It doesn't do this
for around direct_splice_read() as that will call ->read_iter().

A couple of new tracepoints are added for this purpose.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Mark Fasheh <mark@fasheh.com>
cc: Joel Becker <jlbec@evilplan.org>
cc: Joseph Qi <joseph.qi@linux.alibaba.com>
cc: ocfs2-devel@oss.oracle.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ocfs2/file.c        | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/ocfs2/ocfs2_trace.h |  3 +++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index efb09de4343d..27c54a71ec57 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2581,6 +2581,46 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 	return ret;
 }
 
+static ssize_t ocfs2_file_splice_read(struct file *in, loff_t *ppos,
+				      struct pipe_inode_info *pipe,
+				      size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	ssize_t ret = 0;
+	int lock_level = 0;
+
+	trace_ocfs2_file_splice_read(inode, in, in->f_path.dentry,
+				     (unsigned long long)OCFS2_I(inode)->ip_blkno,
+				     in->f_path.dentry->d_name.len,
+				     in->f_path.dentry->d_name.name,
+				     0);
+
+	if (in->f_flags & O_DIRECT)
+		return direct_splice_read(in, ppos, pipe, len, flags);
+
+	/*
+	 * We're fine letting folks race truncates and extending writes with
+	 * read across the cluster, just like they can locally.  Hence no
+	 * rw_lock during read.
+	 *
+	 * Take and drop the meta data lock to update inode fields like i_size.
+	 * This allows the checks down below generic_file_splice_read() a
+	 * chance of actually working.
+	 */
+	ret = ocfs2_inode_lock_atime(inode, in->f_path.mnt, &lock_level, true);
+	if (ret < 0) {
+		if (ret != -EAGAIN)
+			mlog_errno(ret);
+		goto bail;
+	}
+	ocfs2_inode_unlock(inode, lock_level);
+
+	ret = filemap_splice_read(in, ppos, pipe, len, flags);
+	trace_filemap_splice_read_ret(ret);
+bail:
+	return ret;
+}
+
 /* Refer generic_file_llseek_unlocked() */
 static loff_t ocfs2_file_llseek(struct file *file, loff_t offset, int whence)
 {
@@ -2744,7 +2784,7 @@ const struct file_operations ocfs2_fops = {
 #endif
 	.lock		= ocfs2_lock,
 	.flock		= ocfs2_flock,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= ocfs2_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ocfs2_fallocate,
 	.remap_file_range = ocfs2_remap_file_range,
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index dc4bce1649c1..b8c3d1702076 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -1319,6 +1319,8 @@ DEFINE_OCFS2_FILE_OPS(ocfs2_file_splice_write);
 
 DEFINE_OCFS2_FILE_OPS(ocfs2_file_read_iter);
 
+DEFINE_OCFS2_FILE_OPS(ocfs2_file_splice_read);
+
 DEFINE_OCFS2_ULL_ULL_ULL_EVENT(ocfs2_truncate_file);
 
 DEFINE_OCFS2_ULL_ULL_EVENT(ocfs2_truncate_file_error);
@@ -1470,6 +1472,7 @@ TRACE_EVENT(ocfs2_prepare_inode_for_write,
 );
 
 DEFINE_OCFS2_INT_EVENT(generic_file_read_iter_ret);
+DEFINE_OCFS2_INT_EVENT(filemap_splice_read_ret);
 
 /* End of trace events for fs/ocfs2/file.c. */
 

