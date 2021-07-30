Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4F3DB504
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhG3I1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231411AbhG3I1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627633621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FtGnm8xmLjSMkjUsJ50BAg0rK1TkGGuEgcUSvcoAdjc=;
        b=aMLxmLC8zmVX0eIlafisYVXo3QbtQ4e8h/e5Bf6/XgNROwJLQlLUq8CpEoydBBLGwh2sWN
        k0WubA4rTha9A+46Tpn0Ag2sDdIu3JbSL7Z916y4M0/vQyKlIHLMBw3AYp8I5ostnmg/lj
        1w3rCKVqTt5x5NsLdV9YK6/mfdKM2Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-HzwnD3o8MJaLgfvxUP-Y0A-1; Fri, 30 Jul 2021 04:25:23 -0400
X-MC-Unique: HzwnD3o8MJaLgfvxUP-Y0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1929100E420;
        Fri, 30 Jul 2021 08:25:22 +0000 (UTC)
Received: from T590 (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07D8C5D6A1;
        Fri, 30 Jul 2021 08:25:15 +0000 (UTC)
Date:   Fri, 30 Jul 2021 16:25:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 01/17] block: Add bio_add_folio()
Message-ID: <YQO3bXpibArh37fH@T590>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-2-willy@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:45PM +0100, Matthew Wilcox (Oracle) wrote:
> This is a thin wrapper around bio_add_page().  The main advantage here
> is the documentation that the submitter can expect to see folios in the
> completion handler, and that stupidly large folios are not supported.
> It's not currently possible to allocate stupidly large folios, but if
> it ever becomes possible, this function will fail gracefully instead of
> doing I/O to the wrong bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/bio.c         | 21 +++++++++++++++++++++
>  include/linux/bio.h |  3 ++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1fab762e079b..c64e35548fb2 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -933,6 +933,27 @@ int bio_add_page(struct bio *bio, struct page *page,
>  }
>  EXPORT_SYMBOL(bio_add_page);
>  
> +/**
> + * bio_add_folio - Attempt to add part of a folio to a bio.
> + * @bio: Bio to add to.
> + * @folio: Folio to add.
> + * @len: How many bytes from the folio to add.
> + * @off: First byte in this folio to add.
> + *
> + * Always uses the head page of the folio in the bio.  If a submitter only
> + * uses bio_add_folio(), it can count on never seeing tail pages in the
> + * completion routine.  BIOs do not support folios that are 4GiB or larger.
> + *
> + * Return: The number of bytes from this folio added to the bio.
> + */
> +size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> +		size_t off)
> +{
> +	if (len > UINT_MAX || off > UINT_MAX)
> +		return 0;

The added page shouldn't cross 4G boundary, so just wondering why not
check 'if (len > UINT_MAX - off)'?


Thanks, 
Ming

