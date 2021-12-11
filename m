Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D47D471407
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhLKNiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 08:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231135AbhLKNh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 08:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639229878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Z8c8lX7Q347Z+4ORdcMYBofXUvb1OCWCHdF//k2AV4=;
        b=DNli0noFqJ8lUPi7jbfZT67rQaCSs+19MVIEc5UYfulLowkQdCev5HwDr6eJIFkRHy9hYF
        ZpWFKUtDA6F+7Kzi9kJN5D0FtLeZa0oTeqopJBiU8l0IGOAvAWzX3rQQKZKcy+A58EgHov
        IC2SZCBaLsn21IEsrGTdpr5Q+J6+oLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-qp91NnnxO2W56AfTygDTXQ-1; Sat, 11 Dec 2021 08:37:55 -0500
X-MC-Unique: qp91NnnxO2W56AfTygDTXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F5FF801AAB;
        Sat, 11 Dec 2021 13:37:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BBF188F7;
        Sat, 11 Dec 2021 13:37:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zOknSu_qkb9N0i4LY8tUtXmXirSsU7gGZsUOtLu8c88ieg@mail.gmail.com>
References: <CALF+zOknSu_qkb9N0i4LY8tUtXmXirSsU7gGZsUOtLu8c88ieg@mail.gmail.com> <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk> <163906979003.143852.2601189243864854724.stgit@warthog.procyon.org.uk>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs <linux-cachefs@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        linux-cifs <linux-cifs@vger.kernel.org>,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 62/67] nfs: Convert to new fscache volume/cookie API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <353627.1639229864.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sat, 11 Dec 2021 13:37:44 +0000
Message-ID: <353628.1639229864@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> >  (4) fscache_enable/disable_cookie() have been removed.
> >
> >      Call fscache_use_cookie() and fscache_unuse_cookie() when a file =
is
> >      opened or closed to prevent a cache file from being culled and to=
 keep
> >      resources to hand that are needed to do I/O.
> >
> >      Unuse the cookie when a file is opened for writing.  This is gate=
d by
> >      the NFS_INO_FSCACHE flag on the nfs_inode.
> >
> >      A better way might be to invalidate it with FSCACHE_INVAL_DIO_WRI=
TE
> >      which will keep it unused until all open files are closed.
> >
> =

> It looks like the comment doesn't match what was actually done inside
> nfs_fscache_open_file().  Is the code right and the comment just out of =
date?

The comment is out of date.  NFS_INO_FSCACHE isn't used now.

> I'm getting that kasan UAF firing periodically in this code path, and so=
 it
> looks related to this change,though I don't have great info on it so far=
 and
> it's hard to reproduce.

Can you copy the kasan UAF text into a reply?

David

