Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9132E530
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCEJrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 04:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEJq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:46:58 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBEFC061574;
        Fri,  5 Mar 2021 01:46:58 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id c10so1388455ilo.8;
        Fri, 05 Mar 2021 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lC8zlzO4d9sCo2iAF0K+KJjctz9hWtNl5+a8xoEn6KM=;
        b=i2qzEGac3XPgrmwqATg7vs33UeB3HMXXSReSnTkVXneQVd3GKQ1eNIV4IfWNSRfkcE
         DLwr84l4nYLLulaFsQGStlw/EgeC7WpGkU2AjYH2mcTfIlMCqMwDIuwADxrhV3zaDc/w
         PMTb28rk8pFzogQTuViBw+Xd5/XRXrndraO9zRwTEzyguICXw/eJWDgnl5nnXtWXD7Di
         Lc82h9MuPnroWugZng1019AiMijfsUJ7ah25YzjZDhsXz/joZiatnXmRdJs5GtUDdZ/m
         HZZp+RgNNpiGt4lICUtn75sQegDE7rt1UIJxpLWnZrRhy56GdDx/0fzT/RpuQjm7XchX
         n9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lC8zlzO4d9sCo2iAF0K+KJjctz9hWtNl5+a8xoEn6KM=;
        b=oHX0GMcHShQjTxYMtgIgSWQCyfv94h6zq9jnlstZOj+JpEKRupxc0kn5UJFreKkakD
         D5rTy/no3kLpjuWW+L2pnDbslTRfjkecKp7mcEquDT3YLHFW9Yc8UWPwZkzsuqv3kPMu
         CLd5cIOHmIJdtS+eZ5CjWysAOT52OxOCkQXsx6YYIrr7hiOtuXcKYBbyub1pAY4bSKYB
         UABaHEZACziR3hmlkqXg6di/SK8zmI3+Pt31+xlHSOvgHJyIEhVzXGBw9na67nr+ZeAt
         /38wgSarPjMaBh0gjETuKntqs3SPIhUissziS5W4HfcGt17mkr9GuLBwasEgLLoflEjr
         NDrg==
X-Gm-Message-State: AOAM533SgOYqHuXuqmW84xl1AlawOBW8GU+/MrRgtexCVHvW7I9PPrl/
        5gBgb3fga3ME+1oSkT6NIDy63UcsMJScJcp52GY=
X-Google-Smtp-Source: ABdhPJzsjPPI76V+ifK/5cRmuhQcSx+F9xfxp+D6hQd7smAfVv8piF6gITprUwnhLkj/CwhgI90S8l7lugFNR/SBJqw=
X-Received: by 2002:a92:da48:: with SMTP id p8mr7580193ilq.137.1614937617862;
 Fri, 05 Mar 2021 01:46:57 -0800 (PST)
MIME-Version: 1.0
References: <2653261.1614813611@warthog.procyon.org.uk>
In-Reply-To: <2653261.1614813611@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 5 Mar 2021 11:46:46 +0200
Message-ID: <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com>
Subject: Re: fscache: Redesigning the on-disk cache
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 4, 2021 at 4:10 PM David Howells <dhowells@redhat.com> wrote:
>
> I'm looking at redesigning the on-disk cache format used by fscache's
> cachefiles driver to try and eliminate the number of synchronous metadata
> operations done by the driver, to improve culling performance and to reduce
> the amount of opens/files open.  I also need to stop relying on the backing
> filesystem to track where I have data stored.
>
> There are a number of options that I've considered:
>
>  (0) The current format lays out a directory tree, with directories for each
>      level of index (so in AFS's terms, you've got an overall "afs" dir
>      containing a dir for each cell.  In each cell dir, there's a dir for each
>      volume and within that there's a file for each afs vnode cached.  Extra
>      levels of directory are also interposed to reduce the number of entries
>      in a directory.
>
>      - Pathwalk cost to open a cache file.
>      - Netfs coherency data is in xattrs.
>      - Invalidation done by truncate or unlink.
>      - Uses backing filesystem metadata to keep track of present data.
>        - Determined by bmap() on the cache file.
>      - Culling performed by userspace daemon.
>      - Data file opened for every write.
>      - Read done by readpage without file.
>
>  (0a) As (0) but using SEEK_DATA/SEEK_HOLE instead of bmap and opening the
>       file for every whole operation (which may combine reads and writes).

I read that NFSv4 supports hole punching, so when using ->bmap() or SEEK_DATA
to keep track of present data, it's hard to distinguish between an
invalid cached range
and a valid "cached hole".
With ->fiemap() you can at least make the distinction between a non existing
and an UNWRITTEN extent.

>
>  (1) Structured the same as (0), but keeping an independent content map and
>      not relying on backing fs metadata.  Use a larger blocksize, say 256K, to
>      reduce the size of the content map.
>
>      - Netfs coherency data in xattrs.
>      - Invalidation done by tmpfile creation and link-replace.
>      - Content bitmap kept in xattr.
>        - Limited capacity.  Could use multiple bitmaps.
>        - Can skip the bitmap for a non-sparse file that we have all of.
>      - "Open" state kept in xattr.
>      - File is kept open
>      - Culling performed by userspace daemon.
>      - Cache file open whilst netfs file is open.
>
>  (2) Structured the same as (1), but keeping an extent list instead of a
>      bitmap.
>
>      - Content extent map kept in xattr.
>        - Limited capacity.
>        - Highly scattered extents use a lot of map space.
>
>  (3) OpenAFS-style format.  One index file to look up {file_key,block#} and an
>      array of data files, each holding one block (e.g. a 256KiB-aligned chunk
>      of a file).  Each index entry has valid start/end offsets for easy
>      truncation.
>
>      The index has a hash to facilitate the lookup and an LRU that allows a
>      block to be recycled at any time.
>
>      - File keys, are highly variable in length and can be rather long,
>        particularly NFS FIDs.
>        - Might want a separate file index that maps file keys to a slot ID
>          that can then be used in the block index.
>      - Netfs coherency data in vnode index entry.
>      - Invalidation done by clearing matching entries in the index.
>        - Dead data files can be lazily unlinked or truncated or just
>          overwritten.
>      - Content mapping by lookup in block index hash table.
>        - Fine if the hash table is large and scatter is good.
>      - Potential coherency problem between indices and data file.
>      - Culling performed by block index LRU.
>      - Really want to retain entire block index in RAM.
>      - Data files are opened for every read/write.
>
>  (4) Similar format to (3), but could put entirety of data in one file.
>
>      - Data file open entire time cache online.
>      - Unused block bitmap.
>      - Can use fallocate to punch out dead blocks.
>      - Could put data file on blockdev.
>
>  (5) Similar idea to (4), but just have a file index and use block pointers
>      and indirection blocks instead.  Use an LRU in the file index and cull
>      whole files only, not individual blocks.
>
>      - File keys, are highly variable in length and can be rather long,
>        particularly NFS FIDs.
>      - Netfs coherency data in vnode index entry.
>      - Unused data block bitmap.
>      - Invalidation done by clearing entries in the file index.
>        - Data blocks must be recycled and returned to bitmap.
>        - Dead data blocks can be lazily punched out with fallocate.
>      - Potential coherency problem between index, pointers/indirection and
>        bitmap.
>      - Culling performed by file index LRU.
>      - Really want to retain entire file index and block bitmap in RAM.
>        - May be less memory than block index.
>      - Data file open entire time cache online.
>      - Could put data file on blockdev.
>      - If the block size is large, lots of dead space in indirection blocks.
>
>  (6) Similar to (5), but use extent lists rather than indirection blocks.
>
>      - Requires allocation of contiguous space to be worthwhile.
>      - Buddy allocator approach?
>        - Can always arbitrarily recycle buddies to make larger spaces - if we
>          can find them...
>
>  (7) Hybrid approach.  Stick the first block of every netfs file in one big
>      cache file.  For a lot of cases, that would suffice for the entire file
>      if the block size is large enough.  Store the tails of larger files in
>      separate files.
>
>      - File index with LRU.
>      - More complicated to manage.
>      - Fewer files open.
>
> So (0) is what's upstream.  I have (0a) implemented in my fscache-netfs-lib
> branch and (1) implemented in my fscache-iter branch.  However, it spends a
> lot of cpu time doing synchronous metadata ops, such as creating tmpfiles,
> link creation and setting xattrs, particularly when unmounting the filesystem
> or disabling the cache - both of which are done during shutdown.
>

You didn't say much about crash consistency or durability requirements of the
cache. Since cachefiles only syncs the cache on shutdown, I guess you
rely on the hosting filesystem to provide the required ordering guarantees.

How does this work with write through network fs cache if the client system
crashes but the write gets to the server? Client system get restart with older
cached data because disk caches were not flushed before crash. Correct?
Is that case handled? Are the caches invalidated on unclean shutdown?

Anyway, how are those ordering requirements going to be handled when
entire indexing is in a file? You'd practically need to re-implement a
filesystem
journal or only write cache updates to a temp file that can be discarded at
any time?

> I'm leaning towards (4) or (5).  I could use extent maps, but I don't
> necessarily have a good idea of what access patterns I have to deal with till
> later.  With network filesystems that are going to read and cache large blocks
> (say 2MiB), extents would allow reduction of the metadata, particularly where
> it would span a bitmap.
>
> Using a block index (4) allows me to easily recycle a large chunk of cache in
> one go - even if it means arbitrarily kicking out blocks that weren't near the
> end of the LRU yet.
>
> Using block pointers and indirection blocks (5) means I only need this data in
> RAM when I need it; with the LRU management being done in the file index.
>
> Either way with (4) and (5), at least one index really needs to be resident in
> RAM to make LRU wangling efficient.  Also, I need to decide how to handle
> coherency management - setting an "in use" flag on the file index entry and
> flushing it before making any modifications might work.
>
> On the other hand, sticking with (1) or (2) makes it easier to add extra
> metadata very easily (say to handle disconnected operation), though it's
> harder to manage culling and manage the capacity of the cache.
>
> I have a suspicion that the answer is "it depends" and that the best choice is
> very much going to be workload dependent - and may even vary from volume to
> volume within the same workload.
>
> Any thoughts or better solutions?
>

If you come up with a useful generic implementation of a "file data overlay",
overlayfs could also use it for "partial copy up" as well as for implementation
of address space operations, so please keep that in mind.

Thanks,
Amir.
