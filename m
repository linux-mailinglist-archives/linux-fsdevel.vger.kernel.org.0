Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9146DFD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 01:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbhLIA7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 19:59:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38074 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbhLIA7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:59:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B27FB82346;
        Thu,  9 Dec 2021 00:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF94C00446;
        Thu,  9 Dec 2021 00:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639011360;
        bh=0Qbd6pnoKep9PNXa8MnEXlrP1XPI1fzykn2+If23HC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwH5kjdT+ZrSgp1QJ5JzDwZteTzSABNYgvXh5fvoT7maj1keKRq7OKSwn5wHlNReK
         DlZ+utWnr1WP72lUzs1D9KPMBeTLE6pnyFX6bjfITB76PxwwzVaQLQ/5LqkyhI+vLC
         6/Py7x04YTa2iH/57ZRqkYdizrk9/+vKPCd3BrYnn8SGaNtYjCSMN8w+MVahKr7t+Z
         QYq8X5skWZl22WiSXofTzLDft88WB4oroc5jX/PJPLYOMkguxlBaXZq94HXE4BykOL
         3AOO9MexN/6OwwaVjUPHjviGgOolhDjtLzJQRCivpRUnHKn2mh1ZXMMHfP2CFCC5cH
         KEIWMJw6UtwNA==
Date:   Wed, 8 Dec 2021 16:55:59 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iomap: turn the byte variable in iomap_zero_iter into a
 ssize_t
Message-ID: <20211209005559.GB69193@magnolia>
References: <20211208091203.2927754-1-hch@lst.de>
 <20211209004846.GA69193@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209004846.GA69193@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:48:46PM -0800, Darrick J. Wong wrote:
> On Wed, Dec 08, 2021 at 10:12:03AM +0100, Christoph Hellwig wrote:
> > bytes also hold the return value from iomap_write_end, which can contain
> > a negative error value.  As bytes is always less than the page size even
> > the signed type can hold the entire possible range.
> > 
> > Fixes: c6f40468657d ("fsdax: decouple zeroing from the iomap buffered I/O code")

...waitaminute, ^^^^^^ in what tree is this commit?  Did Linus merge
the dax decoupling series into upstream without telling me?

/me checks... no?

Though I searched for it on gitweb and came up with this bizarre plot
twist:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6f40468657d16e4010ef84bf32a761feb3469ea

(Is this the same as that github thing a few months ago where
everybody's commits get deduplicated into the same realm and hence
anyone can make trick the frontend into sort of making it look like
their rando commits end up in Linus' tree?  Or did it get merged and
push -f reverted?)

Ok, so ... I don't know what I'm supposed to apply this to?  Is this
something that should go in Christoph's development branch?

<confused, going to run away now>

On the plus side, that means I /can/ go test-merge willy's iomap folios
for 5.17 stuff tonight.

--D

> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  fs/iomap/buffered-io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index b1511255b4df8..ac040d607f4fe 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -883,7 +883,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  
> >  	do {
> >  		unsigned offset = offset_in_page(pos);
> > -		size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
> > +		ssize_t bytes = min_t(u64, PAGE_SIZE - offset, length);
> >  		struct page *page;
> >  		int status;
> >  
> > -- 
> > 2.30.2
> > 
