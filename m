Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03FE43498A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 12:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhJTLAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 07:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhJTLAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634727476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nznzQGZwFhWi7IrCsZuwpAlnduoRBn7ox7Rs/xNM+f4=;
        b=ao7CYGkAf2Rc5QTHAndf5BYdCyum23WSVz/VyMKxK4+H+JavDtVnb9MUMvNV4GzbSzPunQ
        EO8qkbTIIvgXrzS2ZGzMLicnkLpEtBEX1OoxBirXV4sbntNwea5+ONM1PVSS9QrrPQ7EqD
        fqGc1BVyCvIAndToX3UTFVVRNiuMisk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-d8OhdiHCN4OcfUmy5JVW4A-1; Wed, 20 Oct 2021 06:57:53 -0400
X-MC-Unique: d8OhdiHCN4OcfUmy5JVW4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09B5D10A8E00;
        Wed, 20 Oct 2021 10:57:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9758360D30;
        Wed, 20 Oct 2021 10:57:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <67f55d920f40bf6c49643af08fe8a5cfc97a9542.camel@kernel.org>
References: <67f55d920f40bf6c49643af08fe8a5cfc97a9542.camel@kernel.org> <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk> <163456871794.2614702.15398637170877934146.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trondmy@hammerspace.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/67] nfs, cifs, ceph, 9p: Disable use of fscache prior to its rewrite
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3164228.1634727463.1@warthog.procyon.org.uk>
Date:   Wed, 20 Oct 2021 11:57:43 +0100
Message-ID: <3164229.1634727463@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> The typical way to do this would be to rebrand the existing FSCACHE
> Kconfig symbols into FSCACHE_OLD and then build the new fscache
> structure such that it exists in parallel with the old.

That, there, is nub of the problem.

You can't have parallel cachefiles drivers: There's a single userspace
interface (/dev/cachefiles) and only one driver can register it.  You would
need to decide at compile time whether you want the converted or the
unconverted network filesystems to be cached.

> You'd then just drop the old infrastructure once all of the fs's are
> converted to the new. You could even make them conflict with one another in
> Kconfig too, so that only one could be built in during the transition period
> if supporting both at runtime is too difficult.
> 
> This approach of disabling everything is much more of an all-or-nothing
> affair. It may mean less "churn" overall, but it seems less "nice"
> because you have an interval of commits where fscache is non-functional.
> 
> I'm not necessarily opposed to this approach, but I'd like to better
> understand why doing it this way was preferred.

I'm trying to avoid adding two parallel drivers, but change in place so that I
can test parts of it as I go along.

David

