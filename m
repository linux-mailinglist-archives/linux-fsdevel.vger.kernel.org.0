Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142E06E8C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjDTIEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjDTIEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2613E
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 01:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2094F60DFC
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 08:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E154C433D2;
        Thu, 20 Apr 2023 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681977844;
        bh=XeWdmkyc9D5aTf3bX5LVoYzWJtaddA3mhOd1N60Bjdo=;
        h=From:To:Cc:Subject:Date:From;
        b=erTaHao8Evg4+ims2BPdPuBoczHPfOSr124yKoqYMiClw2jEbMJaqW2B3TN+IzxES
         cfE/o0AAehouLcJXwa+jp7Fwxt2ZxAiKZc7DpGgvHBYBG9ELxNhCoPYLkUgX2+HOIj
         mkg+o1v0jWtfSLD/EoHXkn4urHp5CW5U+mbn+153ZeTsYTgujmbQdiW4ZW+EC6eU3i
         g9+RpV+Xe1ebOUvUH41V86psVgfYpq0GaFpXPB78sX93+Ej8CKy/b/VxC6hLSyci+g
         co0TURTjrs0sH1a/3EUTbKIaJMyoMOmeNeNemOWmgdw9iRgrnKE90/ygiCJwv2Cyke
         27OGuN5oFdGHg==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH V2 0/6] shmem: Add user and group quota support for tmpfs
Date:   Thu, 20 Apr 2023 10:03:53 +0200
Message-Id: <20230420080359.2551150-1-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Carlos Maiolino <cmaiolino@dhat.com>

Hello folks.

This is the version 2 of the quota support from tmpfs addressing some issues
discussed on V1 and a few extra things, details are within each patch. Original
cover-letter below.

Hi folks. this work has been done originally by Lukas, but he left the company,
so I'm taking over his work from where he left it of. This series is virtually
done, and he had updated it with comments from the last version, but, I'm
initially posting it as a RFC because it's been a while since he posted the
last version.
Most of what I did here was rebase his last work on top of current Linus's tree.

Honza, there is one patch from you in this series, which I believe you had it
suggested to Lukas on a previous version.

The original cover-letter follows...

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

Jan Kara (1):
  quota: Check presence of quota operation structures instead of
    ->quota_read and ->quota_write callbacks

Lukas Czerner (5):
  shmem: make shmem_inode_acct_block() return error
  shmem: make shmem_get_inode() return ERR_PTR instead of NULL
  shmem: prepare shmem quota infrastructure
  shmem: quota support
  Add default quota limit mount options

 Documentation/filesystems/tmpfs.rst |  31 ++
 fs/Kconfig                          |  12 +
 fs/quota/dquot.c                    |   2 +-
 include/linux/shmem_fs.h            |  28 ++
 include/uapi/linux/quota.h          |   1 +
 mm/Makefile                         |   2 +-
 mm/shmem.c                          | 473 +++++++++++++++++++++-------
 mm/shmem_quota.c                    | 327 +++++++++++++++++++
 8 files changed, 768 insertions(+), 108 deletions(-)
 create mode 100644 mm/shmem_quota.c

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

-- 
2.30.2

