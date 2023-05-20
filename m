Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9687970A3C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 02:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjETADo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 20:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjETAD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 20:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1658BE40
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684540902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0untNcr1icklU0hwhU0ty94Xf23B/VjszjVy/DS5Ow=;
        b=aJG+5rVDzdMpr6tY+Nf/tbIrSd0FFknSSsCWVcK3/nm8tVlloY0EXJtj2QMJBrEdJMcyEj
        zEBdg0vfCDBI6drfVH/AkQIf+0ws4ea4bEKq3ehQdML6eJDX5TL7CTeuWxA1QktGjFlDTt
        /XgfGYy0WRjXjX23DjaUiALkt4xdi4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-ZoV9UQXCOsyihBFlh8yZBw-1; Fri, 19 May 2023 20:01:39 -0400
X-MC-Unique: ZoV9UQXCOsyihBFlh8yZBw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C79A38032FA;
        Sat, 20 May 2023 00:01:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0872492B0A;
        Sat, 20 May 2023 00:01:34 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev
Subject: [PATCH v21 14/30] 9p:  Add splice_read stub
Date:   Sat, 20 May 2023 01:00:33 +0100
Message-Id: <20230520000049.2226926-15-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a splice_read stub for 9p.  We should use copy_splice_read() if
9PL_DIRECT is set and filemap_splice_read() otherwise.  Note that this
doesn't seem to be particularly related to O_DIRECT.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/9p/vfs_file.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 6c31b8c8112d..2996fb00387f 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -374,6 +374,28 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+/*
+ * v9fs_file_splice_read - splice-read from a file
+ * @in: The 9p file to read from
+ * @ppos: Where to find/update the file position
+ * @pipe: The pipe to splice into
+ * @len: The maximum amount of data to splice
+ * @flags: SPLICE_F_* flags
+ */
+static ssize_t v9fs_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags)
+{
+	struct p9_fid *fid = in->private_data;
+
+	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
+		 fid->fid, len, *ppos);
+
+	if (fid->mode & P9L_DIRECT)
+		return copy_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
 /**
  * v9fs_file_write_iter - write to a file
  * @iocb: The operation parameters
@@ -569,7 +591,7 @@ const struct file_operations v9fs_file_operations = {
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock,
 	.mmap = generic_file_readonly_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
 };
@@ -583,7 +605,7 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.lock = v9fs_file_lock_dotl,
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
 };

