Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4785440B75A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhINTAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 15:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232272AbhINTAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631645957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3OUaDnOxKNbvKbqhxE7IAvlc8abcRFpZR5Sv/ym/5Ys=;
        b=TuoNLdAVxHonvf8be3WaeK6OOoNJg85imVPHsK+l/BBuv27VZ0zZQZ7tS6rsxxnqGj+0J/
        bWD2MK4UQWGnlWdH9VWmTayAHsuDjLp9kvigLr/E4v8z9cYlRirEb4EHNVQLvMBpVZ4Cbf
        Ycjz5cyJ+rkwdhJksFFxZEltkcLtS5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-DTeW0HMUPTu9bfacEsuHNg-1; Tue, 14 Sep 2021 14:59:14 -0400
X-MC-Unique: DTeW0HMUPTu9bfacEsuHNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCC78100CC84;
        Tue, 14 Sep 2021 18:59:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26FAE7A8D2;
        Tue, 14 Sep 2021 18:59:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgR_unCDRZ+8iTb5gBO6bgRkuS4JYBpi25v12Yp6TzWVA@mail.gmail.com>
References: <CAHk-=wgR_unCDRZ+8iTb5gBO6bgRkuS4JYBpi25v12Yp6TzWVA@mail.gmail.com> <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk> <CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/8] fscache: Replace and remove old I/O API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <738325.1631645944.1@warthog.procyon.org.uk>
Date:   Tue, 14 Sep 2021 19:59:04 +0100
Message-ID: <738326.1631645944@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Call it "fallback" or "simple" or something that shows the intent, but
> > no, I'm not taking patches that introduce a _new_ interface and call
> > it "deprecated".

Yeah, I'll change it to "fallback" - I started talking about it like that in
the docs anyway.

> Put another way: to call something "deprecated", you have to already
> have the replacement all ready to go.

We're not far off.  There's a fair distance (in number of patches) between
this patchset and the completion, hence why I marked them as deprecated here,
intending to remove them at the end.  Between myself, Jeff and Dave we have
fscache, cachefiles, afs, ceph and nfs (almost) covered.  I have patches for
9p and I've given a partial patch for cifs to Steve and Shyam.

David

