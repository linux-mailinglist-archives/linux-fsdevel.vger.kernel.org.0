Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC49431594A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhBIWUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:20:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233891AbhBIWJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612908480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JtpFlXocz3kO5xx1cv2U4rE+tvnYS4ZliCWcM+gS1O4=;
        b=KrpTxnFzuTPzqS+jxtE1xHqy+VS6iKc+Dcks0j3hrn7xP19rXqVzhlIj5l3HeA/+716Y0f
        cchMN3+MjaFLlA7A80AQvcM/lGbf/iymdkn75Er+tjoYdgafkbtut2qVm5FvXShGv+go0L
        bk4k7cDIu/BTw2vqAB9SXm6rIH3ktSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-0xBnI-LxOQq3zEJ47KXu9A-1; Tue, 09 Feb 2021 16:55:37 -0500
X-MC-Unique: 0xBnI-LxOQq3zEJ47KXu9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6314C107ACE3;
        Tue,  9 Feb 2021 21:55:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E37C719C78;
        Tue,  9 Feb 2021 21:55:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com>
References: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com> <591237.1612886997@warthog.procyon.org.uk> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com> <20210209202134.GA308988@casper.infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
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
Content-ID: <620723.1612907726.1@warthog.procyon.org.uk>
Date:   Tue, 09 Feb 2021 21:55:26 +0000
Message-ID: <620724.1612907726@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Yeah, I have trouble with the private2 vs fscache bit too.  I've been
> > trying to persuade David that he doesn't actually need an fscache
> > bit at all; he can just increment the page's refcount to prevent it
> > from being freed while he writes data to the cache.
> 
> Does the code not hold a refcount already?

AIUI, Willy wanted me to drop the refcount and rely on PG_locked alone during
I/O triggered by the new ->readahead() method, so when it comes to setting
PG_fscache after a successful read from the server, I don't hold any page refs
- the assumption being that the waits in releasepage and invalidatepage
suffice.  If that isn't sufficient, I can make it take page refs on the pages
to be written out - that should be easy enough to do.

> Honestly, the fact that writeback doesn't take a refcount, and then
> has magic "if writeback is set, don't free" code in other parts of the
> VM layer has been a problem already, when the wakeup ended up
> "leaking" from a previous page to a new allocation.
> 
> I very much hope the fscache bit does not make similar mistakes,
> because the rest of the VM will _not_ have special "if fscache is set,
> then we won't do X" the way we do for writeback.

The VM can't do that because PG_private_2 might not be being used for
PG_fscache.  It does, however, treat PG_private_2 like PG_private when
triggering calls to releasepage and invalidatepage.

> So I think the fscache code needs to hold a refcount regardless, and
> that the fscache bit is set the page has to have a reference.
> 
> So what are the current lifetime rules for the fscache bit?

It depends which 'current' you're referring to.

The old fscache I/O API (ie. what's upstream) - in which PG_fscache is set on
a page to note that fscache knows about the page - does not keep a separate
ref on such pages.

The new fscache I/O API simplifies things.  With that, pages are only known
about for the duration of a write to the cache.  I've tried to analogise the
way PG_writeback works[*], including waiting for it in places like
invalidation, releasepage, page_mkwrite (though in the netfs, not the core VM)
as it may represent DMA.

Note that with the new I/O API, fscache and cachefiles know nothing about the
PG_fscache bit or netfs pages; they just deal with an iov_iter and a
completion function.  Dealing with PG_fscache is done by the netfs and the new
netfs helper lib.

[*] Though I see that 073861ed77b6b made a change to end_page_writeback() for
    an issue that probably affects unlock_page_fscache() too[**].

[**] This may mean that both PG_fscache and PG_writeback need to hold a ref on
     the page.

David

