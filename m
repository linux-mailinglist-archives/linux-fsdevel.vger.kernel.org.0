Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96E3E1712
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 16:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhHEOiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 10:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232963AbhHEOiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628174288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w90vbKB51SLxac7fkQF8VwHCUjek+TgW3nOJS8GSEyU=;
        b=SQ/tqphP7O6DOLsZZCdj7aK008jci9/IKdxvYF3+nUedZEUeA79g8VpJByH6l1wjJtY20x
        gajykuvo7L2bO9II17BWQuSriRz5fh8oWoZJwT5sxxZOFFwmeeRt1P+2m9UcMAwJ/svDkx
        JbZH6c8Y+ugLwumX0g5MwQobtOOiWSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-0WieseC_PrujNVSR2mwqqA-1; Thu, 05 Aug 2021 10:38:05 -0400
X-MC-Unique: 0WieseC_PrujNVSR2mwqqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5730190D340;
        Thu,  5 Aug 2021 14:38:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F7FE5D9DD;
        Thu,  5 Aug 2021 14:38:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YQvpDP/tdkG4MMGs@casper.infradead.org>
References: <YQvpDP/tdkG4MMGs@casper.infradead.org> <YQvbiCubotHz6cN7@casper.infradead.org> <1017390.1628158757@warthog.procyon.org.uk> <1170464.1628168823@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Could it be made possible to offer "supplementary" data to a DIO write ?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1186270.1628174281.1@warthog.procyon.org.uk>
Date:   Thu, 05 Aug 2021 15:38:01 +0100
Message-ID: <1186271.1628174281@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> You can already get 400Gbit ethernet.

Sorry, but that's not likely to become relevant any time soon.  Besides, my
laptop's wifi doesn't really do that yet.

> Saving 500 bytes by sending just the 12 bytes that changed is optimising the
> wrong thing.

In one sense, at least, you're correct.  The cost of setting up an RPC to do
the write and setting up crypto is high compared to transmitting 3 bytes vs 4k
bytes.

> If you have two clients accessing the same file at byte granularity, you've
> already lost.

Doesn't stop people doing it, though.  People have sqlite, dbm, mail stores,
whatever in the homedirs from the desktop environments.  Granted, most of the
time people don't log in twice with the same homedir from two different
machines (and it doesn't - or didn't - used to work with Gnome or KDE).

> Extent based filesystems create huge extents anyway:

Okay, so it's not feasible.  That's fine.

> This has already happened when you initially wrote to the file backing
> the cache.  Updates are just going to write to the already-allocated
> blocks, unless you've done something utterly inappropriate to the
> situation like reflinked the files.

Or the file is being read random-access and we now have a block we didn't have
before that is contiguous to another block we already have.

> If you want to take leases at byte granularity, and then not writeback
> parts of a page that are outside that lease, feel free.  It shouldn't
> affect how you track dirtiness or how you writethrough the page cache
> to the disk cache.

Indeed.  Handling writes to the local disk cache is different from handling
writes to the server(s).  The cache has a larger block size but I don't have
to worry about third-party conflicts on it, whereas the server can be taken as
having no minimum block size, but my write can clash with someone else's.

Generally, I prefer to write back the minimum I can get away with (as does the
Linux NFS client AFAICT).

However, if everyone agrees that we should only ever write back a multiple of
a certain block size, even to network filesystems, what block size should that
be?  Note that PAGE_SIZE varies across arches and folios are going to
exacerbate this.  What I don't want to happen is that you read from a file, it
creates, say, a 4M (or larger) folio; you change three bytes and then you're
forced to write back the entire 4M folio.

Note that when content crypto or compression is employed, some multiple of the
size of the encrypted/compressed blocks would be a requirement.

David

