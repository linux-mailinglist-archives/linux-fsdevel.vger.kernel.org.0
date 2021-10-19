Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F77433F9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 22:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhJSUKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 16:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSUKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:10:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473AEC06161C;
        Tue, 19 Oct 2021 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lULRZJ5d3ao6ySUvWKVx/OK5Yxv64Zr2QB+S9ALbnhk=; b=mIpellGqKkgTzWprx+JB2u19Fn
        W3XjBye8qaIBsuKD1brinKgUFUgTBnm83lFLOi/DJMldVswrTiZ4aLSPKKmLfiTZpN6Hy40tCEGEA
        Fpf1fzF7/hEPMwoJdNAvKJUzMMUFe6+tJAB6PVXsIs9GA7vJahbqOecOWTbFXZ4YDmLfwpOHbaIlW
        t9XhNs1dqMoagIj2giLzCvoUrzHgQqEOFJBCuwQOdhrzLZkofdCn06Uww2O40lmR8kGLTrWTBrNT+
        jvm8v/4VBD1w9anPxGRNNe76dwmejwwJBWyB0TnXXZJUuqQIlv0GqDDJ/VTYQUgbzh+g3yMKmj3QA
        u7K/IZCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcvLv-00Byg0-2k; Tue, 19 Oct 2021 20:05:31 +0000
Date:   Tue, 19 Oct 2021 21:04:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/67] mm: Stop filemap_read() from grabbing a
 superfluous page
Message-ID: <YW8k4wEpt3Ehz5Hf@casper.infradead.org>
References: <YW8OMsrEzrY8aSxo@casper.infradead.org>
 <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
 <163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk>
 <2971214.1634669295@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2971214.1634669295@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 07:48:15PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > +		isize = i_size_read(inode);
> > > +		if (unlikely(iocb->ki_pos >= isize))
> > > +			goto put_pages;
> > > +
> > 
> > Is there a good reason to assign to isize here?  I'd rather not,
> > because it complicates analysis, and a later change might look at
> > the isize read here, not realising it was a racy use.  So I'd
> > rather see:
> 
> If we don't set isize, the loop will never end.  Actually, maybe we can just
> break out at that point rather than going to put_pages.

Umm, yes, of course.  Sorry.

It makes more sense to just break because we haven't got any pages,
so putting pages that we haven't got seems unnecessary.
> 
