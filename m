Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5D9724AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 20:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjFFSIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 14:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbjFFSIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:08:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886A1730;
        Tue,  6 Jun 2023 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ie1db8N9V0M6Yogyw2EjaVMj665tiZSmITTGtrkMxk=; b=wAj6PBdSP2jrRyeQ8YhpKNLd2d
        XuwB8qrpTortcDiX11wO+JKvFQAzrqzdq1njdeQodEcraQFqjx0CoaaZgwtEgXm18u1eT9Z5QpqYN
        SVjM7zPxQRLycMSifGq4dXJp6bDjX/I6Mb8oaFFyEUs+CCwFiozqG2L8JSzmHBlCLhFfUNm/VKWiD
        lL025uQae5hZiTpR2SnryhLuSYFjhgLnQ7ERCBitnSUbvLCUmqNgFXbv6PGvi/rAHJ0rh+Odv8dYQ
        HSOq65CxN5RV5p6DzqE5/xa3yTkmfFYjMbhwVkIr0OY4mioay6tt6x0+VTV7VBDThWQrFynPtrGct
        O/C3fWlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6b61-00DOWU-IF; Tue, 06 Jun 2023 18:07:53 +0000
Date:   Tue, 6 Jun 2023 19:07:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
Message-ID: <ZH91+QWd3k8a2x/Z@casper.infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-8-willy@infradead.org>
 <20230604182952.GH72241@frogsfrogsfrogs>
 <ZH0MDtoTyUMQ7eok@casper.infradead.org>
 <d47f280e-9e98-ffd2-1386-097fc8dc11b5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47f280e-9e98-ffd2-1386-097fc8dc11b5@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:25:22PM +0800, Yin, Fengwei wrote:
> On 6/5/2023 6:11 AM, Matthew Wilcox wrote:
> > On Sun, Jun 04, 2023 at 11:29:52AM -0700, Darrick J. Wong wrote:
> >> On Fri, Jun 02, 2023 at 11:24:44PM +0100, Matthew Wilcox (Oracle) wrote:
> >>> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> >>> +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
> >>
> >> I think I've gotten lost in the weeds.  Does copy_page_from_iter_atomic
> >> actually know how to deal with a multipage folio?  AFAICT it takes a
> >> page, kmaps it, and copies @bytes starting at @offset in the page.  If
> >> a caller feeds it a multipage folio, does that all work correctly?  Or
> >> will the pagecache split multipage folios as needed to make it work
> >> right?
> > 
> > It's a smidgen inefficient, but it does work.  First, it calls
> > page_copy_sane() to check that offset & n fit within the compound page
> > (ie this all predates folios).
> > 
> > ... Oh.  copy_page_from_iter() handles this correctly.
> > copy_page_from_iter_atomic() doesn't.  I'll have to fix this
> > first.  Looks like Al fixed copy_page_from_iter() in c03f05f183cd
> > and didn't fix copy_page_from_iter_atomic().
> > 
> >> If we create a 64k folio at pos 0 and then want to write a byte at pos
> >> 40k, does __filemap_get_folio break up the 64k folio so that the folio
> >> returned by iomap_get_folio starts at 40k?  Or can the iter code handle
> >> jumping ten pages into a 16-page folio and I just can't see it?
> > 
> > Well ... it handles it fine unless it's highmem.  p is kaddr + offset,
> > so if offset is 40k, it works correctly on !highmem.
> So is it better to have implementations for !highmem and highmem? And for
> !highmem, we don't need the kmap_local_page()/kunmap_local() and chunk
> size per copy is not limited to PAGE_SIZE. Thanks.

No, that's not needed; we can handle that just fine.  Maybe this can
use kmap_local_page() instead of kmap_atomic().  Al, what do you think?
I haven't tested this yet; need to figure out a qemu config with highmem ...

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 960223ed9199..d3d6a0789625 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -857,24 +857,36 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
-size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
-				  struct iov_iter *i)
+size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
+		size_t bytes, struct iov_iter *i)
 {
-	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
-	if (!page_copy_sane(page, offset, bytes)) {
-		kunmap_atomic(kaddr);
+	size_t n = bytes, copied = 0;
+
+	if (!page_copy_sane(page, offset, bytes))
 		return 0;
-	}
-	if (WARN_ON_ONCE(!i->data_source)) {
-		kunmap_atomic(kaddr);
+	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
+
+	page += offset / PAGE_SIZE;
+	offset %= PAGE_SIZE;
+	if (PageHighMem(page))
+		n = min_t(size_t, bytes, PAGE_SIZE);
+	while (1) {
+		char *kaddr = kmap_atomic(page) + offset;
+		iterate_and_advance(i, n, base, len, off,
+			copyin(kaddr + off, base, len),
+			memcpy_from_iter(i, kaddr + off, base, len)
+		)
+		kunmap_atomic(kaddr);
+		copied += n;
+		if (!PageHighMem(page) || copied == bytes || n == 0)
+			break;
+		offset += n;
+		page += offset / PAGE_SIZE;
+		offset %= PAGE_SIZE;
+		n = min_t(size_t, bytes - copied, PAGE_SIZE);
 	}
-	iterate_and_advance(i, bytes, base, len, off,
-		copyin(p + off, base, len),
-		memcpy_from_iter(i, p + off, base, len)
-	)
-	kunmap_atomic(kaddr);
-	return bytes;
+	return copied;
 }
 EXPORT_SYMBOL(copy_page_from_iter_atomic);
 
