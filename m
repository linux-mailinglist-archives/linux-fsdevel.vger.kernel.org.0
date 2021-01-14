Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EF2F65A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 17:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhANQUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 11:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbhANQUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:20:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F13C061575;
        Thu, 14 Jan 2021 08:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L957m6SCsm4YfRvwt1RQwkHpsqdoGDsxSLN6pjGCXjg=; b=SwgoX4biWiRfNIkgGKBzF1hThh
        fgohm23xOlFZxJhSLZKiwJXvlpOT7mQ1aERIfxlbDnMSz8cAhA501/6QBLnf5vxFq+Kvg8w7lNzGu
        lKsu5VUh30ZpNT1bDp4PgQQDOAF2zDky3QBOcd8dN/XGAqJ/p2C2tMdWALZA6gQ+xCzpv+dn065rk
        2TTrQt7lGJCVnnHfj+gY6z8VUTG1gzIwprxJtAF5iFkyufA4tU7Q2Fuvhh6wXdjjz4/2sT9ZCH6eX
        Aa9Hq52wo/tTnFG/QpwZVj0ONsXxVxsjndY/W8xQ7Zm0pIhz05bcYui4M6gozuphqFgWnJ9k7MeB2
        tBm+E3uQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l05LN-007mRF-WF; Thu, 14 Jan 2021 16:19:41 +0000
Date:   Thu, 14 Jan 2021 16:19:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        jlayton@redhat.com, dwysocha@redhat.com,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Christoph Hellwig <hch@lst.de>, dchinner@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Redesigning and modernising fscache
Message-ID: <20210114161929.GQ35215@casper.infradead.org>
References: <2758811.1610621106@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2758811.1610621106@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:45:06AM +0000, David Howells wrote:
> However, there've been some objections to the approach I've taken to
> implementing this.  The way I've done it is to disable the use of fscache by
> the five network filesystems that use it, remove much of the old code, put in
> the reimplementation, then cut the filesystems over.  I.e. rip-and-replace.
> It leaves unported filesystems unable to use it - but three of the five are
> done (afs, ceph, nfs), and I've supplied partially-done patches for the other
> two (9p, cifs).
> 
> It's been suggested that it's too hard to review this way and that either I
> should go for a gradual phasing in or build the new one in parallel.  The
> first is difficult because I want to change how almost everything in there
> works - but the parts are tied together; the second is difficult because there
> are areas that would *have* to overlap (the UAPI device file, the cache
> storage, the cache size limits and at least some state for managing these), so
> there would have to be interaction between the two variants.  One refinement
> of the latter would be to make the two implementations mutually exclusive: you
> can build one or the other, but not both.

My reservation with "build fscache2" is that it's going to take some
time to do, and I really want rid of ->readpages as soon as possible.

What I'd like to see is netfs_readahead() existing as soon as possible,
built on top of the current core.  Then filesystems can implement
netfs_read_request_ops one by one, and they become insulated from the
transition.
