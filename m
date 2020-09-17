Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC9226D1C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 05:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIQDaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 23:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIQDaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:30:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ED7C06174A;
        Wed, 16 Sep 2020 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZfJS/f94/KKMV+Mccd9pRniL7TH36xiMBW1d5y04Aj8=; b=EX0cU1ou1P3jaAsaDLeoOiLSqS
        mpJxcZClyN7A/RxlPuDO+uLp/wWLe8+zS3tZhZ6gSYArpXlRnCCZqieAvt0KZy9UpEqn+NwzdV1+Z
        7q71orzFU1qK9I2vlfUUB0OlhaJAej5di8m2n493sVqTnPyqSQKoW5HSFq3nH3/cUDZhJjUPF5rlU
        J0h7/9LgDSD8rQI1Q6gBl6AfrL3YbkqezqoXnB5w9r+sj/MuHiIQfCeM0U9ldilA32SFxAValxk/H
        9XKnI0m4GYu/NSW4qXaPK+UhPQxpEM8Dl/XD2xnLOSuR/4bbTTiRH3DI40oBgw9sjwwNaARQE3imp
        NoOd9b/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIkcn-0007dR-B9; Thu, 17 Sep 2020 03:30:21 +0000
Date:   Thu, 17 Sep 2020 04:30:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: THP support for btrfs
Message-ID: <20200917033021.GR5449@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I was pointed at the patches posted this week for sub-page support in
btrfs, and I thought it might be a good idea to mention that THP support
is going to hit many of the same issues as sub-PAGE_SIZE blocks, so if
you're thinking about sub-page block sizes, it might be a good idea to
add THP support at the same time, or at least be aware of it when you're
working on those patches to make THP work in the future.

While the patches have not entirely landed yet, complete (in that it
passes xfstests on my laptop) support is available here:
http://git.infradead.org/users/willy/pagecache.git

About 40 of the 100 patches are in Andrew Morton's tree or the iomap
tree waiting for the next merge window, and I'd like to get the rest
upstream in the merge window after that.  About 20-25 of the patches are
to iomap/xfs and the rest are generic MM/FS support.

The first difference you'll see after setting the flag indicating
that your filesystem supports THPs is transparent huge pages being
passed to ->readahead().  You should submit I/Os to read every byte
in those pages, not just the first PAGE_SIZE bytes ;-)  Likewise, when
writepages/writepage is called, you'll want to write back every dirty
byte in that page, not just the first PAGE_SIZE bytes.

If there's a page error (I strongly recommend error injection), you'll
also see these pages being passed to ->readpage and ->write_begin
without being PageUptodate, and again, you'll have to handle reads
for the parts of the page which are not Uptodate.

You'll have to handle invalidatepage being called from the truncate /
page split path.

page_mkwrite can be called with a tail page.  You should be sure to mark
the entire page as dirty (we only track dirty state on a per-THP basis,
not per-subpage basis).

---

I see btrfs is switching to iomap for the directIO path.  Has any
consideration been given to switching to iomap for the buffered I/O path?
Or is that just too much work?
