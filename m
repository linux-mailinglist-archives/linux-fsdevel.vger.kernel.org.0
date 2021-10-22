Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF4437EC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhJVTmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233084AbhJVTmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634931635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TXn+dNe02I1e9WL3b+8Rpc7Yy2ZUl284mKuARnxOrKM=;
        b=Z6qdVq18zN8Ebb4rnjV2X8PXR93cjhN/Jzug8j4vLAmpcOiPQgiwfae8dY1hUTryV5kVQt
        ZM+3fPnXOeCoNnt3NjjMcxA3xHZaofSvWGDLkOR18HaXyIhCorZVOgq5TamS83JjKAjiEU
        9bD92JuQ1t6keOpXuLTAuilL2aXttTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-zGI3szvNO1-ZuOVh4-qMlA-1; Fri, 22 Oct 2021 15:40:32 -0400
X-MC-Unique: zGI3szvNO1-ZuOVh4-qMlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1851B806689;
        Fri, 22 Oct 2021 19:40:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 592161346F;
        Fri, 22 Oct 2021 19:40:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
References: <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com> <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/53] fscache: Rewrite index API and management system
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1041556.1634931616.1@warthog.procyon.org.uk>
Date:   Fri, 22 Oct 2021 20:40:16 +0100
Message-ID: <1041557.1634931616@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Honestly, I don't see the point of this when it ends up just being
> dead code basically immediately.
> 
> You don't actually support picking one or the other at build time,
> just a hard switch-over.
> 
> That makes the old fscache driver useless. You can't say "use the old
> one because I don't trust the new". You just have a legacy
> implementation with no users.

What's the best way to do this?  Is it fine to disable caching in all the
network filesystems and then directly remove the fscache and cachefiles
drivers and replace them?  It won't stop the network filesystems actually
working - it'll just mean that they don't do any caching until converted and
have caching reenabled.

David

