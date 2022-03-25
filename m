Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71BF4E72FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358968AbiCYMYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358956AbiCYMYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:24:07 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0BD3AFA;
        Fri, 25 Mar 2022 05:22:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V89jH7j_1648210943;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V89jH7j_1648210943)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 20:22:24 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v6 00/22] fscache,erofs: fscache-based on-demand read semantics
Date:   Fri, 25 Mar 2022 20:22:01 +0800
Message-Id: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes since v5:
- cachefiles: Move the enabling of on-demand read mode to the end of the
  cachefiles subset of the patchset (David Howells) (patch 6)
- cachefiles: avoid the duplicate kstrdup() when handling cinit command.
  Also polish the commist message with the suggestion from David
  Howells. (David Howells) (patch 3)
- cachefiles: reuse the spinlock inside xarray to prevent the race
  condition, which also fixes GFP_KERNEL allocation while holding
  rw_lock (Matthew Wilcox) (patch 3)
- cachefiles: completion of READ request is done through
  CACHEFILES_IOC_CREAD ioctl on anon_fd (David Howells) (patch 5)
- erofs: rename erofs_bdev_mode() to erofs_is_nodev_mode() (Gao Xiang)
  (patch 10)
- erofs: expand the existing "struct erofs_map_blocks" rather than create
  a new "struct erofs_fscache_map" (Gao Xiang) (patch 17)
- erofs: fold functions handling readahead for inline/non-inline/hole
  into one function, which also omits use of "struct
  erofs_fscache_ra_ctx" (Gao Xiang) (patch 21)
- erofs: use folio APIs, though there's assumption that folio size
  equals PAGE_SIZE (Gao Xiang)
- erofs: rename "-o uuid=" mount option to "-o tag=" (Gao Xiang) (patch
  22)


Kernel Patchset
---------------
Git tree:

    git@github.com:lostjeffle/linux.git jingbo/dev-erofs-fscache-v6

Gitweb:

    https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v6


User Daemon for Quick Test
--------------------------
Git tree:

    git@github.com:lostjeffle/demand-read-cachefilesd.git main

Gitweb:

    https://github.com/lostjeffle/demand-read-cachefilesd


RFC: https://lore.kernel.org/all/YbRL2glGzjfZkVbH@B-P7TQMD6M-0146.local/t/
v1: https://lore.kernel.org/lkml/47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com/T/
v2: https://lore.kernel.org/all/2946d871-b9e1-cf29-6d39-bcab30f2854f@linux.alibaba.com/t/
v3: https://lore.kernel.org/lkml/20220209060108.43051-1-jefflexu@linux.alibaba.com/T/
v4: https://lore.kernel.org/lkml/20220307123305.79520-1-jefflexu@linux.alibaba.com/T/#t
v5: https://lore.kernel.org/lkml/202203170912.gk2sqkaK-lkp@intel.com/T/


[Background]
============
Nydus [1] is an image distribution service especially optimized for
distribution over network. Nydus is an excellent container image
acceleration solution, since it only pulls data from remote when needed,
a.k.a. on-demand reading and it also supports chunk-based deduplication,
compression, etc.

erofs (Enhanced Read-Only File System) is a filesystem designed for
read-only scenarios. (Documentation/filesystem/erofs.rst)

Over the past months we've been focusing on supporting Nydus image service
with in-kernel erofs format[2]. In that case, each container image will be
organized in one bootstrap (metadata) and (optional) multiple data blobs in
erofs format. Massive container images will be stored on one machine.

To accelerate the container startup (fetching container images from remote
and then start the container), we do hope that the bootstrap & blob files
could support on-demand read. That is, erofs can be mounted and accessed
even when the bootstrap/data blob files have not been fully downloaded.
Then it'll have native performance after data is available locally.

That means we have to manage the cache state of the bootstrap/data blob
files (if cache hit, read directly from the local cache; if cache miss,
fetch the data somehow). It would be painful and may be dumb for erofs to
implement the cache management itself. Thus we prefer fscache/cachefiles
to do the cache management instead.

The fscache on-demand read feature aims to be implemented in a generic way
so that it can benefit other use cases and/or filesystems if it's
implemented in the fscache subsystem.

[1] https://nydus.dev
[2] https://sched.co/pcdL


[Overall Design]
================
Please refer to patch 7 ("cachefiles: document on-demand read mode") for
more details.

When working in the original mode, cachefiles mainly serves as a local cache
for remote networking fs, while in on-demand read mode, cachefiles can work
in the scenario where on-demand read semantics is needed, e.g. container image
distribution.

The essential difference between these two modes is that, in original mode,
when cache miss, netfs itself will fetch data from remote, and then write the
fetched data into cache file. While in on-demand read mode, a user daemon is
responsible for fetching data and then feeds to the kernel fscache side.

The on-demand read mode relies on a simple protocol used for communication
between kernel and user daemon.

The proposed implementation relies on the anonymous fd mechanism to avoid
the dependence on the format of cache file. When a fscache cachefile is opened
for the first time, an anon_fd associated with the cache file is sent to the
user daemon. With the given anon_fd, user daemon could fetch and write data
into the cache file in the background, even when kernel has not triggered the
cache miss. Besides, the write() syscall to the anon_fd will finally call
cachefiles kernel module, which will write data to cache file in the latest
format of cache file.

1. cache miss
When cache miss, cachefiles kernel module will notify user daemon with the
anon_fd, along with the requested file range. When notified, user dameon
needs to fetch data of the requested file range, and then write the fetched
data into cache file with the given anonymous fd. When finished processing
the request, user daemon needs to notify the kernel.

After notifying the user daemon, the kernel read routine will hang there,
until the request is handled by user daemon. When it's awaken by the
notification from user daemon, i.e. the corresponding hole has been filled
by the user daemon, it will retry to read from the same file range.

2. cache hit
Once data is already ready in cache file, netfs will read from cache
file directly.


[Advantage of fscache-based on-demand read]
========================================
1. Asynchronous Prefetch
In current mechanism, fscache is responsible for cache state management,
while the data plane (fetch data from local/remote on cache miss) is
done on the user daemon side.

If data has already been ready in the backing file, netfs (e.g. erofs)
will read from the backing file directly and won't be trapped to user
space anymore. Thus the user daemon could fetch data (from remote)
asynchronously on the background, and thus accelerate the backing file
accessing in some degree.

2. Support massive blob files
Besides this mechanism supports a large amount of backing files, and
thus can benefit the densely employed scenario.

In our using scenario, one container image can correspond to one
bootstrap file (required) and multiple data blob files (optional). For
example, one container image for node.js will corresponds to ~20 files
in total. In densely employed environment, there could be as many as
hundreds of containers and thus thousands of backing files on one
machine.



Jeffle Xu (22):
  fscache: export fscache_end_operation()
  cachefiles: extract write routine
  cachefiles: notify user daemon with anon_fd when looking up cookie
  cachefiles: notify user daemon when withdrawing cookie
  cachefiles: implement on-demand read
  cachefiles: enable on-demand read mode
  cachefiles: document on-demand read mode
  erofs: use meta buffers for erofs_read_superblock()
  erofs: make erofs_map_blocks() generally available
  erofs: add mode checking helper
  erofs: register global fscache volume
  erofs: add cookie context helper functions
  erofs: add anonymous inode managing page cache of blob file
  erofs: add erofs_fscache_read_folios() helper
  erofs: register cookie context for bootstrap blob
  erofs: implement fscache-based metadata read
  erofs: implement fscache-based data read for non-inline layout
  erofs: implement fscache-based data read for inline layout
  erofs: register cookie context for data blobs
  erofs: implement fscache-based data read for data blobs
  erofs: implement fscache-based data readahead
  erofs: add 'tag' mount option

 .../filesystems/caching/cachefiles.rst        | 178 +++++++
 fs/cachefiles/Kconfig                         |  11 +
 fs/cachefiles/Makefile                        |   1 +
 fs/cachefiles/daemon.c                        |  89 +++-
 fs/cachefiles/interface.c                     |   2 +
 fs/cachefiles/internal.h                      |  64 +++
 fs/cachefiles/io.c                            |  72 ++-
 fs/cachefiles/namei.c                         |  16 +-
 fs/cachefiles/ondemand.c                      | 456 ++++++++++++++++++
 fs/erofs/Kconfig                              |  10 +
 fs/erofs/Makefile                             |   1 +
 fs/erofs/data.c                               |  24 +-
 fs/erofs/fscache.c                            | 444 +++++++++++++++++
 fs/erofs/inode.c                              |   8 +-
 fs/erofs/internal.h                           |  51 ++
 fs/erofs/super.c                              | 115 ++++-
 fs/fscache/internal.h                         |  11 -
 fs/nfs/fscache.c                              |   8 -
 include/linux/fscache.h                       |  15 +
 include/linux/netfs.h                         |   1 +
 include/trace/events/cachefiles.h             |   2 +
 include/uapi/linux/cachefiles.h               |  55 +++
 22 files changed, 1544 insertions(+), 90 deletions(-)
 create mode 100644 fs/cachefiles/ondemand.c
 create mode 100644 fs/erofs/fscache.c
 create mode 100644 include/uapi/linux/cachefiles.h

-- 
2.27.0

