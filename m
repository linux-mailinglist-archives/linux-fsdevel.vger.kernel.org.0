Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459D695D22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 09:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjBNIjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 03:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjBNIjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88823E3AE
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 00:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676363859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aqt7Ie9m7VBTVoG66ytoaEfOzMGB0BP8eJc00dhMkTk=;
        b=idNAs3u6Jx9T7p9AoA0T7XiO7pOeb4RoHEZrBKwgvjQLTyevHsi9LfjLKjFK1sOkUiisUc
        gtSsZNjsBD9dR9mFD8ZYUBZOETUfbkCOLxLVL79g2VNHwm9FB3QGndVlWPjdPn35yx/YRs
        zx7jLeowbeEpE+xpkJFKJ9gp3bar7pU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-REqII07MME2i0C0sg7aRjw-1; Tue, 14 Feb 2023 03:37:36 -0500
X-MC-Unique: REqII07MME2i0C0sg7aRjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 151B7857A9F;
        Tue, 14 Feb 2023 08:37:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5598F140EBF6;
        Tue, 14 Feb 2023 08:37:31 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Hugh Dickins <hughd@google.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v3 5/5] shmem, overlayfs, coda, tty, proc, kernfs, random: Fix splice-read
Date:   Tue, 14 Feb 2023 08:37:10 +0000
Message-Id: <20230214083710.2547248-6-dhowells@redhat.com>
In-Reply-To: <20230214083710.2547248-1-dhowells@redhat.com>
References: <20230214083710.2547248-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new filemap_splice_read() has an implicit expectation via
filemap_get_pages() that ->read_folio() exists if ->readahead() doesn't
fully populate the pagecache of the file it is reading from[1], potentially
leading to a jump to NULL if this doesn't exist.

A filesystem or driver shouldn't suffer from this if:

  - It doesn't set ->splice_read()
  - It implements ->read_folio()
  - It implements its own ->splice_read()

Note that some filesystems set generic_file_splice_read() and
generic_file_read_iter() but don't set ->read_folio().  g_f_read_iter()
will fall back to filemap_read_iter() which looks like it should suffer
from the same issue.

Certain drivers, can just use direct_splice_read() rather than
generic_file_splice_read() as that creates an output buffer and then just
calls their ->read_iter() function:

  - random & urandom
  - tty
  - kernfs
  - proc
  - proc_namespace

Stacked filesystems just need to pass the operation down a layer:

  - coda
  - overlayfs

And finally, there's shmem (used in tmpfs, ramfs, rootfs).  This needs its
own splice-read implementation, based on filemap_splice_read(), but able to
paste in zero_page when there's a page missing.

Fixes: d9722a475711 ("splice: Do splice read from a buffered file without using ITER_PIPE")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Daniel Golle <daniel@makrotopia.org>
cc: Guenter Roeck <groeck7@gmail.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Hugh Dickins <hughd@google.com>
cc: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Arnd Bergmann <arnd@arndb.de>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: coda@cs.cmu.edu
cc: codalist@coda.cs.cmu.edu
cc: linux-unionfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/Y+pdHFFTk1TTEBsO@makrotopia.org/ [1]
---
 drivers/char/random.c  |   4 +-
 drivers/tty/tty_io.c   |   4 +-
 fs/coda/file.c         |  36 +++++++++++-
 fs/kernfs/file.c       |   2 +-
 fs/overlayfs/file.c    |  36 +++++++++++-
 fs/proc/inode.c        |   4 +-
 fs/proc/proc_sysctl.c  |   2 +-
 fs/proc_namespace.c    |   6 +-
 fs/splice.c            |   6 +-
 include/linux/fs.h     |   6 ++
 include/linux/splice.h |   4 --
 mm/filemap.c           |   5 +-
 mm/internal.h          |   6 ++
 mm/shmem.c             | 124 ++++++++++++++++++++++++++++++++++++++++-
 14 files changed, 221 insertions(+), 24 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ce3ccd172cc8..792713616ba8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1546,7 +1546,7 @@ const struct file_operations random_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
-	.splice_read = generic_file_splice_read,
+	.splice_read = direct_splice_read,
 	.splice_write = iter_file_splice_write,
 };
 
@@ -1557,7 +1557,7 @@ const struct file_operations urandom_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
-	.splice_read = generic_file_splice_read,
+	.splice_read = direct_splice_read,
 	.splice_write = iter_file_splice_write,
 };
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3149114bf130..495678e9b95e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -466,7 +466,7 @@ static const struct file_operations tty_fops = {
 	.llseek		= no_llseek,
 	.read_iter	= tty_read,
 	.write_iter	= tty_write,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.poll		= tty_poll,
 	.unlocked_ioctl	= tty_ioctl,
@@ -481,7 +481,7 @@ static const struct file_operations console_fops = {
 	.llseek		= no_llseek,
 	.read_iter	= tty_read,
 	.write_iter	= redirected_tty_write,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.poll		= tty_poll,
 	.unlocked_ioctl	= tty_ioctl,
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 3f3c81e6b1ab..33cd7880d30e 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/splice.h>
 
 #include <linux/coda.h>
 #include "coda_psdev.h"
@@ -94,6 +95,39 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t
+coda_file_splice_read(struct file *coda_file, loff_t *ppos,
+		      struct pipe_inode_info *pipe,
+		      size_t len, unsigned int flags)
+{
+	struct inode *coda_inode = file_inode(coda_file);
+	struct coda_file_info *cfi = coda_ftoc(coda_file);
+	struct file *in = cfi->cfi_container;
+	loff_t ki_pos = *ppos;
+	ssize_t ret;
+
+	if (!in->f_op->splice_read)
+		return -EINVAL;
+
+	ret = rw_verify_area(READ, in, ppos, len);
+	if (unlikely(ret < 0))
+		return ret;
+
+	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+				  &cfi->cfi_access_intent,
+				  len, ki_pos, CODA_ACCESS_TYPE_READ);
+	if (ret)
+		goto finish_read;
+
+	ret = in->f_op->splice_read(in, ppos, pipe, len, flags);
+
+finish_read:
+	venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+			    &cfi->cfi_access_intent,
+			    len, ki_pos, CODA_ACCESS_TYPE_READ_FINISH);
+	return ret;
+}
+
 static void
 coda_vm_open(struct vm_area_struct *vma)
 {
@@ -302,5 +336,5 @@ const struct file_operations coda_file_operations = {
 	.open		= coda_open,
 	.release	= coda_release,
 	.fsync		= coda_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= coda_file_splice_read,
 };
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e4a50e4ff0d2..9d23b8141db7 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -1011,7 +1011,7 @@ const struct file_operations kernfs_file_fops = {
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
 	.fsync		= noop_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c9d0c362c7ef..267b61df6fcd 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -419,6 +419,40 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
+			       struct pipe_inode_info *pipe, size_t len,
+			       unsigned int flags)
+{
+	const struct cred *old_cred;
+	struct fd real;
+	ssize_t ret;
+
+	ret = ovl_real_fdget(in, &real);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+	if (in->f_flags & O_DIRECT &&
+	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
+		goto out_fdput;
+	if (!real.file->f_op->splice_read)
+		goto out_fdput;
+
+	ret = rw_verify_area(READ, in, ppos, len);
+	if (unlikely(ret < 0))
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(in)->i_sb);
+	ret = real.file->f_op->splice_read(real.file, ppos, pipe, len, flags);
+
+	revert_creds(old_cred);
+	ovl_file_accessed(in);
+out_fdput:
+	fdput(real);
+
+	return ret;
+}
+
 /*
  * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
  * due to lock order inversion between pipe->mutex in iter_file_splice_write()
@@ -695,7 +729,7 @@ const struct file_operations ovl_file_operations = {
 	.fallocate	= ovl_fallocate,
 	.fadvise	= ovl_fadvise,
 	.flush		= ovl_flush,
-	.splice_read    = generic_file_splice_read,
+	.splice_read    = ovl_splice_read,
 	.splice_write   = ovl_splice_write,
 
 	.copy_file_range	= ovl_copy_file_range,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index f495fdb39151..711f12706469 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -591,7 +591,7 @@ static const struct file_operations proc_iter_file_ops = {
 	.llseek		= proc_reg_llseek,
 	.read_iter	= proc_reg_read_iter,
 	.write		= proc_reg_write,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.mmap		= proc_reg_mmap,
@@ -617,7 +617,7 @@ static const struct file_operations proc_reg_file_ops_compat = {
 static const struct file_operations proc_iter_file_ops_compat = {
 	.llseek		= proc_reg_llseek,
 	.read_iter	= proc_reg_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.write		= proc_reg_write,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 48f2d60bd78a..92533bd0e67b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -869,7 +869,7 @@ static const struct file_operations proc_sys_file_operations = {
 	.poll		= proc_sys_poll,
 	.read_iter	= proc_sys_read,
 	.write_iter	= proc_sys_write,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.llseek		= default_llseek,
 };
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 846f9455ae22..492abbbeff5e 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -324,7 +324,7 @@ static int mountstats_open(struct inode *inode, struct file *file)
 const struct file_operations proc_mounts_operations = {
 	.open		= mounts_open,
 	.read_iter	= seq_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 	.poll		= mounts_poll,
@@ -333,7 +333,7 @@ const struct file_operations proc_mounts_operations = {
 const struct file_operations proc_mountinfo_operations = {
 	.open		= mountinfo_open,
 	.read_iter	= seq_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 	.poll		= mounts_poll,
@@ -342,7 +342,7 @@ const struct file_operations proc_mountinfo_operations = {
 const struct file_operations proc_mountstats_operations = {
 	.open		= mountstats_open,
 	.read_iter	= seq_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 };
diff --git a/fs/splice.c b/fs/splice.c
index 341cd8fb47a8..0708cf0d12b7 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -287,9 +287,9 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
  * Splice data from an O_DIRECT file into pages and then add them to the output
  * pipe.
  */
-static ssize_t direct_splice_read(struct file *in, loff_t *ppos,
-				  struct pipe_inode_info *pipe,
-				  size_t len, unsigned int flags)
+ssize_t direct_splice_read(struct file *in, loff_t *ppos,
+			   struct pipe_inode_info *pipe,
+			   size_t len, unsigned int flags)
 {
 	struct iov_iter to;
 	struct bio_vec *bv;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..551c9403f9b3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3163,6 +3163,12 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 			    struct iov_iter *iter);
 
 /* fs/splice.c */
+ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
+			    struct pipe_inode_info *pipe,
+			    size_t len, unsigned int flags);
+ssize_t direct_splice_read(struct file *in, loff_t *ppos,
+			   struct pipe_inode_info *pipe,
+			   size_t len, unsigned int flags);
 extern ssize_t generic_file_splice_read(struct file *, loff_t *,
 		struct pipe_inode_info *, size_t, unsigned int);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 691c44ef5c0b..a55179fd60fc 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -67,10 +67,6 @@ typedef int (splice_actor)(struct pipe_inode_info *, struct pipe_buffer *,
 typedef int (splice_direct_actor)(struct pipe_inode_info *,
 				  struct splice_desc *);
 
-ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
-			    struct pipe_inode_info *pipe,
-			    size_t len, unsigned int flags);
-
 extern ssize_t splice_from_pipe(struct pipe_inode_info *, struct file *,
 				loff_t *, size_t, unsigned int,
 				splice_actor *);
diff --git a/mm/filemap.c b/mm/filemap.c
index e1ee267675d2..c01bbcb9fa92 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2846,9 +2846,8 @@ EXPORT_SYMBOL(generic_file_read_iter);
 /*
  * Splice subpages from a folio into a pipe.
  */
-static size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-				     struct folio *folio,
-				     loff_t fpos, size_t size)
+size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			      struct folio *folio, loff_t fpos, size_t size)
 {
 	struct page *page;
 	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..6d4ca98f3844 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -794,6 +794,12 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
+/*
+ * mm/filemap.c
+ */
+size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			      struct folio *folio, loff_t fpos, size_t size);
+
 /*
  * mm/vmalloc.c
  */
diff --git a/mm/shmem.c b/mm/shmem.c
index 0005ab2c29af..5a3cc74aba28 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2711,6 +2711,128 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return retval ? retval : error;
 }
 
+static bool zero_pipe_buf_try_steal(struct pipe_inode_info *pipe,
+				    struct pipe_buffer *buf)
+{
+	return false;
+}
+
+static const struct pipe_buf_operations zero_pipe_buf_ops = {
+	.release	= generic_pipe_buf_release,
+	.try_steal	= zero_pipe_buf_try_steal,
+	.get		= generic_pipe_buf_get,
+};
+
+static size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe,
+					loff_t fpos, size_t size)
+{
+	size_t offset = fpos & ~PAGE_MASK;
+
+	size = min(size, PAGE_SIZE - offset);
+
+	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		struct pipe_buffer *buf = pipe_head_buf(pipe);
+
+		*buf = (struct pipe_buffer) {
+			.ops	= &zero_pipe_buf_ops,
+			.page	= ZERO_PAGE(0),
+			.offset	= offset,
+			.len	= size,
+		};
+		get_page(buf->page);
+		pipe->head++;
+	}
+
+	return size;
+}
+
+static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
+				      struct pipe_inode_info *pipe,
+				      size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio = NULL;
+	size_t total_spliced = 0, used, npages, n, part;
+	loff_t isize;
+	int error = 0;
+
+	/* Work out how much data we can actually add into the pipe */
+	used = pipe_occupancy(pipe->head, pipe->tail);
+	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	len = min_t(size_t, len, npages * PAGE_SIZE);
+
+	do {
+		if (*ppos >= i_size_read(inode))
+			break;
+
+		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio, SGP_READ);
+		if (error) {
+			if (error == -EINVAL)
+				error = 0;
+			break;
+		}
+		if (folio) {
+			folio_unlock(folio);
+
+			if (folio_test_hwpoison(folio)) {
+				error = -EIO;
+				break;
+			}
+		}
+
+		/*
+		 * i_size must be checked after we know the pages are Uptodate.
+		 *
+		 * Checking i_size after the check allows us to calculate
+		 * the correct value for "nr", which means the zero-filled
+		 * part of the page is not copied back to userspace (unless
+		 * another truncate extends the file - this is desired though).
+		 */
+		isize = i_size_read(inode);
+		if (unlikely(*ppos >= isize))
+			break;
+		part = min_t(loff_t, isize - *ppos, len);
+
+		if (folio) {
+			/*
+			 * If users can be writing to this page using arbitrary
+			 * virtual addresses, take care about potential aliasing
+			 * before reading the page on the kernel side.
+			 */
+			if (mapping_writably_mapped(mapping))
+				flush_dcache_folio(folio);
+			folio_mark_accessed(folio);
+			/*
+			 * Ok, we have the page, and it's up-to-date, so we can
+			 * now splice it into the pipe.
+			 */
+			n = splice_folio_into_pipe(pipe, folio, *ppos, part);
+			folio_put(folio);
+			folio = NULL;
+		} else {
+			n = splice_zeropage_into_pipe(pipe, *ppos, len);
+		}
+
+		if (!n)
+			break;
+		len -= n;
+		total_spliced += n;
+		*ppos += n;
+		in->f_ra.prev_pos = *ppos;
+		if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+			break;
+
+		cond_resched();
+	} while (len);
+
+	if (folio)
+		folio_put(folio);
+
+	file_accessed(in);
+	return total_spliced ? total_spliced : error;
+}
+
 static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct address_space *mapping = file->f_mapping;
@@ -3929,7 +4051,7 @@ static const struct file_operations shmem_file_operations = {
 	.read_iter	= shmem_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.fsync		= noop_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= shmem_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
 #endif

