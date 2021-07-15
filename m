Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0263CAF75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhGOW6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhGOW6e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:58:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4976E613AF;
        Thu, 15 Jul 2021 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626389740;
        bh=P9uyzQH7V/Vu5iTQd3DZbraQ8Ej5+Fm7bfjvma3F+c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2jY8kpWCk9OuIFpx7Sbt4ugXyih8DxDDZo9X87C+6a6klH0p3PEjKLEhlpNsihmv
         dIVA1Sx5t2FNXUM5+lTvl+3ZqN48p7pvqjA0EsBTnRytiZ6qbfW+8KCW81SijAsRrY
         riWkplRp/TzC32evC0K1O7aaDw2BL2B792GvYA/VhmhJP+CxtQqNtLsq5VhOxji6gr
         E12NqYxl1ujJN1J+M/RJOQaOhexuFlBWuVfIpEiYxPUqgsXH9I4KSMTUjQph9xZTJD
         ppzOrtguGGUm96LDyB0+E4zoJgNCzQgPw9GF1eC35VuySBJfCyMkcMZ8ktdO6osWUM
         LYtqCC0m/qhJw==
Date:   Thu, 15 Jul 2021 15:55:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 098/138] iomap: Use folio offsets instead of page
 offsets
Message-ID: <20210715225539.GX22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-99-willy@infradead.org>
 <20210715212657.GI22357@magnolia>
 <YPC7ILHEYv1JKKJW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPC7ILHEYv1JKKJW@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:48:00PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 15, 2021 at 02:26:57PM -0700, Darrick J. Wong wrote:
> > > +	size_t poff = offset_in_folio(folio, *pos);
> > > +	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
> > 
> > I'm confused about 'size_t poff' here vs. 'unsigned end' later -- why do
> > we need a 64-bit quantity for poff?  I suppose some day we might want to
> > have folios larger than 4GB or so, but so far we don't need that large
> > of a byte offset within a page/folio, right?
> > 
> > Or are you merely moving the codebase towards using size_t for all byte
> > offsets?
> 
> Both.  'end' isn't a byte count -- it's a block count.
> 
> > >  	if (orig_pos <= isize && orig_pos + length > isize) {
> > > -		unsigned end = offset_in_page(isize - 1) >> block_bits;
> > > +		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
> 
> That right shift makes it not-a-byte-count.
> 
> I don't especially want to do all the work needed to support folios >2GB,
> but I do like using size_t to represent a byte count.

DOH.  Yes, I just noticed that.

TBH I doubt anyone's really going to care about 4GB folios anyway.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D
