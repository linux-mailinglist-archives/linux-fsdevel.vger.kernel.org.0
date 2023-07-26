Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB2763376
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjGZK0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjGZK0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:26:15 -0400
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C09211C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 03:26:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690367171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WsCnoMov9KDBT3PhGLWO6x2CSRgl6EOcF1M0mVnuJoA=;
        b=lcBUOokl1NEFQcA/qOXrUhWrnZOieB2pmdi7iWA+QZAlVRy5B4DaYBklnEkM1h0bSZ/LEB
        /fuKqviwZ8q5o1NI4wS83FD7gDb+5D1xQ+tMvb73Q5vOByFgrhRp7dynXXPI+Z52HiInvL
        h2XoljZyjo8CxsWNWMx1AtC+pAhjFCc=
From:   Hao Xu <hao.xu@linux.dev>
To:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>
Subject: [RFC 0/7] io_uring lseek
Date:   Wed, 26 Jul 2023 18:25:56 +0800
Message-Id: <20230726102603.155522-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

This series adds lseek for io_uring, the motivation to import this
syscall is in previous io_uring getdents patchset, we lack a way to
rewind the file cursor when it goes to the end of file. Another reason
is lseek is a common syscall, it's good for coding consistency when
users use io_uring as their main loop.

Patch 1 is code clean for iomap
Patch 2 adds IOMAP_NOWAIT logic for iomap lseek
Patch 3 adds a nowait parameter to for IOMAP_NOWAIT control
Patch 4 adds llseek_nowait() for file_operations so that specific
        filesystem can implement it for nowait lseek
Patch 5 adds llseek_nowait() implementation for xfs
Patch 6 adds a new vfs wrapper for io_uring use
Patch 7 is the main io_uring lseek implementation

Note, this series depends on the previous io_uring getdents series.

This is marked RFC since there is (at least) an issue to be discussed:
The work in this series is mainly to reslove a problem that the current
llseek() in struct file_operations doesn't have a place to deliver
nowait info, and adding an argument to it results in update for llseek
implementation of all filesystems (35 functions), so here I introduce
a new llseek_nowait() as a workaround.

For performance, it has about 20%~30% improvement on iops.
The test program is just like the one for io_uring getdents, here is the
link to it: https://github.com/HowHsu/liburing/blob/llseek/test/lseek.c
- Each test runs about 30000 async requests/sync syscalls
- Each test runs 100 times and get the average value.
- offset is randomly generated value
- the file is a 1M all zero file

[howeyxu@~]$ python3 run_lseek.py
test args:  seek mode:SEEK_SET, offset: 334772
Average of  sync :  0.012300650000000002
Average of  iouring :  0.008528009999999999
30.67%

[howeyxu@~]$ python3 run_lseek.py
test args:  seek mode:SEEK_CUR, offset: 389292
Average of  sync :  0.012736129999999995
Average of  iouring :  0.00928725
27.08%

[howeyxu@~]$ python3 run_lseek.py
test args:  seek mode:SEEK_END, offset: 281141
Average of  sync :  0.01221595
Average of  iouring :  0.008442890000000003
30.89%

[howeyxu@~]$ python3 run_lseek.py
test args:  seek mode:SEEK_DATA, offset: 931103
Average of  sync :  0.015496230000000005
Average of  iouring :  0.012341509999999998
20.36%

[howeyxu@~]$ python3 run_lseek.py
test args:  seek mode:SEEK_HOLE, offset: 430194
Average of  sync :  0.01555663000000001
Average of  iouring :  0.012064940000000003
22.45%
 

Hao Xu (7):
  iomap: merge iomap_seek_hole() and iomap_seek_data()
  xfs: add nowait support for xfs_seek_iomap_begin()
  add nowait parameter for iomap_seek()
  add llseek_nowait() for struct file_operations
  add llseek_nowait support for xfs
  add vfs_lseek_nowait()
  add lseek for io_uring

 fs/ext4/file.c                |  9 ++---
 fs/gfs2/inode.c               |  4 +--
 fs/iomap/seek.c               | 42 ++++++-----------------
 fs/read_write.c               | 18 ++++++++++
 fs/xfs/xfs_file.c             | 34 ++++++++++++++++---
 fs/xfs/xfs_iomap.c            |  4 ++-
 include/linux/fs.h            |  4 +++
 include/linux/iomap.h         |  6 ++--
 include/uapi/linux/io_uring.h |  1 +
 io_uring/fs.c                 | 63 +++++++++++++++++++++++++++++++++++
 io_uring/fs.h                 |  3 ++
 io_uring/opdef.c              |  8 +++++
 12 files changed, 145 insertions(+), 51 deletions(-)


base-commit: 4a4b046082eca8ae90b654d772fccc30e9f23f4d
-- 
2.25.1

