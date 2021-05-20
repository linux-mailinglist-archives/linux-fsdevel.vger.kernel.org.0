Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D876338AE2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhETM24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 08:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237244AbhETM1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 08:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621513563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5mrbqRtsMxsD6ZDRsu0QACrl2UqbZc8cHGI2l2L33w=;
        b=fs5xZUFiebemtnPuBDRomo3BYDm8tvetE7CDBhwCKrTrF+GFOwXCH7tcs4Yh6puaGCHzZs
        l4rs/JSN4QPNFvZBwqyZFU/9nKHh3ZfsgVNaYkUarZI6tpbC5tC6zri2CTiVmFf0M8pVqo
        1563hoqv47H+nddmrIX5qmd4KqE55v0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-Izi-5FhIPdCnX14K1t8m0Q-1; Thu, 20 May 2021 08:25:56 -0400
X-MC-Unique: Izi-5FhIPdCnX14K1t8m0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63F17180FD69;
        Thu, 20 May 2021 12:25:55 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFA5B60C04;
        Thu, 20 May 2021 12:25:53 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, cluster-devel@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 6/6] gfs2: Fix mmap + page fault deadlocks (part 2)
Date:   Thu, 20 May 2021 14:25:36 +0200
Message-Id: <20210520122536.1596602-7-agruenba@redhat.com>
In-Reply-To: <20210520122536.1596602-1-agruenba@redhat.com>
References: <20210520122536.1596602-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we handle self-recursion on the inode glock in gfs2_fault and
gfs2_page_mkwrite, we need to take care of more complex deadlock
scenarios like the following (example by Jan Kara):

Two independent processes P1, P2. Two files F1, F2, and two mappings M1,
M2 where M1 is a mapping of F1, M2 is a mapping of F2. Now P1 does DIO
to F1 with M2 as a buffer, P2 does DIO to F2 with M1 as a buffer. They
can race like:

P1                                      P2
read()                                  read()
  gfs2_file_read_iter()                   gfs2_file_read_iter()
    gfs2_file_direct_read()                 gfs2_file_direct_read()
      locks glock of F1                       locks glock of F2
      iomap_dio_rw()                          iomap_dio_rw()
        bio_iov_iter_get_pages()                bio_iov_iter_get_pages()
          <fault in M2>                           <fault in M1>
            gfs2_fault()                            gfs2_fault()
              tries to grab glock of F2               tries to grab glock of F1

Those kinds of scenarios are much harder to reproduce than
self-recursion.

We deal with such situations by using the LM_FLAG_OUTER flag to mark
"outer" glock taking.  Then, when taking an "inner" glock, we use the
LM_FLAG_TRY flag so that locking attempts that don't immediately succeed
will be aborted.  In case of a failed locking attempt, we "unroll" to
where the "outer" glock was taken, drop the "outer" glock, and fault in
the first offending user page.  This will re-trigger the "inner" locking
attempt but without the LM_FLAG_TRY flag.  Once that has happened, we
re-acquire the "outer" glock and retry the original operation.

Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c |  3 ++-
 fs/gfs2/file.c | 62 +++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 2ff501c413f4..82e4506984e3 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -967,7 +967,8 @@ static int gfs2_write_lock(struct inode *inode)
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	int error;
 
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &ip->i_gh);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, LM_FLAG_OUTER,
+			 &ip->i_gh);
 	error = gfs2_glock_nq(&ip->i_gh);
 	if (error)
 		goto out_uninit;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 7d88abb4629b..8b26893f8dc6 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -431,21 +431,30 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	vm_fault_t ret = VM_FAULT_LOCKED;
 	struct gfs2_holder gh;
 	unsigned int length;
+	u16 flags = 0;
 	loff_t size;
 	int err;
 
 	sb_start_pagefault(inode->i_sb);
 
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (current_holds_glock())
+		flags |= LM_FLAG_TRY;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, flags, &gh);
 	if (likely(!outer_gh)) {
 		err = gfs2_glock_nq(&gh);
 		if (err) {
 			ret = block_page_mkwrite_return(err);
+			if (err == GLR_TRYFAILED) {
+				set_current_needs_retry(true);
+				ret = VM_FAULT_SIGBUS;
+			}
 			goto out_uninit;
 		}
 	} else {
 		if (!gfs2_holder_is_compatible(outer_gh, LM_ST_EXCLUSIVE)) {
 			/* We could try to upgrade outer_gh here. */
+			set_current_needs_retry(true);
 			ret = VM_FAULT_SIGBUS;
 			goto out_uninit;
 		}
@@ -568,20 +577,28 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 	struct gfs2_holder *outer_gh = gfs2_glock_is_locked_by_me(ip->i_gl);
 	struct gfs2_holder gh;
 	vm_fault_t ret;
-	u16 state;
+	u16 state, flags = 0;
 	int err;
 
+	if (current_holds_glock())
+		flags |= LM_FLAG_TRY;
+
 	state = (vmf->flags & FAULT_FLAG_WRITE) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
-	gfs2_holder_init(ip->i_gl, state, 0, &gh);
+	gfs2_holder_init(ip->i_gl, state, flags, &gh);
 	if (likely(!outer_gh)) {
 		err = gfs2_glock_nq(&gh);
 		if (err) {
 			ret = block_page_mkwrite_return(err);
+			if (err == GLR_TRYFAILED) {
+				set_current_needs_retry(true);
+				ret = VM_FAULT_SIGBUS;
+			}
 			goto out_uninit;
 		}
 	} else {
 		if (!gfs2_holder_is_compatible(outer_gh, state)) {
 			/* We could try to upgrade outer_gh here. */
+			set_current_needs_retry(true);
 			ret = VM_FAULT_SIGBUS;
 			goto out_uninit;
 		}
@@ -807,13 +824,21 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	if (!count)
 		return 0; /* skip atime */
 
-	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, LM_FLAG_OUTER, gh);
+retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
 
 	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0);
 	gfs2_glock_dq(gh);
+	if (unlikely(current_needs_retry())) {
+		set_current_needs_retry(false);
+		if (ret == -EFAULT) {
+			if (!iov_iter_fault_in_writeable(to, PAGE_SIZE))
+				goto retry;
+		}
+	}
 out_uninit:
 	gfs2_holder_uninit(gh);
 	return ret;
@@ -837,7 +862,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	 * unfortunately, have the option of only flushing a range like the
 	 * VFS does.
 	 */
-	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, LM_FLAG_OUTER, gh);
+retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
@@ -851,6 +877,13 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = 0;
 out:
 	gfs2_glock_dq(gh);
+	if (unlikely(current_needs_retry())) {
+		set_current_needs_retry(false);
+		if (ret == -EFAULT) {
+			if (!iov_iter_fault_in_readable(from, PAGE_SIZE))
+				goto retry;
+		}
+	}
 out_uninit:
 	gfs2_holder_uninit(gh);
 	return ret;
@@ -883,7 +916,8 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 	ip = GFS2_I(iocb->ki_filp->f_mapping->host);
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_OUTER, &gh);
+retry:
 	ret = gfs2_glock_nq(&gh);
 	if (ret)
 		goto out_uninit;
@@ -891,6 +925,13 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (ret > 0)
 		written += ret;
 	gfs2_glock_dq(&gh);
+	if (unlikely(current_needs_retry())) {
+		set_current_needs_retry(false);
+		if (ret == -EFAULT) {
+			if (!iov_iter_fault_in_writeable(to, PAGE_SIZE))
+				goto retry;
+		}
+	}
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	return written ? written : ret;
@@ -902,9 +943,18 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb, struct iov_iter *fro
 	struct inode *inode = file_inode(file);
 	ssize_t ret;
 
+retry:
 	current->backing_dev_info = inode_to_bdi(inode);
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
 	current->backing_dev_info = NULL;
+	if (unlikely(current_needs_retry())) {
+		set_current_needs_retry(false);
+		if (ret == -EFAULT) {
+			if (!iov_iter_fault_in_readable(from, PAGE_SIZE))
+				goto retry;
+		}
+	}
+
 	return ret;
 }
 
-- 
2.26.3

