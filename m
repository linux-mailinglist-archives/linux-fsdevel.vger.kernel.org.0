Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177F37090B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjESHni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjESHm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D2E1988
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ul54+Rfc7Xx/QmGKIvy0/Dk3iAPI5N6ujIbh8BdRPD4=;
        b=HiLXH2w/J6GJO7yspHtXh0S8gCvRl46viQMs553NF906U3NabFJziO0y/j+mY0wFV7qAxA
        AOQis/Xown6hVKXFhnGrs833klEYLrI5hqfEaz7l0e4CfLF7D3csRIsyzuP2E23/K269pO
        Hz0pWe6cMnlitmsBR8rLh92wve5q9y0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-yZVFR8FJO82q_4bbCE1uzg-1; Fri, 19 May 2023 03:41:46 -0400
X-MC-Unique: yZVFR8FJO82q_4bbCE1uzg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B75B6185A78E;
        Fri, 19 May 2023 07:41:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D4D04F2DDE;
        Fri, 19 May 2023 07:41:43 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Subject: [PATCH v20 13/32] ceph: Provide a splice-read stub
Date:   Fri, 19 May 2023 08:40:28 +0100
Message-Id: <20230519074047.1739879-14-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
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

Provide a splice_read stub for Ceph.  This does the inode shutdown check
before proceeding and jumps to direct_splice_read() if O_DIRECT is set, the
file has inline data or is a synchronous file.

We try and get FILE_RD and either FILE_CACHE and/or FILE_LAZYIO caps and
hold them across filemap_splice_read().  If we fail to get FILE_CACHE or
FILE_LAZYIO capabilities, we use direct_splice_read() instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Xiubo Li <xiubli@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ceph/file.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f4d8bf7dec88..382dd5901748 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1745,6 +1745,70 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+/*
+ * Wrap filemap_splice_read with checks for cap bits on the inode.
+ * Atomically grab references, so that those bits are not released
+ * back to the MDS mid-read.
+ */
+static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
+				struct pipe_inode_info *pipe,
+				size_t len, unsigned int flags)
+{
+	struct ceph_file_info *fi = in->private_data;
+	struct inode *inode = file_inode(in);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	ssize_t ret;
+	int want = 0, got = 0;
+	CEPH_DEFINE_RW_CONTEXT(rw_ctx, 0);
+
+	dout("splice_read %p %llx.%llx %llu~%zu trying to get caps on %p\n",
+	     inode, ceph_vinop(inode), *ppos, len, inode);
+
+	if (ceph_inode_is_shutdown(inode))
+		return -ESTALE;
+
+	if ((in->f_flags & O_DIRECT) ||
+	    ceph_has_inline_data(ci) ||
+	    (fi->flags & CEPH_F_SYNC))
+		return direct_splice_read(in, ppos, pipe, len, flags);
+
+	ceph_start_io_read(inode);
+
+	want = CEPH_CAP_FILE_CACHE;
+	if (fi->fmode & CEPH_FILE_MODE_LAZY)
+		want |= CEPH_CAP_FILE_LAZYIO;
+
+	ret = ceph_get_caps(in, CEPH_CAP_FILE_RD, want, -1, &got);
+	if (ret < 0) {
+		ceph_end_io_read(inode);
+		return ret;
+	}
+
+	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) == 0) {
+		dout("splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
+		     inode, ceph_vinop(inode), *ppos, len,
+		     ceph_cap_string(got));
+
+		ceph_end_io_read(inode);
+		return direct_splice_read(in, ppos, pipe, len, flags);
+	}
+
+	dout("splice_read %p %llx.%llx %llu~%zu got cap refs on %s\n",
+	     inode, ceph_vinop(inode), *ppos, len, ceph_cap_string(got));
+
+	rw_ctx.caps = got;
+	ceph_add_rw_context(fi, &rw_ctx);
+	ret = filemap_splice_read(in, ppos, pipe, len, flags);
+	ceph_del_rw_context(fi, &rw_ctx);
+
+	dout("splice_read %p %llx.%llx dropping cap refs on %s = %zd\n",
+	     inode, ceph_vinop(inode), ceph_cap_string(got), ret);
+	ceph_put_cap_refs(ci, got);
+
+	ceph_end_io_read(inode);
+	return ret;
+}
+
 /*
  * Take cap references to avoid releasing caps to MDS mid-write.
  *
@@ -2593,7 +2657,7 @@ const struct file_operations ceph_file_fops = {
 	.lock = ceph_lock,
 	.setlease = simple_nosetlease,
 	.flock = ceph_flock,
-	.splice_read = generic_file_splice_read,
+	.splice_read = ceph_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl = ceph_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,

