Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A994185D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Sep 2021 05:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhIZDMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 23:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhIZDMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 23:12:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B67C061570;
        Sat, 25 Sep 2021 20:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WwIZ0BhBYA1F8Xahxd7anDpTfWZsBUHuFr6CADROb6c=; b=il8nnVKNIf4P7d1b/wjKSIYSsb
        tKx4hIRiHaRAIWdEBd4+ppylMZXu8zj+sunMAUv+TAookWSNqbjWCTqQ6xZCbzO9nz8LVRtU5eRkd
        2qqAe4aZyxP/jMB3vR2gELmqcn/uTa+TTcC9bJxCMyc1jDp4WCD0j5nA2HjcbT5ylZIDLRgBEx6hW
        wMLm/jdYvre6N0SpLJSED3l2DEVtfQ6kBBvhtgafZactWNTZLdgPPwiyhujYSm5XSi7gR+NN9zIgD
        gwTymYQIr2WuO3xqn+Mr8tukgD1eRuloL2tYfe754ETp6XoRMgmEDc1lF2Cbj+Eq11zBbRdlOskjB
        zkACra/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUKYt-008bG5-I5; Sun, 26 Sep 2021 03:10:46 +0000
Date:   Sun, 26 Sep 2021 04:10:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     David Howells <dhowells@redhat.com>, hch@lst.de,
        trond.myklebust@primarydata.com, Theodore Ts'o <tytso@mit.edu>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        Bob Liu <bob.liu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-cifs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Steve French <sfrench@samba.org>, NeilBrown <neilb@suse.de>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 0/9] mm: Use DIO for swap and fix NFS swapfiles
Message-ID: <YU/ks7Sfw5Wj0K1p@casper.infradead.org>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <20210925234243.GA1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925234243.GA1756565@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 26, 2021 at 09:42:43AM +1000, Dave Chinner wrote:
> Ok, so if the filesystem is doing block mapping in the IO path now,
> why does the swap file still need to map the file into a private
> block mapping now?  i.e all the work that iomap_swapfile_activate()
> does for filesystems like XFS and ext4 - it's this completely
> redundant now that we are doing block mapping during swap file IO
> via iomap_dio_rw()?

Hi Dave,

Thanks for bringing up all these points.  I think they all deserve to go
into the documentation as "things to consider" for people implementing
->swap_rw for their filesystem.

Something I don't think David perhaps made sufficiently clear is that
regular DIO from userspace gets handled by ->read_iter and ->write_iter.
This ->swap_rw op is used exclusive for, as the name suggests, swap DIO.
So filesystems don't have to handle swap DIO and regular DIO the same
way, and can split the allocation work between ->swap_activate and the
iomap callback as they see fit (as long as they can guarantee the lack
of deadlocks under memory pressure).

There are several advantages to using the DIO infrastructure for
swap:

 - unify block & net swap paths
 - allow filesystems to _see_ swap IOs instead of being bypassed
 - get rid of the swap extent rbtree
 - allow writing compound pages to swap files instead of splitting
   them
 - allow ->readpage to be synchronous for better error reporting
 - remove page_file_mapping() and page_file_offset()

I suspect there are several problems with this patchset, but I'm not
likely to have a chance to read it closely for a few days.  If you
have time to give the XFS parts a good look, that would be fantastic.
