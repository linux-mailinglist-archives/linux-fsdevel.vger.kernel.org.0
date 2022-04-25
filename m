Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C801B50DFD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiDYMY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiDYMYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:24:55 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544D31228;
        Mon, 25 Apr 2022 05:21:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VBG8mcj_1650889303;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VBG8mcj_1650889303)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 20:21:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v10 00/21] fscache,erofs: fscache-based on-demand read semantics
Date:   Mon, 25 Apr 2022 20:21:22 +0800
Message-Id: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes since v9:
- rebase to 5.18-rc3
- cachefiles: extract cachefiles_in_ondemand_mode() helper; add barrier
  pair between enqueuing and flushing requests; make the xarray
  structures non-conditionally defined in struct cachefiles_cache
  (patch 2) (David Howells)
- cacehfiles: use refcount_t for unbind_pincount; run "cachefiles_open = 0;"
  cleanup only when unbind_pincount is decreased to 0 (patch 3)
  (David Howells)
- cachefiles: rename CACHEFILES_IOC_CREAD ioctl to
  CACHEFILES_IOC_READ_COMPLETE (patch 5) (David Howells)
- cachefiles: fix the error message when the argument to the 'bind'
  command is invalid (patch 6) (David Howells)
- cachefiles: update the documentation polished by David (patch 8)
- erofs: tweak the code arrangement of erofs_fscache_meta_readpage()
  (patch 17) (Gao Xiang)
- erofs: add comment on error cases (patch 20) (Gao Xiang)
- update Tested-by tags in the cover letter


Kernel Patchset
---------------
Git tree:

    https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v10

Gitweb:

    https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v10


User Guide for E2E Container Use Case
-------------------------------------
User guide:

    https://github.com/dragonflyoss/image-service/blob/fscache/docs/nydus-fscache.md

Video:

    https://youtu.be/F4IF2_DENXo


User Daemon for Quick Test
--------------------------
Git tree:

    https://github.com/lostjeffle/demand-read-cachefilesd.git main

Gitweb:

    https://github.com/lostjeffle/demand-read-cachefilesd


Tested-by: Zichen Tian <tianzichen@kuaishou.com>
Tested-by: Jia Zhu <zhujia.zj@bytedance.com>


RFC: https://lore.kernel.org/all/YbRL2glGzjfZkVbH@B-P7TQMD6M-0146.local/t/
v1: https://lore.kernel.org/lkml/47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com/T/
v2: https://lore.kernel.org/all/2946d871-b9e1-cf29-6d39-bcab30f2854f@linux.alibaba.com/t/
v3: https://lore.kernel.org/lkml/20220209060108.43051-1-jefflexu@linux.alibaba.com/T/
v4: https://lore.kernel.org/lkml/20220307123305.79520-1-jefflexu@linux.alibaba.com/T/#t
v5: https://lore.kernel.org/lkml/202203170912.gk2sqkaK-lkp@intel.com/T/
v6: https://lore.kernel.org/lkml/202203260720.uA5o7k5w-lkp@intel.com/T/
v7: https://lore.kernel.org/lkml/557bcf75-2334-5fbb-d2e0-c65e96da566d@linux.alibaba.com/T/
v8: https://lore.kernel.org/all/ac8571b8-0935-1f4f-e9f1-e424f059b5ed@linux.alibaba.com/T/
v9: https://lore.kernel.org/lkml/2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com/T/


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
anon_fd, along with the requested file range. When notified, user daemon
needs to fetch data of the requested file range, and then write the fetched
data into cache file with the given anonymous fd. When finished processing
the request, user daemon needs to notify the kernel.

After notifying the user daemon, the kernel read routine will wait there,
until the request is handled by user daemon. When it's awaken by the
notification from user daemon, i.e. the corresponding hole has been filled
by the user daemon, it will retry to read from the same file range.

2. cache hit
Once data is already ready in cache file, netfs will read from cache
file directly.


[Advantage of fscache-based on-demand read]
========================================
1. Asynchronous prefetch
In current mechanism, fscache is responsible for cache state management,
while the data plane (fetching data from local/remote on cache miss) is
done on the user daemon side even without any file system request driven.
In addition, if cached data has already been available locally, fscache
will use it instead of trapping to user space anymore.

Therefore, different from event-driven approaches, the fscache on-demand
user daemon could also fetch data (from remote) asynchronously in the
background just like most multi-threaded HTTP downloaders.

2. Flexible request amplification
Since the data plane can be independently controlled by the user daemon,
the user daemon can also fetch more data from remote than that the file
system actually requests for small I/O sizes. Then, fetched data in bulk
will be available at once and fscache won't be trapped into the user
daemon again.

3. Support massive blobs
This mechanism can naturally support a large amount of backing files,
and thus can benefit the densely employed scenarios. In our use cases,
one container image can be formed of one bootstrap (required) and
multiple chunk-deduplicated data blobs (optional).

For example, one container image for node.js will correspond to ~20
files in total. In densely employed environment, there could be hundreds
of containers and thus thousands of backing files on one machine.


Jeffle Xu (21):
  cachefiles: extract write routine
  cachefiles: notify the user daemon when looking up cookie
  cachefiles: unbind cachefiles gracefully in on-demand mode
  cachefiles: notify the user daemon when withdrawing cookie
  cachefiles: implement on-demand read
  cachefiles: enable on-demand read mode
  cachefiles: add tracepoints for on-demand read mode
  cachefiles: document on-demand read mode
  erofs: make erofs_map_blocks() generally available
  erofs: add fscache mode check helper
  erofs: register fscache volume
  erofs: add fscache context helper functions
  erofs: add anonymous inode caching metadata for data blobs
  erofs: add erofs_fscache_read_folios() helper
  erofs: register fscache context for primary data blob
  erofs: register fscache context for extra data blobs
  erofs: implement fscache-based metadata read
  erofs: implement fscache-based data read for non-inline layout
  erofs: implement fscache-based data read for inline layout
  erofs: implement fscache-based data readahead
  erofs: add 'fsid' mount option

 .../filesystems/caching/cachefiles.rst        | 174 ++++++
 fs/cachefiles/Kconfig                         |  12 +
 fs/cachefiles/Makefile                        |   1 +
 fs/cachefiles/daemon.c                        | 117 +++-
 fs/cachefiles/interface.c                     |   2 +
 fs/cachefiles/internal.h                      |  78 +++
 fs/cachefiles/io.c                            |  76 ++-
 fs/cachefiles/namei.c                         |  16 +-
 fs/cachefiles/ondemand.c                      | 503 ++++++++++++++++++
 fs/erofs/Kconfig                              |  10 +
 fs/erofs/Makefile                             |   1 +
 fs/erofs/data.c                               |  26 +-
 fs/erofs/fscache.c                            | 363 +++++++++++++
 fs/erofs/inode.c                              |   4 +
 fs/erofs/internal.h                           |  49 ++
 fs/erofs/super.c                              | 105 +++-
 fs/erofs/sysfs.c                              |   4 +-
 include/linux/fscache.h                       |   1 +
 include/linux/netfs.h                         |   1 +
 include/trace/events/cachefiles.h             | 176 ++++++
 include/uapi/linux/cachefiles.h               |  68 +++
 21 files changed, 1708 insertions(+), 79 deletions(-)
 create mode 100644 fs/cachefiles/ondemand.c
 create mode 100644 fs/erofs/fscache.c
 create mode 100644 include/uapi/linux/cachefiles.h

-- 
2.27.0

