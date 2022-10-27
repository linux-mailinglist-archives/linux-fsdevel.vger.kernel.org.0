Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAD860F25F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiJ0If5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 04:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiJ0Ifz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:35:55 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA7689AEB;
        Thu, 27 Oct 2022 01:35:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAl7YM_1666859747;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAl7YM_1666859747)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:48 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] fscache,netfs: decouple raw fscache APIs from libnetfs
Date:   Thu, 27 Oct 2022 16:35:38 +0800
Message-Id: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Git tree:

    https://github.com/lostjeffle/linux.git jingbo/clean-fscache-v1-clean-netfs

Gitweb:

    https://github.com/lostjeffle/linux/commits/jingbo/clean-fscache-v1-clean-netfs


[Rationale]
===========
Fscache has been landed as a generic caching management framework in
the Linux kernel for decades.  It aims to manage cache data availability
or fetch data if needed.  Currently it's mainly used for network fses,
but in principle the main caching subsystem can be used more widely.

We do really like fscache framework and we believe it'd be better to
reuse such framework if possible instead of duplicating other
alternatives for better maintenance and testing.  Therefore for our
container image use cases, we applied the existing fscache to implement
on-demand read for erofs in the past months.  For more details, also see
[1].

In short, here each erofs filesystem is composed of multiple blobs (or
devices).  Each blob corresponds to one fscache cookie to strictly
follow on-disk format and implement the image downloading in a
deterministic manner, which means it has a unique checksum and is signed
by vendors.

Data of each erofs inode can be scattered among multiple blobs (cookie)
since erofs supports chunk-level deduplication.  In this case, each
erofs inode can correspond to multiple cookies, and there's a logical to
physical offset mapping between the logical offset in erofs inode and
the physical offset in the backing file.

As described above, per-cookie netfs model can not be used here
directly.  Instead, we'd like to propose/decouple a simple set of raw
fscache APIs, e.g. fscache_read(), to access cache for all fses to use.
We believe it's useful since it's like the relationship between raw bio
and iomap, both of which are useful for local fses.  However, after
fscache/netfs rework, libnetfs is preferred to access fscache, making
fscache closely coupled with libnetfs.

Therefore, a more simple neutral raw fscache APIs is shown here which is
independent to libnetfs for those who are not using libnetfs.


[Patchset Organization]
=======================
patch 1: decouple prepare_read() from netfs_io_subrequest

patch 2-9:
All structures related to cache accessing will be transformed with
"fscache_" prefix, and defined in fscache namespace.  The whole
transition is divided into separate patches to facilitate code review,
with each patch transforming one structure.

It is worth noting that the structure declaration is temporarily placed
in netfs.h, and will be moved to fscache.h when all related structures
are transformed to "fscache_" prefixed finally.  The reason is that, in
the intermediate state during the transition, the declarations of
related structures are scattered among fscache.h and netfs.h.  This will
cause a bidirectional reference of these two headers, and compilation
error then.  As a work around, keep the declaration in netfs.h
temporarily, until all structures are transformed and then moved to
fscache.h (in patch 9).


[Following cleanup for erofs]
=============================
We will also cleanup erofs based on fscache_read() so that it won't rely
on netfs internals anymore. For example, erofs can implement its own
request completion routine, so that it can get rid of reliance on
netfs_io_request and netfs_io_subrequest.


[1] https://lore.kernel.org/all/Yoj1AcHoBPqir++H@debian/


Jingbo Xu (9):
  fscache: decouple prepare_read() from netfs_io_subrequest
  fscache,netfs: rename netfs_io_source as fscache_io_source
  fscache,netfs: rename netfs_io_terminated_t as fscache_io_terminated_t
  fscache,netfs: rename netfs_read_from_hole as fscache_read_from_hole
  fscache,netfs: rename netfs_cache_ops as fscache_ops
  fscache,netfs: rename netfs_cache_resources as fscache_resources
  fscache,netfs: define flags for prepare_read()
  fscache,netfs: move PageFsCache() family helpers to fscache.h
  fscache,netfs: move "fscache_" prefixed structures to fscache.h

 fs/afs/internal.h                 |   2 +-
 fs/cachefiles/interface.c         |   2 +-
 fs/cachefiles/internal.h          |   8 +-
 fs/cachefiles/io.c                |  84 ++++++------
 fs/cifs/fscache.c                 |   8 +-
 fs/erofs/fscache.c                |  17 ++-
 fs/fscache/io.c                   |  18 +--
 fs/netfs/buffered_read.c          |   2 +-
 fs/netfs/io.c                     |  67 +++++-----
 fs/nfs/fscache.c                  |   6 +-
 fs/nfs/fscache.h                  |   2 +-
 include/linux/fscache-cache.h     |   8 +-
 include/linux/fscache.h           | 211 +++++++++++++++++++++++++++---
 include/linux/netfs.h             | 173 +-----------------------
 include/trace/events/cachefiles.h |  27 ++--
 include/trace/events/netfs.h      |  14 +-
 16 files changed, 330 insertions(+), 319 deletions(-)

-- 
2.19.1.6.gb485710b

