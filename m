Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553C739D09B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFFTMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFFTMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD66C061767;
        Sun,  6 Jun 2021 12:10:52 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAd-0056Yt-79; Sun, 06 Jun 2021 19:10:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 02/37] generic_perform_write()/iomap_write_actor(): saner logics for short copy
Date:   Sun,  6 Jun 2021 19:10:16 +0000
Message-Id: <20210606191051.1216821-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

if we run into a short copy and ->write_end() refuses to advance at all,
use the amount we'd managed to copy for the next iteration to handle.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/iomap/buffered-io.c | 25 ++++++++++---------------
 mm/filemap.c           | 24 +++++++++---------------
 2 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f2cd2034a87b..354b41d20e5d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -771,10 +771,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		 * Otherwise there's a nasty deadlock on copying from the
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
-		 *
-		 * Not only is this an optimisation, but it is also required
-		 * to check that the address is actually valid, when atomic
-		 * usercopies are used, below.
 		 */
 		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
 			status = -EFAULT;
@@ -791,25 +787,24 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 
-		copied = iomap_write_end(inode, pos, bytes, copied, page, iomap,
+		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
 
 		cond_resched();
 
-		iov_iter_advance(i, copied);
-		if (unlikely(copied == 0)) {
+		if (unlikely(status == 0)) {
 			/*
-			 * If we were unable to copy any data at all, we must
-			 * fall back to a single segment length write.
-			 *
-			 * If we didn't fallback here, we could livelock
-			 * because not all segments in the iov can be copied at
-			 * once without a pagefault.
+			 * A short copy made iomap_write_end() reject the
+			 * thing entirely.  Might be memory poisoning
+			 * halfway through, might be a race with munmap,
+			 * might be severe memory pressure.
 			 */
-			bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_single_seg_count(i));
+			if (copied)
+				bytes = copied;
 			goto again;
 		}
+		copied = status;
+		iov_iter_advance(i, copied);
 		pos += copied;
 		written += copied;
 		length -= copied;
diff --git a/mm/filemap.c b/mm/filemap.c
index 66f7e9fdfbc4..0be24942bf8e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3642,10 +3642,6 @@ ssize_t generic_perform_write(struct file *file,
 		 * Otherwise there's a nasty deadlock on copying from the
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
-		 *
-		 * Not only is this an optimisation, but it is also required
-		 * to check that the address is actually valid, when atomic
-		 * usercopies are used, below.
 		 */
 		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
 			status = -EFAULT;
@@ -3672,24 +3668,22 @@ ssize_t generic_perform_write(struct file *file,
 						page, fsdata);
 		if (unlikely(status < 0))
 			break;
-		copied = status;
 
 		cond_resched();
 
-		iov_iter_advance(i, copied);
-		if (unlikely(copied == 0)) {
+		if (unlikely(status == 0)) {
 			/*
-			 * If we were unable to copy any data at all, we must
-			 * fall back to a single segment length write.
-			 *
-			 * If we didn't fallback here, we could livelock
-			 * because not all segments in the iov can be copied at
-			 * once without a pagefault.
+			 * A short copy made ->write_end() reject the
+			 * thing entirely.  Might be memory poisoning
+			 * halfway through, might be a race with munmap,
+			 * might be severe memory pressure.
 			 */
-			bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_single_seg_count(i));
+			if (copied)
+				bytes = copied;
 			goto again;
 		}
+		copied = status;
+		iov_iter_advance(i, copied);
 		pos += copied;
 		written += copied;
 
-- 
2.11.0

