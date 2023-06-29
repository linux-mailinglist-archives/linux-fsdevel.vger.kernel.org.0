Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B041D7429FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 17:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjF2Pzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF2Pzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3135A0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688054101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oe2QNXSzQeZLuqUZwzrEJvS7XHDU0AAQ2jNLxvMy70I=;
        b=IBYspWgPW6TDTo4W16cMfUyAqARP2b+rFxAKhBb7u4HuzGJNIX64m3aB9TefIXFuP/Z4H3
        Nwgzu9DJ6FXYPTp948K0dHhDUXFDud4i4EhoiSS16fm5J1K5VipDZiMmQU5sE7NNF62rll
        5fUXDKyKGrKQO3LgNbYAITMHHp39jqg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-iYBDvSvpPX2FsZBV3XlVEw-1; Thu, 29 Jun 2023 11:54:59 -0400
X-MC-Unique: iYBDvSvpPX2FsZBV3XlVEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99C0F8C589D;
        Thu, 29 Jun 2023 15:54:43 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15B2F429543;
        Thu, 29 Jun 2023 15:54:41 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 3/4] splice: Remove some now-unused bits
Date:   Thu, 29 Jun 2023 16:54:32 +0100
Message-ID: <20230629155433.4170837-4-dhowells@redhat.com>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove some code that's no longer used as the ->confirm() op is no longer
used and pages spliced in from the pagecache and process VM are now
pre-stolen or copied.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Dave Chinner <david@fromorbit.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dev.c             |  37 ---------
 fs/pipe.c                 |  12 ---
 fs/splice.c               | 155 +-------------------------------------
 include/linux/pipe_fs_i.h |  14 ----
 include/linux/splice.h    |   1 -
 mm/filemap.c              |   2 +-
 6 files changed, 3 insertions(+), 218 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..9718dce0f0d9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -700,10 +700,6 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 		struct pipe_buffer *buf = cs->pipebufs;
 
 		if (!cs->write) {
-			err = pipe_buf_confirm(cs->pipe, buf);
-			if (err)
-				return err;
-
 			BUG_ON(!cs->nr_segs);
 			cs->currbuf = buf;
 			cs->pg = buf->page;
@@ -766,26 +762,6 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 	return ncpy;
 }
 
-static int fuse_check_folio(struct folio *folio)
-{
-	if (folio_mapped(folio) ||
-	    folio->mapping != NULL ||
-	    (folio->flags & PAGE_FLAGS_CHECK_AT_PREP &
-	     ~(1 << PG_locked |
-	       1 << PG_referenced |
-	       1 << PG_uptodate |
-	       1 << PG_lru |
-	       1 << PG_active |
-	       1 << PG_workingset |
-	       1 << PG_reclaim |
-	       1 << PG_waiters |
-	       LRU_GEN_MASK | LRU_REFS_MASK))) {
-		dump_page(&folio->page, "fuse: trying to steal weird page");
-		return 1;
-	}
-	return 0;
-}
-
 static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 {
 	int err;
@@ -800,10 +776,6 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 
 	fuse_copy_finish(cs);
 
-	err = pipe_buf_confirm(cs->pipe, buf);
-	if (err)
-		goto out_put_old;
-
 	BUG_ON(!cs->nr_segs);
 	cs->currbuf = buf;
 	cs->len = buf->len;
@@ -818,14 +790,6 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 
 	newfolio = page_folio(buf->page);
 
-	if (!folio_test_uptodate(newfolio))
-		folio_mark_uptodate(newfolio);
-
-	folio_clear_mappedtodisk(newfolio);
-
-	if (fuse_check_folio(newfolio) != 0)
-		goto out_fallback_unlock;
-
 	/*
 	 * This is a new and locked page, it shouldn't be mapped or
 	 * have any special flags on it
@@ -2020,7 +1984,6 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				goto out_free;
 
 			*obuf = *ibuf;
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->len = rem;
 			ibuf->offset += obuf->len;
 			ibuf->len -= obuf->len;
diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..d5c86eb20f29 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -286,7 +286,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t chars = buf->len;
 			size_t written;
-			int error;
 
 			if (chars > total_len) {
 				if (buf->flags & PIPE_BUF_FLAG_WHOLE) {
@@ -297,13 +296,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				chars = total_len;
 			}
 
-			error = pipe_buf_confirm(pipe, buf);
-			if (error) {
-				if (!ret)
-					ret = error;
-				break;
-			}
-
 			written = copy_page_to_iter(buf->page, buf->offset, chars, to);
 			if (unlikely(written < chars)) {
 				if (!ret)
@@ -462,10 +454,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 		if ((buf->flags & PIPE_BUF_FLAG_CAN_MERGE) &&
 		    offset + chars <= PAGE_SIZE) {
-			ret = pipe_buf_confirm(pipe, buf);
-			if (ret)
-				goto out;
-
 			ret = copy_page_from_iter(buf->page, offset, chars, from);
 			if (unlikely(ret < chars)) {
 				ret = -EFAULT;
diff --git a/fs/splice.c b/fs/splice.c
index 42af642c0ff8..2b1f109a7d4f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -56,129 +56,6 @@ static noinline void noinline pipe_clear_nowait(struct file *file)
 	} while (!try_cmpxchg(&file->f_mode, &fmode, fmode & ~FMODE_NOWAIT));
 }
 
-/*
- * Attempt to steal a page from a pipe buffer. This should perhaps go into
- * a vm helper function, it's already simplified quite a bit by the
- * addition of remove_mapping(). If success is returned, the caller may
- * attempt to reuse this page for another destination.
- */
-static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
-		struct pipe_buffer *buf)
-{
-	struct folio *folio = page_folio(buf->page);
-	struct address_space *mapping;
-
-	folio_lock(folio);
-
-	mapping = folio_mapping(folio);
-	if (mapping) {
-		WARN_ON(!folio_test_uptodate(folio));
-
-		/*
-		 * At least for ext2 with nobh option, we need to wait on
-		 * writeback completing on this folio, since we'll remove it
-		 * from the pagecache.  Otherwise truncate wont wait on the
-		 * folio, allowing the disk blocks to be reused by someone else
-		 * before we actually wrote our data to them. fs corruption
-		 * ensues.
-		 */
-		folio_wait_writeback(folio);
-
-		if (folio_has_private(folio) &&
-		    !filemap_release_folio(folio, GFP_KERNEL))
-			goto out_unlock;
-
-		/*
-		 * If we succeeded in removing the mapping, set LRU flag
-		 * and return good.
-		 */
-		if (remove_mapping(mapping, folio)) {
-			buf->flags |= PIPE_BUF_FLAG_LRU;
-			return true;
-		}
-	}
-
-	/*
-	 * Raced with truncate or failed to remove folio from current
-	 * address space, unlock and return failure.
-	 */
-out_unlock:
-	folio_unlock(folio);
-	return false;
-}
-
-static void page_cache_pipe_buf_release(struct pipe_inode_info *pipe,
-					struct pipe_buffer *buf)
-{
-	put_page(buf->page);
-	buf->flags &= ~PIPE_BUF_FLAG_LRU;
-}
-
-/*
- * Check whether the contents of buf is OK to access. Since the content
- * is a page cache page, IO may be in flight.
- */
-static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
-				       struct pipe_buffer *buf)
-{
-	struct page *page = buf->page;
-	int err;
-
-	if (!PageUptodate(page)) {
-		lock_page(page);
-
-		/*
-		 * Page got truncated/unhashed. This will cause a 0-byte
-		 * splice, if this is the first page.
-		 */
-		if (!page->mapping) {
-			err = -ENODATA;
-			goto error;
-		}
-
-		/*
-		 * Uh oh, read-error from disk.
-		 */
-		if (!PageUptodate(page)) {
-			err = -EIO;
-			goto error;
-		}
-
-		/*
-		 * Page is ok afterall, we are done.
-		 */
-		unlock_page(page);
-	}
-
-	return 0;
-error:
-	unlock_page(page);
-	return err;
-}
-
-const struct pipe_buf_operations page_cache_pipe_buf_ops = {
-	.confirm	= page_cache_pipe_buf_confirm,
-	.release	= page_cache_pipe_buf_release,
-	.try_steal	= page_cache_pipe_buf_try_steal,
-	.get		= generic_pipe_buf_get,
-};
-
-static bool user_page_pipe_buf_try_steal(struct pipe_inode_info *pipe,
-		struct pipe_buffer *buf)
-{
-	if (!(buf->flags & PIPE_BUF_FLAG_GIFT))
-		return false;
-
-	buf->flags |= PIPE_BUF_FLAG_LRU;
-	return generic_pipe_buf_try_steal(pipe, buf);
-}
-
-static const struct pipe_buf_operations user_page_pipe_buf_ops = {
-	.release	= page_cache_pipe_buf_release,
-	.try_steal	= user_page_pipe_buf_try_steal,
-	.get		= generic_pipe_buf_get,
-};
-
 static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
 {
 	smp_mb();
@@ -460,13 +337,6 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
 		if (sd->len > sd->total_len)
 			sd->len = sd->total_len;
 
-		ret = pipe_buf_confirm(pipe, buf);
-		if (unlikely(ret)) {
-			if (ret == -ENODATA)
-				ret = 0;
-			return ret;
-		}
-
 		ret = actor(pipe, buf, sd);
 		if (ret <= 0)
 			return ret;
@@ -723,13 +593,6 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				continue;
 			this_len = min(this_len, left);
 
-			ret = pipe_buf_confirm(pipe, buf);
-			if (unlikely(ret)) {
-				if (ret == -ENODATA)
-					ret = 0;
-				goto done;
-			}
-
 			bvec_set_page(&array[n], buf->page, this_len,
 				      buf->offset);
 			left -= this_len;
@@ -764,7 +627,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 			}
 		}
 	}
-done:
+
 	kfree(array);
 	splice_from_pipe_end(pipe, &sd);
 
@@ -855,13 +718,6 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 
 			seg = min_t(size_t, remain, buf->len);
 
-			ret = pipe_buf_confirm(pipe, buf);
-			if (unlikely(ret)) {
-				if (ret == -ENODATA)
-					ret = 0;
-				break;
-			}
-
 			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
 			remain -= seg;
 			if (remain == 0 || bc >= ARRAY_SIZE(bvec))
@@ -1450,7 +1306,6 @@ static int splice_try_to_steal_page(struct pipe_inode_info *pipe,
 need_copy_unlock:
 	folio_unlock(folio);
 need_copy:
-
 	copy = folio_alloc(GFP_KERNEL, 0);
 	if (!copy)
 		return -ENOMEM;
@@ -1578,10 +1433,6 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 {
 	struct pipe_inode_info *pipe;
 	long ret = 0;
-	unsigned buf_flag = 0;
-
-	if (flags & SPLICE_F_GIFT)
-		buf_flag = PIPE_BUF_FLAG_GIFT;
 
 	pipe = get_pipe_info(file, true);
 	if (!pipe)
@@ -1592,7 +1443,7 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	pipe_lock(pipe);
 	ret = wait_for_space(pipe, flags);
 	if (!ret)
-		ret = iter_to_pipe(iter, pipe, buf_flag);
+		ret = iter_to_pipe(iter, pipe, flags);
 	pipe_unlock(pipe);
 	if (ret > 0)
 		wakeup_pipe_readers(pipe);
@@ -1876,7 +1727,6 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			 * Don't inherit the gift and merge flags, we need to
 			 * prevent multiple steals of this page.
 			 */
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->flags &= ~PIPE_BUF_FLAG_CAN_MERGE;
 
 			obuf->len = len;
@@ -1968,7 +1818,6 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 		 * Don't inherit the gift and merge flag, we need to prevent
 		 * multiple steals of this page.
 		 */
-		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 		obuf->flags &= ~PIPE_BUF_FLAG_CAN_MERGE;
 
 		if (obuf->len > len)
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 02e0086b10f6..9cfbefd7ba31 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -6,7 +6,6 @@
 
 #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
 #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
-#define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
 #define PIPE_BUF_FLAG_CAN_MERGE	0x10	/* can merge buffers */
 #define PIPE_BUF_FLAG_WHOLE	0x20	/* read() must return entire buffer or error */
@@ -203,19 +202,6 @@ static inline void pipe_buf_release(struct pipe_inode_info *pipe,
 	ops->release(pipe, buf);
 }
 
-/**
- * pipe_buf_confirm - verify contents of the pipe buffer
- * @pipe:	the pipe that the buffer belongs to
- * @buf:	the buffer to confirm
- */
-static inline int pipe_buf_confirm(struct pipe_inode_info *pipe,
-				   struct pipe_buffer *buf)
-{
-	if (!buf->ops->confirm)
-		return 0;
-	return buf->ops->confirm(pipe, buf);
-}
-
 /**
  * pipe_buf_try_steal - attempt to take ownership of a pipe_buffer
  * @pipe:	the pipe that the buffer belongs to
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 6c461573434d..3c5abbd49ff2 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -97,6 +97,5 @@ extern ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 extern int splice_grow_spd(const struct pipe_inode_info *, struct splice_pipe_desc *);
 extern void splice_shrink_spd(struct splice_pipe_desc *);
 
-extern const struct pipe_buf_operations page_cache_pipe_buf_ops;
 extern const struct pipe_buf_operations default_pipe_buf_ops;
 #endif
diff --git a/mm/filemap.c b/mm/filemap.c
index a002df515966..dd144b0dab69 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2929,7 +2929,7 @@ ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
 
 		*buf = (struct pipe_buffer) {
-			.ops	= &page_cache_pipe_buf_ops,
+			.ops	= &default_pipe_buf_ops,
 			.page	= page,
 			.offset	= offset,
 			.len	= part,

