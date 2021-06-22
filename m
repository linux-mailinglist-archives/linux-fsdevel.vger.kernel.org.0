Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505173B092E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhFVPf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhFVPf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:35:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DFAC061574;
        Tue, 22 Jun 2021 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=onXjNZqYJvcXEs5IHU9oGds+e0Y699nhJ9IN46Qq5mk=; b=PCnfHk7hpZ8eK7iPoYxSOSuj6G
        1tUFbwnesmnCZZYpqC+8zpn7nVezeIhTJkGu3HAru4xuQ2ITGOzB8rB2u+pBNY4mmQw34951UjgFH
        mkqMzGLYQtulSDgUlSbcIfhLz3aB29WXpvSyL2e7scCCUjelbAgXrGW4GZGgsqBLTiPRK7GW8ArFm
        FRbOPhnArtDCAec9CaxrQYaa+7NpPDmEHZMyjUOpucSyIEY9haZEuWXLnPWsLPjGsnG/M+jWtHpWI
        Z2RI2N1TZCBEL12bboLdGP76RpuzQ9y47vG1zzN27I7NcDTcMgImIBnzLe/6veLF3VFjals1bMlsO
        1rTQ37uA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lviO7-00ERke-6n; Tue, 22 Jun 2021 15:32:37 +0000
Date:   Tue, 22 Jun 2021 16:32:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Message-ID: <YNICj+bHUuIQCTFZ@casper.infradead.org>
References: <3221175.1624375240@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3221175.1624375240@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 04:20:40PM +0100, David Howells wrote:
> and wondering if the iov_iter_fault_in_readable() is actually effective.  Yes,
> it can make sure that the page we're intending to modify is dragged into the
> pagecache and marked uptodate so that it can be read from, but is it possible
> for the page to then get reclaimed before we get to
> iov_iter_copy_from_user_atomic()?  a_ops->write_begin() could potentially take
> a long time, say if it has to go and get a lock/lease from a server.

It's certainly possible, but unlikely.  The page is going to go to the
head of the active queue, and so we'll have to burn our way through the
entire inactive and then active queue in order to bump this page out
of memory.

> Also, I've been thinking about Willy's folio/THP stuff that allows bunches of
> pages to be glued together into single objects for efficiency.  This is
> problematic with the above code because the faultahead is limited to a maximum
> of PAGE_SIZE, but we might be wanting to modify a larger object than that.

Just to be clear, it's not _currently_ a problem for the folio patchset.

Multi-page folios are only created during readahead.  Unless there's a
read error during readahead, a folio found during write() will either
be freshly created and order-0, or it'll be multi-order and uptodate.
I would like to create larger folios during write() eventually, but I'm
choosing to not burden the folio patchset with that enhancement yet.
It has enough performance improvement to not need that yet.

