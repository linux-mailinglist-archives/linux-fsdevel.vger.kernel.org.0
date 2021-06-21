Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913273AECF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFUQD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFUQD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:03:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C1C06175F;
        Mon, 21 Jun 2021 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0sCXh9zTGifU/TAqLlM8zHbqptoq8nXnWvN/dnsVTLo=; b=nhRvMcgt8Z0lnw1ZWtAONHxwbW
        jJrzTtiaP/4lyU459oyai+GDLEFYA/FJf16PRsuTouor/r27tcMYZvBUmD9U2ff9gNjBXzv6K2NPv
        cQlW6VdDB2W0i4mBHHE0Y8Ez6smH3OaDOUSGRwTQx4AEe1lKTKgWEinyZ2UReUaQR7YB5CJQxT/KZ
        kIR1BJK/IF96wmUBVBsqjAnT8s5h3993UU5bYwCiJAXyR8oBG9UCy8UqITG5kMEZhkandlDmnTQT1
        tV0RrdFV6G6cw1IgO3SqZ7kuq+Y/AEy99g7hFhutB9/trAl+vVnK0K6Llg4F7GAUfSKL4Qvj/cnK/
        vw5PwJmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvMM8-00DGcM-F8; Mon, 21 Jun 2021 16:01:04 +0000
Date:   Mon, 21 Jun 2021 17:01:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] afs: Fix afs_write_end() to handle short writes
Message-ID: <YNC3vP4BKi5l6SfW@casper.infradead.org>
References: <162429000639.2770648.6368710175435880749.stgit@warthog.procyon.org.uk>
 <162429001766.2770648.1072619730387446884.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162429001766.2770648.1072619730387446884.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 04:40:17PM +0100, David Howells wrote:
> Fix afs_write_end() to correctly handle a short copy into the intended
> write region of the page.  Two things are necessary:
> 
>  (1) If the page is not up to date, then we should just return 0
>      (ie. indicating a zero-length copy).  The loop in
>      generic_perform_write() will go around again, possibly breaking up the
>      iterator into discrete chunks[1].
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
> 
> Changes:
> v3: Remove the handling of len exceeding the end of the page.
> 
> Fixes: 3003bbd0697b ("afs: Use the netfs_write_begin() helper")
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-afs@lists.infradead.org
> Link: https://lore.kernel.org/r/YMwVp268KTzTf8cN@zeniv-ca.linux.org.uk/ [1]
> Link: https://lore.kernel.org/r/162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/162391825688.1173366.3437507255136307904.stgit@warthog.procyon.org.uk/ # v2

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
