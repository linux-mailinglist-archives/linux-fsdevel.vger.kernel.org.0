Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2834B3C8B2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGNSuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhGNSuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:20 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9FC061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:28 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id m68so2619787qke.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rg6YI/g6xDW5I6Us7BLgeP9OjLg6NUXX4CFbZla+KfA=;
        b=XKpFQOZEYOFX+gVLhzM/qQtI+fWrwvZX9Lc0bvgEmJl+kLVZ4R4F1jo/5q3Fl15w58
         ozHOGR6h2Xg59CFoU28UoxM0veRYaLuHhnR3oPYFIPu6Q4MxEBvIv/fAXDvf7wat65ol
         ZmiykVCwhzRZtH0ZNSM5Z1FnO07Wj8rbZ5vqwidtbb5oG9fl/JZj8LOZF32iK8tr6aNj
         9KFZXFBO3iYf1yEBFDDtdESyN1v+fTJm+EJrJvreXDKemFViqrtbFuwNer8Br8HHjn+V
         wkeECFXXZC2jF3U9SG26bsHMrbxz4nY6/Gm1Q4OC2h22ueRk60FX+El7KLKfM2rIvp1b
         cJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rg6YI/g6xDW5I6Us7BLgeP9OjLg6NUXX4CFbZla+KfA=;
        b=TqT7bEWKiQGNdFOHwCm9B8kmKDY9vnvNtzoldXp4wT5bPYHAu5IzUfcK1lvE16xpn9
         1017Df97WOx34iyjgJCXyHroVFVys4rKCKsf5iViZ2XM2SkZBC4YSFJSPInf3gAK6jN8
         dqB+dVyTcn9lrpLd0LJ0I063sS21w7zXhm++YWTQHgG9LG+aFNqoU/LDHK7o4c5NLlK2
         sOIxJqXVRxvcBFauHAAKDY4jaA/87JwliXoHl/VpyG/ydm7QyFUJOJMf4VeHptzJ/3Zs
         Ykjdk26k8tbxx6oGmIq3pmXBct0hVAUBprJ10XElbiVYX+9xggkE3Y8S81P3TsBjgAHi
         0w8w==
X-Gm-Message-State: AOAM531WF0jNmG8o5/mUAvTZalY+SZn8sTjfIYLK7IRtDoHOT6DvRgiI
        bQdnpObReB6NK0ExWplWm8L0jQ==
X-Google-Smtp-Source: ABdhPJwTmJNoPUMBgpmU1HGFOqWofrT0qLWTVuUsBKMZEfZiUunwMYBG8Yomk5EfKZo3bo/8Pgvlog==
X-Received: by 2002:a37:9a0a:: with SMTP id c10mr9046929qke.86.1626288447214;
        Wed, 14 Jul 2021 11:47:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i2sm1412356qko.43.2021.07.14.11.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/9] ENOSPC delalloc flushing fixes
Date:   Wed, 14 Jul 2021 14:47:16 -0400
Message-Id: <cover.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2->v3:
- Reordered the patches to have "btrfs: wake up async_delalloc_pages waiters
  after submit" come first, as it's a general fix that we need.
- Fixed the nit that Nikolay pointed out in "btrfs: handle shrink_delalloc pages
  calculation differently".
- Added "btrfs: include delalloc related info in dump space info tracepoint" to
  include the delalloc_bytes and ordered_bytes in the dump_space_info
  tracepoint.

v1->v2:
- Two extra patches to remove the last user of sync_inode() (p9fs) and then
  remove sync_inode() itself, as per hch's request

--- Original email ---

Hello,

I've been debugging and fixing a problem we hit in production related to getting
ENOSPC when we still should have had space to use.  A variety of different
things were going wrong, but one of them was sometimes we wouldn't wait for all
of delalloc to be flushed.  This series of patches fixes a few problems in this
area, starting with

  btrfs: handle shrink_delalloc pages calculation differently

When we switched to writing pages instead of full inodes for flushing we didn't
adjust the counters to give us pages, instead using the "items" amount.  This is
incorrect as we'd just not flush that much delalloc, leaving a lot laying around
when we finally ENOSPC'd.

The next bit are related to compression, as we have compression on everywhere in
production.

  btrfs: wait on async extents when flushing delalloc
  btrfs: wake up async_delalloc_pages waiters after submit

I ripped this code out because I added a second sync_inode() if we had async
extents in order to do the proper waiting.  However sync_inode() could skip
writeout if writeout had begun already on the inode, so we still need this
waiting in order to make sure we don't try to wait on ordered extents until all
ordered extents have been created.

And finally these two patches

  fs: add a filemap_fdatawrite_wbc helper
  btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking

We need a writeback helper that will take a wbc and not try to do anything fancy
other than write out the inode we want.  sync_inode() has the drawback that it
will skip writeout if the inode is currently under writeback, and thus we won't
wait properly.

I ran this series through fsperf, the results ar eposted below.  I'm still
printing the %diff, but I'm also printing the stdev so you can see the variance
in teh values we expect.  Generally there is no change or it's within the normal
range.  These patches really only affect anything when we're very full on space.

I also ran this through the enospc stress test and saw no early enospc.  Thanks,

Josef

dbench60 results
  metric     baseline   current     stdev           diff
==============================================================
qpathinfo       11.26      11.87       0.64     5.35%
throughput     652.90     628.99      65.68    -3.66%
flush        22292.41   35005.49   15197.94    57.03%
qfileinfo        1.04       1.24       0.17    19.02%
ntcreatex     3965.31    6167.38    7790.74    55.53%
qfsinfo          1.79       1.41       0.40   -20.88%
close            1.81       1.95       0.39     7.67%
sfileinfo        4.96       5.50       1.13    10.70%
rename        2640.98    5844.86    5873.86   121.31%
find            12.29      12.83       1.00     4.36%
unlink        3310.42    4809.88    7179.77    45.30%
writex       12521.22   37992.79    7567.72   203.43%
deltree        409.86     363.46     224.63   -11.32%
readx            2.37       4.18       0.66    76.01%
mkdir            0.03       0.11       0.01   271.06%
lockx            0.44       0.17       0.27   -61.83%
unlockx          0.16       0.64       0.11   291.70%

emptyfiles500k results
     metric         baseline   current      stdev           diff
======================================================================
write_io_kbytes       125000     125000            0    0.00%
read_clat_ns_p99           0          0            0    0.00%
write_bw_bytes      1.83e+08   1.77e+08   5516543.33   -3.19%
read_iops                  0          0            0    0.00%
write_clat_ns_p50      17536      17792       273.68    1.46%
read_io_kbytes             0          0            0    0.00%
read_io_bytes              0          0            0    0.00%
write_clat_ns_p99      72576      74240      2677.97    2.29%
read_bw_bytes              0          0            0    0.00%
elapsed                    1          1            0    0.00%
write_lat_ns_min           0          0            0    0.00%
sys_cpu                91.86      91.29         0.66   -0.63%
write_lat_ns_max           0          0            0    0.00%
read_lat_ns_min            0          0            0    0.00%
write_iops          44583.10   43162.98      1346.81   -3.19%
read_lat_ns_max            0          0            0    0.00%
read_clat_ns_p50           0          0            0    0.00%

smallfiles100k results
     metric         baseline   current       stdev            diff
========================================================================
write_io_kbytes     2.04e+08   2.04e+08             0     0.00%
read_clat_ns_p99           0          0             0     0.00%
write_bw_bytes      1.33e+08   1.40e+08   15033768.39     5.20%
read_iops                  0          0             0     0.00%
write_clat_ns_p50       6424       6688         79.77     4.11%
read_io_kbytes             0          0             0     0.00%
read_io_bytes              0          0             0     0.00%
write_clat_ns_p99      15960      16320        251.24     2.26%
read_bw_bytes              0          0             0     0.00%
elapsed              1592.50       1492        234.98    -6.31%
write_lat_ns_min     2730.75       2768         45.73     1.36%
sys_cpu                 5.75       6.25          0.65     8.68%
write_lat_ns_max    5.17e+08   1.52e+08      1.05e+09   -70.54%
read_lat_ns_min            0          0             0     0.00%
write_iops          32545.54   34239.34       3670.35     5.20%
read_lat_ns_max            0          0             0     0.00%
read_clat_ns_p50           0          0             0     0.00%

bufferedrandwrite16g results
     metric          baseline     current       stdev            diff
===========================================================================
write_io_kbytes        16777216   16777216             0     0.00%
read_clat_ns_p99              0          0             0     0.00%
write_bw_bytes      91729211.62   94071836   13859731.84     2.55%
read_iops                     0          0             0     0.00%
write_clat_ns_p50         12704      11840       1227.26    -6.80%
read_io_kbytes                0          0             0     0.00%
read_io_bytes                 0          0             0     0.00%
write_clat_ns_p99         31136      32384       2925.86     4.01%
read_bw_bytes                 0          0             0     0.00%
elapsed                  191.38        183         25.98    -4.38%
write_lat_ns_min        3961.25       4068         95.29     2.69%
sys_cpu                   31.83      29.77          6.85    -6.47%
write_lat_ns_max       3.05e+10   1.70e+10      1.95e+10   -44.34%
read_lat_ns_min               0          0             0     0.00%
write_iops             22394.83   22966.76       3383.72     2.55%
read_lat_ns_max               0          0             0     0.00%
read_clat_ns_p50              0          0             0     0.00%

dio4kbs16threads results
     metric          baseline     current       stdev            diff
===========================================================================
write_io_kbytes         4187092    4949612     599817.04    18.21%
read_clat_ns_p99              0          0             0     0.00%
write_bw_bytes      71448568.62   84467746   10233293.68    18.22%
read_iops                     0          0             0     0.00%
write_clat_ns_p50        245504     240640       4370.25    -1.98%
read_io_kbytes                0          0             0     0.00%
read_io_bytes                 0          0             0     0.00%
write_clat_ns_p99      22249472   20054016    1120427.41    -9.87%
read_bw_bytes                 0          0             0     0.00%
elapsed                      61         61             0     0.00%
write_lat_ns_min          38440      38571        225.10     0.34%
sys_cpu                    3.89       4.57          0.46    17.47%
write_lat_ns_max       1.23e+09   9.48e+08      7.00e+08   -23.22%
read_lat_ns_min               0          0             0     0.00%
write_iops             17443.50   20622.01       2498.36    18.22%
read_lat_ns_max               0          0             0     0.00%
read_clat_ns_p50              0          0             0     0.00%

randwrite2xram results
     metric         baseline   current       stdev            diff
========================================================================
write_io_kbytes     33948247   34359528    4793805.63     1.21%
read_clat_ns_p99           0          0             0     0.00%
write_bw_bytes      1.15e+08   1.17e+08   17455355.14     1.47%
read_iops                  0          0             0     0.00%
write_clat_ns_p50      15232      14400       1043.81    -5.46%
read_io_kbytes             0          0             0     0.00%
read_io_bytes              0          0             0     0.00%
write_clat_ns_p99      95264      67072      25379.05   -29.59%
read_bw_bytes              0          0             0     0.00%
elapsed               313.62        314          5.10     0.12%
write_lat_ns_min     5399.38       5658        126.19     4.79%
sys_cpu                11.61      11.06          2.04    -4.69%
write_lat_ns_max    3.16e+10   2.91e+10      1.46e+10    -8.05%
read_lat_ns_min            0          0             0     0.00%
write_iops          28099.86   28511.67       4261.56     1.47%
read_lat_ns_max            0          0             0     0.00%
read_clat_ns_p50           0          0             0     0.00%

untarfirefox results
metric    baseline   current   stdev        diff
======================================================
elapsed      46.89     46.75    0.18   -0.29%

Josef Bacik (9):
  btrfs: wake up async_delalloc_pages waiters after submit
  btrfs: include delalloc related info in dump space info tracepoint
  btrfs: enable a tracepoint when we fail tickets
  btrfs: handle shrink_delalloc pages calculation differently
  btrfs: wait on async extents when flushing delalloc
  fs: add a filemap_fdatawrite_wbc helper
  btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
  9p: migrate from sync_inode to filemap_fdatawrite_wbc
  fs: kill sync_inode

 fs/9p/vfs_file.c             |  7 +--
 fs/btrfs/ctree.h             |  9 ++--
 fs/btrfs/inode.c             | 16 +++----
 fs/btrfs/space-info.c        | 82 ++++++++++++++++++++++++++++++------
 fs/fs-writeback.c            | 19 +--------
 include/linux/fs.h           |  3 +-
 include/trace/events/btrfs.h | 21 +++++++--
 mm/filemap.c                 | 35 +++++++++++----
 8 files changed, 128 insertions(+), 64 deletions(-)

-- 
2.26.3

