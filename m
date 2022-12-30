Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077C4659DB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiL3XEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3XEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:04:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC815FC1;
        Fri, 30 Dec 2022 15:04:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46B9ACE193B;
        Fri, 30 Dec 2022 23:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CCAC433D2;
        Fri, 30 Dec 2022 23:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672441445;
        bh=4Ry4JXh+MBFlYtqLXTog1NCiskH3/pi/JIpj9bWV8Go=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LY5KhO3dZzDdu+SXby8wTnxc4J/vt/kKiHazDmCgcq9N+gl3qcGMyS08mDEkHbAAs
         AV6kAyi3coTJ9ut8fqvRnJyETF0/DNMBgcbV3DCbyVoBan1VfymeSGlBon96zMxelw
         +cwz1uJkzNzS4YuflvolGp/FCJp1GiuNMsBc8m4/9RDoPOeJJ8Aww8IhUvt03YTIai
         6UIm6IYsgnRPcU6ooMYzXMsvyXvfD5AwbmUOG5ftbXXxNvZuy22HStQ8RBHhROW4FA
         CsBwbVYeIOEaIxepG5KoNc+k0OMPHfqMUtdfuku7fl5yc82XNj4GZUY0ZfQuMwj9LL
         oRQmnGRe/XT9w==
Subject: [PATCHSET v24.0 0/7] xfs: support in-memory btrees
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:26 -0800
Message-ID: <167243840589.696535.4812770109109400531.stgit@magnolia>
In-Reply-To: <Y69Unb7KRM5awJoV@magnolia>
References: <Y69Unb7KRM5awJoV@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/xfs/Makefile                    |    1 
 fs/xfs/libxfs/xfs_btree.c          |  173 ++++++--
 fs/xfs/libxfs/xfs_btree.h          |   17 +
 fs/xfs/libxfs/xfs_btree_mem.h      |  128 ++++++
 fs/xfs/libxfs/xfs_refcount_btree.c |    4 
 fs/xfs/libxfs/xfs_rmap_btree.c     |    4 
 fs/xfs/scrub/bitmap.c              |   28 +
 fs/xfs/scrub/bitmap.h              |    3 
 fs/xfs/scrub/scrub.c               |    4 
 fs/xfs/scrub/scrub.h               |    3 
 fs/xfs/scrub/trace.c               |   13 +
 fs/xfs/scrub/trace.h               |  110 +++++
 fs/xfs/scrub/xfbtree.c             |  816 ++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfbtree.h             |   57 +++
 fs/xfs/scrub/xfile.c               |  181 ++++++++
 fs/xfs/scrub/xfile.h               |   65 +++
 fs/xfs/xfs_aops.c                  |    5 
 fs/xfs/xfs_bmap_util.c             |    8 
 fs/xfs/xfs_buf.c                   |  234 ++++++++--
 fs/xfs/xfs_buf.h                   |   90 ++++
 fs/xfs/xfs_discard.c               |    8 
 fs/xfs/xfs_file.c                  |    6 
 fs/xfs/xfs_health.c                |    3 
 fs/xfs/xfs_ioctl.c                 |    3 
 fs/xfs/xfs_iomap.c                 |    4 
 fs/xfs/xfs_log.c                   |    4 
 fs/xfs/xfs_log_cil.c               |    3 
 fs/xfs/xfs_log_recover.c           |    3 
 fs/xfs/xfs_super.c                 |    4 
 fs/xfs/xfs_trace.c                 |    3 
 fs/xfs/xfs_trace.h                 |   85 ++++
 fs/xfs/xfs_trans.h                 |    1 
 fs/xfs/xfs_trans_buf.c             |   42 ++
 34 files changed, 2011 insertions(+), 110 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_btree_mem.h
 create mode 100644 fs/xfs/scrub/xfbtree.c
 create mode 100644 fs/xfs/scrub/xfbtree.h

