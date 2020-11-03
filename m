Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7492A486A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgKCOjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKCOib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:38:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1EFC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GsR5KszsrGWJa+7lvaiZqEHJ7PGTiqJSY/KZQP69oWQ=; b=B/+zSbqmCBatqk9I/ujBrkK5JC
        KAoJhnlm0+6FWd9XxLJxvwg8X+CYlClYhVs1boIVEDdZyUJBDXrpPudFGFIOQ6Puu52GAF5f1Qerb
        NCqOcOy9v6G+JF4cqGR45RwuLkwR8k/4J79Her/tIvGF/eRKX3w+11huugIUvtTDWX6Sq45UhL9LQ
        LfhfocWzkavSpm+keqyJBfKCFzJ5zKcqFkYy8huXCSxdHgh59rz4Ww186XxOQ7qItTfAGUvs7h2jz
        mgeFfKLU1KVJ2LyYDJwpZcnst7rJXvPnKefv3tO0GzBB7jczPZRVpQX03HVEomCx8pikSCBp0YD1J
        zK+e6MJw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZxS8-0002pE-Uk; Tue, 03 Nov 2020 14:38:28 +0000
Date:   Tue, 3 Nov 2020 14:38:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix panic in __readahead_batch()
Message-ID: <20201103143828.GU27442@casper.infradead.org>
References: <20201103124349.16722-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103124349.16722-1-vvghjk1234@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:43:49PM +0900, Wonhyuk Yang wrote:
> @@ -906,6 +906,12 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
>  	xas_set(&xas, rac->_index);
>  	rcu_read_lock();
>  	xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
> +		if (xas_retry(&xas, page))
> +			continue;
> +
> +		if (!xa_is_value(page))
> +			continue;

By the way, this isn't right.  You meant 'if (xa_is_value(page))'.
It wouldn't cause a bug because it would simply cause all the pages to be
skipped, and so they get brought uptodate by ->readpage.  That's slower,
but if you're testing with fuse, I don't know that you'd notice!

Also, we can't see value entries here.  Readahead inserts the pages into
the page cache locked, and all paths to remove pages from the cache need
to acquire the page lock.

The reason we can see a retry entry here is that we did a readahead of a
single page at index 0.  Between that page being inserted and the lookup,
another page was removed from the file (maybe the file was truncated
down) and this caused the node to be removed, and the pointer to the
page got moved into the root of the tree.  The pointer in the node was
replaced with a retry entry, indicating that the page is still valid,
it just isn't here any more.  And so we retry the lookup.
