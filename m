Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777EF6A329B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBZQDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBZQDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:03:32 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE6BF746;
        Sun, 26 Feb 2023 08:03:19 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 99D5E8319A;
        Sun, 26 Feb 2023 16:03:13 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677427398;
        bh=wfVxdCU0WiYOKtzPo+vOA/+kkGOosWbPqZrRb2tJROM=;
        h=From:To:Cc:Subject:Date:From;
        b=Cbwp9hG1ztLu//tbm0WTi431HwgTqf/o6Ow6TTH8vqx4fqBSXmIB2kIZZUPjAgabw
         ETlx2MqhF+NzRe5c8bb7KfXKbL8522tCQdYTzzjbMhGpZXdCmy0yzsL3QDvfMpQFbf
         LRYLl2SrLHb9hldByAo0hFw0yc8k9oq5GPWsFxFyAcs8PVDwF6YO8Of49NVShJtr15
         MX8He954Co/SrT29kA0TVceGBZ9A+A1iPsg04NnEvBQbZMHE/bKmkafFxJM71fFjf/
         87buMqh/YyudR1WduVho1V7Jb21UQAhSZ2eQ3TWies9fOi/J9flnTRrz4ODQh+kH1A
         AHmkD8Y2Iw3aQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for btrfs
Date:   Sun, 26 Feb 2023 23:02:53 +0700
Message-Id: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is an RFC patchset that introduces the `wq_cpu_set` mount option.
This option lets the user specify a CPU set that the Btrfs workqueues
will use.

Btrfs workqueues can slow sensitive user tasks down because they can use
any online CPU to perform heavy workloads on an SMP system. Add a mount
option to isolate the Btrfs workqueues to a set of CPUs. It is helpful
to avoid sensitive user tasks being preempted by Btrfs heavy workqueues.

This option is similar to the taskset bitmask except that the comma
separator is replaced with a dot. The reason for this is that the mount
option parser uses commas to separate mount options.

Figure (the CPU usage when `wq_cpu_set` is used VS when it is not):
https://gist.githubusercontent.com/ammarfaizi2/a10f8073e58d1712c1ed49af83ae4ad1/raw/a4f7cbc4eb163db792a669d570ff542495e8c704/wq_cpu_set.png

A simple stress testing:

1. Open htop.
2. Open a new terminal.
3. Mount and perform a heavy workload on the mounted Btrfs filesystem.

## Test without wq_cpu_set
sudo mount -t btrfs -o rw,compress-force=zstd:15,commit=1500 /dev/sda2 hdd/a;
cp -rf /path/folder_with_many_large_files/ hdd/a/test;
sync; # See the CPU usage in htop.
sudo umount hdd/a;

## Test wq_cpu_set
sudo mount -t btrfs -o rw,compress-force=zstd:15,commit=1500,wq_cpu_set=0.4.1.5 /dev/sda2 hdd/a;
cp -rf /path/folder_with_many_large_files/ hdd/a/test;
sync; # See the CPU usage in htop.
sudo umount hdd/a;

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (6):
  workqueue: Add set_workqueue_cpumask() helper function
  btrfs: Change `mount_opt` type in `struct btrfs_fs_info` to `u64`
  btrfs: Create btrfs CPU set struct and helpers
  btrfs: Add wq_cpu_set=%s mount option
  btrfs: Adjust the default thread pool size when `wq_cpu_set` option is used
  btrfs: Add `BTRFS_DEFAULT_MAX_THREAD_POOL_SIZE` macro

 fs/btrfs/async-thread.c   | 51 ++++++++++++++++++++
 fs/btrfs/async-thread.h   |  3 ++
 fs/btrfs/disk-io.c        |  6 ++-
 fs/btrfs/fs.c             | 97 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fs.h             | 12 ++++-
 fs/btrfs/super.c          | 83 +++++++++++++++++++++++++++++++++
 include/linux/workqueue.h |  3 ++
 kernel/workqueue.c        | 19 ++++++++
 8 files changed, 271 insertions(+), 3 deletions(-)


base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
-- 
Ammar Faizi

