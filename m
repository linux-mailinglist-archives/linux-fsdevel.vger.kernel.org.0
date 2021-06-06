Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DED39D0A4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhFFTMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhFFTMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FEC0613A4;
        Sun,  6 Jun 2021 12:10:53 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAe-0056Zh-96; Sun, 06 Jun 2021 19:10:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 14/37] sanitize iov_iter_fault_in_readable()
Date:   Sun,  6 Jun 2021 19:10:28 +0000
Message-Id: <20210606191051.1216821-14-viro@zeniv.linux.org.uk>
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

1) constify iov_iter argument; we are not advancing it in this primitive.

2) cap the amount requested by the amount of data in iov_iter.  All
existing callers should've been safe, but the check is really cheap and
doing it here makes for easier analysis, as well as more consistent
semantics among the primitives.

3) don't bother with iterate_iovec().  Explicit loop is not any harder
to follow, and we get rid of standalone iterate_iovec() users - it's
only used by iterate_and_advance() and (soon to be gone) iterate_all_kinds().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/uio.h |  2 +-
 lib/iov_iter.c      | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 56b6ff235281..18b4e0a8e3bf 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -119,7 +119,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		struct iov_iter *i, unsigned long offset, size_t bytes);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
-int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes);
+int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5621a3457118..21b3e253b766 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -466,19 +466,25 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
  * Return 0 on success, or non-zero if the memory could not be accessed (i.e.
  * because it is an invalid address).
  */
-int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
+int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes)
 {
-	size_t skip = i->iov_offset;
-	const struct iovec *iov;
-	int err;
-	struct iovec v;
-
 	if (iter_is_iovec(i)) {
-		iterate_iovec(i, bytes, v, iov, skip, ({
-			err = fault_in_pages_readable(v.iov_base, v.iov_len);
+		const struct iovec *p;
+		size_t skip;
+
+		if (bytes > i->count)
+			bytes = i->count;
+		for (p = i->iov, skip = i->iov_offset; bytes; p++, skip = 0) {
+			size_t len = min(bytes, p->iov_len - skip);
+			int err;
+
+			if (unlikely(!len))
+				continue;
+			err = fault_in_pages_readable(p->iov_base + skip, len);
 			if (unlikely(err))
-			return err;
-		0;}))
+				return err;
+			bytes -= len;
+		}
 	}
 	return 0;
 }
-- 
2.11.0

