Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA853159B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhBIWtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234532AbhBIWbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612909741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNTsEzyoPupLf8uFnqlZZbYFAgQKr7S0geejlS5p7yc=;
        b=GaNqQwHcsf7X5DUG7zHse/iSOu+uumKqB4CNyntGD4Qh5Wfe5+oV6X2SykIpoTltj8Ossx
        Mbqs6+Yx8x4dq9KnBbrqxq9oZYNmkovxnfHgRd7ymXsi0vllKZCF+P8TpDFPhjF5coPjWs
        PO/1apuebPoFGiaX6t25IbHgrNTpF+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-zfMDn4FfM1uj1j28ps60sQ-1; Tue, 09 Feb 2021 16:10:52 -0500
X-MC-Unique: zfMDn4FfM1uj1j28ps60sQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 199F0107ACC7;
        Tue,  9 Feb 2021 21:10:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDE796062F;
        Tue,  9 Feb 2021 21:10:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
References: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com> <591237.1612886997@warthog.procyon.org.uk>
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
Content-ID: <617684.1612905042.1@warthog.procyon.org.uk>
Date:   Tue, 09 Feb 2021 21:10:42 +0000
Message-ID: <617685.1612905042@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The PG_fscache bit waiting functions are completely crazy. The comment
> about "this will wake up others" is actively wrong,

You mean this?

/**
 * unlock_page_fscache - Unlock a page pinned with PG_fscache
 * @page: The page
 *
 * Unlocks the page and wakes up sleepers in wait_on_page_fscache().  Also
 * wakes those waiting for the lock and writeback bits because the wakeup
 * mechanism is shared.  But that's OK - those sleepers will just go back to
 * sleep.
 */

Actually, you're right.  The wakeup check func is evaluated by the
waker-upper.  I can fix the comment with a patch.

> and the waiting function looks insane, because you're mixing the two names
> for "fscache" which makes the code look totally incomprehensible. Why would
> we wait for PF_fscache, when PG_private_2 was set? Yes, I know why, but the
> code looks entirely nonsensical.

IIRC someone insisted that I should make it a generic name and put the
accessor functions in the fscache headers (which means they aren't available
to core code), but I don't remember who (maybe Andrew? it was before mid-2007)
- kind of like PG_checked is an alias for PG_owner_priv_1.

I'd be quite happy to move the accessors for PG_fscache to the
linux/page-flags.h as that would simplify things.

David

