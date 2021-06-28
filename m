Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737473B661F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 17:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhF1PyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 11:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbhF1Pxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:53:50 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93A9C061A31
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 08:37:13 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bj15so27783050qkb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+VsOP7A2mVCSObCNhCG4Kw3159bOWBhT/FDqlhrCBc=;
        b=s1EnxRSr4H8hFM/iHD/CDde+QdTt+GIsBwe9sCsR17F6ugHYoBiwVokNq8nCARjNdT
         je5scP/EVeml0mXFQXxE5+MH3OP84A+R38MDy3w3Lf2eTKFZoKqBWny9OiHcanoOdLWW
         z4srXSB0j7GV/KCnAdMUOFW6HpeIpcbdWORBToXGyW9AKV6oFQd5ZlSHdV/pvi1XKpDL
         mV6AG5YCVIf5gXGGIspz0th1dtIY2Qd5ruz8/ZDKGWFpfM5tWl2suYG7rk3RKS9egMaL
         MATWTwqhsIz3Qx0+qs7to8hTb8hywEb/01fJ9fnthmsnGsW1mkhoMWD24veMlBjFHqzT
         +7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+VsOP7A2mVCSObCNhCG4Kw3159bOWBhT/FDqlhrCBc=;
        b=oeqHH1rOnqLt4T8/q0TjTf1es5SIHy//m66YvipBcqp2RC6IsqtXRaNDlibXCzpehy
         ezgvrYGNVolIP6WPBKf8f5LwX+shnUHgs1lSRwzknTVAGnDgsGCh7hGcaNbG/Ze9wLWH
         DH+Td9vrv1i2F/UzRyzz9FKjuRHqI0Uq1dyQ7OGlYzivWr9toYbS3uTvYiLEBxPY2ih3
         RQSw4UsOGUp6BsOjuAI0ls6ENWUmC5YW8cglye2QuiKiFwaVay3RhrVm08hhbJlwJkj9
         cw8lSaGONz/Li601Y1qAq3/NhhNSVjkJJ5qlhq42uo0FOoBypc1GnmXe+6bSqhBd7opN
         YAnw==
X-Gm-Message-State: AOAM531xO7nvvE+KBYM4ovHqvPeUISiLsrG+LQQizeb8KsieIw7pFWnh
        jpzSXiQSWPExPiKqlBIay39Mu757CEFAQg==
X-Google-Smtp-Source: ABdhPJxcir3QpHwISHPAcL1xOwKh4WLF09typVCzvOSoOHFQBGpuIEW1LUYoXqn0d2+s6Vq66IHH8w==
X-Received: by 2002:a37:6854:: with SMTP id d81mr6509296qkc.343.1624894632906;
        Mon, 28 Jun 2021 08:37:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d20sm8210563qtw.92.2021.06.28.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 08:37:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/6] ENOSPC delalloc flushing fixes
Date:   Mon, 28 Jun 2021 11:37:05 -0400
Message-Id: <cover.1624894102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Josef Bacik (6):
  btrfs: enable a tracepoint when we fail tickets
  btrfs: handle shrink_delalloc pages calculation differently
  btrfs: wait on async extents when flushing delalloc
  btrfs: wake up async_delalloc_pages waiters after submit
  fs: add a filemap_fdatawrite_wbc helper
  btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking

 fs/btrfs/ctree.h             |  9 +++--
 fs/btrfs/inode.c             | 16 +++-----
 fs/btrfs/space-info.c        | 77 +++++++++++++++++++++++++++++++-----
 include/linux/fs.h           |  2 +
 include/trace/events/btrfs.h |  7 ++++
 mm/filemap.c                 | 35 +++++++++++-----
 6 files changed, 114 insertions(+), 32 deletions(-)

-- 
2.26.3

