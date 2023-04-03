Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1376D3F61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjDCIsU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjDCIsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:48:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC08682
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA4C3B815C3
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 08:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4152C433D2;
        Mon,  3 Apr 2023 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680511693;
        bh=WFpcu3jPpBE2YFKVZd2NuKIP5d21v3quSUR0d+rf6yU=;
        h=From:To:Cc:Subject:Date:From;
        b=mXZ7yyaVOVp7KOPzUUqJeiiHWQC8V25Hlhr9HKtDNhmEnkQ2KSQHlFzRRuTWJFL8g
         Ob1dVuZt5qWBIG0Q0CqjXld47rTcEg/u57m7ISrAqvFa2rMDYYWIrohftUHjExdzkq
         aCZZb/RTUaFOJXyg4pU3+839XTi3caY3l93GktdNYnjWBf2e/0zlTqrlEt+/q0CH57
         zx7bdsxeffEsd0tdHuiqkuvhJ9tJI+M094HrqaeLVG9RD4gmGqTBT6/UE3kTtQXEZM
         nBGk6I/zm7ZZkn5UemaQoYoS5DtU+c8zbjPA4in1kyJsHrRZORe+p84SOsekEfXo4i
         LMn6Y1vKAjJ8g==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 0/6] shmem: Add user and group quota support for tmpfs
Date:   Mon,  3 Apr 2023 10:47:53 +0200
Message-Id: <20230403084759.884681-1-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Carlos Maiolino <cmaiolino@redhat.com>

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


Jan Kara (1):
  quota: Check presence of quota operation structures instead of
    ->quota_read and ->quota_write callbacks

Lukas Czerner (5):
  shmem: make shmem_inode_acct_block() return error
  shmem: make shmem_get_inode() return ERR_PTR instead of NULL
  shmem: prepare shmem quota infrastructure
  shmem: quota support
  Add default quota limit mount options

 Documentation/filesystems/tmpfs.rst |  28 ++
 fs/Kconfig                          |  12 +
 fs/quota/dquot.c                    |   2 +-
 include/linux/shmem_fs.h            |  25 ++
 include/uapi/linux/quota.h          |   1 +
 mm/Makefile                         |   2 +-
 mm/shmem.c                          | 452 +++++++++++++++++++++-------
 mm/shmem_quota.c                    | 327 ++++++++++++++++++++
 8 files changed, 740 insertions(+), 109 deletions(-)
 create mode 100644 mm/shmem_quota.c

-- 
2.30.2

