Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562EF6325CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 15:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKUOaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 09:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKUOaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:30:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12855C747
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669040960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+GqZOZ3Ge0gmFEUW/+k13x8e6CReeYjz07m3XvBDfBs=;
        b=gcO03OUs+pas7HK6cbPXJKxbZ5BouhdRflKE/eV5TV1i4F61+muUWvrlnryGh0p5EE/jRI
        kxdLDt/B/msd7pn5DjKvKJ0Ka+jsajFZykN3q1Sp6faaUbJEnsR1ezVvYuGTHGu/22sRSD
        FUN+KzCocmqLCrTn112sk9WqOryNH9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-lVT5P5mzNSKrEWyssnzScA-1; Mon, 21 Nov 2022 09:29:16 -0500
X-MC-Unique: lVT5P5mzNSKrEWyssnzScA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B0A6811E84;
        Mon, 21 Nov 2022 14:29:16 +0000 (UTC)
Received: from ovpn-193-186.brq.redhat.com (ovpn-193-186.brq.redhat.com [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 563162166B2E;
        Mon, 21 Nov 2022 14:29:15 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.com>, Eric Sandeen <sandeen@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH v2 0/3] [RFC] shmem: user and group quota support for tmpfs
Date:   Mon, 21 Nov 2022 15:28:51 +0100
Message-Id: <20221121142854.91109-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Changes in v2:
  - Instead of using quota format QFMT_VFS_V1 with all the complexities
    around writing/reading quota files, instroduce new in-memory only
    quota format (PATCH 1/3) and use that instead as suggested by
    Jan Kara.
  - Rename global quota limits mount options to something much more
    sensible as suggested by Darrick J. Wong.
  - Improve documentation.
  - Check if qlobal quota limits aren't too large.

-Lukas

[1] https://github.com/lczerner/quota/tree/quotactl_fd_support
[2] https://github.com/lczerner/xfsprogs/tree/quotactl_fd_support
[3] https://github.com/lczerner/xfstests/tree/tmpfs_quota_support







