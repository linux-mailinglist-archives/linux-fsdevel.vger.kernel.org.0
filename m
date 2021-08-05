Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117A93E19A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhHEQgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 12:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232071AbhHEQgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628181357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cqiBhFIK0kAqQNHfo/GucN8GfiLKs6hRFMJo5oTIZHg=;
        b=HXRfYAiteoIhSGOOdI6G5F9CkVaTe4eiZ+YgtWllrydzGO8Ts08glJhrUywlWREKJKTsmL
        466mcB54Rosn2D5E8dthiIly8/NADo6lIvDcB0edk9CtCKfVKv97lGGHVGlgFxFBdoTj+l
        qeSkemg84REb/Bk69/z2hnjx0tetvjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-OwRpS98qMZeNyIhOZrpXfg-1; Thu, 05 Aug 2021 12:35:47 -0400
X-MC-Unique: OwRpS98qMZeNyIhOZrpXfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C19FFCC623;
        Thu,  5 Aug 2021 16:35:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A1BA5C1A1;
        Thu,  5 Aug 2021 16:35:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Canvassing for network filesystem write size vs page size
References: <YQv+iwmhhZJ+/ndc@casper.infradead.org>
 <YQvpDP/tdkG4MMGs@casper.infradead.org>
 <YQvbiCubotHz6cN7@casper.infradead.org>
 <1017390.1628158757@warthog.procyon.org.uk>
 <1170464.1628168823@warthog.procyon.org.uk>
 <1186271.1628174281@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1219712.1628181333.1@warthog.procyon.org.uk>
Date:   Thu, 05 Aug 2021 17:35:33 +0100
Message-ID: <1219713.1628181333@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With Willy's upcoming folio changes, from a filesystem point of view, we're
going to be looking at folios instead of pages, where:

 - a folio is a contiguous collection of pages;

 - each page in the folio might be standard PAGE_SIZE page (4K or 64K, say) or
   a huge pages (say 2M each);

 - a folio has one dirty flag and one writeback flag that applies to all
   constituent pages;

 - a complete folio currently is limited to PMD_SIZE or order 8, but could
   theoretically go up to about 2GiB before various integer fields have to be
   modified (not to mention the memory allocator).

Willy is arguing that network filesystems should, except in certain very
special situations (eg. O_SYNC), only write whole folios (limited to EOF).

Some network filesystems, however, currently keep track of which byte ranges
are modified within a dirty page (AFS does; NFS seems to also) and only write
out the modified data.

Also, there are limits to the maximum RPC payload sizes, so writing back large
pages may necessitate multiple writes, possibly to multiple servers.

What I'm trying to do is collate each network filesystem's properties (I'm
including FUSE in that).

So we have the following filesystems:

 Plan9
 - Doesn't track bytes
 - Only writes single pages

 AFS
 - Max RPC payload theoretically ~5.5 TiB (OpenAFS), ~16EiB (Auristor/kAFS)
 - kAFS (Linux kernel)
   - Tracks bytes, only writes back what changed
   - Writes from up to 65535 contiguous pages.
 - OpenAFS/Auristor (UNIX/Linux)
   - Deal with cache-sized blocks (configurable, but something from 8K to 2M),
     reads and writes in these blocks
 - OpenAFS/Auristor (Windows)
   - Track bytes, write back only what changed

 Ceph
 - File divided into objects (typically 2MiB in size), which may be scattered
   over multiple servers.
 - Max RPC size is therefore object size.
 - Doesn't track bytes.

 CIFS/SMB
 - Writes back just changed bytes immediately under some circumstances
 - Doesn't track bytes and writes back whole pages otherwise.
 - SMB3 has a max RPC size of 16MiB, with a default of 4MiB

 FUSE
 - Doesn't track bytes.
 - Max 'RPC' size of 256 pages (I think).

 NFS
 - Tracks modified bytes within a page.
 - Max RPC size of 1MiB.
 - Files may be constructed of objects scattered over different servers.

 OrangeFS
 - Doesn't track bytes.
 - Multipage writes possible.

If you could help me fill in the gaps, that would be great.

Thanks,
David

