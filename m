Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02412FADCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 00:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbhARXiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 18:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731639AbhARXiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 18:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611013011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=evmA0OdyD5M8kY9qOkiMZu9GD1M5IQ2ieILxxBsie0w=;
        b=fBa5OS2p7FmBHPIYk71s7ABbFcoLE6C5ipliYxoatF8wtoub1Nen+FrPk896Sm24EcEDKx
        6YZf32Br+dHTCCJgzUd2ny4G1/VQtCAWXYNbhK2w2zS9wlllaBUA89to4jrLSXSDW0xVnf
        fSuGqzN15KS/mG3b79uG4u/Mvc7GSLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-7qf1DA_HP76SP8BqpolMWQ-1; Mon, 18 Jan 2021 18:36:49 -0500
X-MC-Unique: 7qf1DA_HP76SP8BqpolMWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CA1359;
        Mon, 18 Jan 2021 23:36:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6B365D9CD;
        Mon, 18 Jan 2021 23:36:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2758811.1610621106@warthog.procyon.org.uk>
References: <2758811.1610621106@warthog.procyon.org.uk>
To:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, jlayton@redhat.com, dwysocha@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Christoph Hellwig <hch@lst.de>, dchinner@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Cut down implementation of fscache new API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <160654.1611012999.1@warthog.procyon.org.uk>
Date:   Mon, 18 Jan 2021 23:36:39 +0000
Message-ID: <160655.1611012999@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Take a look at:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/

I've extracted the netfs helper library from my patch set and built an
alternative cut-down I/O API for the existing fscache code as a bridge to
moving to a new fscache implementation.  With this, a netfs now has two
choices: use the existing API as is or use the netfs lib and the alternative
API.  You can't mix the two APIs - a netfs has to use one or the other.

It works with AFS, at least for reading data through a cache, and without a
cache, xfstests is quite happy.  I was able to take a bunch of the AFS patches
from my fscache-iter branch (the full rewrite) and apply them with minimal
changes.  Since it goes through the new I/O API in both cases, those changes
should be the same.  The main differences are in the cookie wrangling API.

The alternative API is different from the current in the following ways:

 (1) It uses kiocbs to do async DIO rather than using readpage() with page
     wake queue snooping and vfs_write().

 (2) It uses SEEK_HOLE/SEEK_DATA rather than bmap() to determine the location
     of data in the file.  This is still broken because we can't rely on this
     information in the backing filesystem.

 (3) It completely changes how PG_fscache is used.  As for the new API, it's
     used to indicate an in progress write to the cache from a page rather
     than a page the cache knows about.

 (4) It doesn't keep track of the netfs's pages beyond the termination of an
     I/O operation.  The old API added pages that have outstanding writes to
     the cache to a radix three for a background writer; now an async kiocb is
     dispatched.

 (5) The netfs needs to call fscache_begin_read_operation() from its
     ->begin_cache_operation() handler as passed to the netfs helper lib.
     This tells the netfs helpers how to access the cache.

 (6) It relies on the netfs helper lib to reissue a failed cache read to the
     server.

 (7) Handles THPs.

 (8) Implements completely ->readahead() and ->readpage() and implements a
     chunk of ->write_begin().

Things it doesn't address:

 (1) Mapping the content independently of the backing filesystem's metadata.

 (2) Getting rid of the backpointers into the netfs.

 (3) Simplifying the management of cookies and objects and their processing.

 (4) Holding an open file to the cache for any great length of time.  It gets
     a new file struct for each read op it does on the cache and drops it
     again afterwards.

 (5) Pinning the cache context/state required to handle a deferred write to
     the cache from ->write_begin() as performed by, say, ->writepages().

David

