Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7866F737D88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjFUIii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 04:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjFUIic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:38:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41781733
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 01:38:28 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621083825euoutp02cd6e7407a010295c1fe4a0e9570c6d8d~qn8tOZyVJ0552105521euoutp02J
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 08:38:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621083825euoutp02cd6e7407a010295c1fe4a0e9570c6d8d~qn8tOZyVJ0552105521euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687336705;
        bh=xvc2sXLnGhjLFsmbguf3lN8FCrGCE+c6gqNP7gHJ+6E=;
        h=From:To:CC:Subject:Date:References:From;
        b=Fog8brKPDWpTPI2mhjAInqaNxIrdyluJLk3bGvJKKJgjQMgnG1LjGoEo4HjjHGntT
         qua/u/YvKLzfRvKnWU2ZEA/sjx57CRcWjtNPe+MS15hMyaa1e8eEf0+f+yJTwOayet
         4BjzZEbGLtqo6bJnVvLkKZDTyOvNovbeSDVwXK4w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621083825eucas1p16d3b63ee510633d075e53ae04dc89616~qn8s_KRHt2117621176eucas1p1V;
        Wed, 21 Jun 2023 08:38:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 39.1A.42423.107B2946; Wed, 21
        Jun 2023 09:38:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a~qn8sk8gNA1658116581eucas1p11;
        Wed, 21 Jun 2023 08:38:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621083825eusmtrp233925ce44cddfcf590425c8d7e60f792~qn8sjqxzl0284602846eusmtrp28;
        Wed, 21 Jun 2023 08:38:25 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-81-6492b7018925
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.8B.14344.107B2946; Wed, 21
        Jun 2023 09:38:25 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621083825eusmtip22703050621435331ea1809e6ba0deb8c~qn8saRz8T3188231882eusmtip2T;
        Wed, 21 Jun 2023 08:38:25 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 09:38:24 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <hare@suse.de>, <willy@infradead.org>, <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 0/4] minimum folio order support in filemap
Date:   Wed, 21 Jun 2023 10:38:19 +0200
Message-ID: <20230621083823.1724337-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87qM2yelGHx5pGKx5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtigum5TUnMyy1CJ9uwSujJZpD9gKukUr5s3SbGDcKdjFyMEhIWAi8aNZrYuR
        k0NIYAWjxK35yV2MXED2F0aJw/t2MUE4nxklurt3s4FUgTR0znjIDNGxnFGi9b4LhA1UtP6U
        NETDFkaJrW/WsYBsYBPQkmjsZAepERFwkNi8cQ4rSA2zwB5GiQONn5hAEsIClhIz164Cs1kE
        VCV+PZ4DZvMKWEt8f7qPEeJSeYnFDyQgwoISJ2c+YQGxmYHCzVtnM0PcpiTRsPkMC4RdK7G3
        +QA7yC4JgSccEssf7mSFmOMicXtCAUSNsMSr41vYIWwZif875zNB2NUST2/8ZobobWGU6N+5
        ng2i11qi70wOiMksoCmxfpc+RLmjxNNt15ghKvgkbrwVhLiMT2LStulQYV6JjjYhiGo1idX3
        3rBMYFSeheSXWUh+mYUwfwEj8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAZHP63/FP
        Oxjnvvqod4iRiYPxEKMEB7OSCK/spkkpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmk
        J5akZqemFqQWwWSZODilGpi4LLcYtjFOPG7x97V1hovF5vgQ3RdL/tZcmOBWnbPJYrGnqM7U
        HN3KUFavzrtca+OlpfztltY41W5OWVWm1zArhvfb017GlvY72VNkVJ3udX07aXeDY2Na/80v
        y8+rdTNpLjisdngNt+5NNh0hg5wjJUVe5qxBl/Xtf+SJsm6x0wr82yAm03Uu0zQtZKfh42km
        bef6KvZdWHbj9Zvl+TwGxo+K/MNyVm6cadzMqqT0wVTLVLdXY8U89XU7jI7cCDilHL099wZn
        0fY/D+zqOLTWL/PbnVUeGHlYWcUkwN3z899LvmZyhrore++9+Leg2vSiT9PbKZ+3L2vmr+hd
        4incJqqxaD3T58UsMyVslViKMxINtZiLihMBZ9GixqUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7qM2yelGCy6xGWx5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jJZpD9gKukUr5s3SbGDcKdjFyMkhIWAi0TnjIXMXIxeHkMBSRomddw4zQiRkJDZ+
        ucoKYQtL/LnWxQZR9JFR4tKls1DOFkaJyU9+M3UxcnCwCWhJNHaygzSICDhIbN44hxWkhllg
        D6PEgcZPTCAJYQFLiZlrV4HZLAKqEr8ezwGzeQWsJb4/3ccIMkdCQF5i8QMJEJNZQFNi/S59
        iApBiZMzn7CA2MxAFc1bZzND3KYk0bD5DAuEXSvR+eo02wRGoVkI3bOQdM9C0r2AkXkVo0hq
        aXFuem6xkV5xYm5xaV66XnJ+7iZGYJRtO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMIru2lSihBv
        SmJlVWpRfnxRaU5q8SFGU6BnJjJLiSbnA+M8ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2x
        JDU7NbUgtQimj4mDU6qBSeOY2KOk29wdTCwSdsIaD88GJRx6mpm1eVXi4oTsycwbs2ofGl3f
        3akd8Txra/csluB/jsUJvxW/vzhpu/T/cu+5jy9e2bdx3xMXQ8e3EQ3z2pgW7oiYvq7+8pkZ
        PTdD5m57rd3SVKZ1unGX8ssFtmkMXhc//1dZOPnT3096Xm2dc3k1V2Rcfqf4yn1tjz1v6P6j
        09ZZPVso8t/hhfXNeYuzNI8WBbsdzHP7pWsX/Ejj1s6eVLPqTS9PeHGFeepdt1/tuvtXfQNf
        0NQE/5j40601L/7sP+K44OuL/2wiSQrMTy8svnNkUmUC0+5/ykbKTzhenvq7aSM/z4v7uycf
        kL1v3Hr3vP9yk/1S1zXfnLqkxFKckWioxVxUnAgAppSQgzsDAAA=
X-CMS-MailID: 20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a
References: <CGME20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There has been a lot of discussion recently to support devices and fs for
bs > ps. One of the main plumbing to support buffered IO is to have a minimum
order while allocating folios in the page cache.

Hannes sent recently a series[1] where he deduces the minimum folio
order based on the i_blkbits in struct inode. This takes a different
approach based on the discussion in that thread where the minimum and
maximum folio order can be set individually per inode.

This series is based on top of Christoph's patches to have iomap aops
for the block cache[2]. I rebased his remaining patches to
next-20230621. The whole tree can be found here[3].

Compiling the tree with CONFIG_BUFFER_HEAD=n, I am able to do a buffered
IO on a nvme drive with bs>ps in QEMU without any issues:

[root@archlinux ~]# cat /sys/block/nvme0n2/queue/logical_block_size
16384
[root@archlinux ~]# fio -bs=16k -iodepth=8 -rw=write -ioengine=io_uring -size=500M
		    -name=io_uring_1 -filename=/dev/nvme0n2 -verify=md5
io_uring_1: (g=0): rw=write, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=io_uring, iodepth=8
fio-3.34
Starting 1 process
Jobs: 1 (f=1): [V(1)][100.0%][r=336MiB/s][r=21.5k IOPS][eta 00m:00s]
io_uring_1: (groupid=0, jobs=1): err= 0: pid=285: Wed Jun 21 07:58:29 2023
  read: IOPS=27.3k, BW=426MiB/s (447MB/s)(500MiB/1174msec)
  <snip>
Run status group 0 (all jobs):
   READ: bw=426MiB/s (447MB/s), 426MiB/s-426MiB/s (447MB/s-447MB/s), io=500MiB (524MB), run=1174-1174msec
  WRITE: bw=198MiB/s (207MB/s), 198MiB/s-198MiB/s (207MB/s-207MB/s), io=500MiB (524MB), run=2527-2527msec

Disk stats (read/write):
  nvme0n2: ios=35614/4297, merge=0/0, ticks=11283/1441, in_queue=12725, util=96.27%

One of the main dependency to work on a block device with bs>ps is
Christoph's work on converting block device aops to use iomap.

[1] https://lwn.net/Articles/934651/
[2] https://lwn.net/ml/linux-kernel/20230424054926.26927-1-hch@lst.de/
[3] https://github.com/Panky-codes/linux/tree/next-20230523-filemap-order-generic-v1

Luis Chamberlain (1):
  block: set mapping order for the block cache in set_init_blocksize

Matthew Wilcox (Oracle) (1):
  fs: Allow fine-grained control of folio sizes

Pankaj Raghav (2):
  filemap: use minimum order while allocating folios
  nvme: enable logical block size > PAGE_SIZE

 block/bdev.c             |  9 ++++++++
 drivers/nvme/host/core.c |  2 +-
 include/linux/pagemap.h  | 46 ++++++++++++++++++++++++++++++++++++----
 mm/filemap.c             |  9 +++++---
 mm/readahead.c           | 34 ++++++++++++++++++++---------
 5 files changed, 82 insertions(+), 18 deletions(-)

-- 
2.39.2

