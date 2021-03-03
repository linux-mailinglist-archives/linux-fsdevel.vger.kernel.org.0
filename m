Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402CD32C4FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359491AbhCDASr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354906AbhCCGIU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:08:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E01064EBD;
        Wed,  3 Mar 2021 06:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614751658;
        bh=03wcpTwHahDBsiSbVcpeFCVxgD9QL3kxEznzoucjZUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jx/JVO4MnKxyigL9ai/tLjmttmUs2C41FzRTRFKaORumw57eY6QuomDS7H6DTsHBD
         2BYjnPJKl3oZB3SzW1wHAnyx+X6lf+DLB/lQHMQege7J6fSSRiyZY+Q7ymMShA93CV
         36DLphGpISvamlNUHRfRnxclRvObLisuVRy2ULCE=
Date:   Tue, 2 Mar 2021 22:07:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/filemap: Use filemap_read_page in filemap_fault
Message-Id: <20210302220735.1f150f28323f676d2955ab49@linux-foundation.org>
In-Reply-To: <20210303013313.GZ2723601@casper.infradead.org>
References: <20210226140011.2883498-1-willy@infradead.org>
        <20210302173039.4625f403846abd20413f6dad@linux-foundation.org>
        <20210303013313.GZ2723601@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 3 Mar 2021 01:33:13 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Mar 02, 2021 at 05:30:39PM -0800, Andrew Morton wrote:
> > On Fri, 26 Feb 2021 14:00:11 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > 
> > > After splitting generic_file_buffered_read() into smaller parts, it
> > > turns out we can reuse one of the parts in filemap_fault().  This fixes
> > > an oversight -- waiting for the I/O to complete is now interruptible
> > > by a fatal signal.  And it saves us a few bytes of text in an unlikely
> > > path.
> > 
> > We also handle AOP_TRUNCATED_PAGE which the present code fails to do. 
> > Should this be in the changelog?
> 
> No, the present code does handle AOP_TRUNCATED_PAGE.  It's perhaps not
> the clearest in the diff, but it's there.  Here's git show -U5:
> 
> -       ClearPageError(page);
>         fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -       error = mapping->a_ops->readpage(file, page);
> -       if (!error) {
> -               wait_on_page_locked(page);
> -               if (!PageUptodate(page))
> -                       error = -EIO;
> -       }
> +       error = filemap_read_page(file, mapping, page);
>         if (fpin)
>                 goto out_retry;
>         put_page(page);
>  
>         if (!error || error == AOP_TRUNCATED_PAGE)
>                 goto retry_find;
>  
> -       shrink_readahead_size_eio(ra);
>         return VM_FAULT_SIGBUS;

But ->readpage() doesn't check for !mapping (does it?).  So the
->readpage() cannot return AOP_TRUNCATED_PAGE.

However filemap_read_page() does check for !mapping.  So current -linus
doesn't check for !mapping, and post-willy does do this?
