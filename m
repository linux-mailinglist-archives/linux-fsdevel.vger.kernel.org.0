Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021D3315954
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhBIWVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233959AbhBIWNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612908742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njyj2XCXYGtI5AX/JV14IYXR8Ipi7RDaSVkhJ8oSglg=;
        b=EA3Za0h758jj/Hd3hLIadII+kqMWGEt9QB04NhktkFyvq+6i7AYkWIdIJuknLHBcR4FOlw
        TgVmLjYL/fsfjb1sJhZfDU7xf/sXouZmN36AzXHBp/O1qYAVj9F5fDxsDZXx4793uysNFp
        rOmVmfR3ahGYpYTRDOWRcRS8R2ig9PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-Ez0mEz_fP32izAfxafFp3w-1; Tue, 09 Feb 2021 16:25:32 -0500
X-MC-Unique: Ez0mEz_fP32izAfxafFp3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7E8FCC626;
        Tue,  9 Feb 2021 21:25:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E044519C78;
        Tue,  9 Feb 2021 21:25:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210209202134.GA308988@casper.infradead.org>
References: <20210209202134.GA308988@casper.infradead.org> <591237.1612886997@warthog.procyon.org.uk> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <618608.1612905923.1@warthog.procyon.org.uk>
Date:   Tue, 09 Feb 2021 21:25:23 +0000
Message-ID: <618609.1612905923@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Yeah, I have trouble with the private2 vs fscache bit too.  I've been
> trying to persuade David that he doesn't actually need an fscache
> bit at all; he can just increment the page's refcount to prevent it
> from being freed while he writes data to the cache.

That's not what the bit is primarily being used for.  It's being used to
prevent the starting of a second write to the cache whilst the first is in
progress and also to prevent modification whilst DMA to the cache is in
progress.  This isn't so obvious in this cut-down patchset, but comes more in
to play with full caching of local writes in my fscache-iter branch.

I can't easily share PG_writeback for this because each bit covers a write to
a different place.  PG_writeback covers the write to the server and PG_fscache
the write to the cache.  These writes may get split up differently and will
most likely finish at different times.

If I have to share PG_writeback, that will mean storing both states for each
page somewhere else and then "OR'ing" them together to drive PG_writeback.

David

