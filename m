Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4CE3FCF80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbhHaWQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 18:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240378AbhHaWQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630448157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=87x+DTynGLQU2JkIoM5X3ezVDhZ+h9VNFi3bKAp7/QQ=;
        b=SC5opOwb4XMmnxbhEkFrMXcheIS5fkgOGfL4A4kQO6i0sMUsno9jZibQBOxPqrPxc12a/O
        bfphV4MynyHqQTQuhuuUqVZTPzwi1eCQl0UD1lVDjxVNgtnZ9eJBVd6rQ9kSEa5IoigfEr
        XUmIsPO63hkOCVbqD0kC4RdkyHnDX18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-QiOs4Te1P7m56nLit_JQdA-1; Tue, 31 Aug 2021 18:15:53 -0400
X-MC-Unique: QiOs4Te1P7m56nLit_JQdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302021009628;
        Tue, 31 Aug 2021 22:15:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E57D26060F;
        Tue, 31 Aug 2021 22:15:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Folios: Can we resolve this please?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3285173.1630448147.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 31 Aug 2021 23:15:47 +0100
Message-ID: <3285174.1630448147@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus, Andrew, Johannes,

Can we come to a quick resolution on folios?  I'd really like this to be
solved in this merge window if at all possible as I (and others) have stuf=
f
that will depend on and will conflict with Willy's folio work.  It would b=
e
great to get this sorted one way or another.

As I see it, there are three issues, I think, and I think they kind of go =
like
this:

 (1) Johannes wants to get away from pages being used as the unit of memor=
y
     currency and thinks that folios aren't helpful in this regard[1].  Th=
ere
     seems to be some disagreement about where this is heading.

 (2) Linus isn't entirely keen on Willy's approach[2], with a bottom up
     approach hiding the page objects behind a new type from the pov of th=
e
     filesystem, but would rather see the page struct stay the main API ty=
pe
     and the changes be hidden transparently inside of that.

     I think from what Linus said, he may be in favour (if that's not too
     strong a word) of using a new type to make sure we don't miss the
     necessary changes[3].

 (3) Linus isn't in favour of the name 'folio' for the new type[2].  Vario=
us
     names have been bandied around and Linus seems okay with "pageset"[4]=
,
     though it's already in minor(-ish) use[5][6].  Willy has an alternate
     patchset with "folio" changed to "pageset"[7].

With regard to (1), I think the folio concept could be used in future to h=
ide
at least some of the paginess from filesystems.

With regard to (2), I think a top-down approach won't work until and unles=
s we
wrap all accesses to struct page by filesystems (and device drivers) in
wrapper functions - we need to stop filesystems fiddling with page interna=
ls
because what page internals may mean may change.

With regard to (3), I'm personally fine with the name "folio", as are othe=
r
people[8][9][10][11], but I could also live with a conversion to "pageset"=
.

Is it possible to take the folios patchset as-is and just live with the na=
me,
or just take Willy's rename-job (although it hasn't had linux-next soak ti=
me
yet)?  Or is the approach fundamentally flawed and in need of redoing?

Thanks,
David

Link: https://lore.kernel.org/r/YSQSkSOWtJCE4g8p@cmpxchg.org/ [1]
Link: https://lore.kernel.org/r/CAHk-=3DwjD8i2zJVQ9SfF2t=3D_0Fkgy-i5Z=3DmQ=
jCw36AHvbBTGXyg@mail.gmail.com/ [2]
Link: https://lore.kernel.org/r/CAHk-=3DwgkA=3DRKJ-vke0EoOUK19Hv1f=3D47Da6=
pWAWQZPhjKD6WOg@mail.gmail.com/ [3]
Link: https://lore.kernel.org/r/CAHk-=3DwiZ=3Dwwa4oAA0y=3DKztafgp0n+BDTEV6=
ybLoH2nvLBeJBLA@mail.gmail.com/ [4]
Link: https://lore.kernel.org/r/CAHk-=3Dwhd8ugrzMS-3bupkPQz9VS+dWHPpsVssrD=
fuFgfff+n5A@mail.gmail.com/ [5]
Link: https://lore.kernel.org/r/CAHk-=3DwgwRW1_o6iBOxtSE+vm7uiSr98wkTLbCze=
9-7wW0ZhOLQ@mail.gmail.com/ [6]
Link: https://lore.kernel.org/r/YSmtjVTqR9%2F4W1aq@casper.infradead.org/ [=
7]
Link: https://lore.kernel.org/r/YSXkDFNkgAhQGB0E@infradead.org/ [8]
Link: https://lore.kernel.org/r/92cbfb8f-7418-15d5-c469-d7861e860589@rasmu=
svillemoes.dk/ [9]
Link: https://lore.kernel.org/r/cf30c0e8d1eecf08b2651c5984ff09539e2266f9.c=
amel@kernel.org/ [10]
Link: https://lore.kernel.org/r/20210826005914.GG12597@magnolia/ [11]

