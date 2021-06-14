Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70F3A67D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 15:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhFNNal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbhFNNal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:30:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DA0C061574;
        Mon, 14 Jun 2021 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rLl9KhJ8TfT78cb0hFkDybqzBiOXdTnDOFMoiHYjrzU=; b=tPJSCKR602M86CL1/WSp8JTRsW
        SycyfpCKCxVQOzeW6eWQ+ZEIwly5NE54ZyurHgEn/u22UmR2LF6Io04WdT3hk4L2Hma/W5E7Tqkde
        pPqdwqVKPOXxmzmBZVgHeUtZDQqFfKcFROAQY6qd7ObukF3uhx1snqs6f+scK2sqeDARq5FjEDd3q
        s8Em32APnv+gjJaB3gb3tD7dQ8S9eezgjiLyqHDykzDOrCT1sZt4bVccr8qy2UUFBkWmkdEbCo7A3
        GGlhR9+yPDT9dWxI/yoi2yF/xHuLEthcc4jAAUR/9rT25BrIbwf/lzWgJZomeJPndj/YhbhE+0fbW
        ySJ6+U/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsmdS-005Sjm-FA; Mon, 14 Jun 2021 13:28:19 +0000
Date:   Mon, 14 Jun 2021 14:28:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
Message-ID: <YMdZbsvBNYBtZDC2@casper.infradead.org>
References: <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
 <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 02:20:25PM +0100, David Howells wrote:
> Fix afs_write_end() to correctly handle a short copy into the intended
> write region of the page.  Two things are necessary:
> 
>  (1) If the page is not up to date, then we should just return 0
>      (ie. indicating a zero-length copy).  The loop in
>      generic_perform_write() will go around again, possibly breaking up the
>      iterator into discrete chunks.

Does this actually work?  What about the situation where you're reading
the last page of a file and thus (almost) always reading fewer bytes
than a PAGE_SIZE?

>      This is analogous to commit b9de313cf05fe08fa59efaf19756ec5283af672a
>      for ceph.
> 
>  (2) The page should not have been set uptodate if it wasn't completely set
>      up by netfs_write_begin() (this will be fixed in the next page), so we
>      need to set PG_uptodate here in such a case.

s/page/patch/

and you have a really bad habit of breaking the layering and referring
to PG_foo.  Please just refer to PageFoo.  Filesystems shouldn't
care what the implementation of PageFoo is.

> +	len = min_t(size_t, len, thp_size(page) - from);
> +	if (!PageUptodate(page)) {
> +		if (copied < len) {
> +			copied = 0;
> +			goto out;
> +		}
> +
> +		SetPageUptodate(page);
> +	}
