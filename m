Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1A47FCCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhL0Myr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:54:47 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38932 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229996AbhL0Myr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:54:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.xJoOo_1640609684;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.xJoOo_1640609684)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:54:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/23] fscache,erofs: fscache-based demand-read semantics
Date:   Mon, 27 Dec 2021 20:54:21 +0800
Message-Id: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes since RFC:
- patch set organization:
  patch 1-16 implement the data plane over fscache without demand
  reading support, while the demand reading support is left to patch
  17-23.
- implement a new devnode ("/dev/cachefiles_demand") for the new mode
  (patch 1,20-22)
- use flag bit inside cache->flags to distinguish modes (patch 2) (David
  Howells)
- user daemon is responsible for placing blob files under corresponding
  fan sub directory, and setting "CacheFiles.cache" xattr in advance,
  so that cachefiles backend doesn't need modification to adapt to the
  new mode. (David Howells)
- erofs will allocate an anonymous inode for each backed file. This
  anonymous inode is responsible for managing page cache of backed file,
  so that netfs API doesn't need modification to adapt to the new mode.
  (Gao Xiang)


RFC: https://lore.kernel.org/all/YbRL2glGzjfZkVbH@B-P7TQMD6M-0146.local/t/


[Background]
============
erofs (Enhanced Read-Only File System) is a filesystem specially
optimised for read-only scenarios. (Documentation/filesystem/erofs.rst)

Recently we are focusing on erofs in container images distribution
scenario (https://sched.co/pcdL). In this case, erofs can be mounted
from one bootstrap file (metadata) with (optional) multiple data blob
files (data) stored on another local filesystem. (All these files are
actually image files in erofs disk format.)

To accelerate the container startup (fetching container image from remote
and then start the container), we do hope that the bootstrap blob file
could support demand read. That is, erofs can be mounted and accessed
even when the bootstrap/data blob files have not been fully downloaded.

That means we have to manage the cache state of the bootstrap/data blob
files (if cache hit, read directly from the local cache; if cache miss,
fetch the data somehow). It would be painful and may be dumb for erofs to
implement the cache management itself. Thus we prefer fscache/cachefiles
to do the cache management. Besides, the demand-read feature shall be
general and it can benefit other using scenarios if it can be implemented
in fscache level.


[Overall Design]
================
The upper fs uses a backing file on the local fs as the local cache
(exactly the "cachefiles" way), and relies on fscache to detect if data
is ready or not (cache hit/miss). Since currently fscache detects cache
hit/miss by detecting the hole of the backing files, our demand-read
mechanism also relies on the hole detecting.

1. initial phase
On the first beginning, the user daemon will touch the backing files
(bootstrap/data blob files) under corresponding directory (under
<root>/cache/<volume>/<fan>/) in advance. These backing files are
completely sparse files (with zero disk usage). Since these backing
files are all read-only and the file size is known prior mounting, user
daemon will set corresponding file size and thus create all these sparse
backing files in advance.

2. cache miss
When a file range (of bootstrap/data blob file) is accessed for the
first time, a cache miss will be triggered and then .issue_op() will be
called to fetch the data somehow.

In the demand-read case, we relies on a user daemon to fetch the data
from local/remote. In this case, .issue_op() just packages the file
range into a message and informs the user daemon. User daemon needs to
poll and wait on the devnode (/dev/cachefiles_demand). Once awaken, the
user daemon will read the devnode to get the file range information, and
then fetch the data corresponding to the file range somehow, e.g.
download from remote through network. Once data ready, the user daemon
will write the fetched data into the backing file and then inform
cachefiles backend by writing to the devnode. Cachefiles backend getting
blocked on the previous .issue_op() calling will be awaken then. By then
the data has been ready in the backing file, and the netfs API will
re-initiate a read request from the backing file.

3. cache hit
Once data is already ready in the backing file, netfs API will read from
the backing file directly.


[Advantage of fscache-based demand-read]
========================================
1. Asynchronous Prefetch
In current mechanism, fscache is responsible for cache state management,
while the data plane (fetch data from local/remote on cache miss) is
done on the user daemon side.

If data has already been ready in the backing file, netfs API will read
from the backing file directly and won't be trapped to user space anymore.
Thus the user daemon could fetch data (from remote) asynchronously on the
background, and thus accelerate the backing file accessing in some degree.

2. Support massive blob files
Besides this mechanism supports a large amount of backing files, and
thus can benefit the densely employed scenario.

In our using scenario, one container image can correspond to one
bootstrap file (required) and multiple data blob files (optional). For
example, one container image for node.js will corresponds to ~20 files
in total. In densely employed environment, there could be as many as
hundreds of containers and thus thousands of backing files on one
machine.


[Test]
======
1. create erofs image (bootstrap)
mkfs.erofs --chunksize=1048576 --blobdev=Dblob1.img -Eforce-chunk-indexes Dtest.img tmp/

2. create sparse blob files under fscache root directory ("/root")
truncate -s 28672 cache/Ierofs/@9c/Dtest.img
truncate -s 8040448 cache/Ierofs/@b5/Dblob1.img

3. set "CacheFiles.cache" xattr for blob files in advance (refer to
https://github.com/lostjeffle/demand-read-cachefilesd/blob/main/setxattr.c)

4. run user daemon
(https://github.com/lostjeffle/demand-read-cachefilesd/blob/main/cachefilesd2.c)
./cachefilesd2

5. mount erofs from bootstrap
mount -t erofs none -o uuid=test.img /mnt/


Jeffle Xu (23):
  cachefiles: add cachefiles_demand devnode
  cachefiles: add mode command to distinguish modes
  cachefiles: detect backing file size in demand-read mode
  netfs: make ops->init_rreq() optional
  netfs: add inode parameter to netfs_alloc_read_request()
  erofs: export erofs_map_blocks()
  erofs: add nodev mode
  erofs: register global fscache volume
  erofs: add cookie context helper functions
  erofs: add anonymous inode managing page cache of blob file
  erofs: register cookie context for bootstrap
  erofs: implement fscache-based metadata read
  erofs: implement fscache-based data read
  erofs: register cookie context for data blobs
  erofs: implement fscache-based data read for data blobs
  erofs: add 'uuid' mount option
  netfs: support on demand read
  cachefiles: use idr tree managing pending demand read
  cachefiles: implement .demand_read() for demand read
  cachefiles: implement .poll() for demand read
  cachefiles: implement .read() for demand read
  cachefiles: add done command for demand read
  erofs: support on demand read

 fs/cachefiles/daemon.c   | 124 +++++++++++++++++
 fs/cachefiles/internal.h |  18 +++
 fs/cachefiles/io.c       |  56 ++++++++
 fs/cachefiles/main.c     |  12 ++
 fs/cachefiles/namei.c    |  40 ++++++
 fs/ceph/addr.c           |   5 -
 fs/erofs/Makefile        |   2 +-
 fs/erofs/data.c          |  20 ++-
 fs/erofs/fscache.c       | 292 +++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c         |   6 +-
 fs/erofs/internal.h      |  25 ++++
 fs/erofs/super.c         |  98 ++++++++++---
 fs/netfs/read_helper.c   |  41 +++++-
 include/linux/netfs.h    |   4 +
 14 files changed, 708 insertions(+), 35 deletions(-)
 create mode 100644 fs/erofs/fscache.c

-- 
2.27.0

