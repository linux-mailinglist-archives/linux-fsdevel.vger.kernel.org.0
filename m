Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD77D06F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 00:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfGaWFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 18:05:43 -0400
Received: from fieldses.org ([173.255.197.46]:43134 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbfGaWFn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:05:43 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 663E4ABE; Wed, 31 Jul 2019 18:05:42 -0400 (EDT)
Date:   Wed, 31 Jul 2019 18:05:42 -0400
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/16] Cache open file descriptors in knfsd
Message-ID: <20190731220542.GA20006@fieldses.org>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for the delay responding....

On Sun, Jun 30, 2019 at 09:52:24AM -0400, Trond Myklebust wrote:
> When a NFSv3 READ or WRITE request comes in, the first thing knfsd has
> to do is open a new file descriptor.

I assume it shouldn't make a significant difference for NFSv4?

> While this is often a relatively
> inexpensive thing to do for most local filesystems, it is usually less
> so for FUSE, clustered or networked filesystems that are being exported
> by knfsd.
> 
> This set of patches attempts to reduce some of that cost by caching
> open file descriptors so that they may be reused by other incoming
> READ/WRITE requests for the same file.
> One danger when doing this, is that knfsd may end up caching file
> descriptors for files that have been unlinked. In order to deal with
> this issue, we use fsnotify to monitor the files, and have hooks to
> evict those descriptors from the file cache if the i_nlink value
> goes to 0.

That was one of the objections to previous attempts at a file cache so
it's good to have a simple solution.

This attempt seems pretty well thought-out.  I'll tentatively target
this for 5.4 pending some more review and testing.

--b.

> 
> Jeff Layton (12):
>   sunrpc: add a new cache_detail operation for when a cache is flushed
>   locks: create a new notifier chain for lease attempts
>   nfsd: add a new struct file caching facility to nfsd
>   nfsd: hook up nfsd_write to the new nfsd_file cache
>   nfsd: hook up nfsd_read to the nfsd_file cache
>   nfsd: hook nfsd_commit up to the nfsd_file cache
>   nfsd: convert nfs4_file->fi_fds array to use nfsd_files
>   nfsd: convert fi_deleg_file and ls_file fields to nfsd_file
>   nfsd: hook up nfs4_preprocess_stateid_op to the nfsd_file cache
>   nfsd: have nfsd_test_lock use the nfsd_file cache
>   nfsd: rip out the raparms cache
>   nfsd: close cached files prior to a REMOVE or RENAME that would
>     replace target
> 
> Trond Myklebust (4):
>   notify: export symbols for use by the knfsd file cache
>   vfs: Export flush_delayed_fput for use by knfsd.
>   nfsd: Fix up some unused variable warnings
>   nfsd: Fix the documentation for svcxdr_tmpalloc()
> 
>  fs/file_table.c                  |   1 +
>  fs/locks.c                       |  62 +++
>  fs/nfsd/Kconfig                  |   1 +
>  fs/nfsd/Makefile                 |   3 +-
>  fs/nfsd/blocklayout.c            |   3 +-
>  fs/nfsd/export.c                 |  13 +
>  fs/nfsd/filecache.c              | 885 +++++++++++++++++++++++++++++++
>  fs/nfsd/filecache.h              |  60 +++
>  fs/nfsd/nfs4layouts.c            |  12 +-
>  fs/nfsd/nfs4proc.c               |  83 +--
>  fs/nfsd/nfs4state.c              | 183 ++++---
>  fs/nfsd/nfs4xdr.c                |  31 +-
>  fs/nfsd/nfssvc.c                 |  16 +-
>  fs/nfsd/state.h                  |  10 +-
>  fs/nfsd/trace.h                  | 140 +++++
>  fs/nfsd/vfs.c                    | 295 ++++-------
>  fs/nfsd/vfs.h                    |   9 +-
>  fs/nfsd/xdr4.h                   |  19 +-
>  fs/notify/fsnotify.h             |   2 -
>  fs/notify/group.c                |   2 +
>  fs/notify/mark.c                 |   6 +
>  include/linux/fs.h               |   5 +
>  include/linux/fsnotify_backend.h |   2 +
>  include/linux/sunrpc/cache.h     |   1 +
>  net/sunrpc/cache.c               |   3 +
>  25 files changed, 1465 insertions(+), 382 deletions(-)
>  create mode 100644 fs/nfsd/filecache.c
>  create mode 100644 fs/nfsd/filecache.h
> 
> -- 
> 2.21.0
