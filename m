Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB09477D5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 21:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbhLPUVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 15:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhLPUVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:21:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59047C061574;
        Thu, 16 Dec 2021 12:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XqnUXa9RW7uRpASlJT6RfFyTUcif6Eix1YgAPYLKeT8=; b=MX6WDKLG1OL6cTeGQdGY+wgibY
        Ll9mC56eOlFh37FPX41YNMduoufYqbHvKzG37ydlx6UrCUQlo3fsxYKXTB8XSfeJih3eLvh2ulurZ
        UAq+weJj9S1y75jcgGgTlW+pZlugSZvh0gdBNPYCHZomHQ88c5LVGSUc5ZdP8W4wArLoqs4ITVUxK
        sQ/pssRK0WSdbasQQD8ktK/KjuTBnt0Yp8Vq5EwJX78mf6XlTgI4EsJsZ++2N1rSxRmKV2sguuD4g
        XN2WFfsDXEyr3sGDX+3E0wEj1hINEP9R8QYGpzjbfP3vM/db1mMd2vQa8eUB/JcEkQh9ZW77Y1ApP
        JLe01syQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxEx-00FvEE-Bh; Thu, 16 Dec 2021 20:20:35 +0000
Date:   Thu, 16 Dec 2021 20:20:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 56/68] afs: Handle len being extending over page end
 in write_begin/write_end
Message-ID: <YbufkzMCoxssd6Vi@casper.infradead.org>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
 <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk>
 <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com>
 <YbuTaRbNUAJx5xOA@casper.infradead.org>
 <CAHk-=wh2dr=NgVSVj0sw-gSuzhxhLRV5FymfPS146zGgF4kBjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2dr=NgVSVj0sw-gSuzhxhLRV5FymfPS146zGgF4kBjA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:46:18AM -0800, Linus Torvalds wrote:
> On Thu, Dec 16, 2021 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Since ->write_begin is the place where we actually create folios, it
> > needs to know what size folio to create.  Unless you'd rather we do
> > something to actually create the folio before calling ->write_begin?
> 
> I don't think we can create a folio before that, because the
> filesystem may not even want a folio (think persistent memory or
> whatever).
> 
> Honestly, I think you need to describe more what you actually want to
> happen. Because generic_perform_write() has already decided to use a
> PAGE_SIZE by the time write_begin() is called,
> 
> Right now the world order is "we chunk things by PAGE_SIZE", and
> that's just how it is.

Right.  And we could leave it like that.  There's a huge amount of win
that comes from just creating large folios as part of readahead, and
anything we do for writes is going to be a smaller win.

That said, I would like it if a program which does:

fd = creat("foo", 0644);
write(fd, buf, 64 * 1024);
close(fd);

uses a single 64k page.

> I can see other options - like the filesystem passing in the chunk
> size when it calls generic_perform_write().

I'm hoping to avoid that.  Ideally filesystems don't know what the
"chunk size" is that's being used; they'll see a mixture of sizes
being used for any given file (potentially).  Depends on access
patterns, availability of higher-order memory, etc.

> Or we make the rule be that ->write_begin() simply always is given the
> whole area, and the filesystem can decide how it wants to chunk things
> up, and return the size of the write chunk in the status (rather than
> the current "success or error").

We do need to be slightly more limiting than "always gets the whole
area", because we do that fault_in_iov_iter_readable() call first,
and if the user has been mean and asked to write() 2GB of memory on
a (virtual) machine with 256MB, I'd prefer it if we didn't swap our way
through 2GB of address space before calling into ->write_begin.

> But at no point will this *EVER* be a "afs will limit the size to the
> folio size" issue. Nothing like that will ever make sense. Allowing
> bigger chunks will not be about any fscache issues, it will be about
> every single filesystem that uses generic_perform_write().

I agree that there should be nothing here that is specific to fscache.
David has in the past tried to convince me that he should always get
256kB folios, and I've done my best to explain that the MM just isn't
going to make that guarantee.

That said, this patch seems to be doing the right thing; it passes
the entire length into netfs_write_begin(), and is then truncating
the length to stop at the end of the folio that it got back.

