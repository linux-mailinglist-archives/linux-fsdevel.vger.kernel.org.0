Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8040B3D0108
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhGTRPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 13:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhGTRPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:15:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DBAC061574;
        Tue, 20 Jul 2021 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oDAJ42dv5UM7XR2QM94ynNYpWgzAJSt3LgUls9TMDrA=; b=iI3D7zk0Eux8BZ3+/5gXEBCIkU
        V7ksq2N37ISwvTSZKYLGaQKxw4tVV1OfJ0mQ2pr88p2jBqzQoovqGyH+UaJGpH3PeMpuoc4thidA+
        2hQX3PjKZBfcT9hGj5YsnVjFlBRk0njEXAXTRZVZmiqwbvcUgnQLg4fEcz0HDsRtsfgxGYh00OF67
        R2a3e4Uu9husSNqcuY1qYLWMQOqYfohQtodkDq9js4MCWvx5hbLvDVmxPhcPkgDXJTj9JmtM3qNYh
        EIMRIxMepEYobhn9xutI0g4wN9naS/UA1wyHe62gx3U43WMKZ3G9IAj+xF5z03QFg3RoR48GUpkFy
        JVFVl1Uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5txY-008NQ7-FL; Tue, 20 Jul 2021 17:55:17 +0000
Date:   Tue, 20 Jul 2021 18:55:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 014/138] mm/filemap: Add folio_next_index()
Message-ID: <YPcOAADVC2ta+7Zh@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-15-willy@infradead.org>
 <YPaog6FqCWY+JQLk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPaog6FqCWY+JQLk@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:42:11PM +0300, Mike Rapoport wrote:
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index f7c165b5991f..bd0e7e91bfd4 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -406,6 +406,17 @@ static inline pgoff_t folio_index(struct folio *folio)
> >          return folio->index;
> >  }
> >  
> > +/**
> > + * folio_next_index - Get the index of the next folio.
> > + * @folio: The current folio.
> > + *
> > + * Return: The index of the folio which follows this folio in the file.
> > + */
> 
> Maybe note that index is in units of pages?

I don't think this is the place to explain that.  Remember, we already
have:

 * @index: Offset within the file, in units of pages.  For anonymous pages,
 *    this is the index from the beginning of the mmap.

and I don't want to explain every term of art in every function
description.  I think if you're reading this, you can follow the
link to the struct folio description and see what an index is.
