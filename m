Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C33E85BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhHJVzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbhHJVzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628632483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HURkytPMW1jYOFriQemgfAiLPlwMlS6WXiAU+lsajVI=;
        b=KOraZ+4kOcm0pN8dZmgjPiEm6WzMXPFAtr5ccMq/dOi8H6PIqnzbVNJ9qdXcu93L6hKMwz
        C8ipTytJ2whE7XEU2zuhrAe3LdPykaEjPO2Z7od5W4k44IkwoZ/ZYQECROqOxL0E8gY7cj
        kVeklPjKwhN+7t1DYtf98b1ZFUJgHqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-M2730V9LPqyEH1IGWgyY1Q-1; Tue, 10 Aug 2021 17:54:42 -0400
X-MC-Unique: M2730V9LPqyEH1IGWgyY1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A28C692500;
        Tue, 10 Aug 2021 21:54:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4D610016FB;
        Tue, 10 Aug 2021 21:54:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-86-willy@infradead.org>
References: <20210715033704.692967-86-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 085/138] mm/filemap: Add filemap_alloc_folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1814675.1628632478.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:54:38 +0100
Message-ID: <1814676.1628632478@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Reimplement __page_cache_alloc as a wrapper around filemap_alloc_folio
> to allow filesystems to be converted at our leisure.  Increases
> kernel text size by 133 bytes, mostly in cachefiles_read_backing_file().
> pagecache_get_page() shrinks by 32 bytes, though.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ...
> +static inline struct page *__page_cache_alloc(gfp_t gfp)
> +{
> +	return &filemap_alloc_folio(gfp, 0)->page;
> +}

Might be worth a note that this *will* return NULL if the allocation fails,
though I guess it's deprecated?

Reviewed-by: David Howells <dhowells@redhat.com>

