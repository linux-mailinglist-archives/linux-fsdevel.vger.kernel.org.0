Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4899A488279
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 09:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiAHIlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 03:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233820AbiAHIlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641631304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9IAN3xR9Cay5DTUAfbThKuQWTtiMNDV7nchjhETfU8=;
        b=DcO3wdB7Fmn+D1qemYbCJwAwXouzAN7ffvWeF/p+McavT1t4NEjG73zL4ZPcXaDIsihDb1
        7TO7zwnfSQEPBAUzRNkXn6JUrdhjm+dsFudM8nkQ40UGq/RZbjaaXirDe1GF/LQIZZnpWB
        M4O6+c163citrlOYw727F/Gy0ZmMN90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-N4TjadJYNBChUM06yBqS9g-1; Sat, 08 Jan 2022 03:41:39 -0500
X-MC-Unique: N4TjadJYNBChUM06yBqS9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7036B18397A7;
        Sat,  8 Jan 2022 08:41:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA3CF5F92A;
        Sat,  8 Jan 2022 08:41:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxjEcvffv=rNXS-r+NLz+=6yk4abRuX_AMq9v-M4nf_PtA@mail.gmail.com>
References: <CAOQ4uxjEcvffv=rNXS-r+NLz+=6yk4abRuX_AMq9v-M4nf_PtA@mail.gmail.com> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk> <164021541207.640689.564689725898537127.stgit@warthog.procyon.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 38/68] vfs, cachefiles: Mark a backing file in use with an inode flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3492170.1641631286.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sat, 08 Jan 2022 08:41:26 +0000
Message-ID: <3492171.1641631286@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> > -       if (is_local_mountpoint(dentry))
> > +       if (is_local_mountpoint(dentry) ||
> > +           (dentry->d_inode->i_flags & S_KERNEL_FILE))
> =

> Better as this check to the many other checks in may_delete()

Okay.  It will make things a bit more complicated, so I'll do it in a foll=
ow
up patch.  The problem is that it will prevent the cachefiles driver in th=
e
kernel from renaming directories and unlinking files as it's currently
removing the mark *after* moving/deleting them.

> > +#define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg.=
 fs/cachefiles) */
> >
> =

> Trying to brand this flag as a generic "in use by kernel" is misleading.
> Modules other than cachefiles cannot set/clear this flag, because then
> cachefiles won't know that it is allowed to set/clear the flag.

If the flag is set, then cachefiles thinks some other kernel driver is usi=
ng
the file and it shouldn't try to use it.  It doesn't matter who has it ope=
n.

It should never happen as other kernel drivers shouldn't be poking around
inside cachefiles's cache, but possibly someone could misconfigure somethi=
ng.

David

