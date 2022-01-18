Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6F492686
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiARNMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:12:24 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58730 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242009AbiARNMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2C1owk_1642511536;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2C1owk_1642511536)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:17 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read semantics
Date:   Tue, 18 Jan 2022 21:11:56 +0800
Message-Id: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes since v1:
- rebase to v5.17
- erofs: In chunk based layout, since the logical file offset has the
  same remainder over PAGE_SIZE with the corresponding physical address
  inside the data blob file, the file page cache can be directly
  transferred to netfs library to contain the data from data blob file.
  (patch 15) (Gao Xiang)
- netfs,cachefiles: manage logical/physical offset separately. (patch 2)
  (It is used by erofs_begin_cache_operation() in patch 15.)
- cachefiles: introduce a new devnode specificaly for on-demand reading.
  (patch 6)
- netfs,fscache,cachefiles: add new CONFIG_* for on-demand reading.
  (patch 3/5)
- You could start a quick test by
  https://github.com/lostjeffle/demand-read-cachefilesd
- add more background information (mainly introduction to nydus) in the
  "Background" part of this cover letter

[Important Issues]
The following issues still need further discussion. Thanks for your time
and patience.

1. I noticed that there's refactoring of netfs library[1], and patch 1
is not needed since [2].

2. The current implementation will severely conflict with the
refactoring of netfs library[1][2]. The assumption of 'struct
netfs_i_context' [2] is that, every file in the upper netfs will
correspond to only one backing file. While in our scenario, one file in
erofs can correspond to multiple backing files. That is, the content of
one file can be divided into multiple chunks, and are distrubuted over
multiple blob files, i.e. multiple backing files. Currently I have no
good idea solving this conflic.

Besides there are still two quetions:
- What's the plan of [1]? When is it planned to be merged?
- It seems that all upper fs using fscache is going to use netfs API,
  while the APIs like fscache_read_or_alloc_page() are deprecated. Is
  that true?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=netfs-lib&id=087d913752522fb9aa6d3effdb9a8c7908c779dd


RFC: https://lore.kernel.org/all/YbRL2glGzjfZkVbH@B-P7TQMD6M-0146.local/t/
v1: https://lore.kernel.org/lkml/47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com/T/


[Background]
============
Nydus is a remote container snapthotter specially optimised for container
images distribution over network. It has recently been accepted as a
sub-project of containerd[1]. Nydus is an excellent container image
acceleration solution, since it only pulls data from remote when it's
really needed, a.k.a. on-demand reading.

erofs (Enhanced Read-Only File System) is a filesystem specially
optimised for read-only scenarios. (Documentation/filesystem/erofs.rst)

Recently we are focusing on erofs in container images distribution
scenario [2], trying to combine it with nydus. In this case, erofs can
be mounted from one bootstrap file (metadata) with (optional) multiple
data blob files (data) stored on another local filesystem. (All these
files are actually image files in erofs disk format.)

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

[1] https://d7y.io/en-us/blog/containerd_accepted_nydus-snapshotter.html
[2] https://sched.co/pcdL


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
You could start a quick test by
https://github.com/lostjeffle/demand-read-cachefilesd


Jeffle Xu (20):
  netfs: make @file optional in netfs_alloc_read_request()
  netfs,cachefiles: manage logical/physical offset separately
  netfs,fscache: support on-demand reading
  cachefiles: extract generic daemon write function
  cachefiles: detect backing file size in on-demand read mode
  cachefiles: introduce new devnode for on-demand read mode
  erofs: use meta buffers for erofs_read_superblock()
  erofs: export erofs_map_blocks()
  erofs: add mode checking helper
  erofs: register global fscache volume
  erofs: add cookie context helper functions
  erofs: add anonymous inode managing page cache of blob file
  erofs: register cookie context for bootstrap blob
  erofs: implement fscache-based metadata read
  erofs: implement fscache-based data read for non-inline layout
  erofs: implement fscache-based data read for inline layout
  erofs: register cookie context for data blobs
  erofs: implement fscache-based data read for data blobs
  erofs: add 'uuid' mount option
  erofs: support on-demand reading

 fs/cachefiles/Kconfig    |   8 +
 fs/cachefiles/daemon.c   | 147 ++++++++++++++++-
 fs/cachefiles/internal.h |  23 +++
 fs/cachefiles/io.c       |  82 +++++++++-
 fs/cachefiles/main.c     |  27 ++++
 fs/cachefiles/namei.c    |  60 ++++++-
 fs/erofs/Kconfig         |   2 +-
 fs/erofs/Makefile        |   3 +-
 fs/erofs/data.c          |  18 ++-
 fs/erofs/fscache.c       | 339 +++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c         |   6 +-
 fs/erofs/internal.h      |  30 ++++
 fs/erofs/super.c         | 101 +++++++++---
 fs/fscache/Kconfig       |   8 +
 fs/netfs/Kconfig         |   8 +
 fs/netfs/read_helper.c   |  65 ++++++--
 include/linux/netfs.h    |  10 ++
 17 files changed, 886 insertions(+), 51 deletions(-)
 create mode 100644 fs/erofs/fscache.c

-- 
2.27.0

