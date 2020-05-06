Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F531C6EF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgEFLJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 07:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728052AbgEFLJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 07:09:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F3C061A0F;
        Wed,  6 May 2020 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vfQ2xLQJnaSv4eyB6fGBnkHjNO7cWTECMxbc0VqkGy0=; b=tnbyHqNTBqyLYSKmKdfmPbRTZu
        0HU8rZ2kSJ85KuTjgAOzhh5mBjRJtnCSyCsyRTHJNBkezNrvw6JjyT0hN0fsiuFMt/D0UO31Uyaj0
        Cgq0Sw1/9ekun8nxOq73YMn6DKuegBmQUMVFceY3ns5sH4A2w7nmsZSU9yyFRxn4RU0wd5y92VABJ
        GmnF3fk82h8xF2i+MYQIIVq4xzP2IxGNvBw+dZjWza8mm9PoG+zEq+011Yr6Sp1f7lcANyvzI0rP8
        Z2SwZzJrOqp27iZuKDrosbbRxVeY1qJo5KFDsLVNR0PHbg199RyKT8jQ9eIg1uMIdx2ASMaCO0f60
        3McnRVTw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWHvq-0005ga-Fj; Wed, 06 May 2020 11:09:42 +0000
Date:   Wed, 6 May 2020 04:09:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 54/61] afs: Wait on PG_fscache before
 modifying/releasing a page
Message-ID: <20200506110942.GL16070@bombadil.infradead.org>
References: <20200505115946.GF16070@bombadil.infradead.org>
 <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
 <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk>
 <683739.1588751878@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683739.1588751878@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 06, 2020 at 08:57:58AM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > PG_fscache is going to be used to indicate that a page is being written to
> > > the cache, and that the page should not be modified or released until it's
> > > finished.
> > > 
> > > Make afs_invalidatepage() and afs_releasepage() wait for it.
> > 
> > Well, why?  Keeping a refcount on the page will prevent it from going
> > away while it's being written to storage.  And the fact that it's
> > being written to this cache is no reason to delay the truncate of a file
> > (is it?)
> 
> Won't that screw up ITER_MAPPING?  Does that mean that ITER_MAPPING isn't
> viable?

Can you remind me why ITER_MAPPING needs:

"The caller must guarantee that the pages are all present and they must be
locked using PG_locked, PG_writeback or PG_fscache to prevent them from
going away or being migrated whilst they're being accessed."

An elevated refcount prevents migration, and it also prevents the pages
from being freed.  It doesn't prevent them from being truncated out of
the file, but it does ensure the pages aren't reallocated.
