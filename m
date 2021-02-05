Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF19F311865
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 03:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhBFCgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 21:36:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:15180 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230392AbhBFCei (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:34:38 -0500
IronPort-SDR: TCHA17zK98xYwtcNVhemcBbn1x/FKllJ7S0hdFsV7rt1brsr8LDYOX148FDhuglaz2Ftd+WJfW
 sWxI8BBt7jMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="180725349"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="180725349"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:23:08 -0800
IronPort-SDR: dfoMsox0sys4E2FEjMh74vTx+VIqCPoEifN+Z9LDi8Yd10bqmFOMN5AiRicZLQ0pgKcveL8uFj
 8aziCvhiG2/g==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="373729251"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:23:08 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Date:   Fri,  5 Feb 2021 15:23:00 -0800
Message-Id: <20210205232304.1670522-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There are many places where kmap/<operation>/kunmap patterns occur.  We lift
these various patterns to core common functions and use them in the btrfs file
system.  At the same time we convert those core functions to use
kmap_local_page() which is more efficient in those calls.

I think this is best accepted through Andrew's tree as it has the mem*_page
functions in it.  But I'd like to get an ack from David or one of the other
btrfs maintainers before the btrfs patches go through.

There are a lot more kmap->kmap_local_page() conversions but kmap_local_page()
requires some care with the unmapping order and so I'm still reviewing those
changes because btrfs uses a lot of loops for it's kmaps.

Thanks,
Ira

Ira Weiny (4):
  mm/highmem: Lift memcpy_[to|from]_page to core
  fs/btrfs: Use memcpy_[to|from]_page()
  fs/btrfs: Use copy_highpage() instead of 2 kmaps()
  fs/btrfs: Convert to zero_user()

 fs/btrfs/compression.c  | 11 +++------
 fs/btrfs/extent_io.c    | 22 ++++-------------
 fs/btrfs/inode.c        | 33 ++++++++-----------------
 fs/btrfs/lzo.c          |  4 ++--
 fs/btrfs/raid56.c       | 10 +-------
 fs/btrfs/reflink.c      | 12 ++--------
 fs/btrfs/send.c         |  7 ++----
 fs/btrfs/zlib.c         | 10 +++-----
 fs/btrfs/zstd.c         | 11 +++------
 include/linux/highmem.h | 53 +++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c          | 26 +++-----------------
 11 files changed, 86 insertions(+), 113 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

