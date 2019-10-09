Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89EBD0727
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 08:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJIG22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 02:28:28 -0400
Received: from verein.lst.de ([213.95.11.211]:50466 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfJIG22 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:28:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B14CB68B05; Wed,  9 Oct 2019 08:28:24 +0200 (CEST)
Date:   Wed, 9 Oct 2019 08:28:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/20] iomap: use a srcmap for a read-modify-write I/O
Message-ID: <20191009062824.GA29833@lst.de>
References: <20191008071527.29304-1-hch@lst.de> <20191008071527.29304-9-hch@lst.de> <20191008150044.GV13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008150044.GV13108@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:00:44AM -0700, Darrick J. Wong wrote:
> >  	unsigned long vaddr = vmf->address;
> >  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> >  	struct iomap iomap = { 0 };
> 
> Does this definition ^^^^^ need to be converted too?  You convert the
> one in iomap_apply()...

Doesn't strictly need to, but it sure would look nicer and fit the theme.

> 	/*
> 	 * The @iomap and @srcmap parameters should be set to a hole
> 	 * prior to calling ->iomap_begin.
> 	 */
> 	#define IOMAP_EMPTY_RECORD	{ .type = IOMAP_HOLE }
> 
> ...and later...
> 
> 	struct iomap srcmap = IOMAP_EMPTY_RECORD;
> 
> ..but meh, I'm not sure that adds much.

I don't really see the point.

> >  	unsigned flags = IOMAP_FAULT;
> >  	int error, major = 0;
> >  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > @@ -1292,7 +1293,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	 * the file system block size to be equal the page size, which means
> >  	 * that we never have to deal with more than a single extent here.
> >  	 */
> > -	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap);
> > +	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap, &srcmap);
> 
> ->iomap_begin callers are never supposed to touch srcmap, right?
> Maybe we ought to check that srcmap.io_type == HOLE, at least until
> someone fixes this code to dax-copy the data from srcmap to iomap?

What do you mean with touch?  ->iomap_begin fills it out and then the
caller looks at it, at least for places that can deal with
read-modify-write operations (DAX currently can't).
