Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7881D70C06D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjEVNzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjEVNyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE861987
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTfdYshb2SEJ7i+Rhr+GK9rq0gZ3nIJZ8Q96oyv400s=;
        b=NCpiZNvfK/g2Wp6M5Wd2td/2uTMCV5f9UR1kRF9SbqG+lL0xSDuzR3N2DY72fZU9iupiDa
        7j9zXPiMbyrRVKX0nhqRvkVx3tA9wI8XnjFPOnWtU5NVRwRlEE4fU9owXscHs5k9gSMZ1P
        I6TeE00ytsNmNXF+zah9w4Nl+2pqong=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-VqXNS97OMu6rkAXf15s6Mg-1; Mon, 22 May 2023 09:51:53 -0400
X-MC-Unique: VqXNS97OMu6rkAXf15s6Mg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 684713C025AD;
        Mon, 22 May 2023 13:51:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43402400F17;
        Mon, 22 May 2023 13:51:49 +0000 (UTC)
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
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
Subject: [PATCH v22 22/31] ocfs2: Provide a splice-read wrapper
Date:   Mon, 22 May 2023 14:50:09 +0100
Message-Id: <20230522135018.2742245-23-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read wrapper for ocfs2.  This emits trace lines and does
an atime lock/update before calling filemap_splice_read().  Splicing from
direct I/O is handled by the caller.

A couple of new tracepoints are added for this purpose.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Mark Fasheh <mark@fasheh.com>
cc: Joel Becker <jlbec@evilplan.org>
cc: ocfs2-devel@oss.oracle.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #22:
     - Adjust a couple of comments mentioning generic_file_splice_read().
     - Pass 1 to ocfs2_inode_lock_atomic() rather than true.
     - Pass the splice flags into the tracepoint.

 fs/ocfs2/file.c        | 41 +++++++++++++++++++++++++++++++++++++++--
 fs/ocfs2/ocfs2_trace.h |  3 +++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index efb09de4343d..86add13b5f23 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2552,7 +2552,7 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 	 *
 	 * Take and drop the meta data lock to update inode fields
 	 * like i_size. This allows the checks down below
-	 * generic_file_read_iter() a chance of actually working.
+	 * copy_splice_read() a chance of actually working.
 	 */
 	ret = ocfs2_inode_lock_atime(inode, filp->f_path.mnt, &lock_level,
 				     !nowait);
@@ -2581,6 +2581,43 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
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
+				     flags);
+
+	/*
+	 * We're fine letting folks race truncates and extending writes with
+	 * read across the cluster, just like they can locally.  Hence no
+	 * rw_lock during read.
+	 *
+	 * Take and drop the meta data lock to update inode fields like i_size.
+	 * This allows the checks down below filemap_splice_read() a chance of
+	 * actually working.
+	 */
+	ret = ocfs2_inode_lock_atime(inode, in->f_path.mnt, &lock_level, 1);
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
@@ -2744,7 +2781,7 @@ const struct file_operations ocfs2_fops = {
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
 

