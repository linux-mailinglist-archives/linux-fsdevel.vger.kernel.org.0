Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72206CDBA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 16:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjC2OLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjC2OKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:10:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B6355A4;
        Wed, 29 Mar 2023 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680099011; x=1711635011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=54TwdqI2jO0fD5SczmgJpyLhNeumpJSC1ZS+7HlXaF4=;
  b=Ijctlcwa4HfpYhsBm+c2ZHpX3kWWI0k8xeFrqDzGruLaEed1GeE0UpTK
   K381/zlCDGhQFnuPAy4sJxBCDPdR4+cejaRrDDYoly2KiHgG6pG4b+ppQ
   X8PPOta35kENgB7Y+zaQ89UrQLL+MICplaRh5ppU0AXt7i4rVBH5MltP7
   HOM6nCW50z+360nDQ1lxodSOU6PUGXtHXOlXIuNdWmP0Hgp7mYuCuBBee
   6nuXdiiXAnydg3U7W4DFRKGmIZvEA9pNgNSRAw50cxol5ramjM2sKbB73
   JK2PsyrAdd+lwPfu3/EG3qTJGdGfPFIUCc8BpeAgTa2lKIOvA2BM47oMH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="324789527"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="324789527"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795245926"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="795245926"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2023 07:07:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phWSv-000Jba-1B;
        Wed, 29 Mar 2023 14:07:53 +0000
Date:   Wed, 29 Mar 2023 22:07:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, bvanassche@acm.org, hare@suse.de,
        ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device.
Message-ID: <202303292151.7DDOUCIt-lkp@intel.com>
References: <20230327084103.21601-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327084103.21601-5-anuj20.g@samsung.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Anuj,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on device-mapper-dm/for-next linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anuj-Gupta/block-Add-copy-offload-support-infrastructure/20230329-162018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230327084103.21601-5-anuj20.g%40samsung.com
patch subject: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for direct block device.
config: loongarch-randconfig-r001-20230329 (https://download.01.org/0day-ci/archive/20230329/202303292151.7DDOUCIt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/61819d260936954ddd6688548f074e7063dcf39e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anuj-Gupta/block-Add-copy-offload-support-infrastructure/20230329-162018
        git checkout 61819d260936954ddd6688548f074e7063dcf39e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303292151.7DDOUCIt-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: fs/read_write.o: in function `.L633':
>> read_write.c:(.text+0x42e0): undefined reference to `I_BDEV'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
