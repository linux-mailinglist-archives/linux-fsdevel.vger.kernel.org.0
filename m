Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13D46FBA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbhLJHkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:06 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:38357 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235371AbhLJHj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:39:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8PLOD_1639121779;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8PLOD_1639121779)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:20 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 00/19] fscache,erofs: fscache-based demand-read semantics
Date:   Fri, 10 Dec 2021 15:36:00 +0800
Message-Id: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
<root>/cache/<volume>) in advance. These backing files are completely
sparse files (with zero disk usage). Since these backing files are all
read-only and the file size is fixed, user daemon will set corresponding
file size and thus create all these sparse backing files in advance.

2. cache miss
When a file range (of bootstrap/data blob file) is accessed for the
first time, a cache miss will be triggered and then .issue_op() will be
called to fetch the data somehow.

In the demand-read case, we relies on a user daemon to fetch the data
from local/remote. In this case, .issue_op() just packages the file
range into a message and informs the user daemon, which was polling and
waiting on /dev/cachefiles. Once awaken, the user daemon will then read
/dev/cachefiles to get the file range information, and go to fetch the
data corresponding to the file range. Once data ready, the user daemon
will write the fetched data into the backing file and then inform the
previous .issue_op() by writing to /dev/cachefiles. The previous
.issue_op() calling will be blocked there until it is informed by the
user daemon that the data has been ready. By then the data has been
ready in the backing file, and the netfs API will re-initiate a read
request from the backing file.

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


[Invalidation Strategy]
=======================
Currently I have no clear idea on the invalidation (culling) strategy
yet... It needs further discussion and then gets implemented later.


[Patchset Organization]
=======================
- patch 1-16 implement the data plane over fscache. Until then erofs
  could access the bootstrap blob file (backing file) with fscache,
  though the backing file needs to be ready (fully downloaded).
- patch 17-19 implement the demand-read semantics. Then it will rely on
  the user daemon to fetch the data once the backing file has not been
  ready (cache miss).


[Interaction with fscache/cachefiles/netfs]
===========================================
fscache/cachefiles/netfs are initially designed to serve as a local
cache for remote filesystems. As they are used to implement the
demand-read semantics, the logic may need to be twisted somehow.

This RFC pathset is still quite coarse and is only used to show the
skeleton of the whole mechanism. Thus to get a workable model as soon as
possible, the refactoring to fscache/cachefiles/netfs in this pathset is
quite rough. (sorry for that...) Further discussion and clarification is
obviously needed.

1. The path of the backing file
In cachefiles, the backing file will be stored under one fan
sub-directory according to a hashing algorithm. While in our using
scenario, user daemon need to touch bootstrap/data blob file under
correct directory in advance.

In this RFC patchset, I directly passthrough the placing algorithm
(patch 2) for convenience of debug. But in the later version, we can
make the hashing algorithm used by cachefiles built-in into the user
daemon, and let user daemon compute the corresponding hash value and
place bootstrap/data blob file under right directory. The goal is to
keep cachefiles' placing logic untouched as much as possible.

2. Upper fs doesn't know file size in advance
The @object_size parameter of fscache_acquire_cookie() represents the
file size of the netfs file, and serves in several places.

- the size of the backing file will be set to @object_size during the
  cookie lookup phase.
- @object_size will be used to do the coherency checking (compared with
  the file size in "CacheFiles.cache" xattr) during the cookie lookup
  phase.
- netfs API will check if the current readed file range hits EOF
  according to the file size.

While in demand-read case, the upper fs has no idea of the file size of
the blob file. Besides, since these files are all read-only, the file
size is fixed and (as described in 'initial phase') user daemon has set
corresponding file size (of sparse files), maybe fscache could query the
file size of the backing file directly, e.g. through fstat on the
backing file, instead of relying on upper fs to offer the credible file
size.

Similarly patch 3/10/11 in this RFC just skip the related checking and
logic for demand-read case.

3. Refactor the address_space based netfs_readpage() API
The @folio parameter of netfs_readpage() indicates a page cache in the
address_space of the netfs file, and thus the following logic of netfs
API will directly copy data to the page cache in the address_space,
leaving the @folio parameter aside.

While in demand-read case, the input @folio is no longer a page cache in
the address_space of one file. Instead, it may be just a temporary page
used to contain the data. Thus netfs API needed to be refactored somehow
to adapt to this change.

Patch 8/9 in this RFC are for this purpose.

4. Maybe need another device node
In demand-read case, we rely on the user daemon to fetch data from
local/remote. Currently we re-use "/dev/cachefiles" for the
communication between fscache kernel module and user daemon. It's
obviously not acceptable since "/dev/cachefiles" is only for culling.
Later we could create another device node for this purpose.


[Test]
======
1. create erofs image (bootstrap)
mkfs.erofs test.img tmp/

2. move bootstrap to corresponding place under the root directory of
fscache

3. run user daemon
(https://github.com/lostjeffle/demand-read-cachefilesd/blob/main/cachefilesd2.c)
./cachefilesd2

4. mount erofs from bootstrap
mount -t erofs none -o bootstrap_path=test.img /mnt/



Jeffle Xu (19):
  cachefiles: add mode command
  cachefiles: implement key scheme for demand-read mode
  cachefiles: refactor cachefiles_adjust_size()
  netfs: make ops->init_rreq() optional
  netfs: refactor netfs_alloc_read_request
  netfs: add type field to struct netfs_read_request
  netfs: add netfs_readpage_demand()
  netfs: refactor netfs_clear_unread()
  netfs: refactor netfs_rreq_unlock()
  netfs: refactor netfs_rreq_prepare_read
  cachefiles: refactor cachefiles_prepare_read
  erofs: export erofs_map_blocks
  erofs: add bootstrap_path mount option
  erofs: introduce fscache support
  erofs: implement fscache-based metadata read
  erofs: implement fscache-based data read
  netfs: support on demand read
  cachefiles: support on demand read
  erofs: support on demand read

 fs/cachefiles/daemon.c    | 183 ++++++++++++++++++++++++++++----------
 fs/cachefiles/interface.c |   4 +
 fs/cachefiles/internal.h  |  22 +++++
 fs/cachefiles/io.c        |  59 +++++++++++-
 fs/cachefiles/namei.c     |   8 +-
 fs/cachefiles/xattr.c     |   5 ++
 fs/ceph/addr.c            |   5 --
 fs/erofs/Makefile         |   2 +-
 fs/erofs/data.c           |  18 ++--
 fs/erofs/fscache.c        | 161 +++++++++++++++++++++++++++++++++
 fs/erofs/inode.c          |   6 +-
 fs/erofs/internal.h       |  15 ++++
 fs/erofs/super.c          |  55 ++++++++++--
 fs/netfs/read_helper.c    | 179 +++++++++++++++++++++++++++++++++----
 include/linux/netfs.h     |  16 ++++
 15 files changed, 652 insertions(+), 86 deletions(-)
 create mode 100644 fs/erofs/fscache.c

-- 
2.27.0

