Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6157B408C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjI3NlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 09:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3NlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:41:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7DE6;
        Sat, 30 Sep 2023 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696081262; x=1727617262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uLZqwADgpJ9WWjDEC/o1UYcaaGs8VGqI4kgPdR63JWQ=;
  b=CwNTVnWUX10StZbs1eYTdLk5AFNhY74M0/+EXtOHMi4+aMBwUHsj32ss
   LgHa94dF/nD3AITpAyF9EfFDcI2ywXqBnxv5Jt+mR35SfDiXcFfVeHHEL
   LDZczsxS1uKyEConZhX42jXXn6Akbjdm5AEGp1lIvFFRE7HbI5Ipx7GX9
   90c3JLXvoAsDu0ArOQTyyfH4L3aNKqQYP/p7SbyumY1H2GqriJka5CFmi
   kywh6Y+OducVwzeDHmDDV8d5OpbnR+1K6xJc1+uJokfvihxl1ZO4I5gsg
   uqrqp/BCzbeTatFwdFwyATHRyeopAwka+WoYRBIluVgs/UVM9JFKcFZiA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="381325996"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="381325996"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 06:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="743695319"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="743695319"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2023 06:40:56 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmaDG-0004B9-0r;
        Sat, 30 Sep 2023 13:40:54 +0000
Date:   Sat, 30 Sep 2023 21:40:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 09/21] block: Add checks to merging of atomic writes
Message-ID: <202309302100.L6ynQWub-lkp@intel.com>
References: <20230929102726.2985188-10-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-10-john.g.garry@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on xfs-linux/for-next]
[also build test ERROR on axboe-block/for-next mkp-scsi/for-next jejb-scsi/for-next linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/block-Add-atomic-write-operations-to-request_queue-limits/20230929-184542
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20230929102726.2985188-10-john.g.garry%40oracle.com
patch subject: [PATCH 09/21] block: Add checks to merging of atomic writes
config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20230930/202309302100.L6ynQWub-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302100.L6ynQWub-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309302100.L6ynQWub-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __moddi3
   >>> referenced by blk-merge.c
   >>>               block/blk-merge.o:(ll_back_merge_fn) in archive vmlinux.a
   >>> referenced by blk-merge.c
   >>>               block/blk-merge.o:(ll_back_merge_fn) in archive vmlinux.a
   >>> referenced by blk-merge.c
   >>>               block/blk-merge.o:(bio_attempt_front_merge) in archive vmlinux.a
   >>> referenced 3 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
