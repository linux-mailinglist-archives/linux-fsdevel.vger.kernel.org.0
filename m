Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4987F3CAF64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhGOWvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGOWva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:51:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6390C06175F;
        Thu, 15 Jul 2021 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4qnSrdZ/w1EUw3zlkvJMz7MVun67Nfs0vsvhY9+UfNI=; b=aUikITyByImuKlueFD/xvuB2jf
        vRl67XKzSCrw+VgQRCOVNNHC7AShTiw1eMjI2XVUg7cAKuglCLo/fFFjP+JJ8BLDE/YbBybXIOSuo
        Uh2YL4Vz8C8a/6NCHrMQFbwChE1lA5+Su+cEpHHT4e4usjB2cFslFNUW9d7izazTOX4L72EvNag+X
        dKd6Lxnh8p27bmSFkHnt8LI+5iIKOgKuj7bDhELu06GPOkARzeOzV16BdNGD/9bkcPPpiasN/nAHn
        nyYrGj7UMBC0INae5MEOjwOzg2Wng0EcgrrH1B4lSON7rNrEnKa4RiJPfQXNqq4IPueaf39kWcoXo
        t5AI+gvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4A9A-003wr7-5o; Thu, 15 Jul 2021 22:48:10 +0000
Date:   Thu, 15 Jul 2021 23:48:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 098/138] iomap: Use folio offsets instead of page
 offsets
Message-ID: <YPC7ILHEYv1JKKJW@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-99-willy@infradead.org>
 <20210715212657.GI22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715212657.GI22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:26:57PM -0700, Darrick J. Wong wrote:
> > +	size_t poff = offset_in_folio(folio, *pos);
> > +	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
> 
> I'm confused about 'size_t poff' here vs. 'unsigned end' later -- why do
> we need a 64-bit quantity for poff?  I suppose some day we might want to
> have folios larger than 4GB or so, but so far we don't need that large
> of a byte offset within a page/folio, right?
> 
> Or are you merely moving the codebase towards using size_t for all byte
> offsets?

Both.  'end' isn't a byte count -- it's a block count.

> >  	if (orig_pos <= isize && orig_pos + length > isize) {
> > -		unsigned end = offset_in_page(isize - 1) >> block_bits;
> > +		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;

That right shift makes it not-a-byte-count.

I don't especially want to do all the work needed to support folios >2GB,
but I do like using size_t to represent a byte count.

