Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E18502A2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 14:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353525AbiDOMi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 08:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344091AbiDOMiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:38:50 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0170C6EFB;
        Fri, 15 Apr 2022 05:36:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VA7Cc00_1650026174;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VA7Cc00_1650026174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 20:36:15 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: [PATCH v9 00/21] fscache,erofs: fscache-based on-demand read semantics
Date:   Fri, 15 Apr 2022 20:35:53 +0800
Message-Id: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes since v8:
- rebase to 5.18-rc2
- cachefiles: use object_id rather than anon_fd to uniquely identify a
  cachefile object to avoid potential issues when the user moves the
  anonymous fd around, e.g. through dup() (refer to commit message and
  cachefiles_ondemand_get_fd() of patch 2 for more details)
  (David Howells)
- cachefiles: add @unbind_pincount refcount to avoid the potential deadlock
  (refer to commit message of patch3 for more details)
- cachefiles: move the calling site of cachefiles_ondemand_read() from
  cachefiles_read() to cacehfiles_prep_read() (refer to commit message
  of patch 5 for more details)
- cachefiles: add tracepoints (patch 7) (David Howells)
- cachefiles: update documentation (patch 8) (David Howells)
- erofs: update Reviewed-by tag from Gao Xiang
- erofs: move the logic of initializing bdev/dax_dev in fscache mode out
  from patch 15/20. Instead move it into patch 9, so that patch 20 can
  focus on the mount option handling
- erofs: update the subject line and commit message of patch 12 (Gao
  Xiang)
- erofs: remove and fold erofs_fscache_get_folio() helper (patch 16)
  (Gao Xiang)
- erofs: change kmap() to kamp_loacl_folio(), and comment cleanup (patch
  18) (Gao Xiang)
- update "advantage of fscache-based on-demand read" section of the
  cover letter
- we've finished a preliminary end-to-end on-demand download daemon in
  order to test the fscache on-demand kernel code as a real end-to-end
  workload for container use cases. The test user guide is added in the
  cover letter.
- Thanks Zichen Tian for testing
  Tested-by: Zichen Tian <tianzichen@kuaishou.com>


Kernel Patchset
---------------
Git tree:

    https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v9

Gitweb:

    https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v9


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


RFC: https://lore.kernel.org/all/YbRL2glGzjfZkVbH@B-P7TQMD6M-0146.local/t/
v1: https://lore.kernel.org/lkml/47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com/T/
v2: https://lore.kernel.org/all/2946d871-b9e1-cf29-6d39-bcab30f2854f@linux.alibaba.com/t/
v3: https://lore.kernel.org/lkml/20220209060108.43051-1-jefflexu@linux.alibaba.com/T/
v4: https://lore.kernel.org/lkml/20220307123305.79520-1-jefflexu@linux.alibaba.com/T/#t
v5: https://lore.kernel.org/lkml/202203170912.gk2sqkaK-lkp@intel.com/T/
v6: https://lore.kernel.org/lkml/202203260720.uA5o7k5w-lkp@intel.com/T/
v7: https://lore.kernel.org/lkml/557bcf75-2334-5fbb-d2e0-c65e96da566d@linux.alibaba.com/T/
v8: https://lore.kernel.org/all/ac8571b8-0935-1f4f-e9f1-e424f059b5ed@linux.alibaba.com/T/


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

After notifying the user daemon, the kernel read routine will hang there,
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
  cachefiles: notify user daemon when looking up cookie
  cachefiles: unbind cachefiles gracefully in on-demand mode
  cachefiles: notify user daemon when withdrawing cookie
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

 .../filesystems/caching/cachefiles.rst        | 170 ++++++
 fs/cachefiles/Kconfig                         |  11 +
 fs/cachefiles/Makefile                        |   1 +
 fs/cachefiles/daemon.c                        | 116 +++-
 fs/cachefiles/interface.c                     |   2 +
 fs/cachefiles/internal.h                      |  74 +++
 fs/cachefiles/io.c                            |  76 ++-
 fs/cachefiles/namei.c                         |  16 +-
 fs/cachefiles/ondemand.c                      | 496 ++++++++++++++++++
 fs/erofs/Kconfig                              |  10 +
 fs/erofs/Makefile                             |   1 +
 fs/erofs/data.c                               |  26 +-
 fs/erofs/fscache.c                            | 365 +++++++++++++
 fs/erofs/inode.c                              |   4 +
 fs/erofs/internal.h                           |  49 ++
 fs/erofs/super.c                              | 105 +++-
 fs/erofs/sysfs.c                              |   4 +-
 include/linux/fscache.h                       |   1 +
 include/linux/netfs.h                         |   2 +
 include/trace/events/cachefiles.h             | 176 +++++++
 include/uapi/linux/cachefiles.h               |  68 +++
 21 files changed, 1694 insertions(+), 79 deletions(-)
 create mode 100644 fs/cachefiles/ondemand.c
 create mode 100644 fs/erofs/fscache.c
 create mode 100644 include/uapi/linux/cachefiles.h

-- 
2.27.0

