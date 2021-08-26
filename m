Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377083F8409
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbhHZI7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 04:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240751AbhHZI7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629968294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cIdwTiP0NVTGucL/JR43xH/9VntQvDYubEEe+Wyv8Nc=;
        b=TEpjLCk4YZh2BDwu5882jAN6aUIm2A4oBF8eXhK14duVcHJ8TwxR3DYeUctO3+NkidmQpF
        anrDslUmJvtv4kvQARU5vJOsjCxuIh4ZAFDS4HaqDsrX1y5VjnHrabZPR6S8Bib9kY14/r
        3EQrcR6q+atYPHVZlLALxK1yhHW9KJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-hF47ieCuMg-5hNZcWFij9A-1; Thu, 26 Aug 2021 04:58:11 -0400
X-MC-Unique: hF47ieCuMg-5hNZcWFij9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C19180292B;
        Thu, 26 Aug 2021 08:58:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A92D60936;
        Thu, 26 Aug 2021 08:58:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YSZeKfHxOkEAri1q@cmpxchg.org>
References: <YSZeKfHxOkEAri1q@cmpxchg.org> <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org> <YSQeFPTMn5WpwyAa@casper.infradead.org> <YSU7WCYAY+ZRy+Ke@cmpxchg.org> <YSVMAS2pQVq+xma7@casper.infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2101396.1629968286.1@warthog.procyon.org.uk>
Date:   Thu, 26 Aug 2021 09:58:06 +0100
Message-ID: <2101397.1629968286@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> wrote:

> But we're here in part because the filesystems have been too exposed
> to the backing memory implementation details. So all I'm saying is, if
> you're touching all the file cache interface now anyway, why not use
> the opportunity to properly disconnect it from the reality of pages,
> instead of making the compound page the new interface for filesystems.
> 
> What's wrong with the idea of a struct cache_entry

Well, the name's already taken, though only in cifs.  And we have a *lot* of
caches so just calling it "cache_entry" is kind of unspecific.

> which can be
> embedded wherever we want: in a page, a folio or a pageset. Or in the
> future allocated on demand for <PAGE_SIZE entries, if need be. But
> actually have it be just a cache entry for the fs to read and write,
> not also a compound page and an anon page etc. all at the same time.
> 
> Even today that would IMO delineate more clearly between the file
> cache data plane and the backing memory plane. It doesn't get in the
> way of also fixing the base-or-compound mess inside MM code with
> folio/pageset, either.

One thing I like about Willy's folio concept is that, as long as everyone uses
the proper accessor functions and macros, we can mostly ignore the fact that
they're 2^N sized/aligned and they're composed of exact multiples of pages.
What really matters are the correspondences between folio size/alignment and
medium/IO size/alignment, so you could look on the folio as being a tool to
disconnect the filesystem from the concept of pages.

We could, in the future, in theory, allow the internal implementation of a
folio to shift from being a page array to being a kmalloc'd page list or
allow higher order units to be mixed in.  The main thing we have to stop
people from doing is directly accessing the members of the struct.

There are some tricky bits: kmap and mmapped page handling, for example.  Some
of this can be mitigated by making iov_iters handle folios (the ITER_XARRAY
type does, for example) and providing utilities to populate scatterlists.

David

