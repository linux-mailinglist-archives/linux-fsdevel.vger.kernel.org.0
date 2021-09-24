Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C52E4179C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbhIXRV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347773AbhIXRUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8VagtUlhT5Uy1W6HF6FVflMAOHtehIQM8x4I7fA4ic=;
        b=IJ5f3lsPulje4zUj3tiVMOB0dkci36DO7vJv7Q57HxQKDgRx2D0ujpNkHuzVyG6OfA52to
        kQLMj2IJZMOvDypq/wBMU47JmqjEFUk3/W9qKtotvTP1QBECwwwd4Pu6whbEhRfO2vPflQ
        8+oem9opidFrYk14QG+Wq0tYqjfG3ns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-9HXdbiU9P266rFCe3CjhAw-1; Fri, 24 Sep 2021 13:19:08 -0400
X-MC-Unique: 9HXdbiU9P266rFCe3CjhAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE951006AA2;
        Fri, 24 Sep 2021 17:19:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 288C26A908;
        Fri, 24 Sep 2021 17:19:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 7/9] nfs: Fix write to swapfile failure due to
 generic_write_checks()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        NeilBrown <neilb@suse.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        dhowells@redhat.com, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:19:03 +0100
Message-ID: <163250394337.2330363.10000329002686277942.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trying to use a swapfile on NFS results in every DIO write failing with
ETXTBSY because generic_write_checks(), as called by nfs_direct_write()
from nfs_direct_IO(), forbids writes to swapfiles.

Fix this implementing the ->swap_rw() method for NFS, and using that to
bypass the checks in generic_write_checks().  [I'm not sure if we still
need to do some of the checks]

Without this patch, the following is seen:

	Write error on dio swapfile (3800334336)

Altering __swap_writepage() to show the error shows:

	Write error (-26) on dio swapfile (3800334336)

Tested by swapping off all swap partitions and then swapping on a prepared
NFS file (CONFIG_NFS_SWAP=y is also needed).  Enough copies of the
following program then need to be run to force swapping to occur (at least
one per gigabyte of RAM):

	#include <stdbool.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include <sys/mman.h>
	int main()
	{
		unsigned int pid = getpid(), iterations = 0;
		size_t i, j, size = 1024 * 1024 * 1024;
		char *p;
		bool mismatch;
		p = malloc(size);
		if (!p) {
			perror("malloc");
			exit(1);
		}
		srand(pid);
		for (i = 0; i < size; i += 4)
			*(unsigned int *)(p + i) = rand();
		do {
			for (j = 0; j < 16; j++) {
				for (i = 0; i < size; i += 4096)
					*(unsigned int *)(p + i) += 1;
				iterations++;
			}
			mismatch = false;
			srand(pid);
			for (i = 0; i < size; i += 4) {
				unsigned int r = rand();
				unsigned int v = *(unsigned int *)(p + i);
				if (i % 4096 == 0)
					v -= iterations;
				if (v != r) {
					fprintf(stderr, "mismatch %zx: %x != %x (diff %x)\n",
						i, v, r, v - r);
					mismatch = true;
				}
			}
		} while (!mismatch);
		exit(1);
	}


Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trond.myklebust@primarydata.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: "NeilBrown" <neilb@suse.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Darrick J. Wong <darrick.wong@oracle.com>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-nfs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---

 fs/nfs/direct.c        |   28 +++++++---------------------
 fs/nfs/file.c          |   14 ++++++--------
 include/linux/nfs_fs.h |    2 +-
 3 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2e894fec036b..71da8054df7e 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -152,28 +152,18 @@ nfs_direct_count_bytes(struct nfs_direct_req *dreq,
 }
 
 /**
- * nfs_direct_IO - NFS address space operation for direct I/O
+ * nfs_swap_rw - Do direct I/O to a swapfile on NFS
  * @iocb: target I/O control block
  * @iter: I/O buffer
  *
  * The presence of this routine in the address space ops vector means
- * the NFS client supports direct I/O. However, for most direct IO, we
- * shunt off direct read and write requests before the VFS gets them,
- * so this method is only ever called for swap.
+ * the NFS client supports direct I/O for swap.
  */
-ssize_t nfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
-
-	/* we only support swap file calling nfs_direct_IO */
-	if (!IS_SWAPFILE(inode))
-		return 0;
-
-	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
-
-	if (iov_iter_rw(iter) == READ)
-		return nfs_file_direct_read(iocb, iter);
-	return nfs_file_direct_write(iocb, iter);
+	if (iocb->ki_flags & IOCB_WRITE)
+		return nfs_file_direct_write(iocb, iter);
+	return nfs_file_direct_read(iocb, iter);
 }
 
 static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
@@ -894,7 +884,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t result, requested;
-	size_t count;
+	size_t count = iov_iter_count(iter);
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
@@ -905,10 +895,6 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
 
-	result = generic_write_checks(iocb, iter);
-	if (result <= 0)
-		return result;
-	count = result;
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTWRITTENBYTES, count);
 
 	pos = iocb->ki_pos;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 7403ec6317cb..70dd49994751 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -523,7 +523,7 @@ const struct address_space_operations nfs_file_aops = {
 	.write_end = nfs_write_end,
 	.invalidatepage = nfs_invalidate_page,
 	.releasepage = nfs_release_page,
-	.direct_IO = nfs_direct_IO,
+	.swap_rw = nfs_swap_rw,
 #ifdef CONFIG_MIGRATION
 	.migratepage = nfs_migrate_page,
 #endif
@@ -616,14 +616,16 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	if (result)
 		return result;
 
-	if (iocb->ki_flags & IOCB_DIRECT)
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		result = generic_write_checks(iocb, from);
+		if (result <= 0)
+			return result;
 		return nfs_file_direct_write(iocb, from);
+	}
 
 	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
 		file, iov_iter_count(from), (long long) iocb->ki_pos);
 
-	if (IS_SWAPFILE(inode))
-		goto out_swapfile;
 	/*
 	 * O_APPEND implies that we must revalidate the file length.
 	 */
@@ -678,10 +680,6 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
 out:
 	return result;
-
-out_swapfile:
-	printk(KERN_INFO "NFS: attempt to write to active swap file!\n");
-	return -ETXTBSY;
 }
 EXPORT_SYMBOL_GPL(nfs_file_write);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b9a8b925db43..4a8bd9e48237 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -493,7 +493,7 @@ static inline const struct cred *nfs_file_cred(struct file *file)
 /*
  * linux/fs/nfs/direct.c
  */
-extern ssize_t nfs_direct_IO(struct kiocb *, struct iov_iter *);
+extern ssize_t nfs_swap_rw(struct kiocb *, struct iov_iter *);
 extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
 			struct iov_iter *iter);
 extern ssize_t nfs_file_direct_write(struct kiocb *iocb,


