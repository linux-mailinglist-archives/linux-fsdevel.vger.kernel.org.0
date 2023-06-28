Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F65A7413C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjF1OV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 10:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231899AbjF1OUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687962003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tjEhyaZHu/TlkcYajya1TetdwCu90GUACyMii6y47c=;
        b=iDfiS8t8SjIY5yJH/c5mYrIHv8Rr8eM1Uv3yBsFhvJQ0fl6gc8bzogXYr38ZLE6i2uv+5/
        78PW3pmdVhg+A+FQVFhuXcfIWGm1OR9aLfUC+XVXCq8pzJroWQzBm3pfX1Z2p48a15cAFG
        HzwNjnWsjmVjQF+M3Culbamrug9OpjA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-W9_THFgGM7KpBq0jLQEyiA-1; Wed, 28 Jun 2023 10:19:59 -0400
X-MC-Unique: W9_THFgGM7KpBq0jLQEyiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F6888ED62D;
        Wed, 28 Jun 2023 14:19:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ABCB111F3B6;
        Wed, 28 Jun 2023 14:19:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZJws4Yr9tcaF7Mis@casper.infradead.org>
References: <ZJws4Yr9tcaF7Mis@casper.infradead.org> <ZJvsJJKMPyM77vPv@dread.disaster.area> <ZJq6nJBoX1m6Po9+@casper.infradead.org> <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name> <ZJp4Df8MnU8F3XAt@dread.disaster.area> <3299543.1687933850@warthog.procyon.org.uk> <3388728.1687944804@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and FALLOC_FL_PUNCH_HOLE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3527414.1687961979.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 28 Jun 2023 15:19:39 +0100
Message-ID: <3527415.1687961979@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Jun 28, 2023 at 10:33:24AM +0100, David Howells wrote:
> > Would you consider it a kernel bug, then, if you use sendmsg(MSG_ZEROC=
OPY) to
> > send some data from a file mmapping that some other userspace then cor=
rupts by
> > altering the file before the kernel has managed to send it?
> =

> I think there's a difference in that sendmsg() will block until it
> returns (... right?

Nope - sendmsg returns once the data is in the Tx queue.  It tells you abo=
ut
the progress made in transmitting your zerocopy data by pasting error-repo=
rt
messages with SO_EE_ORIGIN_ZEROCOPY set into the msg_control buffer when y=
ou
call recvmsg().  That tells you how many of the bytes you sent with
MSG_ZEROCOPY have so far been transmitted.  You're expected to work out fr=
om
that which of your buffers are now freed up.

Further, even if the process that issued the sendmsg() might be blocked, i=
t
doesn't mean that some other process can modify the contents of the buffer=
 by
write() or writing through a shared-writable mmap.

> splice() returns.  That implies the copy is done.

I thought the whole point of splice was to *avoid* the copy.  Or is it onl=
y to
avoid user<->kernel copies?

> Then the same thread modifies the file, but the pipe sees the new data, =
not
> the old.  Doesn't that feel like a bug to you?

It can be argued either way.  It you want to see it as a bug, then what
solution do you want?

 (1) Always copy the data into the pipe.

 (2) Always unmap and steal the pages from the pagecache, copying if we ca=
n't.

 (3) R/O-protect any PTEs mapping those pages and implement CoW.

 (4) Disallow splice() from any region that's mmapped, disallow mmap() on =
or
     make page_mkwrite wait for any region that's currently spliced.  Disa=
llow
     fallocate() on or make fallocate() wait for any pages that are splice=
d.

2 and 3 are likely to have a performance degradation because we'll have to
zap/modify PTEs before completing the splice.  4 will have some functional=
ity
degradation.

3 sounds particularly messy.  The problem is that if a page in the pagecac=
he
is spliced into a pipe, we have to discard the page from the pagecache if =
we
would otherwise want to modify it.  I guess we'd need a splice counter add=
ing
to struct folio?  (Or as least a PG_was_once_spliced bit).

Maybe (2a) Steal the page if unmapped, unpinned and only in use by the
pagecache, copy it otherwise?

Maybe you have a better solution?

David

