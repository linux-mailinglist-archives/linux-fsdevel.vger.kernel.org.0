Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C5232407A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhBXPGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 10:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232661AbhBXNgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614173667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FGAEWcqi7R+QLdnM9l4hJ0vRCcM6Gnle1kdY4AuWCGU=;
        b=iwtB4CCQXriIDPqyRir8X8BAPknWo7PFFPNB/PQPC9WgdW79Vj1aDHd0XIoC+A62IBdvQ3
        E+1V56FNvcV7V1X3/ypwAoRgaIIwe0DpjrS+rnXEQ5SmzY+e+Gxltim4D7bW5nw4mGKnF8
        PCV20Uf57boIK2nR8hI300auZ71yKhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-3MKbxeFLOOeiKKs9HaYL0w-1; Wed, 24 Feb 2021 08:33:46 -0500
X-MC-Unique: 3MKbxeFLOOeiKKs9HaYL0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82D3BD547E;
        Wed, 24 Feb 2021 13:32:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 320E35D9F1;
        Wed, 24 Feb 2021 13:32:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mv=PZk_wn2=b0VQcaom9TEw1MGLz+qB_Ktxxm2bnV9Nig@mail.gmail.com>
References: <CAH2r5mv=PZk_wn2=b0VQcaom9TEw1MGLz+qB_Ktxxm2bnV9Nig@mail.gmail.com> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <9e49f96cd80eaf9c8ed267a7fbbcb4c6467ee790.camel@redhat.com> <CAH2r5mvPLivjuE=cbijzGSHOvx-hkWSWbcxpoBnJX-BR9pBskQ@mail.gmail.com> <20210216021015.GH2858050@casper.infradead.org>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Wysochanski <dwysocha@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 00/33] Network fs helper library & fscache kiocb API [ver #3]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3743318.1614173522.1@warthog.procyon.org.uk>
Date:   Wed, 24 Feb 2021 13:32:02 +0000
Message-ID: <3743319.1614173522@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> This (readahead behavior improvements in Linux, on single large file
> sequential read workloads like cp or grep) gets particularly interesting
> with SMB3 as multichannel becomes more common.  With one channel having one
> readahead request pending on the network is suboptimal - but not as bad as
> when multichannel is negotiated. Interestingly in most cases two network
> connections to the same server (different TCP sockets,but the same mount,
> even in cases where only network adapter) can achieve better performance -
> but still significantly lags Windows (and probably other clients) as in
> Linux we don't keep multiple I/Os in flight at one time (unless different
> files are being read at the same time by different threads).

I think it should be relatively straightforward to make the netfs_readahead()
function generate multiple read requests.  If I wasn't handed sufficient pages
by the VM upfront to do two or more read requests, I would need to do extra
expansion.  There are a couple of ways this could be done:

 (1) I could expand the readahead_control after fully starting a read request
     and then create another independent read request, and another for how
     ever many we want.

 (2) I could expand the readahead_control first to cover however many requests
     I'm going to generate, then chop it up into individual read requests.

However, generating larger requests means we're more likely to run into a
problem for the cache: if we can't allocate enough pages to fill out a cache
block, we don't have enough data to write to the cache.  Further, if the pages
are just unlocked and abandoned, readpage will be called to read them
individually - which means they likely won't get cached unless the cache
granularity is PAGE_SIZE.  But that's probably okay if ENOMEM occurred.

There are some other considerations too:

 (*) I would need to query the filesystem to find out if I should create
     another request.  The fs would have to keep track of how many I/O reqs
     are in flight and what the limit is.

 (*) How and where should the readahead triggers be emplaced?  I'm guessing
     that each block would need a trigger and that this should cause more
     requests to be generated until we hit the limit.

 (*) I would probably need to shuffle the request generation for the second
     and subsequent blocks in a single netfs_readahead() call to a worker
     thread because it'll probably be in a userspace kernel-side context and
     blocking an application from proceeding and consuming the pages already
     committed.

David

