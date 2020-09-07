Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D060D2605B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgIGUhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 16:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbgIGUhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:37:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E15C061755;
        Mon,  7 Sep 2020 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TFwGHGfKe+HZJQRFWe+TXpSvT9u+E0qJCWrNre5pxiE=; b=jXmghTJy/3FfDdWwKm8BWwfwX6
        55oGdWz/+oZYpM2N2GVt2YoAGJPFQJRyrEjl8YOioSnW2VcB2IXn5/+zygxK8FgLb8dJ3YQZ6/QF3
        otE3V519s9Li3tARQBzRl6mDdAHkJrI9BAyMXr0Tj3s37cyiTA+CEToybsOQoYrnwyJiqX9dN/A0z
        u8lFGTir6IethBr3P/k6JBZlB0rWIcfJkE2zMKK6ENYQEptDoikKpv4mYufiQvetKjbL7pyPOl01S
        j4n80nsxIKg2SIVS5yp8xPURzNLaUFHj9HriPEyb2uCBJzjH31A+cgGpG8tdztPfpIlU0Hzlv/14r
        aZP0ax4w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFNsy-00013B-J4; Mon, 07 Sep 2020 20:37:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Fix silent write loss in iomap
Date:   Mon,  7 Sep 2020 21:37:05 +0100
Message-Id: <20200907203707.3964-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While working on the THP patchset, I decided to inject errors, and
unfortunately I found a hole in our handling of errors with non-THPs.
You can probably reproduce these errors by inserting your own error
injection for readahead pages; mine is a little too tied to the THP
patchset to post.

The basic outline of the problem is:

 - read(ahead) hits an error, page is marked Error, !Uptodate
 - write_begin succeeds at reading in page, but it is not marked
   Uptodate due to PageError being set
 - write path copies data to page, write() call returns success
 - subsequent read() sees a page which is !Uptodate, clears Error,
   calls ->readpage, re-reads data from storage, overwrites data
   from write() with old data.

The solution presented here is to behave compatibly with mm/filemap.c.
I don't _like_ how we handle PageError for read errors.  See that other
mail to linux-fsdevel for details, but this solution fixes an error that
can be hit by people with flaky storage.

I've done this as two patches because there are actually two independent
problems here.  The bug is not fixed without applying both patches, so
I'm happy to combine them into a single patch if that makes life easier.

The problem was introduced with commit 9dc55f1389f9, which made setting
PageUptodate conditional on PageError().

Matthew Wilcox (Oracle) (2):
  iomap: Clear page error before beginning a write
  iomap: Mark read blocks uptodate in write_begin

 fs/iomap/buffered-io.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
2.28.0

