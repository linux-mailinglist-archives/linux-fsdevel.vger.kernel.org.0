Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948F21D6D5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 23:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgEQVIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 17:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgEQVIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 17:08:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EA7C061A0C;
        Sun, 17 May 2020 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZI/wjrmoE8yo1UlRT1uixmxXyXCoD/JXvDZ9ydl0TeI=; b=FKKl0/dyT7xRj9bORWp9hLMHn7
        A3bq1CAcKdeF1Czdpl53nc1IhsVa/goilCVb2nU3qTcV2R7c8KVz9zscA8siHQPRZ8NTyF46azvl0
        r4TVGOnaS6QpG3Js4MK4GPKpGkcKdO0CBb79HXcRR2iM+vAkYD7jVoYEvrJb0saOdeuf4lWGse6dx
        N6nTggIgo8zj4sho1cK05NlX+X1Avp7SNjIZVU7vLsTqZCObnfLJTIDXIK/S2PfpLdwryVtDJVZcO
        /LS3lIQ5QduVOAOOgrGHd/a/lM7R30aBmg59Ku30ibB/KvoxaRunX2u+cG5HxwfVEqC60tSlTgl/f
        bFQbbY8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaQW3-0003ri-60; Sun, 17 May 2020 21:08:11 +0000
Date:   Sun, 17 May 2020 14:08:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Don't unlock fetched data pages until the op
 completes successfully
Message-ID: <20200517210811.GQ16070@bombadil.infradead.org>
References: <158974686528.785191.2525276665446566911.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158974686528.785191.2525276665446566911.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 17, 2020 at 09:21:05PM +0100, David Howells wrote:
> Don't call req->page_done() on each page as we finish filling it with the
> data coming from the network.  Whilst this might speed up the application a
> bit, it's a problem if there's a network failure and the operation has to
> be reissued.

It's readpages, which by definition is called for pages that the
application is _not_ currently waiting for.  Now, if the application
is multithreaded and happens to want pages that are currently under
->readpages, then that's going to be a problem (but also unlikely).
Also if the application overruns the readahead window then it'll have
to wait a little longer (but we ramp up the readahead window, so this
should be a self-correcting problem).

> If this happens, an oops occurs because afs_readpages_page_done() clears
> the pointer to each page it unlocks and when a retry happens, the pointers
> to the pages it wants to fill are now NULL (and the pages have been
> unlocked anyway).

I mean, you could check for NULL pointers and not issue the I/O for that
region ... but it doesn't seem necessary.

> Instead, wait till the operation completes successfully and only then
> release all the pages after clearing any terminal gap (the server can give
> us less data than we requested as we're allowed to ask for more than is
> available).

s/release/mark up to date/

> +	if (req->page_done)
> +		for (req->index = 0; req->index < req->nr_pages; req->index++)
> +			req->page_done(req);
> +

I'd suggest doing one call rather than N and putting the page iteration
inside the callback.  But this patch is appropriate for this late in
the -rc series, just something to consider for the future.

You might even want to use a bit in the req to indicate whether this is
a readahead request ... that's the only user of the ->page_done callback
that I can find.

Anyway,
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
