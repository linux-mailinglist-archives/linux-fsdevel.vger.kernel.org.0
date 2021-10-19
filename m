Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B669433EE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhJSTDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 15:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234361AbhJSTDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634670083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=luTsdgmE900iDsk4r7Drx7azoYqgQwbXioWRwmTxsXU=;
        b=huNdBeYWwUOLuOuo/qO5SfBYJjwIqwCSBTq/UeP4Ze3VnBJXLaNcoBFQCk5BSmzTUsG3J5
        6DyIhKSRvCnJBWamYZfEroGZ12sZ8OLCNOV5bq57P0M6RKyT7a91S4/52edu9+5vtkQI/U
        scbQgcpFF2+a/lJN6mytvUa19PSv9ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-JCqP3r1lPumGoWAVNqfxIw-1; Tue, 19 Oct 2021 15:01:17 -0400
X-MC-Unique: JCqP3r1lPumGoWAVNqfxIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31D42800482;
        Tue, 19 Oct 2021 19:01:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB0645D6D7;
        Tue, 19 Oct 2021 19:00:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b2ea9fdf90939731c08329575c8843e8db5f3219.camel@kernel.org>
References: <b2ea9fdf90939731c08329575c8843e8db5f3219.camel@kernel.org> <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        Latchesar Ionkov <lucho@ionkov.net>,
        Steve French <sfrench@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/67] fscache: Rewrite index API and management system
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2972093.1634670049.1@warthog.procyon.org.uk>
Date:   Tue, 19 Oct 2021 20:00:49 +0100
Message-ID: <2972094.1634670049@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> Given the indexing changes, what sort of behavior should we expect when
> upgrading from old-style to new-style indexes? Do they just not match,
> and we end up downloading new copies of all the data and the old stale
> stuff eventually gets culled?

Correct: they don't match.  The names of the directories and files will be
quite different - and so will the attached xattrs.  However, no filesystems
currently store locally-modified data in the cache, so you shouldn't lose any
data after upgrading.

> Ditto for downgrades -- can we expect sane behavior if someone runs an
> old kernel on top of an existing fscache that was populated by a new
> kernel?

Correct.  With this branch, filesystems now store locally-modified data into
the cache - but they also upload it to the server at the same time.  If
there's a disagreement between what's in the cache and what's on the server
with this branch, the cache is discarded, so simply discarding the cache on a
download shouldn't be a problem.

It's currently operating as a write-through cache, not a write-back cache.
That will change if I get round to implementing disconnected operation, but
it's not there yet.

David

