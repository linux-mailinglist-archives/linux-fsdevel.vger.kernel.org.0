Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA93A96F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhFPKMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231452AbhFPKMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623838217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULWtWmJu0uZsZT3k+laeSUemkJX3QTv8vfev2/hTwgw=;
        b=NVUheoKFMFSUUemRKgkRYi2Dj9Qk9d4epacz7jDEvjrXO14OGKBw0YJ1EjH+vbw8DQJWKb
        LL8OINp56+MivSZ2O9Dl9XB8IgM3YMW3vFw7x7YswZqpLn9ymWAiBiT2glvXGSvj8AObAz
        bPyjqCeuEujJSLqWS8fYqbxp+b4mges=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-CzoDAo_wNy2OnIvD5wiHIg-1; Wed, 16 Jun 2021 06:10:14 -0400
X-MC-Unique: CzoDAo_wNy2OnIvD5wiHIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 489ED8015F8;
        Wed, 16 Jun 2021 10:10:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2224A60C13;
        Wed, 16 Jun 2021 10:10:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-17-willy@infradead.org>
References: <20210614201435.1379188-17-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 16/33] mm/util: Add folio_mapping() and folio_file_mapping()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <814578.1623838209.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:10:09 +0100
Message-ID: <814579.1623838209@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> These are the folio equivalent of page_mapping() and page_file_mapping().
> Add an out-of-line page_mapping() wrapper around folio_mapping()
> in order to prevent the page_folio() call from bloating every caller
> of page_mapping().  Adjust page_file_mapping() and page_mapping_file()

Confusingly named, but not the fault of this patch.

> to use folios internally.  Rename __page_file_mapping() to
> swapcache_mapping() and change it to take a folio.
> 
> This ends up saving 122 bytes of text overall.  folio_mapping() is
> 45 bytes shorter than page_mapping() was, but the new page_mapping()
> wrapper is 30 bytes.  The major reduction is a few bytes less in dozens
> of nfs functions (which call page_file_mapping()).  Most of these appear
> to be a slight change in gcc's register allocation decisions, which allow:
> 
>    48 8b 56 08         mov    0x8(%rsi),%rdx
>    48 8d 42 ff         lea    -0x1(%rdx),%rax
>    83 e2 01            and    $0x1,%edx
>    48 0f 44 c6         cmove  %rsi,%rax
> 
> to become:
> 
>    48 8b 46 08         mov    0x8(%rsi),%rax
>    48 8d 78 ff         lea    -0x1(%rax),%rdi
>    a8 01               test   $0x1,%al
>    48 0f 44 fe         cmove  %rsi,%rdi
> 
> for a reduction of a single byte.  Once the NFS client is converted to
> use folios, this entire sequence will disappear.
> 
> Also add folio_mapping() documentation.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

