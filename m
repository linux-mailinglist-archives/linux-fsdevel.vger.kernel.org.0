Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC15260570
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 22:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgIGUOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgIGUOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:14:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFFEC061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2020 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sO8ozAneCTe/A6QkBFj0/1VJmirKRqD5ifrSbJ0zlPc=; b=Kl/+sRuvWZas/bcj4AKe7eGfkv
        8fd30ybFVLJoV4+aw7cEkLsV7hFyQ4hoSfiwdOYpnucSGOx2bUiUhTbkQ+kSm0Kr7VVzY9z6YY+aD
        yxCYBwfdi3aXBvsNEobDlqqSvhgEZK6kvDcEQviSH9Daymj4VGlGMrqGFs6A4/petu33L2+pMqzWD
        B8mfUgttLHXrWeAGTH7egPNj7kzRNHeDDtx/+PyJ8urumi6hgpG5GpADD9tCxJGS8GCXv+YXk5Nwb
        oWezxm8UmRfEcTr9dpJVS5vE5dSKjNVi5UwB0ixjZtEzyz9WCNb/ODGDv4eV5e3ZjJRmUd1D6zbE/
        gqOHqTig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFNX7-0007gF-La
        for linux-fsdevel@vger.kernel.org; Mon, 07 Sep 2020 20:14:33 +0000
Date:   Mon, 7 Sep 2020 21:14:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Subject: [RFC] Make ->readpage synchronous
Message-ID: <20200907201433.GB27537@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ever since akpm introduced ->readpages() in 2002, it has been the
primary way to bring pages into cache.  Even though it's now been
replaced with ->readahead(), it's still the way to bring pages into
cache asynchronously.

Three of the four current callers of ->readpage rely on readahead to
bring pages into cache asynchronously and want synchronous semantics
from ->readpage.

generic_file_buffered_read():
                error = mapping->a_ops->readpage(filp, page);
                if (!PageUptodate(page)) {
                        error = lock_page_killable(page);

filemap_fault():
        error = mapping->a_ops->readpage(file, page);
        if (!error) {
                wait_on_page_locked(page);

do_read_cache_page():
                        err = mapping->a_ops->readpage(data, page);
                page = wait_on_page_read(page);

(if your brain isn't as deep into the page cache as mine is right now,
the page remains locked until I/O has completed, so all of these calls
wait for I/O to complete).

The one caller which (maybe?) wants async semantics is swap-over-NFS (the
SWP_FS case in swap_readpage()).  I'm not really familiar with the swap
code.  Should this switch to using ->direct_IO like __swap_writepage()?
Or ->read_iter() perhaps?

So the way is clear for everyone except NFS to start to move to having
a synchronous ->readpage().  I think we're all in favour of gradual
transitions.  My plan is to add a new return code from ->readpage called
AOP_UPDATED_PAGE (to rhyme with AOP_TRUNCATED_PAGE).  The semantics
are that the page has remained locked since ->readpage was called,
the necessary read I/Os have completed and PageUptodate is now true.

So why bother?  Better error handling.  If you do async readpage, the best
we can do is -EIO, because we only have one bit.  With a sync readpage,
the fs can return any error from ->readpage.  We can also stop using
the PageError bit for both read and write errors.  Which means we can
stop _clearing_ the PageError bit in the VFS before we call into the
filesystem, potentially losing the information that this page had a
write error.

So, to recap, in the new scheme, if you get an error while doing an async
read, leave the page !Uptodate, don't set PageError.  The VFS will notice
the page is !Uptodate (this can happen for a number of reasons, not just a
failed ->readahead) and call ->readpage().  At that point, your fs should
retry the read.  It can return whatever errno it likes at that point.
Or the read succeeds this time and you return AOP_UPDATED_PAGE to let
the VFS know you succeeded without unlocking the page.

You may get to see the AOP_UPDATED_PAGE return code appear soon ...
it solves an unrelated problem for me with the THP code (where the
requested page is Uptodate, but the entire THP is !Uptodate)
