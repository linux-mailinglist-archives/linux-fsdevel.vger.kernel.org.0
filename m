Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AE70C084
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjEVN4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjEVNzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C361988
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KS9sZ9kcl+UmAh/rrU1AUBhdO0vlEMJjBaa07cCJK5s=;
        b=Rt4XW66KEeAA+LhSvQ7oW3K+Zrx833kZhEoNdS92PYpnxW0LXQff22nKCn/c222yXz317U
        YRkDvcpMhIqmZjna4QytI7utV4mMRlvF7f44tPamuI5epMHkPx6RMc0gcSBnSHVtgwLHP5
        LNlSavjFlqmyMd9/WxDxYNico9tLoqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-yOayTwe9NkiCRekSvPPumw-1; Mon, 22 May 2023 09:52:11 -0400
X-MC-Unique: yOayTwe9NkiCRekSvPPumw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCAA9802355;
        Mon, 22 May 2023 13:52:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8C11482060;
        Mon, 22 May 2023 13:52:07 +0000 (UTC)
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
Subject: [PATCH v22 27/31] cifs: Use filemap_splice_read()
Date:   Mon, 22 May 2023 14:50:14 +0100
Message-Id: <20230522135018.2742245-28-dhowells@redhat.com>
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

Make cifs use filemap_splice_read() rather than doing its own version of
generic_file_splice_read().

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
    ver #21)
     - Switch to filemap_splice_read() rather than generic_file_splice_read().
    
    ver #20)
     - Don't remove the export of filemap_splice_read().
    
    ver #18)
     - Split out from change to generic_file_splice_read().

 fs/cifs/cifsfs.c |  8 ++++----
 fs/cifs/cifsfs.h |  3 ---
 fs/cifs/file.c   | 16 ----------------
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index fa2477bbcc86..4f4492eb975f 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1376,7 +1376,7 @@ const struct file_operations cifs_file_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = cifs_splice_read,
+	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1396,7 +1396,7 @@ const struct file_operations cifs_file_strict_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = cifs_splice_read,
+	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1434,7 +1434,7 @@ const struct file_operations cifs_file_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = cifs_splice_read,
+	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1452,7 +1452,7 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = cifs_splice_read,
+	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 74cd6fafb33e..d7274eefc666 100644
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
index 023496207c18..375a8037a3f3 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5078,19 +5078,3 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
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
-		return copy_splice_read(in, ppos, pipe, len, flags);
-	return filemap_splice_read(in, ppos, pipe, len, flags);
-}

