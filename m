Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D93C1E3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 06:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhGIEaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 00:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhGIEaU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:30:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D5E26144A;
        Fri,  9 Jul 2021 04:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625804857;
        bh=/Sma8EZYItM59thViN0dUnCpvwH2G5EeTeYrZVKb/xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2NtKGdeIlBfp3CurByFWAyJ6hlYKuanLCM8JvBLx3YKeqNIGKj8HhZKhwFVtk1mc
         pQkyLjq2WE4wg4pO720r+j+sFvGClb80p0dIPFO0SFFa4BqNSeeyjKx/I7phZiAd/w
         AsglW5KUw0Yw9ni0hHJ21Gsa5Fc0eanXo+sPicJG0UiobDWKPo4pVjdimHQ90ixwJ7
         4Alsj7kQvEZ/zntf2oZ5UH/hQct7ZBNKJNsIiFvhPb7HMPpYzCAaxb0P7XCXDhI8j+
         KD7ZULKaBAeiJq/m3bQEs8vOV2L8IHb8V2YzhNXe0F52cD4VFKuIfvfpcS1Yz287k2
         UN1Qq8Ues5ZkA==
Date:   Thu, 8 Jul 2021 21:27:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: [PATCH v3 2/3] iomap: Don't create iomap_page objects for inline
 files
Message-ID: <20210709042737.GT11588@locust>
References: <20210707115524.2242151-1-agruenba@redhat.com>
 <20210707115524.2242151-3-agruenba@redhat.com>
 <YOW6Hz0/FgQkQDgm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOW6Hz0/FgQkQDgm@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 03:28:47PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 07, 2021 at 01:55:23PM +0200, Andreas Gruenbacher wrote:
> > @@ -252,6 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >  	}
> >  
> >  	/* zero post-eof blocks as the page may be mapped */
> > +	iop = iomap_page_create(inode, page);
> >  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> >  	if (plen == 0)
> >  		goto done;
> 
> I /think/ a subsequent patch would look like this:
> 
> +	/* No need to create an iop if the page is within an extent */
> +	loff_t page_pos = page_offset(page);
> +	if (pos > page_pos || pos + length < page_pos + page_size(page))
> +		iop = iomap_page_create(inode, page);
> 
> but that might miss some other reasons to create an iop.

I was under the impression that for blksize<pagesize filesystems, the
page always had to have an iop attached.  In principle I think you're
right that we don't need one if all i_blocks_per_page blocks have the
same uptodate state, but someone would have to perform a close reading
of buffered-io.c to make it drop them when unnecessary and re-add them
if it becomes necessary.  That might be more cycling through kmem_alloc
than we like, but as I said, I have never studied this idea.

--D
