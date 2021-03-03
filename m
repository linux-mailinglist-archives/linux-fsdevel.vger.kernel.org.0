Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D17332C56F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355156AbhCDAUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387991AbhCCUNf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:13:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55FA364EE7;
        Wed,  3 Mar 2021 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614802374;
        bh=Xr/eJPdOmWhLdpnQyVVA+xkU185rLwaj41waSYr6VAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V/eX1k7WlMR9lAcOp/w4yS8wqhnK3VY5Z3ZfAOr3g2LhlNIGbbMr/fzo5oVkdmyqt
         ZyvnYZmGXZ8RBBa5oxrRG8d7cUV5PfloPM0pJASQU4NxdtFLy7aL+yqh+tW6oDjm5R
         vazbDg7Ip6MThebfdhPuK3QzZEXqg7Khb618h4Wo=
Date:   Wed, 3 Mar 2021 12:12:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/filemap: Use filemap_read_page in filemap_fault
Message-Id: <20210303121253.9f44d8129f148b1e2e78cc81@linux-foundation.org>
In-Reply-To: <20210303132640.GB2723601@casper.infradead.org>
References: <20210226140011.2883498-1-willy@infradead.org>
        <20210302173039.4625f403846abd20413f6dad@linux-foundation.org>
        <20210303013313.GZ2723601@casper.infradead.org>
        <20210302220735.1f150f28323f676d2955ab49@linux-foundation.org>
        <20210303132640.GB2723601@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 3 Mar 2021 13:26:40 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> But here's the thing ... invalidate_mapping_pages() doesn't
> ClearPageUptodate.  The only places where we ClearPageUptodate is on an
> I/O error.

yup.

> So ... as far as I can tell, the only way to hit this is:
> 
>  - Get an I/O error during the wait
>  - Have another thread cause the page to be removed from the page cache
>    (eg do direct I/O to the file) before this thread is run.
> 
> and the consequence to this change is that we have another attempt to
> read the page instead of returning an error immediately.  I'm OK with
> that unintentional change, although I think the previous behaviour was
> also perfectly acceptable (after all, there was an I/O error while trying
> to read this page).
> 
> Delving into the linux-fullhistory tree, this code was introduced by ...
> 
> commit 56f0d5fe6851037214a041a5cb4fc66199256544
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Fri Jan 7 22:03:01 2005 -0800
> 
>     [PATCH] readpage-vs-invalidate fix
> 
>     A while ago we merged a patch which tried to solve a problem wherein a
>     concurrent read() and invalidate_inode_pages() would cause the read() to
>     return -EIO because invalidate cleared PageUptodate() at the wrong time.
> 
> We no longer clear PageUptodate, so I think this is stale code?  Perhaps
> you could check with the original author ...

Which code do you think might be stale?  We need the !PageUptodate
check to catch IO errors and we need the !page->mapping check to catch
invalidates.  Am a bit confused.

