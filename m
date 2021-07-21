Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F33D118C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhGUOAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 10:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232937AbhGUOAj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:00:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B8A608FE;
        Wed, 21 Jul 2021 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626878475;
        bh=tjvEDndwlqVC8D5pilgd6nm+94RRJ1oxz9bJvd0cl40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuZMi6fJEhdOKhGCC2OF//03EYGnY0M2mu6VYbhx2NB/55HaBUDY6irzSN1a8b6Bq
         5ClVFbJuNzSBtLQDibHKvcjq77579AI4Ig0faWL/zdhmBE8DOdLpgMLlsGopss8GzL
         yDd0BzER9ZGkq3oG+WzcKiAf9zX0s7Sb8HDEu2xte9Z1JiBmCyLaHJM+/OQVO3LCiM
         TZ+udFqK1PVOyS887uMFAse0bfeUEX/ZHkZ0Gi6DuRVEyoJjkXB6PpdYpTgami1rpZ
         2mC6ftkay+45+lBeE6WOcEApyaYJVBZaLrntevRVIHv9JNghcplSOmW0DR9JAe4ovr
         EGUTWFXIZdlcw==
Date:   Wed, 21 Jul 2021 07:41:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 002/138] mm: Introduce struct folio
Message-ID: <20210721144114.GA8572@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-3-willy@infradead.org>
 <YPaoBcXmrLv7zpD2@kernel.org>
 <YPeXrDf2RRJmXMFM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPeXrDf2RRJmXMFM@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 04:42:36AM +0100, Matthew Wilcox wrote:
> On Tue, Jul 20, 2021 at 01:40:05PM +0300, Mike Rapoport wrote:
> > > +/**
> > > + * folio_shift - The number of bits covered by this folio.
> > 
> > For me this sounds like the size of the folio in bits.
> > Maybe just repeat "The base-2 logarithm of the size of this folio" here and
> > in return description?
> > 
> > > + * @folio: The folio.
> > > + *
> > > + * A folio contains a number of bytes which is a power-of-two in size.
> > > + * This function tells you which power-of-two the folio is.
> > > + *
> > > + * Context: The caller should have a reference on the folio to prevent
> > > + * it from being split.  It is not necessary for the folio to be locked.
> > > + * Return: The base-2 logarithm of the size of this folio.
> > > + */
> 
> I've gone with:
> 
>  /**
> - * folio_shift - The number of bits covered by this folio.
> + * folio_shift - The size of the memory described by this folio.
>   * @folio: The folio.
>   *
> - * A folio contains a number of bytes which is a power-of-two in size.
> - * This function tells you which power-of-two the folio is.
> + * A folio represents a number of bytes which is a power-of-two in size.
> + * This function tells you which power-of-two the folio is.  See also
> + * folio_size() and folio_order().
>   *
>   * Context: The caller should have a reference on the folio to prevent
>   * it from being split.  It is not necessary for the folio to be locked.
> 

I like it. :)

--D
