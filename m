Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2ED39D0A7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFFTMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFFTMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52072C061766;
        Sun,  6 Jun 2021 12:10:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAd-0056Yr-0s; Sun, 06 Jun 2021 19:10:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 01/37] ntfs_copy_from_user_iter(): don't bother with copying iov_iter
Date:   Sun,  6 Jun 2021 19:10:15 +0000
Message-Id: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Advance the original, let the caller revert if it needs to.
Don't mess with iov_iter_single_seg_count() in the caller -
if we got a (non-zero) short copy, use the amount actually
copied for the next pass, limit it to "up to the end
of page" if nothing got copied at all.

Originally fault-in only read the first iovec; back then it used
to make sense to limit to the just one iovec for the pass after
short copy.  These days it's no long true.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ntfs/file.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e5aab265dff1..0666d4578137 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1684,20 +1684,19 @@ static size_t ntfs_copy_from_user_iter(struct page **pages, unsigned nr_pages,
 {
 	struct page **last_page = pages + nr_pages;
 	size_t total = 0;
-	struct iov_iter data = *i;
 	unsigned len, copied;
 
 	do {
 		len = PAGE_SIZE - ofs;
 		if (len > bytes)
 			len = bytes;
-		copied = iov_iter_copy_from_user_atomic(*pages, &data, ofs,
+		copied = iov_iter_copy_from_user_atomic(*pages, i, ofs,
 				len);
+		iov_iter_advance(i, copied);
 		total += copied;
 		bytes -= copied;
 		if (!bytes)
 			break;
-		iov_iter_advance(&data, copied);
 		if (copied < len)
 			goto err;
 		ofs = 0;
@@ -1866,34 +1865,24 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 		if (likely(copied == bytes)) {
 			status = ntfs_commit_pages_after_write(pages, do_pages,
 					pos, bytes);
-			if (!status)
-				status = bytes;
 		}
 		do {
 			unlock_page(pages[--do_pages]);
 			put_page(pages[do_pages]);
 		} while (do_pages);
-		if (unlikely(status < 0))
+		if (unlikely(status < 0)) {
+			iov_iter_revert(i, copied);
 			break;
-		copied = status;
+		}
 		cond_resched();
-		if (unlikely(!copied)) {
-			size_t sc;
-
-			/*
-			 * We failed to copy anything.  Fall back to single
-			 * segment length write.
-			 *
-			 * This is needed to avoid possible livelock in the
-			 * case that all segments in the iov cannot be copied
-			 * at once without a pagefault.
-			 */
-			sc = iov_iter_single_seg_count(i);
-			if (bytes > sc)
-				bytes = sc;
+		if (unlikely(copied < bytes)) {
+			iov_iter_revert(i, copied);
+			if (copied)
+				bytes = copied;
+			else if (bytes > PAGE_SIZE - ofs)
+				bytes = PAGE_SIZE - ofs;
 			goto again;
 		}
-		iov_iter_advance(i, copied);
 		pos += copied;
 		written += copied;
 		balance_dirty_pages_ratelimited(mapping);
-- 
2.11.0

