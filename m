Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E87090C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjESHoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjESHnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F910F8
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhBgu+YPWWuhiMuhxeBoG/WfhrSyIDZx4YN21OB8Xyg=;
        b=dNpGYW5z/Q57Q9CJhIMdt7Hj6B9lnbtlUfPePR8Nom2EoMqnbPYXszl1gYQYg7Pw1BXypl
        ld+s0VkG5LQc3+POG+4JnuFh9pyHAmio+SeHpTb/X+/GMfxoWiXOxCOSjxVNKUzV0UMceT
        3E/dGBXjd1TUw2eBK44kkCENyNckpCs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-eDOVwGWEMCmaAhO0IYU1iA-1; Fri, 19 May 2023 03:41:59 -0400
X-MC-Unique: eDOVwGWEMCmaAhO0IYU1iA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EABBE3C01D8C;
        Fri, 19 May 2023 07:41:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC6F2166B28;
        Fri, 19 May 2023 07:41:56 +0000 (UTC)
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
Subject: [PATCH v20 17/32] nfs: Provide a splice-read stub
Date:   Fri, 19 May 2023 08:40:32 +0100
Message-Id: <20230519074047.1739879-18-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read stub for NFS.  This locks the inode around
filemap_splice_read() and revalidates the mapping.  It cannot do this
around direct_splice_read() as that calls ->read_iter().

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
 fs/nfs/file.c     | 26 +++++++++++++++++++++++++-
 fs/nfs/internal.h |  2 ++
 fs/nfs/nfs4file.c |  2 +-
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f0edf5a36237..91fe48b47f3c 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -178,6 +178,30 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 }
 EXPORT_SYMBOL_GPL(nfs_file_read);
 
+ssize_t
+nfs_file_splice_read(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe,
+		     size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	ssize_t result;
+
+	if (in->f_flags & O_DIRECT)
+		return direct_splice_read(in, ppos, pipe, len, flags);
+
+	dprintk("NFS: splice_read(%pD2, %zu@%lu)\n", in, len, *pos);
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
@@ -879,7 +903,7 @@ const struct file_operations nfs_file_operations = {
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

