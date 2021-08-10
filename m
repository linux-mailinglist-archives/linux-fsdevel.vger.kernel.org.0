Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469F73E85AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhHJVv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234993AbhHJVvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628632289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WOJbDaOgR9A4WIv7Hr0VHIDUG6WaV2S/pWdNcf5TSwI=;
        b=RiT0GnH89G/LjiahBjnlSji+hwWahu1fHmTx7BowRQ5/cb63/QubX5NQQWHNkURuv/c5CY
        Y0orjpJxtljFRZxl69YjtXiiSga54MPs+xUCNV0dOTsyuzpETU5erXGvYPCOjVixsyPLpz
        8vStBBHXTwr7UQXF6jBdHQvTgm5bsQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-T7ZIgILRO2iicsiT8o-PHw-1; Tue, 10 Aug 2021 17:51:26 -0400
X-MC-Unique: T7ZIgILRO2iicsiT8o-PHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2258B1853026;
        Tue, 10 Aug 2021 21:51:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F38C760BF1;
        Tue, 10 Aug 2021 21:51:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-85-willy@infradead.org>
References: <20210715033704.692967-85-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 084/138] mm/page_alloc: Add folio allocation functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1814545.1628632283.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:51:23 +0100
Message-ID: <1814546.1628632283@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> +struct folio *folio_alloc(gfp_t gfp, unsigned order)
> +{
> +	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> +
> +	if (page && order > 1)
> +		prep_transhuge_page(page);

Ummm...  Shouldn't order==1 pages (two page folios) be prep'd also?

> +	return (struct folio *)page;
> +}

Would it be better to just jump to alloc_pages() if order <= 1?  E.g.:

struct folio *folio_alloc(gfp_t gfp, unsigned order)
{
	struct page *page;

	if (order <= 1)
		return (struct folio *)alloc_pages(gfp | __GFP_COMP, order);

	page = alloc_pages(gfp | __GFP_COMP, order);
	if (page)
		prep_transhuge_page(page);
	return (struct folio *)page;
}

David

