Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEB5AFF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfF3Nyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:54:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43006 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3Nyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:54:50 -0400
Received: by mail-io1-f65.google.com with SMTP id u19so14191721ior.9;
        Sun, 30 Jun 2019 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qWGrMdtLgj/zgbP/xykxCLkefi7Qm/XeF+sb3t3ses=;
        b=IL3LP8HoF5NtvPFCTYWxpeqMIo0D2jgkfiKKSEYD+QYG4/Bo6CSm2gayqy9sNkc6sc
         12S1D2NGtp10ciRaoVVMZ+mXfNeqqq3kQYiv/D3aq6V4wgP/xYizSbLVFMjluXUoHHCX
         pQmbi+w7+onmERPHbTrxzVsHUCMlmt3HYdTTPujCBazogXfJ1bvJ2bf68FOM1yo1OmyO
         muqNUBasm/IbXToTuMxZQJLqkUWi9mDl9B4bc7fNH8wChSJ4f9iDiK8BPrAan0Yjkc4e
         HDRiORSnIJvS10Cc6Ldtna90mrbUAqjheTNCJdJOWBb8Ad90kX/trOPiChiA0RGYC6y2
         QTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qWGrMdtLgj/zgbP/xykxCLkefi7Qm/XeF+sb3t3ses=;
        b=YfTac20WkAs+n1FK1tu0tXcGqrMC0v+11LOFVoPxpuKe7lLdhQ1qaBbWC4ZRtTSjbf
         wvr1QEl+l2wB0wkU9s0POQ3sn17t7RCPR4IFrzPBi3zaP7wtVo49eOo/bj3I3+Os2Cpi
         616K72TEh6tYb14EAUC+GAOF2Z9/eiu0u6CxkjBsE2pt6IR80QpTkY78s1mAbOIX0UWB
         d5mpP2vzj+GLvF6zxyL1BdwMeo+99rFKNCrpr8GgOPRri2eUnfAd3eLfpOFns88D7rWl
         snW+fv+PVNTxe0HZRGDLF4SQtD5cQd/mxI8SGGoMfgev4XvPSM25gw6Ejb9QEY7EW9OQ
         MU+A==
X-Gm-Message-State: APjAAAW/b/T2xGn/kxlVi+drVXUc4kHqIx+N1LGOssGkRFB3SMdbgKGv
        srVIjlYyvsgJguERQfjM6A==
X-Google-Smtp-Source: APXvYqy4wsex7xfs2I8Ktg2aQKHAYUch92PZ6V8IEbz2NxRl+51/aG4jabgfLokTq433XOG73m65PQ==
X-Received: by 2002:a6b:6012:: with SMTP id r18mr3156655iog.241.1561902888715;
        Sun, 30 Jun 2019 06:54:48 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.54.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:54:48 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/16] Cache open file descriptors in knfsd
Date:   Sun, 30 Jun 2019 09:52:24 -0400
Message-Id: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a NFSv3 READ or WRITE request comes in, the first thing knfsd has
to do is open a new file descriptor. While this is often a relatively
inexpensive thing to do for most local filesystems, it is usually less
so for FUSE, clustered or networked filesystems that are being exported
by knfsd.

This set of patches attempts to reduce some of that cost by caching
open file descriptors so that they may be reused by other incoming
READ/WRITE requests for the same file.
One danger when doing this, is that knfsd may end up caching file
descriptors for files that have been unlinked. In order to deal with
this issue, we use fsnotify to monitor the files, and have hooks to
evict those descriptors from the file cache if the i_nlink value
goes to 0.

Jeff Layton (12):
  sunrpc: add a new cache_detail operation for when a cache is flushed
  locks: create a new notifier chain for lease attempts
  nfsd: add a new struct file caching facility to nfsd
  nfsd: hook up nfsd_write to the new nfsd_file cache
  nfsd: hook up nfsd_read to the nfsd_file cache
  nfsd: hook nfsd_commit up to the nfsd_file cache
  nfsd: convert nfs4_file->fi_fds array to use nfsd_files
  nfsd: convert fi_deleg_file and ls_file fields to nfsd_file
  nfsd: hook up nfs4_preprocess_stateid_op to the nfsd_file cache
  nfsd: have nfsd_test_lock use the nfsd_file cache
  nfsd: rip out the raparms cache
  nfsd: close cached files prior to a REMOVE or RENAME that would
    replace target

Trond Myklebust (4):
  notify: export symbols for use by the knfsd file cache
  vfs: Export flush_delayed_fput for use by knfsd.
  nfsd: Fix up some unused variable warnings
  nfsd: Fix the documentation for svcxdr_tmpalloc()

 fs/file_table.c                  |   1 +
 fs/locks.c                       |  62 +++
 fs/nfsd/Kconfig                  |   1 +
 fs/nfsd/Makefile                 |   3 +-
 fs/nfsd/blocklayout.c            |   3 +-
 fs/nfsd/export.c                 |  13 +
 fs/nfsd/filecache.c              | 885 +++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h              |  60 +++
 fs/nfsd/nfs4layouts.c            |  12 +-
 fs/nfsd/nfs4proc.c               |  83 +--
 fs/nfsd/nfs4state.c              | 183 ++++---
 fs/nfsd/nfs4xdr.c                |  31 +-
 fs/nfsd/nfssvc.c                 |  16 +-
 fs/nfsd/state.h                  |  10 +-
 fs/nfsd/trace.h                  | 140 +++++
 fs/nfsd/vfs.c                    | 295 ++++-------
 fs/nfsd/vfs.h                    |   9 +-
 fs/nfsd/xdr4.h                   |  19 +-
 fs/notify/fsnotify.h             |   2 -
 fs/notify/group.c                |   2 +
 fs/notify/mark.c                 |   6 +
 include/linux/fs.h               |   5 +
 include/linux/fsnotify_backend.h |   2 +
 include/linux/sunrpc/cache.h     |   1 +
 net/sunrpc/cache.c               |   3 +
 25 files changed, 1465 insertions(+), 382 deletions(-)
 create mode 100644 fs/nfsd/filecache.c
 create mode 100644 fs/nfsd/filecache.h

-- 
2.21.0

