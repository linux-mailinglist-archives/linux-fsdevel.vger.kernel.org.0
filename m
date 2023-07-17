Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F367756216
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 13:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGQLwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 07:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQLwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72325A6
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 04:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9AE61024
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 11:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E02C433C8;
        Mon, 17 Jul 2023 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689594757;
        bh=E8Rh0neNu7io2oM8L8reTqLstY9Jmi1bawVs92HmbKs=;
        h=From:To:Cc:Subject:Date:From;
        b=W6tB5o6mu21ndL7u0S3arqg7fKw/KfCWLcZ5gvytulzp1r8C/oC7b1YceYiYVt14y
         b/ejbV2cn+q6pzCJAFyIeqSWBeUQIcqmUTwAXX9aimMfOq6AT1QrmAd5XMMl2PxGc1
         nwYPzQqXppn1GrxLNhxSsSn+hdYCekesbP0fuSoQrJw7JN3KVnpSZrWQZ787R6/WFm
         HZX/yTdyJ8PmL7lOQDoRe3A/3dbQIm7LMaxcTPLlCjumZx4o0vn2VzX2u6HyV2QH4I
         htgh6Xqoz6fQgJ+8MknVuC+0S69fa9yCeyhL+brRIcWS1wqk+R0Ddq4ukB2IECHsmU
         nW9m/5t4scK6Q==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        brauner@kernel.org, mcgrof@kernel.org
Subject: [PATCH V5 0/6] shmem: Add user and group quota support for tmpfs
Date:   Mon, 17 Jul 2023 13:52:07 +0200
Message-Id: <20230717115212.208651-1-cem@kernel.org>
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

This updates the previous series, to improve error handling of
tmpfs quota options.

This new version changes only patch 5/6 "shmem: quota support", and it only adds
a conditional if fc->user_ns != &init_user_ns, so there isn't much logic change
on the overall patch.

This has also been sync'ed to today Linus's TOT, and they should apply cleanly on
top of that.

Honza, the overall logic isn't changed, but since there's new code in here, I opted
to remove your RwB from this patch, would you be so kind to RwB it again?

Christian, could you please also review this?

As before, details are within each patch.

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
 mm/shmem.c                          | 465 +++++++++++++++++++++-------
 mm/shmem_quota.c                    | 350 +++++++++++++++++++++
 8 files changed, 783 insertions(+), 108 deletions(-)
 create mode 100644 mm/shmem_quota.c

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
-- 
2.30.2
