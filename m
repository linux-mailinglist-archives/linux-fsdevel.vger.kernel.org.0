Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006296BB9E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjCOQiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCOQhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECD73AF7
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFE/8AaBiLqJLRp8UNCaoGhfMwL8QvYGE4o0n7cdHXc=;
        b=DNWVp+LVl3nz9bBBm3oJweZj3KYJRwC3mfzA3aQjziEurNS4C+jrP04x80/VjWIEIkroiH
        NJx+7HVE/pnc4LIyiG95jY+TGj0OFX+SHskWJ+xz9NcGIslbs2i6lW8+KOy4lOmqXVFONw
        9emUuxRe1xDVdQo9zFQXnUZBm+r75q4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-PMihXXm7NQapVKheb2ClNg-1; Wed, 15 Mar 2023 12:36:19 -0400
X-MC-Unique: PMihXXm7NQapVKheb2ClNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D87E91C08967;
        Wed, 15 Mar 2023 16:36:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCB147507A;
        Wed, 15 Mar 2023 16:36:15 +0000 (UTC)
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
        Paulo Alcantara <pc@manguebit.com>,
        Steve French <smfrench@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org
Subject: [PATCH v19 08/15] cifs: Use generic_file_splice_read()
Date:   Wed, 15 Mar 2023 16:35:42 +0000
Message-Id: <20230315163549.295454-9-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make cifs use generic_file_splice_read() rather than doing it for itself.

As a consequence, filemap_splice_read() no longer needs to be exported.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Steve French <smfrench@gmail.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    ver #18)
     - Split out from change to generic_file_splice_read().

 fs/cifs/cifsfs.c |  8 ++++----
 fs/cifs/cifsfs.h |  3 ---
 fs/cifs/file.c   | 16 ----------------
 mm/filemap.c     |  1 -
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index cbcf210d56e4..ba963a26cb19 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1359,7 +1359,7 @@ const struct file_operations cifs_file_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = cifs_splice_read,
+	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1379,7 +1379,7 @@ const struct file_operations cifs_file_strict_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = cifs_splice_read,
+	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1417,7 +1417,7 @@ const struct file_operations cifs_file_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = cifs_splice_read,
+	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1435,7 +1435,7 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = cifs_splice_read,
+	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 71fe0a0a7992..8b239854e590 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -100,9 +100,6 @@ extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
-extern ssize_t cifs_splice_read(struct file *in, loff_t *ppos,
-				struct pipe_inode_info *pipe, size_t len,
-				unsigned int flags);
 extern int cifs_flock(struct file *pfile, int cmd, struct file_lock *plock);
 extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, loff_t, loff_t, int);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 4d4a2d82636d..321f9b7c84c9 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5066,19 +5066,3 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.launder_folio = cifs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 };
-
-/*
- * Splice data from a file into a pipe.
- */
-ssize_t cifs_splice_read(struct file *in, loff_t *ppos,
-			 struct pipe_inode_info *pipe, size_t len,
-			 unsigned int flags)
-{
-	if (unlikely(*ppos >= file_inode(in)->i_sb->s_maxbytes))
-		return 0;
-	if (unlikely(!len))
-		return 0;
-	if (in->f_flags & O_DIRECT)
-		return direct_splice_read(in, ppos, pipe, len, flags);
-	return filemap_splice_read(in, ppos, pipe, len, flags);
-}
diff --git a/mm/filemap.c b/mm/filemap.c
index 2723104cc06a..3a93515ae2ed 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2967,7 +2967,6 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 	return total_spliced ? total_spliced : error;
 }
-EXPORT_SYMBOL(filemap_splice_read);
 
 static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 		struct address_space *mapping, struct folio *folio,

