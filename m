Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4909539D0B7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFFTNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFFTMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A663C061224;
        Sun,  6 Jun 2021 12:10:57 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAh-0056cD-Bp; Sun, 06 Jun 2021 19:10:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 31/37] iterate_xarray(): only of the first iteration we might get offset != 0
Date:   Sun,  6 Jun 2021 19:10:45 +0000
Message-Id: <20210606191051.1216821-31-viro@zeniv.linux.org.uk>
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

recalculating offset on each iteration is pointless - on all subsequent
passes through the loop it will be zero anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c1580e574d76..9ecbf59c3378 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -70,9 +70,9 @@
 	__label__ __out;					\
 	size_t __off = 0;					\
 	struct page *head = NULL;				\
-	size_t offset;						\
 	loff_t start = i->xarray_start + i->iov_offset;		\
-	pgoff_t index = start >> PAGE_SHIFT;			\
+	unsigned offset = start % PAGE_SIZE;			\
+	pgoff_t index = start / PAGE_SIZE;			\
 	int j;							\
 								\
 	XA_STATE(xas, i->xarray, index);			\
@@ -89,7 +89,6 @@
 		for (j = (head->index < index) ? index - head->index : 0; \
 		     j < thp_nr_pages(head); j++) {		\
 			void *kaddr = kmap_local_page(head + j);	\
-			offset = (start + __off) % PAGE_SIZE;	\
 			base = kaddr + offset;			\
 			len = PAGE_SIZE - offset;		\
 			len = min(n, len);			\
@@ -100,6 +99,7 @@
 			n -= len;				\
 			if (left || n == 0)			\
 				goto __out;			\
+			offset = 0;				\
 		}						\
 	}							\
 __out:								\
-- 
2.11.0

