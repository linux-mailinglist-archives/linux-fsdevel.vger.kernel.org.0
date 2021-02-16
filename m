Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1031CB11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 14:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBPNZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 08:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBPNZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:25:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BF8C061574;
        Tue, 16 Feb 2021 05:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hgIp8cMPVwAuFQ5Q63EIotyWvfFSj1q5sKGA4WuuKGw=; b=ctbhiVSDQqbf2BoXqncvKXwa5V
        yyZuAi6Jd2FD+1ogrQXZd4B3GkugraUEBxghjXti1sjtmIMBZbtRojFeQVOLvcSCNN7KWI8zGjHRB
        aTbPwSH/89Xk8nb6cxXt7r/DpupCtu6PRowMHNCggqKOsYqrSAKydaABwFJxd50yJQZnTj8UdGVoW
        V0fYtHecjoaTww/OoSZkKEThNGDBmEEDfNhjuoQuWlthj7jZ2lk6XmekUKGID08dGYnEgvpmu1c/k
        v7MMetTzabs77GeK+SjHzRTKERB2iiyjh2pOZt5/wPCbJ4YKul+uZv2isOLBi843nry0+UN0Q914n
        9/DbbT1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lC0JX-00Gtih-RC; Tue, 16 Feb 2021 13:22:58 +0000
Date:   Tue, 16 Feb 2021 13:22:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
Message-ID: <20210216132251.GI2858050@casper.infradead.org>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
 <20210216103215.GB27714@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216103215.GB27714@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 11:32:15AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 15, 2021 at 03:44:52PM +0000, David Howells wrote:
> > Provide a function, readahead_expand(), that expands the set of pages
> > specified by a readahead_control object to encompass a revised area with a
> > proposed size and length.
> > 
> > The proposed area must include all of the old area and may be expanded yet
> > more by this function so that the edges align on (transparent huge) page
> > boundaries as allocated.
> > 
> > The expansion will be cut short if a page already exists in either of the
> > areas being expanded into.  Note that any expansion made in such a case is
> > not rolled back.
> > 
> > This will be used by fscache so that reads can be expanded to cache granule
> > boundaries, thereby allowing whole granules to be stored in the cache, but
> > there are other potential users also.
> 
> So looking at linux-next this seems to have a user, but that user is
> dead wood given that nothing implements ->expand_readahead.
> 
> Looking at the code structure I think netfs_readahead and
> netfs_rreq_expand is a complete mess and needs to be turned upside
> down, that is instead of calling back from netfs_readahead to the
> calling file system, split it into a few helpers called by the
> caller.

That's funny, we modelled it after iomap.

> But even after this can't we just expose the cache granule boundary
> to the VM so that the read-ahead request gets setup correctly from
> the very beginning?

The intent is that this be usable by filesystems which want to (for
example) compress variable sized blocks.  So they won't know which pages
they want to readahead until they're in their iomap actor routine,
see that the extent they're in is compressed, and find out how large
the extent is.
