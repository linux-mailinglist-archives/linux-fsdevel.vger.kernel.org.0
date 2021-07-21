Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89263D0766
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 05:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhGUDCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 23:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhGUDCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 23:02:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64802C061574;
        Tue, 20 Jul 2021 20:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dsRmYc7lEaqoP2+X6AguZk7ez1NBxMNjdl517TP8RNk=; b=cuaVsBujpmqfzmiYbxiUG+lXmq
        ++Ui1/Ic70REJFYqiBVkwOyd3QGSeCGigXG+K6jfltqoo7y8KIH/JaU34COso+QF8nCrbUE9UxIwU
        5c1v5I4Fqdq+4+JpomVDrb+lBWoRVvkKY5xEMqbMFf2Eb24H6s2EePnr6zsM24viBjGsip8Znxbgm
        XIjcwvd8WvL8xipzZUTvTkoBQF8nUDBKSAc1cym13+N41B45HB/3SLv0GRo7TLscDi56UMNMqjeho
        VKdNsPoW6tdqXzFEjAwZLQwLLl1a69/GWbeezSZW55VtOAJ63w6ohSfD4kCN5zIs23YCt5ZfT8q8Z
        aIOHYo6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6380-008lMj-46; Wed, 21 Jul 2021 03:42:42 +0000
Date:   Wed, 21 Jul 2021 04:42:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 002/138] mm: Introduce struct folio
Message-ID: <YPeXrDf2RRJmXMFM@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-3-willy@infradead.org>
 <YPaoBcXmrLv7zpD2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPaoBcXmrLv7zpD2@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:40:05PM +0300, Mike Rapoport wrote:
> > +/**
> > + * folio_shift - The number of bits covered by this folio.
> 
> For me this sounds like the size of the folio in bits.
> Maybe just repeat "The base-2 logarithm of the size of this folio" here and
> in return description?
> 
> > + * @folio: The folio.
> > + *
> > + * A folio contains a number of bytes which is a power-of-two in size.
> > + * This function tells you which power-of-two the folio is.
> > + *
> > + * Context: The caller should have a reference on the folio to prevent
> > + * it from being split.  It is not necessary for the folio to be locked.
> > + * Return: The base-2 logarithm of the size of this folio.
> > + */

I've gone with:

 /**
- * folio_shift - The number of bits covered by this folio.
+ * folio_shift - The size of the memory described by this folio.
  * @folio: The folio.
  *
- * A folio contains a number of bytes which is a power-of-two in size.
- * This function tells you which power-of-two the folio is.
+ * A folio represents a number of bytes which is a power-of-two in size.
+ * This function tells you which power-of-two the folio is.  See also
+ * folio_size() and folio_order().
  *
  * Context: The caller should have a reference on the folio to prevent
  * it from being split.  It is not necessary for the folio to be locked.

