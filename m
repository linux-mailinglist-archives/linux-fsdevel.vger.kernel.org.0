Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA17B3E178C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbhHEPHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhHEPHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F2EC061765;
        Thu,  5 Aug 2021 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ov7WOh57Y5oPUPuBr7cE+QNFoqdlp3ySaVDNxgkioqg=; b=Xm2BnDpdo9UG/w+0PPAQUBZ7vj
        Sfygt8Y3WJxFKdijCILqnLEG1XDTw7GxROJ0iP0UYtizqIjnvA24bTveGjb05f0SQ+Z4lVQ9ktfkS
        R1h4vSaq1jFeXxuFsuaFZNgTZIDC/sxWz1xeizpdKuKHqgWH6FfM0644Tzoo/i2v0SabSZx88cKX9
        5TWOGgiMpBId3vk5v+eVOOj+6MeP40dIf2a/2UqOdkGhGn807qIO7PMoUP85xP5XoQtd++KIhgjUg
        FXkDicV0o/VTRXH7xfuJKLbF+mmanY8o3rbNJ82p5zGPDTkGhrGVuALInH6yY4/13oZqxHDsEbUw9
        qY8hkOQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBexP-007CFt-HG; Thu, 05 Aug 2021 15:06:55 +0000
Date:   Thu, 5 Aug 2021 16:06:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Could it be made possible to offer "supplementary" data to a DIO
 write ?
Message-ID: <YQv+iwmhhZJ+/ndc@casper.infradead.org>
References: <YQvpDP/tdkG4MMGs@casper.infradead.org>
 <YQvbiCubotHz6cN7@casper.infradead.org>
 <1017390.1628158757@warthog.procyon.org.uk>
 <1170464.1628168823@warthog.procyon.org.uk>
 <1186271.1628174281@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1186271.1628174281@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 03:38:01PM +0100, David Howells wrote:
> > If you want to take leases at byte granularity, and then not writeback
> > parts of a page that are outside that lease, feel free.  It shouldn't
> > affect how you track dirtiness or how you writethrough the page cache
> > to the disk cache.
> 
> Indeed.  Handling writes to the local disk cache is different from handling
> writes to the server(s).  The cache has a larger block size but I don't have
> to worry about third-party conflicts on it, whereas the server can be taken as
> having no minimum block size, but my write can clash with someone else's.
> 
> Generally, I prefer to write back the minimum I can get away with (as does the
> Linux NFS client AFAICT).
> 
> However, if everyone agrees that we should only ever write back a multiple of
> a certain block size, even to network filesystems, what block size should that
> be?

If your network protocol doesn't give you a way to ask the server what
size it is, assume 512 bytes and allow it to be overridden by a mount
option.

> Note that PAGE_SIZE varies across arches and folios are going to
> exacerbate this.  What I don't want to happen is that you read from a file, it
> creates, say, a 4M (or larger) folio; you change three bytes and then you're
> forced to write back the entire 4M folio.

Actually, you do.  Two situations:

1. Application uses MADVISE_HUGEPAGE.  In response, we create a 2MB
page and mmap it aligned.  We use a PMD sized TLB entry and then the
CPU dirties a few bytes with a store.  There's no sub-TLB-entry tracking
of dirtiness.  It's just the whole 2MB.

2. The bigger the folio, the more writes it will absorb before being
written back.  So when you're writing back that 4MB folio, you're not
just servicing this 3 byte write, you're servicing every other write
which hit this 4MB chunk of the file.

There is one exception I've found, and that's O_SYNC writes.  These are
pretty rare, and I think I have a solution to it which essentially treats
the page cache as writethrough (for sync writes).  We skip marking
the page (folio) as dirty and go straight to marking it as writeback.
We have all the information we need about which bytes to write and we're
actually using the existing page cache infrastructure to do it.

I'm working on implementing that in iomap; there's some SMOP type
problems to solve, but it looks doable.
