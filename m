Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F013EABAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhHLUWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237256AbhHLUWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628799733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTmU29yZIgB7SK96cJsT0SpdzVNLSTZbvkXxHkWMKmU=;
        b=PaeTm6QbDYXiAp+nyW2nljX2EQKgM20XYK2hgtxeHdMKcI9+gFjCbIcKdHNmkHfkpjLw4v
        kUQ6GNlF6AVE2aH0721kvarYuueTUp2ZYBe8hHvMydpCKVGd7pNoxvWy/+lhi9mMWmGDJp
        HGQW5qIDiKsR4VqnryKqaODg9ZDxG3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-OOb8V-K0PFKzUe5mosFGXw-1; Thu, 12 Aug 2021 16:22:12 -0400
X-MC-Unique: OOb8V-K0PFKzUe5mosFGXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43A641853029;
        Thu, 12 Aug 2021 20:22:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96A9C669ED;
        Thu, 12 Aug 2021 20:22:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v2 1/5] nfs: Fix write to swapfile failure due to
 generic_write_checks()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        linux-nfs@vger.kernel.org, dhowells@redhat.com,
        dhowells@redhat.com, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 21:22:06 +0100
Message-ID: <162879972678.3306668.10709543333474121000.stgit@warthog.procyon.org.uk>
In-Reply-To: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
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

Fix this by introducing a new kiocb flag, IOCB_SWAP, that's set by the swap
code to indicate that the swapper is doing this operation and so overrule
the check in generic_write_checks().

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
cc: Darrick J. Wong <darrick.wong@oracle.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Trond Myklebust <trond.myklebust@primarydata.com>
cc: linux-nfs@vger.kernel.org
---

 fs/read_write.c    |    2 +-
 include/linux/fs.h |    1 +
 mm/page_io.c       |    7 ++++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..daef721ca67e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1646,7 +1646,7 @@ ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	loff_t count;
 	int ret;
 
-	if (IS_SWAPFILE(inode))
+	if (IS_SWAPFILE(inode) && !(iocb->ki_flags & IOCB_SWAP))
 		return -ETXTBSY;
 
 	if (!iov_iter_count(from))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..b3e6a20f28ef 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -319,6 +319,7 @@ enum rw_hint {
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
+#define IOCB_SWAP		(1 << 21)	/* This is a swap request */
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/mm/page_io.c b/mm/page_io.c
index d597bc6e6e45..edb72bf624d2 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -303,7 +303,8 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 
 		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
 		init_sync_kiocb(&kiocb, swap_file);
-		kiocb.ki_pos = page_file_offset(page);
+		kiocb.ki_pos	= page_file_offset(page);
+		kiocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE | IOCB_SWAP;
 
 		set_page_writeback(page);
 		unlock_page(page);
@@ -324,8 +325,8 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 			 */
 			set_page_dirty(page);
 			ClearPageReclaim(page);
-			pr_err_ratelimited("Write error on dio swapfile (%llu)\n",
-					   page_file_offset(page));
+			pr_err_ratelimited("Write error (%d) on dio swapfile (%llu)\n",
+					   ret, page_file_offset(page));
 		}
 		end_page_writeback(page);
 		return ret;


