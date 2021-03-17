Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2712333EC28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 10:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCQJEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 05:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhCQJEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615971862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VuDrqP82HqiAtEe1crFqPJazQMGGUjNo8bu3IT7C6bE=;
        b=Ewo8/XX6FHdLDCayjIWdjZX2gsb1ULd/3Xwn1vNpg/xz513b4htlGEkSGmQ82Y2hmJorMv
        dVYPWjGmcDtWHhuhcZQqUafFgV7XOSa3o/mXYd2X4/IazY0f8+oUzjl7VJYMlzTm75hjmX
        /9n+79zidVF2jaMCvf0HYfaKO58nEaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-61mG3SLaOY-C1c44wLq3Ww-1; Wed, 17 Mar 2021 05:04:20 -0400
X-MC-Unique: 61mG3SLaOY-C1c44wLq3Ww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 195761009456;
        Wed, 17 Mar 2021 09:04:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-138.rdu2.redhat.com [10.10.113.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E43E60CCE;
        Wed, 17 Mar 2021 09:04:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whWoJhGeMn85LOh9FX-5d2-Upzmv1m2ZmYxvD31TKpUTA@mail.gmail.com>
References: <CAHk-=whWoJhGeMn85LOh9FX-5d2-Upzmv1m2ZmYxvD31TKpUTA@mail.gmail.com> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk> <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk> <20210316190707.GD3420@casper.infradead.org> <CAHk-=wjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_WeTgwBBu4uqg@mail.gmail.com> <887b9eb7-2764-3659-d0bf-6a034a031618@toxicpanda.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for PG_private_2/PG_fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31381.1615971849.1@warthog.procyon.org.uk>
Date:   Wed, 17 Mar 2021 09:04:09 +0000
Message-ID: <31382.1615971849@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And as far as I can tell, fscache doesn't want that PG_private_2 bit
> to interact with the random VM lifetime or migration rules either, and
> should rely entirely on the page count. David?

It's slightly complicated for fscache as there are two separate pieces of code
involved:

 (1) For the old fscache code that I'm trying to phase out, it does not take a
     ref when PG_fscache is taken (probably incorrectly), relying instead on
     releasepage, etc. getting called to strip the PG_fscache bit.  PG_fscache
     is held for the lifetime of the page, indicating that fscache knows about
     it and might access it at any time (to write to the cache in the
     background for example or to move pages around in the cache).

     Here PG_fscache should not prevent page eviction or migration and it's
     analogous to PG_private.

     That said, the old fscache code keeps its own radix trees of pages that
     are undergoing write to the cache, so to allow a page to be evicted,
     releasepage and co. have to consult those
     (__fscache_maybe_release_page()).

 (2) For the new netfs lib, PG_fscache is ignored by fscache itself and is
     used by the read helpers.  The helpers simply use it analogously to
     PG_writeback, indicating that there's I/O in progress from this page to
     the cache[*].  It's fine to take a ref here because we know we'll drop it
     shortly.

     Here PG_fscache might prevent page eviction or migration, but only
     because I/O is in progress.  If an increment on the page refcount
     suffices, that's fine.

In both cases, releasepage, etc. look at PG_fscache and decide whether to wait
or not (releasepage may tell the caller to skip the page if PG_fscache is
set).

[*] Willy suggested using PG_writeback to cover both write to the server and
write to the cache, and getting rid of PG_fscache entirely, but that would
require extra mechanisms.  There are three cases:

 (a) We might be writing to only the cache, e.g. because we just read from the
     server.

     Note that this may adversely affect code that does accounting associated
     with PG_writeback because we woudn't actually be writing back a user-made
     change or dealing with a dirty page.  I'm not sure if that's an issue.

 (b) We might writing to both, in which case we can expect both writes to
     finish at different times.

 (c) We might only be writing to the server, e.g. because there's no space in
     the cache or there is no cache.

It's something that might make sense, however, and we can look at in the
future, but for the moment having two separate page flags is simplest.

An additional use of PG_fscache is to prevent a second write to the cache from
being started whilst one is in progress.  I guess that would be taken over by
PG_writeback if we used that.

David

