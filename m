Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE617BC493
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 06:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343528AbjJGEDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 00:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343492AbjJGEDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:03:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8FBD;
        Fri,  6 Oct 2023 21:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696651428; x=1728187428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ezcRfoedZbn+gXeuHPcqeG7E3BDTeiDXih6BWqHt5yc=;
  b=DhZAKzd5cKxde0NNZfps0eKahfP7au0M5iopTSJ2oteMOoaFxipkqKXd
   zvagjnxINtwTbOAZBGOj3I2g/vG3phUrRnxGNwpKFvYCf/Um/OEc9yDPk
   cQ2F6ET1QLID0x+VLj6FRZzGffzU7v7VrutcMMOtxHtFCnAnqxzOeDavE
   FCqxPeZUfAvB1Ncd25DWMeuA/A+VVK2wLDIkUqZ6D1uRrzWbqDIVv8RPc
   LA0Q8rN91m3ORfMt4caKZUEqKuonQ2SnFg5kEFGE5w4mnT8EXatqLbkpc
   lg6k5aR9ZYYyy9qqZm93XUtpxxL8/NEr1ZPaysHjiwNQ0aFGFGtsgyt47
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="448085899"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="448085899"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 21:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818235848"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="818235848"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2023 21:03:45 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoyXW-0003wj-1L;
        Sat, 07 Oct 2023 04:03:42 +0000
Date:   Sat, 7 Oct 2023 12:02:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, djwong@kernel.org,
        ebiggers@kernel.org, david@fromorbit.com, dchinner@redhat.com,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v3 10/28] fsverity: operate with Merkle tree blocks
 instead of pages
Message-ID: <202310071152.hVd0qEeD-lkp@intel.com>
References: <20231006184922.252188-11-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-11-aalbersh@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrey,

kernel test robot noticed the following build errors:

[auto build test ERROR on xfs-linux/for-next]
[also build test ERROR on kdave/for-next tytso-ext4/dev jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Albershteyn/xfs-Add-new-name-to-attri-d/20231007-025742
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20231006184922.252188-11-aalbersh%40redhat.com
patch subject: [PATCH v3 10/28] fsverity: operate with Merkle tree blocks instead of pages
config: powerpc-randconfig-003-20231007 (https://download.01.org/0day-ci/archive/20231007/202310071152.hVd0qEeD-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071152.hVd0qEeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310071152.hVd0qEeD-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: fs/verity/read_metadata.o: in function `fsverity_read_merkle_tree':
>> read_metadata.c:(.text.fsverity_read_merkle_tree+0xa0): undefined reference to `__umoddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
