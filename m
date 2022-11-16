Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A703962BA59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiKPK4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbiKPK4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:56:23 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE4959842;
        Wed, 16 Nov 2022 02:45:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VUxXL9z_1668595503;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUxXL9z_1668595503)
          by smtp.aliyun-inc.com;
          Wed, 16 Nov 2022 18:45:05 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, jlayton@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/2] fscache,cachefiles: add prepare_ondemand_read() interface
Date:   Wed, 16 Nov 2022 18:45:00 +0800
Message-Id: <20221116104502.107431-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v3:
- rebase to v6.1-rc5, while the xas_retry() checking in patch 2 has
  been extracted out as a separate fix [1]

[1] commit 37020bbb71d9 ("erofs: fix missing xas_retry() in fscache mode")
(https://github.com/torvalds/linux/commit/37020bbb71d9)


v2:
- patch 1: the generic routine, i.e. cachefiles_do_prepare_read() now
  accepts a parameter list instead of netfs_io_subrequest, and thus some
  debug info retrieved from netfs_io_subrequest is removed from
  trace_cachefiles_prep_read().
- patch 2: add xas_retry() checking in erofs_fscache_req_complete()


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
fscache APIs, to access cache for all fses to use.  We believe it's
useful since it's like the relationship between raw bio and iomap, both
of which are useful for local fses.  fscache_read() seems a reasonable
candidate and is enough for such use case.

In addition, the on-demand read feature relies on .prepare_read() to
reuse the hole detecting logic as much as possible. However, after
fscache/netfs rework, libnetfs is preferred to access fscache, making
.prepare_read() closely coupled with libnetfs, or more precisely,
netfs_io_subrequest.


[What We Do]
============
As we discussed previously, we propose a new interface, i,e,
.prepare_ondemand_read() dedicated for the on-demand read scenarios,
which is independent on netfs_io_subrequest. The netfs will still use
the original .prepare_read() as usual.


Jingbo Xu (2):
  fscache,cachefiles: add prepare_ondemand_read() callback
  erofs: switch to prepare_ondemand_read() in fscache mode

 fs/cachefiles/io.c                |  75 +++++----
 fs/erofs/fscache.c                | 259 +++++++++++-------------------
 include/linux/netfs.h             |   7 +
 include/trace/events/cachefiles.h |  27 ++--
 4 files changed, 160 insertions(+), 208 deletions(-)

-- 
2.19.1.6.gb485710b

