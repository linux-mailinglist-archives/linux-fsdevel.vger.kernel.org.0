Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD286F7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 03:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbfHIB5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 21:57:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:48197 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbfHIB5s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 21:57:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 18:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="326496078"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2019 18:57:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvuA5-000BOw-Ay; Fri, 09 Aug 2019 09:57:45 +0800
Date:   Fri, 9 Aug 2019 09:56:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        adilger@dilger.ca, jaegeuk@kernel.org, darrick.wong@oracle.com,
        miklos@szeredi.hu, rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <201908090949.xqu7PPMV%lkp@intel.com>
References: <20190808082744.31405-9-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808082744.31405-9-cmaiolino@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Carlos,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc3 next-20190808]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Carlos-Maiolino/New-fiemap-infrastructure-and-bmap-removal/20190808-221354
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/inode.c:1597:36: sparse: sparse: Using plain integer as NULL pointer
   fs/inode.c:721:24: sparse: sparse: context imbalance in 'inode_lru_isolate' - wrong count at exit
   fs/inode.c:810:9: sparse: sparse: context imbalance in 'find_inode' - different lock contexts for basic block
   fs/inode.c:841:9: sparse: sparse: context imbalance in 'find_inode_fast' - different lock contexts for basic block
   fs/inode.c:1447:5: sparse: sparse: context imbalance in 'insert_inode_locked' - wrong count at exit
   include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in 'iput_final' - unexpected unlock
   fs/inode.c:1572:6: sparse: sparse: context imbalance in 'iput' - wrong count at exit
   fs/inode.c:2024:13: sparse: sparse: context imbalance in '__wait_on_freeing_inode' - unexpected unlock

vim +1597 fs/inode.c

  1590	
  1591	static int fiemap_fill_kernel_extent(struct fiemap_extent_info *fieinfo,
  1592				u64 logical, u64 phys, u64 len, u32 flags)
  1593	{
  1594		struct fiemap_extent *extent = fieinfo->fi_cb_data;
  1595	
  1596		/* only count the extents */
> 1597		if (fieinfo->fi_cb_data == 0) {
  1598			fieinfo->fi_extents_mapped++;
  1599			goto out;
  1600		}
  1601	
  1602		if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
  1603			return 1;
  1604	
  1605		if (flags & FIEMAP_EXTENT_DELALLOC)
  1606			flags |= FIEMAP_EXTENT_UNKNOWN;
  1607		if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
  1608			flags |= FIEMAP_EXTENT_ENCODED;
  1609		if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
  1610			flags |= FIEMAP_EXTENT_NOT_ALIGNED;
  1611	
  1612		extent->fe_logical = logical;
  1613		extent->fe_physical = phys;
  1614		extent->fe_length = len;
  1615		extent->fe_flags = flags;
  1616	
  1617		fieinfo->fi_extents_mapped++;
  1618	
  1619		if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
  1620			return 1;
  1621	
  1622	out:
  1623		if (flags & FIEMAP_EXTENT_LAST)
  1624			return 1;
  1625		return 0;
  1626	}
  1627	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
