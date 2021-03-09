Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625583321D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 10:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhCIJWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 04:22:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhCIJV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615281718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbGQhFsWORLegeM9HGujB/YiUTVMdc6Nb8R30vrP8qg=;
        b=QANZGjB7q6airvkYHP7s24/3Y5T31h0I4MEXFYStBomr1I7e/F8+wGOwiOFDAI/hpfCgv3
        GcM1YE5ZQnsM0hFr2wJmRhvM6NJYZsfz3zLwrSFABEInCoZ+/ar5/M7JioDVKrI91Ib20q
        hnCupH9AHjs4vhtG/6/TDJVs2rpTbN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-WXeLrfhUNES_-vEl3omWaQ-1; Tue, 09 Mar 2021 04:21:57 -0500
X-MC-Unique: WXeLrfhUNES_-vEl3omWaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92A4B193F560;
        Tue,  9 Mar 2021 09:21:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9F7059458;
        Tue,  9 Mar 2021 09:21:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210308215535.GA63242@dread.disaster.area>
References: <20210308215535.GA63242@dread.disaster.area> <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com> <2653261.1614813611@warthog.procyon.org.uk> <517184.1615194835@warthog.procyon.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     dhowells@redhat.com, Amir Goldstein <amir73il@gmail.com>,
        linux-cachefs@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fscache: Redesigning the on-disk cache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <152280.1615281705.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 09 Mar 2021 09:21:45 +0000
Message-ID: <152281.1615281705@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> wrote:

> > > With ->fiemap() you can at least make the distinction between a non
> > > existing and an UNWRITTEN extent.
> > =

> > I can't use that for XFS, Ext4 or btrfs, I suspect.  Christoph and Dav=
e's
> > assertion is that the cache can't rely on the backing filesystem's met=
adata
> > because these can arbitrarily insert or remove blocks of zeros to brid=
ge or
> > split extents.
> =

> Well, that's not the big problem. The issue that makes FIEMAP
> unusable for determining if there is user data present in a file is
> that on-disk extent maps aren't exactly coherent with in-memory user
> data state.
> =

> That is, we can have a hole on disk with delalloc user data in
> memory.  There's user data in the file, just not on disk. Same goes
> for unwritten extents - there can be dirty data in memory over an
> unwritten extent, and it won't get converted to written until the
> data is written back and the filesystem runs a conversion
> transaction.
> =

> So, yeah, if you use FIEMAP to determine where data lies in a file
> that is being actively modified, you're going get corrupt data
> sooner rather than later.  SEEK_HOLE/DATA are coherent with in
> memory user data, so don't have this problem.

I thought you and/or Christoph said it *was* a problem to use the backing
filesystem's metadata to track presence of data in the cache because the
filesystem (or its tools) can arbitrarily insert blocks of zeros to
bridge/break up extents.

If that is the case, then that is a big problem, and SEEK_HOLE/DATA won't
suffice.

If it's not a problem - maybe if I can set a mark on a file to tell the
filesystem and tools not to do that - then that would obviate the need for=
 me
to store my own maps.

David

