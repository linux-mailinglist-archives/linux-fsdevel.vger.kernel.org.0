Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027992F0A78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 00:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAJXl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 18:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAJXl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 18:41:59 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFFC061786;
        Sun, 10 Jan 2021 15:41:19 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kykKA-0094e9-Rx; Sun, 10 Jan 2021 23:40:42 +0000
Date:   Sun, 10 Jan 2021 23:40:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [RFC v2] nvfs: a filesystem for persistent memory
Message-ID: <20210110234042.GX3579531@ZenIV.linux.org.uk>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
 <alpine.LRH.2.02.2101101410230.7245@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101101410230.7245@file01.intranet.prod.int.rdu2.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 10, 2021 at 04:14:55PM -0500, Mikulas Patocka wrote:

> That's a good point. I split nvfs_rw_iter to separate functions 
> nvfs_read_iter and nvfs_write_iter - and inlined nvfs_rw_iter_locked into 
> both of them. It improved performance by 1.3%.
> 
> > Not that it had been more useful on the write side, really,
> > but that's another story (nvfs_write_pages() handling of
> > copyin is... interesting).  Let's figure out what's going
> > on with the read overhead first...
> > 
> > lib/iov_iter.c primitives certainly could use massage for
> > better code generation, but let's find out how much of the
> > PITA is due to those and how much comes from you fighing
> > the damn thing instead of using it sanely...
> 
> The results are:
> 
> read:                                           6.744s
> read_iter:                                      7.417s
> read_iter - separate read and write path:       7.321s
> Al's read_iter:                                 7.182s
> Al's read_iter with _copy_to_iter:              7.181s

So
	* overhead of hardening stuff is noise here
	* switching to more straightforward ->read_iter() cuts
the overhead by about 1/3.

	Interesting...  I wonder how much of that is spent in
iterate_and_advance() glue inside copy_to_iter() here.  There's
certainly quite a bit of optimizations possible in those
primitives and your usecase makes a decent test for that...

	Could you profile that and see where is it spending
the time, on instruction level?
