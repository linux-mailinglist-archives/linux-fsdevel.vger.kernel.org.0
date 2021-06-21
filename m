Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BA03AEB86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUOju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUOju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:39:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673CC061574;
        Mon, 21 Jun 2021 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TSzsMEaZNc9O8CyE5xTFvbO8E5MW9oACwQhwhZHUu6o=; b=sX03Tw+S5ActhS5z4uRj8LWHR/
        CHF30jq/TkswHsOvREKbqCuFJtQXtwM3V0Aug1p7odzdH5FWsjG9Yl4lygnJZZ03BHS3QhKVedk8/
        7YSzmV/BqDc86keGKSYU3SyP8xIfsJ3JccMFPfW6QD2HH3qeDbscyaGfBbVA97pTlWhfoV67iI8Vm
        0C0pzNwq4LYNIjz/fygB8mvYlmNnjqST5IqPHy1boozDwXmshZYWqxK0QF2U8m0ikDp65vldg3afJ
        sp31Y/efsi95fcXwk6qUxDj9FaAwPYjQT4YrGiQT4iSjSbugqhTe87U/PRh8EoIUJFnSsnGm8ZXix
        JWmYO/4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvL2j-00DBkD-IM; Mon, 21 Jun 2021 14:36:58 +0000
Date:   Mon, 21 Jun 2021 15:36:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] afs: Fix afs_write_end() to handle short writes
Message-ID: <YNCkBXCo1hiQ0vFs@casper.infradead.org>
References: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
 <162391825688.1173366.3437507255136307904.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162391825688.1173366.3437507255136307904.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 09:24:16AM +0100, David Howells wrote:
> Fix afs_write_end() to correctly handle a short copy into the intended
> write region of the page.  Two things are necessary:
> 
>  (1) If the page is not up to date, then we should just return 0
>      (ie. indicating a zero-length copy).  The loop in
>      generic_perform_write() will go around again, possibly breaking up the
>      iterator into discrete chunks.
> 
>      This is analogous to commit b9de313cf05fe08fa59efaf19756ec5283af672a
>      for ceph.
> 
>  (2) The page should not have been set uptodate if it wasn't completely set
>      up by netfs_write_begin() (this will be fixed in the next patch), so
>      we need to set uptodate here in such a case.
> 
> Also remove the assertion that was checking that the page was set uptodate
> since it's now set uptodate if it wasn't already a few lines above.  The
> assertion was from when uptodate was set elsewhere.

Thanks for adding that explanation.

> +++ b/fs/afs/write.c
> @@ -119,6 +119,16 @@ int afs_write_end(struct file *file, struct address_space *mapping,
>  	_enter("{%llx:%llu},{%lx}",
>  	       vnode->fid.vid, vnode->fid.vnode, page->index);
>  
> +	len = min_t(size_t, len, thp_size(page) - from);

This line isn't necessary yet, right?

> +	if (!PageUptodate(page)) {
> +		if (copied < len) {
> +			copied = 0;
> +			goto out;
> +		}
> +
> +		SetPageUptodate(page);
> +	}
> +
>  	if (copied == 0)
>  		goto out;
>  
> @@ -133,8 +143,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
>  		write_sequnlock(&vnode->cb_lock);
>  	}
>  
> -	ASSERT(PageUptodate(page));
> -
>  	if (PagePrivate(page)) {
>  		priv = page_private(page);
>  		f = afs_page_dirty_from(page, priv);

The rest of this looks good.
