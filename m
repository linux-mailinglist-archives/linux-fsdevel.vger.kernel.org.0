Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7245474AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 14:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiFKM4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiFKM4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:56:40 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E208D4D27F;
        Sat, 11 Jun 2022 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7ECfJmBbWYtsqTXzwSBapwigRDimRB+yDzUlyko8m0Q=; b=F6iHrQPjuQ0xyu1RiBQyyxM9F8
        TcajGIhz0LksFuaovI+QcylO9H9gAsrApJ84iWn5V87n5JeGUxnBgj5FeafaDSF2JmGXalnMLBsFd
        oM8+Vr1ym3K1cHkHVWZvfvSsg2mJAOaMZvY9PEpsAMBIy+qdF+XWvxaL59M65mOXijYkVKD4DDlqH
        RTHSBf4LnWGrpJxxoz9XGy6BrJthRT6bsBsM5eA5DEFgt+FtLuieMpIjasRz4AlRLrL7lbv3gblnB
        clfzSQFsuxXr91IrsOwX1z2kbaUi1nJ+q1N/tedWPrQ7d3Wy0egh1nQmatU4Xp6cBdtQsCDk9nltB
        NYkWpItA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o00fD-0066DC-RO; Sat, 11 Jun 2022 12:56:27 +0000
Date:   Sat, 11 Jun 2022 12:56:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
 <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 12:37:44PM +0000, Al Viro wrote:
> On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:
> 
> 
> > At a guess, should be
> > 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> > 
> > in both places.  I'm more than half-asleep right now; could you verify that it
> > (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> > builds correctly?
> 
> No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
> On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
> OK (both have the same range there), but it triggers the tests.  Try 
> 
> 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> 
> there (both places).

The reason we can't overflow on multiplication there, BTW, is that we have
nr <= count, and count has come from weirdly open-coded
	DIV_ROUND_UP(size + offset, PAGE_SIZE)
IMO we'd better make it explicit, so how about the following:

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index dda6d5f481c1..150dbd314d25 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1445,15 +1445,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	offset = pos & ~PAGE_MASK;
 	*_start_offset = offset;
 
-	count = 1;
-	if (size > PAGE_SIZE - offset) {
-		size -= PAGE_SIZE - offset;
-		count += size >> PAGE_SHIFT;
-		size &= ~PAGE_MASK;
-		if (size)
-			count++;
-	}
-
+	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
 	if (count > maxpages)
 		count = maxpages;
 
@@ -1461,7 +1453,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	return min(nr * PAGE_SIZE - offset, maxsize);
+	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 }
 
 /* must be done on non-empty ITER_IOVEC one */
@@ -1607,15 +1599,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	offset = pos & ~PAGE_MASK;
 	*_start_offset = offset;
 
-	count = 1;
-	if (size > PAGE_SIZE - offset) {
-		size -= PAGE_SIZE - offset;
-		count += size >> PAGE_SHIFT;
-		size &= ~PAGE_MASK;
-		if (size)
-			count++;
-	}
-
+	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
 	p = get_pages_array(count);
 	if (!p)
 		return -ENOMEM;
@@ -1625,7 +1609,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	return min(nr * PAGE_SIZE - offset, maxsize);
+	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 }
 
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
