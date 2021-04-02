Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CF352B1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhDBNvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBNvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:51:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F132EC0613E6;
        Fri,  2 Apr 2021 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ojnb5AIvRYpHX3nwnaimhPwXRkxGFRq4anavZ06KIcI=; b=A9CmSiqJOUZw+FjiFGvjfONx76
        7f9d8eSVn8bxnE1bFTz4yK2ITxpmhlxKrHZfGByE6RdDKzoUa96V+h6/70XUpdxHzuZQY/esWkEa/
        zmpX0+bcTGAbxBOIPWgU1ckx/krtVPfz8jK11qb3At656T1LQ486yxUFYx9LHSWeX7JKs53wlMXst
        5V4ktpU0iVkI+MR9gEPWsDCmchm/vOUUaQyNWwEr9E4id+dyu46pg6X1kQ777PpNALbjQwboGLkfR
        gHQwdFzYJnXfhB91htKAJXkL+8RqW4elR1xFm/orVtWCMd3Bo02ynVxc2S4k2qkMNXB4hQb3U5Egp
        N/SeSzuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lSKC7-007hZo-0W; Fri, 02 Apr 2021 13:50:48 +0000
Date:   Fri, 2 Apr 2021 14:50:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] Convert sysv filesystem to use folios exclusively
Message-ID: <20210402135038.GN351017@casper.infradead.org>
References: <20210325032202.GS1719932@casper.infradead.org>
 <CAOQ4uxikP_GFNYzgatON2dRQyiHvTBP5iO4Xk091ruLUBDMt-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxikP_GFNYzgatON2dRQyiHvTBP5iO4Xk091ruLUBDMt-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 02, 2021 at 09:19:36AM +0300, Amir Goldstein wrote:
> On Thu, Mar 25, 2021 at 5:43 AM Matthew Wilcox <willy@infradead.org> wrote:
> > I decided to see what a filesystem free from struct page would look
> > like.  I chose sysv more-or-less at random; I wanted a relatively simple
> > filesystem, but I didn't want a toy.  The advantage of sysv is that the
> > maintainer is quite interested in folios ;-)
> 
> I would like to address only the social engineering aspect of the s/page/folio
> conversion.
> 
> Personally, as a filesystem developer, I find the concept of the folio
> abstraction very useful and I think that the word is short, clear and witty.
> 
> But the example above (writepage = sysv_write_folio) just goes to show
> how deeply rooted the term 'page' is throughout the kernel and this is
> just the tip of the iceberg. There are documents, comments and decades
> of using 'page' in our language - those will be very hard to root out.
> 
> My first impression from looking at sample patches is that 90% of the churn
> does not serve any good purpose and by that, I am referring to the
> conversion of local variable names and struct field names s/page/folio.
> 
> Those conversions won't add any clarity to subsystems that only need to
> deal with the simple page type (i.e. non-tail pages).
> The compiler type checks will have already did that job already and changing
> the name of the variables does not help in this case.
> 
> I think someone already proposed the "boring" name struct page_head as
> a replacement for the "cool" name struct folio.
> 
> Whether it's page_head, page_ref or what not, anything that can
> be written in a way that these sort of "thin" conversions make sense:
> 
> -static int sysv_readpage(struct file *file, struct page *page)
> +static int sysv_readpage(struct file *file, struct page_head *page)
>  {
>        return block_read_full_page(page, get_block);
>  }
> 
> So when a filesystem developer reviews your conversion patch
> he goes: "Whatever, if the compiler says this is fine, it's fine".

The problem with page_head is that head page already has a meaning,
which is that there are definitely tail pages following it.  Hence
'folio' for 'head or base page'.

I think reasonable people can disagree on whether we should keep the
address_space operation called readpage or rename it to read_folio.
I agree with you that the word "page" is deeply ingrained in our
vocabulary.  The problem is that we don't all agree on what it means.

I am proposing splitting the two meanings, where page refers to the
finest granularity at which things are mapped by the MMU and folio is
used to refer to a group of pages which are managed together by the MM.
This is necessarily going to be churn because we've been using 'page'
for both for so very long.

As far as "thin" conversions go, here's the commit where I do the readpage
conversion to folio:

https://git.infradead.org/users/willy/pagecache.git/commitdiff/a3912fc2313e5c249e3d5b85eefd3394b0745b8f

Some really are as simple as you propose:

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 974dd567e00fe73d1a7a414f3c5e9974e22b8a1e..1d2e228c49e756b55e8fe1ce166b64ca119ca96a 100644 (file)
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -635,9 +635,9 @@ static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
        return block_write_full_page(page, blkdev_get_block, wbc);
 }
 
-static int blkdev_readpage(struct file * file, struct page * page)
+static int blkdev_readpage(struct file *file, struct folio *folio)
 {
-       return block_read_full_page(page, blkdev_get_block);
+       return block_read_full_page(folio, blkdev_get_block);
 }
 
 static void blkdev_readahead(struct readahead_control *rac)

Arguably, I should also rename block_read_full_page() to block_read_folio()
as part of this commit.  And I probably shouldn't be as enthusiastic about
spreading folios around in the same commit, eg I do this to btrfs:

+++ b/fs/btrfs/free-space-cache.c
@@ -450,15 +450,16 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 
                io_ctl->pages[i] = page;
                if (uptodate && !PageUptodate(page)) {
-                       btrfs_readpage(NULL, page);
-                       lock_page(page);
-                       if (page->mapping != inode->i_mapping) {
+                       struct folio *folio = page_folio(page);
+                       btrfs_readpage(NULL, folio);
+                       lock_folio(folio);
+                       if (folio->page.mapping != inode->i_mapping) {
                                btrfs_err(BTRFS_I(inode)->root->fs_info,
                                          "free space cache page truncated");
                                io_ctl_drop_pages(io_ctl);
                                return -EIO;
                        }
-                       if (!PageUptodate(page)) {
+                       if (!FolioUptodate(folio)) {
                                btrfs_err(BTRFS_I(inode)->root->fs_info,
                                           "error reading free space cache");
                                io_ctl_drop_pages(io_ctl);

where it could just be:


-                       btrfs_readpage(NULL, page);
+			btrfs_readpage(NULL, page_folio(page));

and save all the benefits of using folios to a later patch.

those kinds of things are why I haven't submitted that patch for
review yet.
