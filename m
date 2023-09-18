Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541697A4D0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjIRPqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjIRPqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:46:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E732737;
        Mon, 18 Sep 2023 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051892; x=1726587892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ykgUdcAyff68JbKMpOfYfrK6kmGZcZxRKCMtU2anr+I=;
  b=HVTHZ00AThtAOg8Ljc230m/dF8XBoDobEM4sNiBsPcWxLzxoXkjCZD4k
   2X/KFNI8fQSaLLp6Sq2UFMho9h2dbvIc5mqnI0Yp3iLHnkFUpcoPVamCG
   J7LtyiETXVC8jtaPHZhQIerFoozGVE7IwWAB2cbUxdFywnwIO/MnN6QpE
   1OkfsRg5cGWVu38Xi3K6PW15RiGLBiooLb4zGjKX9IEcVB9wG5QK3vsto
   nRz7cL7rWi4kHQEnFJV7Q+7Gsfl3IdP9O+xyoztlLtY+GGzQOKRfTbeb5
   t3jT7k92oy1HR78nXPkk8pBuKD2x/VHUeJ7RUO/3AlmTwISShWMFKoyrt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446113310"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446113310"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811342022"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811342022"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2023 06:12:19 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiE2z-00067M-0D;
        Mon, 18 Sep 2023 13:12:17 +0000
Date:   Mon, 18 Sep 2023 21:11:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 08/18] mm/readahead: allocate folios with mapping order
 preference
Message-ID: <202309182020.nSchrF93-lkp@intel.com>
References: <20230918110510.66470-9-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918110510.66470-9-hare@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.6-rc2 next-20230918]
[cannot apply to xfs-linux/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/mm-readahead-rework-loop-in-page_cache_ra_unbounded/20230918-190732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230918110510.66470-9-hare%40suse.de
patch subject: [PATCH 08/18] mm/readahead: allocate folios with mapping order preference
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230918/202309182020.nSchrF93-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230918/202309182020.nSchrF93-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309182020.nSchrF93-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: mm/readahead.o: in function `readahead_expand':
>> readahead.c:(.text+0x17b): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
