Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527244795AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhLQUoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 15:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234282AbhLQUoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639773844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhXCW/gkgebaf8J387KILDsdSIH5KpfDKz809CKCWyo=;
        b=gy+3u8CQtAjbOCVfY50l4tYe75uOxJHOfr1pLgdajVT8QrenTmqwDLrxLud77xepIMy8yC
        e7ttQ7O9GSwLKCX2psw9sF3E94lusrxDRnRlHgGeALBXn74Vydv+9hAPybROYpSU4ZyEcg
        uk/O8CZAWA9bOdtVBciHYe/Y2krhIyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-r3psBnitNDePrXJsjLMkbA-1; Fri, 17 Dec 2021 15:44:02 -0500
X-MC-Unique: r3psBnitNDePrXJsjLMkbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64B781006AA2;
        Fri, 17 Dec 2021 20:43:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97E16610AE;
        Fri, 17 Dec 2021 20:43:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <310b791fc8afde2a108af4eb06bbe678f4141fac.camel@kernel.org>
References: <310b791fc8afde2a108af4eb06bbe678f4141fac.camel@kernel.org> <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk> <163967106467.1823006.6790864931048582667.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
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
Subject: Re: [PATCH v3 18/68] fscache: Implement cookie user counting and resource pinning
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2084363.1639773828.1@warthog.procyon.org.uk>
Date:   Fri, 17 Dec 2021 20:43:48 +0000
Message-ID: <2084364.1639773828@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > +unsigned int fscache_lru_cookie_timeout = 10 * HZ;
> >  
> 
> Looks like it only pops after 10s? That's a bit more than the "couple of
> seconds" mentioned in the changelog. In fact, that seems like quite a
> long time.
> 
> Did you arrive at this value empirically somehow?

It was 2s originally, but I upped for some reason I don't remember.  I've left
it as it seems to work, but it is arbitrary.  I should make this configurable
perhaps and/or maybe make it based on the number of cookies on the LRU since
the number of open files is what matters.

I don't have a good heuristic, so I'll just fix the commit message for now.

David

