Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F202421FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHKVce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKVcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:32:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575FCC06174A;
        Tue, 11 Aug 2020 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xoesQASABFe9SwD8nRdEL82v49tr3QLmBanAXleWpZU=; b=QOZLZ/epsASplsdljPsEwKW2HT
        qK212HspGz0/v02cQTpc9XmeTUIgVLLnvtlGmkDKPcXSBgdCSdxFn5QoQvHL6TarYgdMKbxXPfpc/
        HKxkNKv6yrdwZ+FKqAtJkJyE4/w3WpdNm1Z3Wf87craATSb8VCUbN6zSa28i6bibuuJuLNBptGFcm
        +wt5LTkDLgXWap9dgMKV7C6qmAIlr6DZsgp6DbD6HwgaHoD5c8Lprdo0CQFBvIzzyGXs6I9rXSAQQ
        XFY6EOGCrtGkO4Ai2QgfWKQxVI69OzMXdUt8nJGn0vTfvvnUZ7ewrZfS4LnEMo5AdaxSIG4JM6Uwv
        gNjabORA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5bsk-0002qc-LI; Tue, 11 Aug 2020 21:32:30 +0000
Date:   Tue, 11 Aug 2020 22:32:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: Add iomap_iter
Message-ID: <20200811213230.GX17456@casper.infradead.org>
References: <20200728173216.7184-1-willy@infradead.org>
 <20200728173216.7184-2-willy@infradead.org>
 <20200811210127.GG6107@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811210127.GG6107@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 02:01:27PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 28, 2020 at 06:32:14PM +0100, Matthew Wilcox (Oracle) wrote:
> > The iomap_iter provides a convenient way to package up and maintain
> > all the arguments to the various mapping and operation functions.
> > iomi_advance() moves the iterator forward to the next chunk of the file.
> > This approach has only one callback to the filesystem -- the iomap_next_t
> > instead of the separate iomap_begin / iomap_end calls.  This slightly
> > complicates the filesystems, but is more efficient.  The next function
> 
> How much more efficient?  I've wondered since the start of

I haven't done any performance measurements.  Not entirely sure what
I'd do to measure it, to be honest.  I suppose I should also note the
decreased stack depth here, although I do mention that in the next patch.

> > +/**
> > + * struct iomap_iter - Iterate through a range of a file.
> > + * @inode: Set at the start of the iteration and should not change.
> > + * @pos: The current file position we are operating on.  It is updated by
> > + *	calls to iomap_iter().  Treat as read-only in the body.
> > + * @len: The remaining length of the file segment we're operating on.
> > + *	It is updated at the same time as @pos.
> > + * @ret: What we want our declaring function to return.  It is initialised
> > + *	to zero and is the cumulative number of bytes processed so far.
> > + *	It is updated at the same time as @pos.
> > + * @copied: The number of bytes operated on by the body in the most
> > + *	recent iteration.  If no bytes were operated on, it may be set to
> > + *	a negative errno.  0 is treated as -EIO.
> > + * @flags: Zero or more of the iomap_begin flags above.
> > + * @iomap: ...
> > + * @srcma:s ...
> 
> ...? :)

I ran out of tuits.  If this approach makes people happy, I can finish it
off.

> > + */
> > +struct iomap_iter {
> > +	struct inode *inode;
> > +	loff_t pos;
> > +	u64 len;
> 
> Thanks for leaving this u64 :)
> 
> > +	loff_t ret;
> > +	ssize_t copied;
> 
> Is this going to be sufficient for SEEK_{HOLE,DATA} when it wants to
> jump ahead by more than 2GB?

That's a good point.  loff_t, I guess.  Even though the current users
of iomap don't support extents larger than 2GB ;-)

> > +	unsigned flags;
> > +	struct iomap iomap;
> > +	struct iomap srcmap;
> > +};
> > +
> > +#define IOMAP_ITER(name, _inode, _pos, _len, _flags)			\
> > +	struct iomap_iter name = {					\
> > +		.inode = _inode,					\
> > +		.pos = _pos,						\
> > +		.len = _len,						\
> > +		.flags = _flags,					\
> > +	}
> > +
> > +typedef int (*iomap_next_t)(const struct iomap_iter *,
> > +		struct iomap *iomap, struct iomap *srcmap);
> 
> I muttered in my other reply how these probably should be called
> iomap_iter_advance_t since they actually do the upper level work of
> advancing the iterator to the next mapping.

nono, the iterator is const!  They don't move the iterator at all,
they just get the next iomap/srcmap.

