Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F58139D0A1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhFFTMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhFFTMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505BC0613A3;
        Sun,  6 Jun 2021 12:10:53 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAd-0056Z1-CI; Sun, 06 Jun 2021 19:10:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 04/37] iov_iter: Remove iov_iter_for_each_range()
Date:   Sun,  6 Jun 2021 19:10:18 +0000
Message-Id: <20210606191051.1216821-4-viro@zeniv.linux.org.uk>
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

From: David Howells <dhowells@redhat.com>

Remove iov_iter_for_each_range() as it's no longer used with the removal of
lustre.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/uio.h |  4 ----
 lib/iov_iter.c      | 27 ---------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index d3ec87706d75..74a401f04bd3 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -294,8 +294,4 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 int import_single_range(int type, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i);
 
-int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
-			    int (*f)(struct kvec *vec, void *context),
-			    void *context);
-
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c701b7a187f2..8f5ce5b1ff91 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2093,30 +2093,3 @@ int import_single_range(int rw, void __user *buf, size_t len,
 	return 0;
 }
 EXPORT_SYMBOL(import_single_range);
-
-int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
-			    int (*f)(struct kvec *vec, void *context),
-			    void *context)
-{
-	struct kvec w;
-	int err = -EINVAL;
-	if (!bytes)
-		return 0;
-
-	iterate_all_kinds(i, bytes, v, -EINVAL, ({
-		w.iov_base = kmap(v.bv_page) + v.bv_offset;
-		w.iov_len = v.bv_len;
-		err = f(&w, context);
-		kunmap(v.bv_page);
-		err;}), ({
-		w = v;
-		err = f(&w, context);}), ({
-		w.iov_base = kmap(v.bv_page) + v.bv_offset;
-		w.iov_len = v.bv_len;
-		err = f(&w, context);
-		kunmap(v.bv_page);
-		err;})
-	)
-	return err;
-}
-EXPORT_SYMBOL(iov_iter_for_each_range);
-- 
2.11.0

