Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA22761C18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGYOpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjGYOpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ED512D
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 07:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618E061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 14:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A596C433C7;
        Tue, 25 Jul 2023 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690296316;
        bh=2C4Du4OdzYuMUJ6Ft6P3cA/szNhsyOJ2t3MD6dK4yRw=;
        h=From:To:Cc:Subject:Date:From;
        b=XHIQ1q9w1O4LQd/fEACIZxKGUMskgVYeVEywu0szY4qRL8GrjqdQkbOV+Ob5o4Js/
         nnxbCgyV24cXsdCVd6FVC0+THjVLPM1ylVoF5yCUS/JFCngnFKHlCdYXSd6RvKwYz7
         Dxr+IZAPPLWleVG8qZyZv2t2N/I6MibNrcUVgb3oB58fQiOjmmU66V+T97NW5Vs5GE
         Jb43KcSpfeX8KRqNyf1N1PLGS+MjgIXOuCTl8ttq95nQcKpeLBCvD0ENduyemcbIQF
         dF+ufGEHhRU+3Ir53n2QmqWGTZeyPvmOdrOJ9zzJZukrkqwP+LpKLYWRIVW+K31qh8
         A88YXw/mJP2YQ==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        brauner@kernel.org, mcgrof@kernel.org
Subject: [PATCH V6 0/7] shmem: Add user and group quota support for tmpfs
Date:   Tue, 25 Jul 2023 16:45:03 +0200
Message-Id: <20230725144510.253763-1-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Carlos Maiolino <cem@kernel.org>

Hello folks.

This is a new version of the implementation of tmpfs quota, below is the serie's
changelog, hopefully it make it easier to track down changes done on the past 3
versions.

I've rebased this series on Linus today's TOT, hopefully it prevents conflicts.

I also removed Jan Kara's RwB from patch 4, due to changes in functions
definition.

Changelog:

V6:
	- Fix build warning (patch 4) by defining shmem_mark_dquot_dirty() and
	  shmem_dquot_write_info() as static functions
	- Add a patch to fix syzkaller's reports.
		Once Patch 7 is applied, I didn't manage to reproduce the
		syzkaller issues anymore, so, added a Tested-by: tag
V5:
	- Update shmem_parse_one() to prevent quota enablement in unprivileged mounts.
V4:
	- Rebase to fix conflicts against 'noswap' mount option.


Original cover below.

people have been asking for quota support in tmpfs many times in the past
mostly to avoid one malicious user, or misbehaving user/program to consume
all of the system memory. This has been partially solved with the size
mount option, but some problems still prevail.

One of the problems is the fact that /dev/shm is still generally unprotected
with this and another is administration overhead of managing multiple tmpfs
mounts and lack of more fine grained control.

Quota support can solve all these problems in a somewhat standard way
people are already familiar with from regular file systems. It can give us
more fine grained control over how much memory user/groups can consume.
Additionally it can also control number of inodes and with special quota
mount options introduced with a second patch we can set global limits
allowing us to replace the size mount option with quota entirely.

Currently the standard userspace quota tools (quota, xfs_quota) are only
using quotactl ioctl which is expecting a block device. I patched quota [1]
and xfs_quota [2] to use quotactl_fd in case we want to run the tools on
mount point directory to work nicely with tmpfs.

The implementation was tested on patched version of xfstests [3].

[1] https://github.com/lczerner/quota/tree/quotactl_fd_support
[2] https://github.com/lczerner/xfsprogs/tree/quotactl_fd_support
[3] https://github.com/lczerner/xfstests/tree/tmpfs_quota_support


Carlos Maiolino (3):
  shmem: make shmem_get_inode() return ERR_PTR instead of NULL
  shmem: prepare shmem quota infrastructure
  shmem: quota support

Hugh Dickins (1):
  shmem: fix quota lock nesting in huge hole handling

Jan Kara (1):
  quota: Check presence of quota operation structures instead of
    ->quota_read and ->quota_write callbacks

Lukas Czerner (2):
  shmem: make shmem_inode_acct_block() return error
  shmem: Add default quota limit mount options

 Documentation/filesystems/tmpfs.rst |  31 ++
 fs/Kconfig                          |  12 +
 fs/quota/dquot.c                    |   2 +-
 include/linux/shmem_fs.h            |  28 ++
 include/uapi/linux/quota.h          |   1 +
 mm/Makefile                         |   2 +-
 mm/huge_memory.c                    |   6 +-
 mm/khugepaged.c                     |  13 +-
 mm/shmem.c                          | 495 +++++++++++++++++++++-------
 mm/shmem_quota.c                    | 350 ++++++++++++++++++++
 10 files changed, 812 insertions(+), 128 deletions(-)
 create mode 100644 mm/shmem_quota.c

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

-- 
2.39.2
