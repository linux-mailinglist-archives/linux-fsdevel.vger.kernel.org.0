Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E861080B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 04:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiJ1CeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiJ1CeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:34:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAE7BD67D;
        Thu, 27 Oct 2022 19:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ux3rx5EhkSfduAU36h1Dq/J6BDBBDDTsHvoL89DBoLU=; b=TjxEMc7GFjEDHVnd08+Mcpwg++
        bzWLwWYd3EjGF+gr2VuywVnBc+TDhkf3DPJdKacP3UgYFhdXLQd95ET7HL37Mhuow9VjjsO9lyWPn
        OHYG2HnVk5lWJ4MwiR39JNoa1SxO8IzLMHHJpTbPH8In6xv5v0JY85tAslqLgGaBICiO+cVXXlTqp
        4t/RxHp8zp0jChA7SucLF3GqvEvvx2F93AJiXQbicxw0zUt7Jv6XBrdH4nWw+POlSUSCgZCFVaSPt
        DqP5m4i+iVZp4bmqVISSX2+PWk8f6gk623mngHsNcDxLq3vbhnvJSoUOl+x58jkQzJIV8s1q5c33P
        Y+ohDAJw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooFBy-00Eorl-0B;
        Fri, 28 Oct 2022 02:33:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] iov_iter: saner checks for attempt to copy to/from iterator
Date:   Fri, 28 Oct 2022 03:33:51 +0100
Message-Id: <20221028023352.3532080-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

instead of "don't do it to ITER_PIPE" check for ->data_source being
false on copying from iterator.  Check for !->data_source for
copying to iterator, while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 020e009d71c5..df0e8fa1a8a2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -520,6 +520,8 @@ static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
+	if (WARN_ON(i->data_source))
+		return 0;
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_pipe_to_iter(addr, bytes, i);
 	if (user_backed_iter(i))
@@ -606,6 +608,8 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
  */
 size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
+	if (WARN_ON(i->data_source))
+		return 0;
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_mc_pipe_to_iter(addr, bytes, i);
 	if (user_backed_iter(i))
@@ -622,10 +626,9 @@ EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
+	if (WARN_ON(!i->data_source))
 		return 0;
-	}
+
 	if (user_backed_iter(i))
 		might_fault();
 	iterate_and_advance(i, bytes, base, len, off,
@@ -639,10 +642,9 @@ EXPORT_SYMBOL(_copy_from_iter);
 
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
+	if (WARN_ON(!i->data_source))
 		return 0;
-	}
+
 	iterate_and_advance(i, bytes, base, len, off,
 		__copy_from_user_inatomic_nocache(addr + off, base, len),
 		memcpy(addr + off, base, len)
@@ -671,10 +673,9 @@ EXPORT_SYMBOL(_copy_from_iter_nocache);
  */
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
+	if (WARN_ON(!i->data_source))
 		return 0;
-	}
+
 	iterate_and_advance(i, bytes, base, len, off,
 		__copy_from_user_flushcache(addr + off, base, len),
 		memcpy_flushcache(addr + off, base, len)
@@ -714,6 +715,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 	size_t res = 0;
 	if (!page_copy_sane(page, offset, bytes))
 		return 0;
+	if (WARN_ON(i->data_source))
+		return 0;
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
 	page += offset / PAGE_SIZE; // first subpage
@@ -811,9 +814,8 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
+	if (WARN_ON(!i->data_source)) {
 		kunmap_atomic(kaddr);
-		WARN_ON(1);
 		return 0;
 	}
 	iterate_and_advance(i, bytes, base, len, off,
@@ -1525,10 +1527,9 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 {
 	__wsum sum, next;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
-		WARN_ON(1);
+	if (WARN_ON(!i->data_source))
 		return 0;
-	}
+
 	iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_from_user(base, addr + off, len);
 		sum = csum_block_add(sum, next, off);
@@ -1548,6 +1549,8 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	struct csum_state *csstate = _csstate;
 	__wsum sum, next;
 
+	if (WARN_ON(i->data_source))
+		return 0;
 	if (unlikely(iov_iter_is_discard(i))) {
 		// can't use csum_memcpy() for that one - data is not copied
 		csstate->csum = csum_block_add(csstate->csum,
-- 
2.30.2

