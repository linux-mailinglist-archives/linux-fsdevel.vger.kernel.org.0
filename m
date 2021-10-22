Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED200437CC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 20:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhJVSyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 14:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232190AbhJVSyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634928754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tW1THt74zlEe0JuUHAuc3WzNTwwNynQeKBO1wEGMPGk=;
        b=crt06X3ccCPwqUfBrG8P1I5R2mXHRTx+2x4DUVmbf9Ea0wG+i4dJx7Lb2QG1+aqqtO58GG
        S4rGkHs1ABQD93eR3GfAh2HnQP1oJDuNQ5K7f4JwFtCid477Ie9PYVfHFhMBLhJyy3qsGx
        FheYWcdHoy6h+A3L8/cOYZYuhj/cRr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-LwTXxwRMMRqR8zd0PjpeHQ-1; Fri, 22 Oct 2021 14:52:31 -0400
X-MC-Unique: LwTXxwRMMRqR8zd0PjpeHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DAC8802B4F;
        Fri, 22 Oct 2021 18:52:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA62C60C04;
        Fri, 22 Oct 2021 18:52:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5msO7-QCXv6JQj2Tado9ZoWAHRkgq6-En18PeKSXFDdBLw@mail.gmail.com>
References: <CAH2r5msO7-QCXv6JQj2Tado9ZoWAHRkgq6-En18PeKSXFDdBLw@mail.gmail.com> <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk> <YXHntB2O0ACr0pbz@relinquished.localdomain>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Omar Sandoval <osandov@osandov.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/67] fscache: Rewrite index API and management system
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1037423.1634928738.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 22 Oct 2021 19:52:18 +0100
Message-ID: <1037424.1634928738@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> On Thu, Oct 21, 2021 at 5:21 PM Omar Sandoval <osandov@osandov.com> wrot=
e:
> >
> > On Mon, Oct 18, 2021 at 03:50:15PM +0100, David Howells wrote:
> > However, with the advent of the tmpfile capacity in the VFS, an opport=
unity
> > arises to do invalidation much more easily, without having to wait for=
 I/O
> > that's actually in progress: Cachefiles can simply cut over its file
> > pointer for the backing object attached to a cookie and abandon the
> > in-progress I/O, dismissing it upon completion.
> =

> Have changes been made to O_TMPFILE?  It is problematic for network
> filesystems because it is not an atomic operation, and would be great if=
 it
> were possible to create a tmpfile and open it atomically (at the file sy=
stem
> level).

In this case, it's nothing to do with the network filesystem that's using =
the
cache per se.  Cachefiles is using tmpfiles on the backing filesystem, so =
as
long as that's, say, ext4, xfs or btrfs, it should work fine.  The backing
filesystem also needs to support SEEK_HOLE and SEEK_DATA.

I'm not sure I'd recommend putting your cache on a network filesystem.

David

