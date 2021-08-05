Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABA3E183B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 17:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbhHEPjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 11:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242313AbhHEPjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628177937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3S29HjL3Vb9q9YH8bmWKld33b/KN/RqQKdhy40cdvM=;
        b=AlcyC1+zNr3FjMU74IPVPVDeSGiTQijnPJ6x4SwwXF4XjD6p7d9rM5S3LMdKivC3G5/48z
        6bfh+41Apnx4Z4JvNEs4yhH/D/QjIARvOuOTPaCO9nxUgt7KpbDPLGCRurSacQP0/heyTL
        wf3lfHwnkfEBolGK8OshRl1rEbfSfOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-NJ6bkOBkNAebOHEifdG9_A-1; Thu, 05 Aug 2021 11:38:56 -0400
X-MC-Unique: NJ6bkOBkNAebOHEifdG9_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7ED0100CA8C;
        Thu,  5 Aug 2021 15:38:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32A0460CA1;
        Thu,  5 Aug 2021 15:38:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YQv+iwmhhZJ+/ndc@casper.infradead.org>
References: <YQv+iwmhhZJ+/ndc@casper.infradead.org> <YQvpDP/tdkG4MMGs@casper.infradead.org> <YQvbiCubotHz6cN7@casper.infradead.org> <1017390.1628158757@warthog.procyon.org.uk> <1170464.1628168823@warthog.procyon.org.uk> <1186271.1628174281@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Could it be made possible to offer "supplementary" data to a DIO write ?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1216853.1628177932.1@warthog.procyon.org.uk>
Date:   Thu, 05 Aug 2021 16:38:52 +0100
Message-ID: <1216854.1628177932@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Note that PAGE_SIZE varies across arches and folios are going to
> > exacerbate this.  What I don't want to happen is that you read from a
> > file, it creates, say, a 4M (or larger) folio; you change three bytes and
> > then you're forced to write back the entire 4M folio.
> 
> Actually, you do.  Two situations:
> 
> 1. Application uses MADVISE_HUGEPAGE.  In response, we create a 2MB
> page and mmap it aligned.  We use a PMD sized TLB entry and then the
> CPU dirties a few bytes with a store.  There's no sub-TLB-entry tracking
> of dirtiness.  It's just the whole 2MB.

That's a special case.  The app specifically asked for it.  I'll grant with
mmap you have to mark a whole page as being dirty - but if you mmapped it, you
need to understand that's what will happen.

> 2. The bigger the folio, the more writes it will absorb before being
> written back.  So when you're writing back that 4MB folio, you're not
> just servicing this 3 byte write, you're servicing every other write
> which hit this 4MB chunk of the file.

You can argue it that way - but we already do it bytewise in some filesystems,
so what you want would necessitate a change of behaviour.

Note also that if the page size > max RPC payload size (1MB in NFS, I think),
you have to make multiple write operations to fulfil that writeback; further,
if you have an object-based system you might be making writes to multiple
servers, some of which will not actually make a change, to make that
writeback.

I wonder if this needs pushing onto the various network filesystem mailing
lists to find out what they want and why.

David

