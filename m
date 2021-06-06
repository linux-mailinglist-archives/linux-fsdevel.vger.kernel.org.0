Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC22739D0B5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFFTNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFFTMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B1C0613A4;
        Sun,  6 Jun 2021 12:10:56 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAh-0056cH-EG; Sun, 06 Jun 2021 19:10:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 32/37] copy_page_to_iter(): don't bother with kmap_atomic() for bvec/kvec cases
Date:   Sun,  6 Jun 2021 19:10:46 +0000
Message-Id: <20210606191051.1216821-32-viro@zeniv.linux.org.uk>
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

kmap_local_page() is enough there.  Moreover, we can use _copy_to_iter()
for actual copying in those cases - no useful extra checks on the
address we are copying from in that call.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9ecbf59c3378..4fcd0cc44e47 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -832,9 +832,9 @@ static size_t __copy_page_to_iter(struct page *page, size_t offset, size_t bytes
 	if (likely(iter_is_iovec(i)))
 		return copy_page_to_iter_iovec(page, offset, bytes, i);
 	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
-		void *kaddr = kmap_atomic(page);
-		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
-		kunmap_atomic(kaddr);
+		void *kaddr = kmap_local_page(page);
+		size_t wanted = _copy_to_iter(kaddr + offset, bytes, i);
+		kunmap_local(kaddr);
 		return wanted;
 	}
 	if (iov_iter_is_pipe(i))
-- 
2.11.0

