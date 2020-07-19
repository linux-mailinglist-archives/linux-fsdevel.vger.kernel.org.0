Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C98224E8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 03:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGSBpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 21:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGSBpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 21:45:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B80C0619D2;
        Sat, 18 Jul 2020 18:45:04 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwyNY-00FOFG-MQ; Sun, 19 Jul 2020 01:44:36 +0000
Date:   Sun, 19 Jul 2020 02:44:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/32] iov_iter: Add ITER_MAPPING
Message-ID: <20200719014436.GG2786714@ZenIV.linux.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
 <159465785214.1376674.6062549291411362531.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159465785214.1376674.6062549291411362531.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 05:30:52PM +0100, David Howells wrote:
> Add an iterator, ITER_MAPPING, that walks through a set of pages attached
> to an address_space, starting at a given page and offset and walking for
> the specified amount of bytes.
> 
> The caller must guarantee that the pages are all present and they must be
> locked using PG_locked, PG_writeback or PG_fscache to prevent them from
> going away or being migrated whilst they're being accessed.
> 
> This is useful for copying data from socket buffers to inodes in network
> filesystems and for transferring data between those inodes and the cache
> using direct I/O.
> 
> Whilst it is true that ITER_BVEC could be used instead, that would require
> a bio_vec array to be allocated to refer to all the pages - which should be
> redundant if inode->i_pages also points to all these pages.
> 
> This could also be turned into an ITER_XARRAY, taking and xarray pointer
> instead of a mapping pointer.  It would be mostly trivial, except for the
> use of find_get_pages_contig() by iov_iter_get_pages*().
> 

My main problem here is that your iterate_mapping() assumes that STEP is
safe under rcu_read_lock(), with no visible mentioning of that fact.
Note, BTW, that iov_iter_for_each_range() quietly calls user-supplied
callback in such context.

Incidentally, do you ever have different steps for bvec and mapping?

> +	if (unlikely(iov_iter_is_mapping(i))) {
> +		/* We really don't want to fetch pages if we can avoid it */
> +		i->iov_offset += size;
> +		i->count -= size;
> +		return;

That's... not nice.  At the very least you want to cap size by i->count here
(and for discard case as well, while we are at it).
