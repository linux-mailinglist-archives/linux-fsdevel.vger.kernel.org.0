Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FD61081D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 04:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiJ1CeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiJ1CeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:34:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5687BE2F5;
        Thu, 27 Oct 2022 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fVteMAVIVg+91bTuLaocFDEKI259Dr9+CPyGCGwShcc=; b=ijcu/m4XkLYK3DKlJDahWgJHiW
        mu7ewOaipKjhqe8VSwqNcZrMyfILUJsa2yaMpnmbZVxHA5i3JWu6p/V0JfsAfj48zCsFoHd3YLmOt
        W01JhZsZst4iSFEpppNf0MEqyWOTaXTYlGSc3NLkewsdvMRN00foyNDwR016b8PpHvZo/LKktG6ty
        MXuZ13R+s+K9VtWA2tvb7xaYR/SlUqxnGEQKVOT6YaVhxbYNRWPcd1wpEdp+lzWrFjBgwtVu+3LUS
        fP6w3UjjniYWMPy29/vK7NAp1gDNZyW3VKJITWWsNvR+1mP8W70AvsKCFX+mWhOMS3BghRETljTH7
        Dq1sletg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooFBw-00Eor9-0O;
        Fri, 28 Oct 2022 02:33:52 +0000
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
Subject: [PATCH v2 01/12] get rid of unlikely() on page_copy_sane() calls
Date:   Fri, 28 Oct 2022 03:33:41 +0100
Message-Id: <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <Y1btOP0tyPtcYajo@ZenIV>
References: <Y1btOP0tyPtcYajo@ZenIV>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c3ca28ca68a6..e9a8fc9ee8ee 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -703,17 +703,16 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 	head = compound_head(page);
 	v += (page - head) << PAGE_SHIFT;
 
-	if (likely(n <= v && v <= (page_size(head))))
-		return true;
-	WARN_ON(1);
-	return false;
+	if (WARN_ON(n > v || v > page_size(head)))
+		return false;
+	return true;
 }
 
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
 	size_t res = 0;
-	if (unlikely(!page_copy_sane(page, offset, bytes)))
+	if (!page_copy_sane(page, offset, bytes))
 		return 0;
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
@@ -808,7 +807,7 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 				  struct iov_iter *i)
 {
 	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
-	if (unlikely(!page_copy_sane(page, offset, bytes))) {
+	if (!page_copy_sane(page, offset, bytes)) {
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-- 
2.30.2

