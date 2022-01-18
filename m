Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89F749202F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiARH0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiARH0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2244C061574;
        Mon, 17 Jan 2022 23:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+dhYCXllEHNKm5Sc731XzwwsjVqJhcW4C4oj7NGz3M4=; b=TGajYPjm2XkqLBdJOhVzBzTwlB
        boJ4d295sjI9UUInwlPKhDyuNoTCqGg0FQw18iEAahbV/VVb81mYPWPf2+b0qiATEyluQn27qsXLu
        5EVgEHA+7ijXmvn4H9WVCyKxYjU5n2iMLOTjwqsd83+4PS4pEhBcGzUeq1dUTDUkcbQTongiSpChY
        fMZaj3W15A+CXTQEIRuyROppX7fq6If8tvRdRgQkFWIaI+wN8ZUno+UKphp83Uu8eTqHUPFrbKJbF
        AjzrmA/xEfJMnw5y3y5YjNzCJMWjtRHB0WCK6aAmH9OhkBqR/9ABbA+LAF3arRARXloUVo1Ubox1R
        7bgznWDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9iri-000afR-VI; Tue, 18 Jan 2022 07:25:14 +0000
Date:   Mon, 17 Jan 2022 23:25:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        Omar Sandoval <osandov@osandov.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Peter Zijlstra <peterz@infradead.org>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Out of order read() completion and buffer filling beyond
 returned amount
Message-ID: <YeZrWoQY/3dKZHfT@infradead.org>
References: <2752208.1642413437@warthog.procyon.org.uk>
 <CAHk-=wjQG5HnwQD98z8de1EvRzDnebZxh=gQUVTKCn0DOp7PQw@mail.gmail.com>
 <YeVvXToTxCsMzHZv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeVvXToTxCsMzHZv@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 01:30:05PM +0000, Matthew Wilcox wrote:
> I think for DIO, you're sacrificing the entire buffer with any filesystem.
> If the underlying file is split across multiple drives, or is even
> just fragmented on a single drive, we'll submit multiple BIOs which
> will complete independently (even for SCSI which writes sequentially;
> never mind NVMe which can DMA blocks asynchronously).  It might be
> more apparent in a networking situation where errors are more common,
> but it's always been a possibility since Linux introduced DIO.

Yes.  Probably because of that we also never allow short reads or writes
due to I/O errrors but always fail the whole I/O.
