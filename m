Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6870C060
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjEVNy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjEVNxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8493E11A
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCSWlIyDBY1jtat2vRjBrfL6m1m2dv8ce4hoKBezm4c=;
        b=Ip75Hx0TpL1z7157kOCco5hfsGUAp2EE9KhQcE7uA5uCgLUqOJTFoPJ2HmELhRbKk73KSL
        +NPuMYSvpwTKoA+TWHA539HasJxutJpnzli4SXXqKH5wS3E+LGbnfd4LUc21gfUZtX2PLG
        R8IpZQOpqe0KQIF0GYa0ZL+/jk1r+4I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-ktvQdbIxMHSGBGqUdvd_JA-1; Mon, 22 May 2023 09:51:45 -0400
X-MC-Unique: ktvQdbIxMHSGBGqUdvd_JA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F0793C025AD;
        Mon, 22 May 2023 13:51:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7EBC2166B29;
        Mon, 22 May 2023 13:51:40 +0000 (UTC)
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
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH v22 20/31] nfs: Provide a splice-read wrapper
Date:   Mon, 22 May 2023 14:50:07 +0100
Message-Id: <20230522135018.2742245-21-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read wrapper for NFS.  This locks the inode around
filemap_splice_read() and revalidates the mapping.  Splicing from direct
I/O is handled by the caller.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna@kernel.org>
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #22)
     - Fix format spec in dprintk() for *ppos.
    
    ver #21)
     - Fix pos -> ppos in dprintk().

 fs/nfs/file.c     | 23 ++++++++++++++++++++++-
 fs/nfs/internal.h |  2 ++
 fs/nfs/nfs4file.c |  2 +-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f0edf5a36237..3855f3ce8d2d 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -178,6 +178,27 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 }
 EXPORT_SYMBOL_GPL(nfs_file_read);
 
+ssize_t
+nfs_file_splice_read(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe,
+		     size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	ssize_t result;
+
+	dprintk("NFS: splice_read(%pD2, %zu@%llu)\n", in, len, *ppos);
+
+	nfs_start_io_read(inode);
+	result = nfs_revalidate_mapping(inode, in->f_mapping);
+	if (!result) {
+		result = filemap_splice_read(in, ppos, pipe, len, flags);
+		if (result > 0)
+			nfs_add_stats(inode, NFSIOS_NORMALREADBYTES, result);
+	}
+	nfs_end_io_read(inode);
+	return result;
+}
+EXPORT_SYMBOL_GPL(nfs_file_splice_read);
+
 int
 nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
@@ -879,7 +900,7 @@ const struct file_operations nfs_file_operations = {
 	.fsync		= nfs_file_fsync,
 	.lock		= nfs_lock,
 	.flock		= nfs_flock,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= nfs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 3cc027d3bd58..b5f21d35d30e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -416,6 +416,8 @@ static inline __u32 nfs_access_xattr_mask(const struct nfs_server *server)
 int nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 loff_t nfs_file_llseek(struct file *, loff_t, int);
 ssize_t nfs_file_read(struct kiocb *, struct iov_iter *);
+ssize_t nfs_file_splice_read(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe,
+			     size_t len, unsigned int flags);
 int nfs_file_mmap(struct file *, struct vm_area_struct *);
 ssize_t nfs_file_write(struct kiocb *, struct iov_iter *);
 int nfs_file_release(struct inode *, struct file *);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 2563ed8580f3..4aeadd6e1a6d 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -454,7 +454,7 @@ const struct file_operations nfs4_file_operations = {
 	.fsync		= nfs_file_fsync,
 	.lock		= nfs_lock,
 	.flock		= nfs_flock,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= nfs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= nfs4_setlease,

