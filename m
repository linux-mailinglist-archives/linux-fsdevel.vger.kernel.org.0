Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC25231E2D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 23:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhBQWw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 17:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbhBQWws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:52:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2998C061574;
        Wed, 17 Feb 2021 14:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=exGxKvz2dkO6Ia4BmvggC59Ll6D9+WqpkO0LLDpW53U=; b=DAsadcKxmsU6ocqG684beBo7F/
        pwtwAkJtxmTMpf4Yaf/uMliVqkqw8h9mTKmhc9jES0ZyI7WcfPT69f5KQCv6xNKgnrvwupFO9uIti
        qu+Lr192QSZBD65r5vcrpJeRgG7Wk6phDdZTZ6QSzm2L8F6/Rw6yoDPMSkwF70J9djiWPgzhM4bzW
        gbH8VzVJvY7blol40F8Lb+Vjx+9EPXX+e6l1ggpAsMYqr+Ou3p9dr73qkXHVrSpAjSVNld/S93yLB
        Nedtkxx4lvJsktlKJ9eFPfP//m8xQ0/weFQAgZU+eqRSoH/EpVvf4qMA+TiHJsM7LqgUgpfBqCbxz
        t0ekOKRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCVdG-000xt5-Iq; Wed, 17 Feb 2021 22:49:44 +0000
Date:   Wed, 17 Feb 2021 22:49:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mike Marshall <hubcap@omnibond.com>,
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
Message-ID: <20210217224918.GP2858050@casper.infradead.org>
References: <20210217161358.GM2858050@casper.infradead.org>
 <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
 <1901187.1613601279@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1901187.1613601279@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 10:34:39PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > We're defeating the ondemand_readahead() algorithm here.  Let's suppose
> > userspace is doing 64kB reads, the filesystem is OrangeFS which only
> > wants to do 4MB reads, the page cache is initially empty and there's
> > only one thread doing a sequential read.  ondemand_readahead() calls
> > get_init_ra_size() which tells it to allocate 128kB and set the async
> > marker at 64kB.  Then orangefs calls readahead_expand() to allocate the
> > remainder of the 4MB.  After the app has read the first 64kB, it comes
> > back to read the next 64kB, sees the readahead marker and tries to trigger
> > the next batch of readahead, but it's already present, so it does nothing
> > (see page_cache_ra_unbounded() for what happens with pages present).
> 
> It sounds like Christoph is right on the right track and the vm needs to ask
> the filesystem (and by extension, the cache) before doing the allocation and
> before setting the trigger flag.  Then we don't need to call back into the vm
> to expand the readahead.

Doesn't work.  You could read my reply to Christoph, or try to figure out
how to get rid of
https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs-io.c#n742
for yourself.

> Also, there's Steve's request to try and keep at least two requests in flight
> for CIFS/SMB at the same time to consider.

That's not relevant to this problem.
