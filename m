Return-Path: <linux-fsdevel+bounces-32309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9C9A35B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27451F22D62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A6188901;
	Fri, 18 Oct 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tpoeo2l6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ADC185B54;
	Fri, 18 Oct 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233664; cv=none; b=D4/nyY0JC/RMuxVkgHEBnZd9cOzDmVrX1mmgj172lnylSdO40mZifwNbW/tPVp1P/HNcvx7dHJIwUOkN/gsD+Strw/FftjyhHq4Suttr7rm/9PndTimJJBSaz12Zb6G6vQQWQ2il5Iwb4rlsQpw3M3fO7l7Wh3qTqdyDWCxmsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233664; c=relaxed/simple;
	bh=SnQFoT2demFuoVOQR3h9+M/hryMmXEj3QJ9+DnUr3Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bClScqZCBFNSamQYprOeiPDjDxp2WqJku3bf0PmJlz+/UJtORG3cWCZT7YTSJH7PCloo0bX1AsGe9z74M644xwsD5mzTIFISMv4q9UMTCJGrCyb4vnp2UBwT4ozIoYJoH/Fan2rGsWhvTD2XOJDq1x0uzdi+V/QsTCuu5aEi0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tpoeo2l6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233663; x=1760769663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SnQFoT2demFuoVOQR3h9+M/hryMmXEj3QJ9+DnUr3Gw=;
  b=Tpoeo2l6YJHJ0PdmN2tQdupSdZeFpoO+1Gp+XVnoYDp73JhdFkavxFu0
   R8MAHcZ2PwR32Nni5E50F8FiczlycoGtZbyvG+qKOdFOfrEvKabDMZnld
   lLOh+BmT92eagIUBJqVqipSFCmCC5ZOQo/bMB/HcUMBU1MZMdufXUfdE4
   SXvSsfoQpv1fNJ47/F+ogUpETBg+UQ2ir1gQAzETikOFBD0wL7Q1WykDE
   emN6/bNDcb/gB/LMrzwYz01yhRF+58sNFAc4vSUZdNR1hGerjgs4r7ZI2
   yS4cVtweRRvd5hYlvjG4MSlQTv/QhCM6o3rRFefuwZv10UXCMGYYRn1MT
   w==;
X-CSE-ConnectionGUID: vhQuTuRyQcCGavk7/gnD8g==
X-CSE-MsgGUID: cm3/tIYtTr+JXX2FbmgWUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884760"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884760"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:01 -0700
X-CSE-ConnectionGUID: 3n8C6713RaSdtr+PYw3ypw==
X-CSE-MsgGUID: 7O0Ti20bSgedmSmh4MdRkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607485"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:01 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 00/13] zswap IAA compress batching
Date: Thu, 17 Oct 2024 23:40:48 -0700
Message-Id: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


IAA Compression Batching:
=========================

This RFC patch-series introduces the use of the Intel Analytics Accelerator
(IAA) for parallel compression of pages in a folio, and for batched reclaim
of hybrid any-order batches of folios in shrink_folio_list().

The patch-series is organized as follows:

 1) iaa_crypto driver enablers for batching: Relevant patches are tagged
    with "crypto:" in the subject:

    a) async poll crypto_acomp interface without interrupts.
    b) crypto testmgr acomp poll support.
    c) Modifying the default sync_mode to "async" and disabling
       verify_compress by default, to facilitate users to run IAA easily for
       comparison with software compressors.
    d) Changing the cpu-to-iaa mappings to more evenly balance cores to IAA
       devices.
    e) Addition of a "global_wq" per IAA, which can be used as a global
       resource for the socket. If the user configures 2WQs per IAA device,
       the driver will distribute compress jobs from all cores on the
       socket to the "global_wqs" of all the IAA devices on that socket, in
       a round-robin manner. This can be used to improve compression
       throughput for workloads that see a lot of swapout activity.

 2) Migrating zswap to use async poll in zswap_compress()/decompress().
 3) A centralized batch compression API that can be used by swap modules.
 4) IAA compress batching within large folio zswap stores.
 5) IAA compress batching of any-order hybrid folios in
    shrink_folio_list(). The newly added "sysctl vm.compress-batchsize"
    parameter can be used to configure the number of folios in [1, 32] to
    be reclaimed using compress batching.

IAA compress batching can be enabled only on platforms that have IAA, by
setting this config variable:

 CONFIG_ZSWAP_STORE_BATCHING_ENABLED="y"
 
The performance testing data with usemem 30 instances shows throughput
gains of up to 40%, elapsed time reduction of up to 22% and sys time
reduction of up to 30% with IAA compression batching.

Our internal validation of IAA compress/decompress batching in highly
contended Sapphire Rapids server setups with workloads running on 72 cores
for ~25 minutes under stringent memory limit constraints have shown up to
50% reduction in sys time and 3.5% reduction in workload run time as
compared to software compressors.


System setup for testing:
=========================
Testing of this patch-series was done with mm-unstable as of 10-16-2024,
commit 817952b8be34, without and with this patch-series.
Data was gathered on an Intel Sapphire Rapids server, dual-socket 56 cores
per socket, 4 IAA devices per socket, 503 GiB RAM and 525G SSD disk
partition swap. Core frequency was fixed at 2500MHz.

The vm-scalability "usemem" test was run in a cgroup whose memory.high
was fixed at 150G. The is no swap limit set for the cgroup. 30 usemem
processes were run, each allocating and writing 10G of memory, and sleeping
for 10 sec before exiting:

usemem --init-time -w -O -s 10 -n 30 10g

Other kernel configuration parameters:

    zswap compressor : deflate-iaa
    zswap allocator   : zsmalloc
    vm.page-cluster   : 2,4

IAA "compression verification" is disabled and the async poll acomp
interface is used in the iaa_crypto driver (the defaults with this
series).


Performance testing (usemem30):
===============================

 4K folios: deflate-iaa:
 =======================

 -------------------------------------------------------------------------------
                mm-unstable-10-16-2024  shrink_folio_list()  shrink_folio_list()
                                         batching of folios   batching of folios
 -------------------------------------------------------------------------------
 zswap compressor          deflate-iaa          deflate-iaa          deflate-iaa
 vm.compress-batchsize             n/a                    1                   32
 vm.page-cluster                     2                    2                    2
 -------------------------------------------------------------------------------
 Total throughput            4,470,466            5,770,824            6,363,045
           (KB/s)
 Average throughput            149,015              192,360              212,101
           (KB/s)
 elapsed time                   119.24               100.96                92.99
        (sec)
 sys time (sec)               2,819.29             2,168.08             1,970.79

 -------------------------------------------------------------------------------
 memcg_high                    668,185              646,357              613,421
 memcg_swap_fail                     0                    0                    0
 zswpout                    62,991,796           58,275,673           53,070,201
 zswpin                            431                  415                  396
 pswpout                             0                    0                    0
 pswpin                              0                    0                    0
 thp_swpout                          0                    0                    0
 thp_swpout_fallback                 0                    0                    0
 pgmajfault                      3,137                3,085                3,440
 swap_ra                            99                  100                   95
 swap_ra_hit                        42                   44                   45
 -------------------------------------------------------------------------------


 16k/32/64k folios: deflate-iaa:
 ===============================
 All three large folio sizes 16k/32/64k were enabled to "always".

 -------------------------------------------------------------------------------
                mm-unstable-  zswap_store()      + shrink_folio_list()
                  10-16-2024    batching of         batching of folios
                                   pages in
                               large folios
 -------------------------------------------------------------------------------
 zswap compr     deflate-iaa     deflate-iaa          deflate-iaa
 vm.compress-            n/a             n/a         4          8             16
 batchsize
 vm.page-                  2               2         2          2              2
  cluster
 -------------------------------------------------------------------------------
 Total throughput   7,182,198   8,448,994    8,584,728    8,729,643    8,775,944
           (KB/s)             
 Avg throughput       239,406     281,633      286,157      290,988      292,531
         (KB/s)               
 elapsed time           85.04       77.84        77.03        75.18        74.98
         (sec)                
 sys time (sec)      1,730.77    1,527.40     1,528.52     1,473.76     1,465.97

 -------------------------------------------------------------------------------
 memcg_high           648,125     694,188      696,004      699,728      724,887
 memcg_swap_fail        1,550       2,540        1,627        1,577        1,517
 zswpout           57,606,876  56,624,450   56,125,082    55,999,42   57,352,204
 zswpin                   421         406          422          400          437
 pswpout                    0           0            0            0            0
 pswpin                     0           0            0            0            0
 thp_swpout                 0           0            0            0            0
 thp_swpout_fallback        0           0            0            0            0
 16kB-mthp_swpout_          0           0            0            0            0
          fallback
 32kB-mthp_swpout_          0           0            0            0            0
          fallback
 64kB-mthp_swpout_      1,550       2,539        1,627        1,577        1,517
          fallback
 pgmajfault             3,102       3,126        3,473        3,454        3,134
 swap_ra                  107         144          109          124          181
 swap_ra_hit               51          88           45           66          107
 ZSWPOUT-16kB               2           3            4            4            3
 ZSWPOUT-32kB               0           2            1            1            0
 ZSWPOUT-64kB       3,598,889   3,536,556    3,506,134    3,498,324    3,582,921
 SWPOUT-16kB                0           0            0            0            0
 SWPOUT-32kB                0           0            0            0            0
 SWPOUT-64kB                0           0            0            0            0
 -------------------------------------------------------------------------------


 2M folios: deflate-iaa:
 =======================

 -------------------------------------------------------------------------------
                   mm-unstable-10-16-2024    zswap_store() batching of pages
                                                      in pmd-mappable folios
 -------------------------------------------------------------------------------
 zswap compressor             deflate-iaa                deflate-iaa
 vm.compress-batchsize                n/a                        n/a
 vm.page-cluster                        2                          2
 -------------------------------------------------------------------------------
 Total throughput               7,444,592                 8,916,349     
           (KB/s)                                                  
 Average throughput               248,153                   297,211     
           (KB/s)                                                  
 elapsed time                       86.29                     73.44     
        (sec)                                                      
 sys time (sec)                  1,833.21                  1,418.58     
                                                                   
 -------------------------------------------------------------------------------
 memcg_high                        81,786                    89,905     
 memcg_swap_fail                       82                       395     
 zswpout                       58,874,092                57,721,884     
 zswpin                               422                       458     
 pswpout                                0                         0     
 pswpin                                 0                         0     
 thp_swpout                             0                         0     
 thp_swpout_fallback                   82                       394     
 pgmajfault                        14,864                    21,544     
 swap_ra                           34,953                    53,751     
 swap_ra_hit                       34,895                    53,660     
 ZSWPOUT-2048kB                   114,815                   112,269     
 SWPOUT-2048kB                          0                         0     
 -------------------------------------------------------------------------------

Since 4K folios account for ~0.4% of all zswapouts when pmd-mappable folios
are enabled for usemem30, we cannot expect much improvement from reclaim
batching.


Performance testing (Kernel compilation):
=========================================

As mentioned earlier, for workloads that see a lot of swapout activity, we
can benefit from configuring 2 WQs per IAA device, with compress jobs from
all same-socket cores being distributed toothe wq.1 of all IAAs on the
socket, with the "global_wq" developed in this patch-series.

Although this data includes IAA decompress batching, which will be
submitted as a separate RFC patch-series, I am listing it here to quantify
the benefit of distributing compress jobs among all IAAs. The kernel
compilation test with "allmodconfig" is able to quantify this well:


 4K folios: deflate-iaa: kernel compilation to quantify crypto patches
 =====================================================================


 ------------------------------------------------------------------------------
                   IAA shrink_folio_list() compress batching and
                       swapin_readahead() decompress batching

                                      1WQ      2WQ (distribute compress jobs)

                        1 local WQ (wq.0)    1 local WQ (wq.0) +
                                  per IAA    1 global WQ (wq.1) per IAA
                        
 ------------------------------------------------------------------------------
 zswap compressor             deflate-iaa         deflate-iaa
 vm.compress-batchsize                 32                  32
 vm.page-cluster                        4                   4
 ------------------------------------------------------------------------------
 real_sec                          746.77              745.42  
 user_sec                       15,732.66           15,738.85
 sys_sec                         5,384.14            5,247.86
 Max_Res_Set_Size_KB            1,874,432           1,872,640

 ------------------------------------------------------------------------------
 zswpout                      101,648,460         104,882,982
 zswpin                        27,418,319          29,428,515
 pswpout                              213                  22
 pswpin                               207                   6
 pgmajfault                    21,896,616          23,629,768
 swap_ra                        6,054,409           6,385,080
 swap_ra_hit                    3,791,628           3,985,141
 ------------------------------------------------------------------------------

The iaa_crypto wq stats will show almost the same number of compress calls
for wq.1 of all IAA devices. wq.0 will handle decompress calls exclusively.
We see a latency reduction of 2.5% by distributing compress jobs among all
IAA devices on the socket.

I would greatly appreciate code review comments for the iaa_crypto driver
and mm patches included in this series!

Thanks,
Kanchana



Kanchana P Sridhar (13):
  crypto: acomp - Add a poll() operation to acomp_alg and acomp_req
  crypto: iaa - Add support for irq-less crypto async interface
  crypto: testmgr - Add crypto testmgr acomp poll support.
  mm: zswap: zswap_compress()/decompress() can submit, then poll an
    acomp_req.
  crypto: iaa - Make async mode the default.
  crypto: iaa - Disable iaa_verify_compress by default.
  crypto: iaa - Change cpu-to-iaa mappings to evenly balance cores to
    IAAs.
  crypto: iaa - Distribute compress jobs to all IAA devices on a NUMA
    node.
  mm: zswap: Config variable to enable compress batching in
    zswap_store().
  mm: zswap: Create multiple reqs/buffers in crypto_acomp_ctx if
    platform has IAA.
  mm: swap: Add IAA batch compression API
    swap_crypto_acomp_compress_batch().
  mm: zswap: Compress batching with Intel IAA in zswap_store() of large
    folios.
  mm: vmscan, swap, zswap: Compress batching of folios in
    shrink_folio_list().

 crypto/acompress.c                         |   1 +
 crypto/testmgr.c                           |  70 +-
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 467 +++++++++++--
 include/crypto/acompress.h                 |  18 +
 include/crypto/internal/acompress.h        |   1 +
 include/linux/fs.h                         |   2 +
 include/linux/mm.h                         |   8 +
 include/linux/writeback.h                  |   5 +
 include/linux/zswap.h                      | 106 +++
 kernel/sysctl.c                            |   9 +
 mm/Kconfig                                 |  12 +
 mm/page_io.c                               | 152 +++-
 mm/swap.c                                  |  15 +
 mm/swap.h                                  |  96 +++
 mm/swap_state.c                            | 115 +++
 mm/vmscan.c                                | 154 +++-
 mm/zswap.c                                 | 771 +++++++++++++++++++--
 17 files changed, 1870 insertions(+), 132 deletions(-)


base-commit: 817952b8be34aad40e07f6832fb9d1fc08961550
-- 
2.27.0


