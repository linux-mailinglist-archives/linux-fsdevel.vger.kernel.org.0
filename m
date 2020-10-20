Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E145C2932C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 03:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbgJTBoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390146AbgJTBoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57F6C0613D1;
        Mon, 19 Oct 2020 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xEnEQq4nhEt/2fPSUDq2nZHDfs7mNAitmj1S5VLZSMQ=; b=arOkUU5TY+O40I7N80zRWQ7QRE
        ajSuiRELkQGbs6eHaqqV5F/WyGEB4H3JPVOXpSWgU6kUIE+bv3arCj1FpkhyxLdju6oRAInySSd9L
        vkOSSJ9pv6Zz+JcOer6LBC+ZZnD4q1IFEaw8Xquomh1ophb7vr8WrfOcrs9Pze94KGaVCMoFMQXl2
        NhV7WslroeNk+CrkVQLAG4aGFZ3OR64tDmEu38zS6hyqFuU8AvBV39pOlYvhjhZUF3KNFhVLJbVlP
        5Mr2ksaT5XcV8daulnEHfFV5kFByINcWwznHKNr+uqvN+XI6DdYh1QbvaimVBsumhK+OOU3wqHeZv
        LQTdq5Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUggv-0002jF-Nt; Tue, 20 Oct 2020 01:43:57 +0000
Date:   Tue, 20 Oct 2020 02:43:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Splitting a THP beyond EOF
Message-ID: <20201020014357.GW20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a weird one ... which is good because it means the obvious
ones have been fixed and now I'm just tripping over the weird cases.
And fortunately, xfstests exercises the weird cases.

1. The file is 0x3d000 bytes long.
2. A readahead allocates an order-2 THP for 0x3c000-0x3ffff
3. We simulate a read error for 0x3c000-0x3cfff
4. Userspace writes to 0x3d697 to 0x3dfaa
5. iomap_write_begin() gets the 0x3c page, sees it's THP and !Uptodate
   so it calls iomap_split_page() (passing page 0x3d)
6. iomap_split_page() calls split_huge_page()
7. split_huge_page() sees that page 0x3d is beyond EOF, so it removes it
   from i_pages
8. iomap_write_actor() copies the data into page 0x3d
9. The write is lost.

Trying to persuade XFS to update i_size before calling
iomap_file_buffered_write() seems like a bad idea.

Changing split_huge_page() to disregard i_size() is something I kind
of want to be able to do long-term in order to make hole-punch more
efficient, but that seems like a lot of work right now.

I think the easiest way to fix this is to decline to allocate readahead
pages beyond EOF.  That is, if we have a file which is, say, 61 pages
long, read the last 5 pages into an order-2 THP and an order-0 THP
instead of allocating an order-3 THP and zeroing the last three pages.

It's probably the right thing to do anyway -- we split THPs that overlap
the EOF on a truncate.  I'll start implementing this in the morning,
but I thought I'd share the problem & proposed solution in case anybody
has a better idea.
