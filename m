Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01779407D90
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhILNWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 09:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235292AbhILNWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 09:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631452878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yZLdvXCxnHFukhCLU/8ODaJA2GQ4KIoZzMo62K6+NmI=;
        b=RU4Cy7HNEbqi0jQ+cHmCgzLnYJiTPzvLNNnrKjzLJ8jWYkvhgO+R5ACSA2DfGTdTLS4PnB
        sfZU9NQhpX3zOkJLn3MxyUIB35UZ6hBkQhvrZlAHuKmqV6YSmTAV7DDUx5jamPTryFipgb
        3jC1t3vmnAKbjiKvEunukiUyemB41g0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-o-hs5TClOaWiPWJYJ7fplQ-1; Sun, 12 Sep 2021 09:21:16 -0400
X-MC-Unique: o-hs5TClOaWiPWJYJ7fplQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE5BD1808304;
        Sun, 12 Sep 2021 13:21:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A8081B472;
        Sun, 12 Sep 2021 13:21:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     dhowells@redhat.com, Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Decoupling filesystems from pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1086692.1631452867.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sun, 12 Sep 2021 14:21:07 +0100
Message-ID: <1086693.1631452867@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Johannes,

> Wouldn't it make more sense to decouple filesystems from "paginess",
> as David puts it, now instead? Avoid the risk of doing it twice, avoid
> the more questionable churn inside mm code, avoid the confusing
> proximity to the page and its API in the long-term...

Let me seize that opening.  I've been working on doing this for network
filesystems - at least those that want to buy in.  If you look here:

https://lore.kernel.org/ceph-devel/162687506932.276387.1445671889052435550=
9.stgit@warthog.procyon.org.uk/T/#m23428c315a77d8c5206b9646bf74c8ef18d4d38=
c

the current state of which is here:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dnetfs-folio-regions

I've been looking at abstracting anything to do with pages out of the netf=
s
and putting that stuff into a helper library.  The library handles all the
caching stuff and just presents the filesystem with requests to read
into/write from an iov_iter.  The filesystem doesn't then see pages at all=
.

The motivation behind this is to make content encryption and compression
transparent and automatically available to all participating filesystems -
with the requirement that the data stored in the local disk cache
(ie. fscache) is *also* encrypted.

I have content encryption working for basic read and write on afs and Jeff
Layton is looking at how to make it work with ceph - but it's very much a =
work
in progress and things like truncate and mmap don't yet work with it.

Anyway, the library, as I'm currently writing it, maintains a list of
byte-range dirty regions on each inode, where a dirty region may span mult=
iple
folios and a folio may be contributory to multiple regions.  The fact that
pages are involved is really then merely an implementation detail

Content encryption/compression blocks may be any power-of-2 size, from 2 b=
ytes
to megabytes, and this need bear no relation to page size.  The library ca=
lls
the crypto hooks for each crypto block in the chunk[*] to be crypted.

[*] Terminology is such fun.  I have to deal with pages, crypto blocks, ob=
ject
    layout blocks, I/O blocks (rsize/wsize settings), regions.

In fact ->readpage(), ->writepage() and ->launder_page() are difficult whe=
n I
may be required to deal with blocks larger than the size of a page.  The p=
age
being poked may be in the middle of a block, so I'm endeavouring to work
around that.  Using the regions should allow me to 'launder' an inode befo=
re
invalidating the pages attached to it, and the dirty region objects can ac=
t
instead of the dirty, writeback and fscache flags on a page.

I've been building this on top of Willy's folio patchset, and so I've paus=
ed
for the moment whilst I wait to see what becomes of that.  If folios doesn=
't
get in or gets renamed, I have a load of reworking to do.

Does this sound like something you'd be interested in looking at more
generally than just network filesystems?

David

