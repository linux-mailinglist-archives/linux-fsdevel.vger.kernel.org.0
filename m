Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B081477E97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhLPVSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234284AbhLPVSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639689478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Szv2WCpyhjVjn4Fey8iXx2Wp1kssTkyePEeP3VFIu8g=;
        b=GbRUD3+MKFN7Kya/IXXWDpTv7Rn8vMKtmkOYUzb9I+g0uWYq6bME+qysj3rGVe1RY/rj7P
        VW3/Vd6+DaDDrbpQMu2fIjgbQifhVr0fz7YrQ+Vc2egrilW+iU42QfiZOXsDCLSpwe6AT9
        6VXov1HQbhjU/09wFmZU/HwgNdjjMDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-9OVE1SGIPOa1lU4pLKOZTQ-1; Thu, 16 Dec 2021 16:17:57 -0500
X-MC-Unique: 9OVE1SGIPOa1lU4pLKOZTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91DAA1937FC0;
        Thu, 16 Dec 2021 21:17:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85D2C6E96B;
        Thu, 16 Dec 2021 21:17:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wh2dr=NgVSVj0sw-gSuzhxhLRV5FymfPS146zGgF4kBjA@mail.gmail.com>
References: <CAHk-=wh2dr=NgVSVj0sw-gSuzhxhLRV5FymfPS146zGgF4kBjA@mail.gmail.com> <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk> <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk> <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com> <YbuTaRbNUAJx5xOA@casper.infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 56/68] afs: Handle len being extending over page end in write_begin/write_end
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1840346.1639689467.1@warthog.procyon.org.uk>
Date:   Thu, 16 Dec 2021 21:17:47 +0000
Message-ID: <1840347.1639689467@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I will NAK these patches by David, because they are fundamentally
> wrong, whichever way we turn. Any "write in bigger chunks" patch will
> be something else entirely.

I'll just drop patches 56 and 57 for now, then.  I think the problem only
manifests if I set the flag saying the filesystem/inode/whatever supports
multipage folios.

David

