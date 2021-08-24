Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A33F5FD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 16:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhHXOGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbhHXOGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:06:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA67BC061796;
        Tue, 24 Aug 2021 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xqja1HTyBUf8uuKLULMlLCkspx2KkmGFa3M60ugx7SA=; b=nkiCR5PXnBI2kOYu9sWcekaCWQ
        yKWpqOl2UlffS0bJ1kSpjldLoczjJkX2SBHFwC8X6bJaoME7zkHjTcZNHQ7UNBUbwLmhCaq4dRmFd
        vMoraImRqOd/nXBYw/Il1WUhTXACqmnzsjuT8YdaLMKDpmIv4kQsIMiW80XpAN+0xUjtn8EkmvNGM
        ktdWjL54SQgz7IEevZKCwsKmdsc9EvDz6hq1RWi9zlkM37z5wQHI4Uh8P6WZBDhRNzubIEWuJvpdL
        BhF0KvKZPmK+uKVqfX1fqnR/io3we8J0AgKiBsSqoYQUF/jyHow1DXSfBRTzX0zL4nds6HkJq2tTZ
        4lm9BWzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIX1d-00B8bA-27; Tue, 24 Aug 2021 14:03:52 +0000
Date:   Tue, 24 Aug 2021 15:03:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] folio: Add a function to get the host inode for a
 folio
Message-ID: <YST8OcVNy02Rivbm@casper.infradead.org>
References: <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk>
 <162981151155.1901565.7010079316994382707.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162981151155.1901565.7010079316994382707.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 02:25:11PM +0100, David Howells wrote:
> + * For folios which are in the page cache, return the inode that is hosting
> + * this folio belongs to.
> + *
> + * Do not call this for folios which aren't in the page cache.
> + */
> +static inline struct inode *folio_inode(struct folio *folio)
> +{
> +	return folio_file_mapping(folio)->host;

You're contradicting yourself here.  If you're allowed to call this
function for swap cache pages, then the documentation needs to change.
If you're not, then we can just use folio->mapping->host.
