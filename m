Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2E433EBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 20:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhJSSut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 14:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhJSSut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634669315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0LKdMZo9vNdqSvore2I0xfjftCA66bzkuaIif0bJYs=;
        b=g/u2dqnVBOn9FGWhex2r7w76fxIJ4HvlaeOi6Zeb+0yyi4274hKCipMfnNBy9J0X7txm95
        gETnPuDSrrIfXKZjRHexSwUeHahBCdJdFPn5raUe8jXpMiuZxdxvsycIvgoZ3+m35WLv4e
        QQuUonyHm7/TurF8rDZs2Nj75pNnrTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-j1U2L1iBM6ODM8XJ0ZVuqg-1; Tue, 19 Oct 2021 14:48:32 -0400
X-MC-Unique: j1U2L1iBM6ODM8XJ0ZVuqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2130C19251A1;
        Tue, 19 Oct 2021 18:48:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 965D65DD68;
        Tue, 19 Oct 2021 18:48:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YW8OMsrEzrY8aSxo@casper.infradead.org>
References: <YW8OMsrEzrY8aSxo@casper.infradead.org> <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk> <163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/67] mm: Stop filemap_read() from grabbing a superfluous page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2971213.1634669295.1@warthog.procyon.org.uk>
Date:   Tue, 19 Oct 2021 19:48:15 +0100
Message-ID: <2971214.1634669295@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +		isize = i_size_read(inode);
> > +		if (unlikely(iocb->ki_pos >= isize))
> > +			goto put_pages;
> > +
> 
> Is there a good reason to assign to isize here?  I'd rather not,
> because it complicates analysis, and a later change might look at
> the isize read here, not realising it was a racy use.  So I'd
> rather see:

If we don't set isize, the loop will never end.  Actually, maybe we can just
break out at that point rather than going to put_pages.

David

