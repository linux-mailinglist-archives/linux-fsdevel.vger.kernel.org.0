Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2549370E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 10:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352975AbiASJSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 04:18:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352967AbiASJSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642583903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsHFjR3VZGRzuJsXGrmQKYKJ/CFlVyV1IKZ/8UEEbWk=;
        b=hZx9c6vsj4M4OonxWbm7CmdS40XFOkgCe1NXyf4qqlUE4hMR5w5gbhZsBTfFwORPNPjB1S
        IRt8bm1waqCNvz2l2/6Ut+UWk+4WGSJrNdFHGAMFN+aiyng7tQqy8zbQFlPlGKZBH1iM6l
        JXclfyN5w+kkmy6hnIxhNj4Zp4hTGao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-GmWhYa85PziqVu9-iauLvg-1; Wed, 19 Jan 2022 04:18:20 -0500
X-MC-Unique: GmWhYa85PziqVu9-iauLvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B820814249;
        Wed, 19 Jan 2022 09:18:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 163D27B9D6;
        Wed, 19 Jan 2022 09:18:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YeefizLOGt1Qf35o@infradead.org>
References: <YeefizLOGt1Qf35o@infradead.org> <YebpktrcUZOlBHkZ@infradead.org> <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk> <164251409447.3435901.10092442643336534999.stgit@warthog.procyon.org.uk> <3613681.1642527614@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs, fscache: Add an IS_KERNEL_FILE() macro for the S_KERNEL_FILE flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3765723.1642583885.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 19 Jan 2022 09:18:05 +0000
Message-ID: <3765724.1642583885@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jan 18, 2022 at 05:40:14PM +0000, David Howells wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > =

> > > On Tue, Jan 18, 2022 at 01:54:54PM +0000, David Howells wrote:
> > > > Add an IS_KERNEL_FILE() macro to test the S_KERNEL_FILE inode flag=
 as is
> > > > common practice for the other inode flags[1].
> > > =

> > > Please fix the flag to have a sensible name first, as the naming of =
the
> > > flag and this new helper is utterly wrong as we already discussed.
> > =

> > And I suggested a new name, which you didn't comment on.
> =

> Again, look at the semantics of the flag:  The only thing it does in the
> VFS is to prevent a rmdir.  So you might want to name it after that.
> =

> Or in fact drop the flag entirely.  We don't have that kind of
> protection for other in-kernel file use or important userspace daemons
> either.  I can't see why cachefiles is the magic snowflake here that
> suddenly needs semantics no one else has.

The flag cannot just be dropped - it's an important part of the interactio=
n
with cachefilesd with regard to culling.  Culling to free up space is
offloaded to userspace rather than being done within the kernel.

Previously, cachefiles, the kernel module, had to maintain a huge tree of
records of every backing inode that it was currently using so that it coul=
d
forbid cachefilesd to cull one when cachefilesd asked.  I've reduced that =
to a
single bit flag on the inode struct, thereby saving both memory and time. =
 You
can argue whether it's worth sacrificing an inode flag bit for that, but t=
he
flag can be reused for any other kernel service that wants to similarly ma=
rk
an inode in use.

Further, it's used as a mark to prevent cachefiles accidentally using an i=
node
twice - say someone misconfigures a second cache overlapping the first - a=
nd,
again, this works if some other kernel driver wants to mark inode it is us=
ing
in use.  Cachefiles will refuse to use them if it ever sees them, so no
problem there.

And it's not true that we don't have that kind of protection for other
in-kernel file use.  See S_SWAPFILE.  I did consider using that, but that =
has
other side effects.  I mentioned that perhaps I should make swapon set
S_KERNEL_FILE also.  Also blockdevs have some exclusion also, I think.

The rmdir thing should really apply to rename and unlink also.  That's to
prevent someone, cachefilesd included, causing cachefiles to malfunction b=
y
removing the directories it created.  Possibly this should be a separate b=
it
to S_KERNEL_FILE, maybe S_NO_DELETE.

So I could change S_KERNEL_FILE to S_KERNEL_LOCK, say, or maybe S_EXCLUSIV=
E.

David

