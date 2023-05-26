Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F80711B3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjEZAci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEZAch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AF3194;
        Thu, 25 May 2023 17:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A061764B87;
        Fri, 26 May 2023 00:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDAFC433EF;
        Fri, 26 May 2023 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685061155;
        bh=OX97w2dF/1Cs+uzEbAUNcCiVBlPZIn1rAPDSr77h9E0=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=ddwFdw2qswG+r+bLpB4kD0XWZD4OhKyrPRy61OnJPR4haRBSOLnIaQh4y6AGR9eTV
         czfFvbQjbQZ7To6Zq2a3aOTrwSRpKX3X0Jpx/ODc0vNztQQSB22nmyOSJ0MxylwiJr
         2X6FaC4FtkpHwl94fX0One2kgsWBlxWH+eBqwlafTL3b3CRgyClVJyTxQt3/5g7/bY
         BmfmIxF5LxwWKscOZ/v7/zjasp+5esRbExu8UUtfc7wmXpE5hSZw8LW9P3Sx88l+z7
         ZVz+pl/xod8Th+eTvqpmoxihmcFzGeu1anle9cjkE8Cb3qy0g0YetUS7pf3kY8T3kF
         mMHoEZi2ZTHNw==
Date:   Thu, 25 May 2023 17:32:34 -0700
Subject: [PATCHSET v25.0 0/9] xfs: support in-memory btrees
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
In-Reply-To: <20230526000020.GJ11620@frogsfrogsfrogs>
References: <20230526000020.GJ11620@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Online repair of the reverse-mapping btrees presens some unique
challenges.  To construct a new reverse mapping btree, we must scan the
entire filesystem, but we cannot afford to quiesce the entire filesystem
for the potentially lengthy scan.

For rmap btrees, therefore, we relax our requirements of totally atomic
repairs.  Instead, repairs will scan all inodes, construct a new reverse
mapping dataset, format a new btree, and commit it before anyone trips
over the corruption.  This is exactly the same strategy as was used in
the quotacheck and nlink scanners.

Unfortunately, the xfarray cannot perform key-based lookups and is
therefore unsuitable for supporting live updates.  Luckily, we already a
data structure that maintains an indexed rmap recordset -- the existing
rmap btree code!  Hence we port the existing btree and buffer target
code to be able to create a btree using the xfile we developed earlier.
Live hooks keep the in-memory btree up to date for any resources that
have already been scanned.

This approach is not maximally memory efficient, but we can use the same
rmap code that we do everywhere else, which provides improved stability
without growing the code base even more.  Note that in-memory btree
blocks are always page sized.

This patchset modifies the kernel xfs buffer cache to be capable of
using a xfile (aka a shmem file) as a backing device.  It then augments
the btree code to support creating btree cursors with buffers that come
from a buftarg other than the data device (namely an xfile-backed
buftarg).  For the userspace xfs buffer cache, we instead use a memfd or
an O_TMPFILE file as a backing device.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=in-memory-btrees

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=in-memory-btrees
---
 fs/xfs/Kconfig                     |    8 
 fs/xfs/Makefile                    |    2 
 fs/xfs/libxfs/xfs_ag.c             |    6 
 fs/xfs/libxfs/xfs_ag.h             |    4 
 fs/xfs/libxfs/xfs_btree.c          |  173 ++++++--
 fs/xfs/libxfs/xfs_btree.h          |   17 +
 fs/xfs/libxfs/xfs_btree_mem.h      |  128 ++++++
 fs/xfs/libxfs/xfs_refcount_btree.c |    4 
 fs/xfs/libxfs/xfs_rmap_btree.c     |    4 
 fs/xfs/scrub/bitmap.c              |   28 +
 fs/xfs/scrub/bitmap.h              |    3 
 fs/xfs/scrub/scrub.c               |    5 
 fs/xfs/scrub/scrub.h               |    3 
 fs/xfs/scrub/trace.c               |   12 +
 fs/xfs/scrub/trace.h               |  110 +++++
 fs/xfs/scrub/xfbtree.c             |  816 ++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfbtree.h             |   57 +++
 fs/xfs/scrub/xfile.c               |  181 ++++++++
 fs/xfs/scrub/xfile.h               |   66 +++
 fs/xfs/xfs_aops.c                  |    5 
 fs/xfs/xfs_bmap_util.c             |    8 
 fs/xfs/xfs_buf.c                   |  198 +++++++--
 fs/xfs/xfs_buf.h                   |   83 ++++
 fs/xfs/xfs_buf_xfile.c             |   97 ++++
 fs/xfs/xfs_buf_xfile.h             |   20 +
 fs/xfs/xfs_discard.c               |    8 
 fs/xfs/xfs_file.c                  |    6 
 fs/xfs/xfs_health.c                |    3 
 fs/xfs/xfs_ioctl.c                 |    3 
 fs/xfs/xfs_iomap.c                 |    4 
 fs/xfs/xfs_log.c                   |    4 
 fs/xfs/xfs_log_cil.c               |    3 
 fs/xfs/xfs_log_recover.c           |    3 
 fs/xfs/xfs_mount.h                 |    3 
 fs/xfs/xfs_super.c                 |    4 
 fs/xfs/xfs_trace.c                 |    3 
 fs/xfs/xfs_trace.h                 |   85 ++++
 fs/xfs/xfs_trans.h                 |    1 
 fs/xfs/xfs_trans_buf.c             |   42 ++
 39 files changed, 2084 insertions(+), 126 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_btree_mem.h
 create mode 100644 fs/xfs/scrub/xfbtree.c
 create mode 100644 fs/xfs/scrub/xfbtree.h
 create mode 100644 fs/xfs/xfs_buf_xfile.c
 create mode 100644 fs/xfs/xfs_buf_xfile.h

