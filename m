Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793E5290507
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407479AbgJPM2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 08:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405601AbgJPM2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:28:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B99C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F5azy1C+DHm5sWEovkALlRq6rf8uP+uxnGoxIcsol1Y=; b=FXKKcMQzE/3gOVuBZ+SUutLO8h
        P6iDD5g0oWQMrNdhYk2KAllWnu49bPdTlHFgWEuD5Tcpfj60oMPox/nMiNQse2WzRBhmaZ0zYKc9P
        vtAxxyo+mUHHqKrLVHHujm76H/6KkGu2r5EzMo00NhvZWmW8BxdXULjqJd+NY9l0SQtHFk6S65Rbx
        fKNySLt9Ur6U0mXMt0GL3rdWhz7HDzCQZktD64PfaAA59OXfo5ZPKVkwGKE2MdDhg008cC/5Jk5hu
        KoNEHdt7CcE3XCA7wTUn8fps8GXVfwoC48WNBFZUswFwoppezge+RYMbVTQR4yZe0T6XMS0uIAxfE
        JSq5ISHw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTOpy-0007mL-BV; Fri, 16 Oct 2020 12:27:58 +0000
Date:   Fri, 16 Oct 2020 13:27:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, Qian Cai <cai@lca.pw>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
Message-ID: <20201016122758.GE20115@casper.infradead.org>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
 <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com>
 <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 12:02:21PM +0200, Miklos Szeredi wrote:
> This was added by commit ea9b9907b82a ("fuse: implement
> perform_write") in v2.6.26 and remains essentially unchanged, AFAICS.
> So this is an old bug indeed.
> 
> So what is the page lock protecting?   I think not truncation, because
> inode_lock should be sufficient protection.
> 
> What it does after sending a synchronous WRITE and before unlocking
> the pages is set the PG_uptodate flag, but only if the complete page
> was really written, which is what the uptodate flag really says:  this
> page is in sync with the underlying fs.

Not in sync with.  Uptodate means "every byte on this page is at least
as new as the bytes on storage".  Dirty means "at least one byte is
newer than the bytes on storage".

> So I think the page lock here is trying to protect against concurrent
> reads/faults on not uptodate pages.  I.e. until the WRITE request
> completes it is unknown whether the page was really written or not, so
> any reads must block until this state becomes known.  This logic falls
> down on already cached pages, since they start out uptodate and the
> write does not clear this flag.

That's not how the page cache should work -- if a write() has touched
every byte in a page, then the page should be marked as Uptodate, and it
can immediately satisfy read()s without even touching the backing store.

> So keeping the pages locked has dubious value: short writes don't seem
> to work correctly anyway.  Which means that we can probably just set
> the page uptodate right after filling it from the user buffer, and
> unlock the page immediately.
> 
> Am I missing something?

I haven't looked at fuse in detail -- are you handling partial page
writes?  That is, if someone writes to bytes 5-15 of a file, are you
first reading bytes 0-4 and 16-4095 from the backing store?  If so,
you can mark the page Uptodate as soon as you've copied bytes 5-15
from the user.
