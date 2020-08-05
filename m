Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77323D042
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgHETqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbgHETdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:33:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B86C061575;
        Wed,  5 Aug 2020 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BjUxyEqkYiqtsdR/KvRwz6ZbXTHnw0kNXap/n+8pwLc=; b=d99BKyoGx9hy4YcJdLSUMJqThT
        5nqIKVLtODQNoljLBcp8S5Qe51texKqOh2lHfYRF6oE9Eennni9qvKXvoNCBo1BmBItdODcTP8rr0
        d9fwQtJqhR7ZefvrgjrymVDmQgC18lF3oe0V6z2N2edcUvDcRkE+9XOUCafaUKs24HosE1ZjfNpyP
        orzIgTlu+kNLZ8DcTbs9SzVLlHxhTCkbT8b6BA/62VFAu20gPM6e4dugjgbyb55pQ8ZyZvQxTDPzk
        tMeIVEAdm2vkbkv0U8ueOK/GHFSZ2Sv4iPAT4k3TV9OgjyznmX+JjL+tR/NszZzvUQ9KYpokZ96xB
        mE2m1QXA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3P9r-0005s8-TN; Wed, 05 Aug 2020 19:33:03 +0000
Date:   Wed, 5 Aug 2020 20:33:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver
 #21]
Message-ID: <20200805193303.GM23808@casper.infradead.org>
References: <CAJfpegtOguKOGWxv-sA_C9eSWG_3Srnj_k=oW-wSHNprCipFVg@mail.gmail.com>
 <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
 <20200804104108.GC32719@miu.piliscsaba.redhat.com>
 <2306029.1596636828@warthog.procyon.org.uk>
 <2315925.1596641410@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2315925.1596641410@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 04:30:10PM +0100, David Howells wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > idr_alloc_cyclic() seems to be a good template for doing the lower
> > 32bit allocation, and we can add code to increment the high 32bit on
> > wraparound.
> > 
> > Lots of code uses idr_alloc_cyclic() so I guess it shouldn't be too
> > bad in terms of memory use or performance.
> 
> It's optimised for shortness of path and trades memory for performance.  It's
> currently implemented using an xarray, so memory usage is dependent on the
> sparseness of the tree.  Each node in the tree is 576 bytes and in the worst
> case, each one node will contain one mount - and then you have to backfill the
> ancestry, though for lower memory costs.
> 
> Systemd makes life more interesting since it sets up a whole load of
> propagations.  Each mount you make may cause several others to be created, but
> that would likely make the tree more efficient.

I would recommend using xa_alloc and ignoring the ID assigned from
xa_alloc.  Looking up by unique ID is then a matter of iterating every
mount (xa_for_each()) looking for a matching unique ID in the mount
struct.  That's O(n) search, but it's faster than a linked list, and we
don't have that many mounts in a system.

The maple tree will handle this case more effectively, but I can't
recommend waiting for that to be ready.
