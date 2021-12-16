Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06618477C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 20:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbhLPT33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 14:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhLPT32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:29:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922BC061574;
        Thu, 16 Dec 2021 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N9CxEizcUKUMKe7tygLAy2SKNqVIaZunBZQhmUvlaCo=; b=TfIC8wH+3iPtFaTNNHTiwoOSwz
        Bpsoi/K/YScFLbzdHHr0K8D4ikaBbFc/WqSk3CClQHeadtbcZldeGLW1OWzKGfUrcONUURVgJ3AKW
        7vvwE7ExhcmC69CTT6pe0i9JUhRALDvQ/XpthdOB/NXqZHs1AuyGOUHNH/oNkTuSwVfvAjuIfuhGC
        Y605ibUw+jfKHeuEPoHslvWaMnVjItExifSdcTybxLgeV5XJXC9PJB18n9KIcEQwZFGm02AaimUXN
        XxcV0oSs+Qu5b4zlqfrJAGknSX+Z66iNgHKFBxEBI2dGXXpHL/POwbDa64BswFZhhWynw0aJMTSGl
        MNr1Gg0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxwQj-00Ft6U-EP; Thu, 16 Dec 2021 19:28:41 +0000
Date:   Thu, 16 Dec 2021 19:28:41 +0000
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
Message-ID: <YbuTaRbNUAJx5xOA@casper.infradead.org>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
 <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk>
 <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:31:19AM -0800, Linus Torvalds wrote:
> On Thu, Dec 16, 2021 at 8:22 AM David Howells <dhowells@redhat.com> wrote:
> >
> > With transparent huge pages, in the future, write_begin() and write_end()
> > may be passed a length parameter that, in combination with the offset into
> > the page, exceeds the length of that page.  This allows
> > grab_cache_page_write_begin() to better choose the size of THP to allocate.
> 
> I still think this is a fundamental bug in the caller. That
> "explanation" is weak, and the whole concept smells like week-old fish
> to me.

You're right that  ->write_end can't be called with more bytes than fit
in the folio.  That makes no sense at all.

I haven't finished fully fleshing this out yet (and as a result we still
only create PAGE_SIZE folios on writes), but my basic plan was:

generic_perform_write:
-	bytes = min_t(unsigned long, PAGE_SIZE - offset,
+	bytes = min_t(unsigned long, FOLIO_MAX_PAGE_CACHE_SIZE - offset,
 					iov_iter_count(i));
...
                status = a_ops->write_begin(file, mapping, pos, bytes, flags,
-                                               &page, &fsdata);
+                                               &folio, &fsdata);

+		offset = offset_in_folio(folio, pos);
+		bytes = folio_size(folio - offset);
...
                status = a_ops->write_end(file, mapping, pos, bytes, copied,
-                                               page, fsdata);
+                                               folio, fsdata);

Since ->write_begin is the place where we actually create folios, it
needs to know what size folio to create.  Unless you'd rather we do
something to actually create the folio before calling ->write_begin?
