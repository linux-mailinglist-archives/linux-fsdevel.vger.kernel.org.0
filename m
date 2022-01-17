Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADF3490995
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiAQNao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 08:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiAQNan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:30:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E1C061574;
        Mon, 17 Jan 2022 05:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DEDlOvAxf5W8MkgN2U6MW75EWRQeMQMQaovnQRcgffo=; b=sWeOK+ACOkqqrSHFGcOcHtqNUt
        affW2E23Y5H4gus5QTI9RNzR2H8EFMA+ssyXPEH7r0ChvHKzzQZMM6GhvSo9Y6sSIYLuUHknRms35
        r4m4Ukllxqdjth6/xEcNDXSsNRIKty4SfiLeQ8WlVQaGLQ9nHIgFuvZKcOEU2QaAvMn3xKQx8Is36
        wrlnbO+VINuUCt6Ifo4R91YldO2uIRPsLZbnaqNcpdpZpstOVzNqmwYWKYxnovCJ0GDEMR54Ffti6
        jldfxY4Dt7+NOyW8Fv26ursPmOgw9jR1Mp4KN89hlw3J5Uicwo4lbSZWBnUkV7lQwn2lq4D66VNBa
        0SAtDMtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9S5F-008EUB-2d; Mon, 17 Jan 2022 13:30:05 +0000
Date:   Mon, 17 Jan 2022 13:30:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
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
Message-ID: <YeVvXToTxCsMzHZv@casper.infradead.org>
References: <2752208.1642413437@warthog.procyon.org.uk>
 <CAHk-=wjQG5HnwQD98z8de1EvRzDnebZxh=gQUVTKCn0DOp7PQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQG5HnwQD98z8de1EvRzDnebZxh=gQUVTKCn0DOp7PQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:19:29PM +0200, Linus Torvalds wrote:
> On Mon, Jan 17, 2022 at 11:57 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Do you have an opinion on whether it's permissible for a filesystem to write
> > into the read() buffer beyond the amount it claims to return, though still
> > within the specified size of the buffer?
> 
> I'm pretty sure that would seriously violate POSIX in the general
> case, and maybe even break some programs that do fancy buffer
> management (ie I could imagine some circular buffer thing that expects
> any "unwritten" ('unread'?) parts to stay with the old contents)
> 
> That said, that's for generic 'read()' cases for things like tty's or
> pipes etc that can return partial reads in the first place.
> 
> If it's a regular file, then any partial read *already* violates
> POSIX, and nobody sane would do any such buffer management because
> it's supposed to be a 'can't happen' thing.
> 
> And since you mention DIO, that's doubly true, and is already outside
> basic POSIX, and has already violated things like "all or nothing"
> rules for visibility of writes-vs-reads (which admittedly most Linux
> filesystems have violated even outside of DIO, since the strictest
> reading of the rules are incredibly nasty anyway). But filesystems
> like XFS which took some of the strict rules more seriously already
> ignored them for DIO, afaik.

I think for DIO, you're sacrificing the entire buffer with any filesystem.
If the underlying file is split across multiple drives, or is even
just fragmented on a single drive, we'll submit multiple BIOs which
will complete independently (even for SCSI which writes sequentially;
never mind NVMe which can DMA blocks asynchronously).  It might be
more apparent in a networking situation where errors are more common,
but it's always been a possibility since Linux introduced DIO.
