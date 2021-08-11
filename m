Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936AA3E9118
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhHKMbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 08:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhHKMao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628685020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++F32s6NyzrMcJ6QkU/iMFSAu/4raHLUOF3ZnxBpv3o=;
        b=etX3rjeP6LkLcii1BF4byojm0kkJvrnpmLn7Or2fBkSxHCyEGokk1pK6vyjGB8TysA2MvI
        d3u3Ya94duaYG2oPJEpGAWY4TbX4Pc7EcNX1ri5fQnZuAD9p6mQzQWBA/tYVoJmSLnxixN
        i4a/24jMSuAHueLVp/wgzeUb446zDcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-V34PEIdXOKO4kGMbz2BpBg-1; Wed, 11 Aug 2021 08:30:18 -0400
X-MC-Unique: V34PEIdXOKO4kGMbz2BpBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54F8F1009E39;
        Wed, 11 Aug 2021 12:30:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18988620DE;
        Wed, 11 Aug 2021 12:30:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-80-willy@infradead.org>
References: <20210715033704.692967-80-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 079/138] mm/filemap: Add readahead_folio()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2384707.1628685015.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 11 Aug 2021 13:30:15 +0100
Message-ID: <2384708.1628685015@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> +/**
> + * readahead_folio - Get the next folio to read.
> + * @ractl: The current readahead request.
> + *
> + * Context: The folio is locked.  The caller should unlock the folio on=
ce
> + * all I/O to that folio has completed.
> + * Return: A pointer to the next folio, or %NULL if we are done.
> + */
> +static inline struct folio *readahead_folio(struct readahead_control *r=
actl)
> +{
> +	struct folio *folio =3D __readahead_folio(ractl);
>  =

> -	return page;
> +	folio_put(folio);

This will oops if __readahead_folio() returns NULL.

> +	return folio;
>  }

