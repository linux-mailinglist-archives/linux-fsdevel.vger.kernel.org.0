Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651BF440186
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJ2R6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 13:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhJ2R6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635530142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DP06qRnSdFYC68aQSXyxDNJ6O08LDIGpwujMUiVvYT4=;
        b=VT7GvEWz7zpSJ4BN5azwRY/8CWTw6t/LwdEI+tyWNjBA/Xau1L4I5/pQwrT/M4M+fSL3FC
        645tIhxrcX+8S1K9XxWMvI/TYfg7bYGL4+EXknAozu5R3/Vt93iiOOFXVpq0qi+Nl41SKc
        yeJVxfzE97qk6TYaegeJI0KA55nnqEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-edqdTVEoNrGl8Zjakzts3Q-1; Fri, 29 Oct 2021 13:55:38 -0400
X-MC-Unique: edqdTVEoNrGl8Zjakzts3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79E6F10A8E02;
        Fri, 29 Oct 2021 17:55:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6985560C13;
        Fri, 29 Oct 2021 17:55:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiy4KNREEqvd10Ku8VVSY1Lb=fxTA1TzGmqnLaHM3gdTg@mail.gmail.com>
References: <CAHk-=wiy4KNREEqvd10Ku8VVSY1Lb=fxTA1TzGmqnLaHM3gdTg@mail.gmail.com> <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] fscache: Replace and remove old I/O API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1889040.1635530124.1@warthog.procyon.org.uk>
Date:   Fri, 29 Oct 2021 18:55:24 +0100
Message-ID: <1889041.1635530124@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

>  - it would be much better if you could incrementally just improve the
> existing FSCACHE so that it just _works_ all the time, and fixes the
> problems in it, and a bisection works, and there is no flag-day.

As I stated in the cover letters, the advent of the kiocb and tmpfile
interfaces provide a way to massively simplify the way fscache and cachefiles
work - and, as a result, remove over five thousand lines of code.

With the changes I'm looking at making, I can get rid of the object state
machine as it stands and the operation scheduling - which means all of the
code in:

	fs/fscache/object.c
	fs/fscache/operation.c

gets deleted along with:

	fs/fscache/page.c
	fs/cachefiles/rdwr.c

when I remove the deprecated I/O code (which is what this patchset does).

A large chunk of code in fs/fscache/cookie.c gets removed and replaced too

Further, I've been looking at simplifying the index management with an eye to
completely replacing the cache backend with something more akin to a tagged
cache with fixed-size storage units.  This also allows the cachefiles code to
be simplified a bit too.

This means bisection is of limited value and why I'm looking at a 'flag day'.


There is one particular problem that *this* patchset was intended to address:
I want to convert the filesystems that are going to be accessing fscache to
use netfslib, but they're not all there yet so that there's one common body of
code that does VM interface, cache I/O and content crypto (eg. fscrypt).  Jeff
and I have converted afs and ceph already and I've got a conversion for 9p in
this patchset.  I have a partial patch for cifs/smb and have been discussing
that with Steve and Shyam.  Dave Wysochanski has a set of patches for nfs, but
there's pushback on it from the nfs maintainers.

This particular patchset is intended to enable removal of the old I/O routines
by changing nfs and cifs to use a "fallback" method to use the new kiocb-using
API and thus allow me to get on with the rest of it.

However, if you would rather I just removed all of fscache and (most of[*])
cachefiles, that I can do.  I have the patches arrayed in a way that makes
them easier to explain logically and, hopefully, easier to review.  It would,
however, leave any netfs that isn't converted to use netfslib unable to use
caching until converted.

David

[*] The code that deals with the cachefilesd UAPI will be mostly unchanged.

