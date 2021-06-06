Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D462339D097
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFTMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhFFTMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EFEC061787;
        Sun,  6 Jun 2021 12:10:52 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAd-0056Z6-GK; Sun, 06 Jun 2021 19:10:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 05/37] teach copy_page_to_iter() to handle compound pages
Date:   Sun,  6 Jun 2021 19:10:19 +0000
Message-Id: <20210606191051.1216821-5-viro@zeniv.linux.org.uk>
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

	In situation when copy_page_to_iter() got a compound page the current
code would only work on systems with no CONFIG_HIGHMEM.  It *is* the majority
of real-world setups, or we would've drown in bug reports by now.  Still needs
fixing.

	Current variant works for solitary page; rename that to
__copy_page_to_iter() and turn the handling of compound pages into a loop over
subpages.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8f5ce5b1ff91..12fb04b23143 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -957,11 +957,9 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 	return false;
 }
 
-size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+static size_t __copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-	if (unlikely(!page_copy_sane(page, offset, bytes)))
-		return 0;
 	if (i->type & (ITER_BVEC | ITER_KVEC | ITER_XARRAY)) {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
@@ -974,6 +972,30 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 	else
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
 }
+
+size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i)
+{
+	size_t res = 0;
+	if (unlikely(!page_copy_sane(page, offset, bytes)))
+		return 0;
+	page += offset / PAGE_SIZE; // first subpage
+	offset %= PAGE_SIZE;
+	while (1) {
+		size_t n = __copy_page_to_iter(page, offset,
+				min(bytes, (size_t)PAGE_SIZE - offset), i);
+		res += n;
+		bytes -= n;
+		if (!bytes || !n)
+			break;
+		offset += n;
+		if (offset == PAGE_SIZE) {
+			page++;
+			offset = 0;
+		}
+	}
+	return res;
+}
 EXPORT_SYMBOL(copy_page_to_iter);
 
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
-- 
2.11.0

