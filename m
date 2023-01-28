Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61967F9B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 17:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjA1Qxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Jan 2023 11:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjA1Qxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:53:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345FC2BEC4;
        Sat, 28 Jan 2023 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674924827; x=1706460827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+o3QfgICgB0ULTb1/dVk5Tk167jK8QaEZNxbvJhNeQY=;
  b=U/xYJLfOvtVqoDDuLvfNVdoaoG0YEl0UWkoWjMbt8B1Fv1oS2gvsR5L7
   3Dx1hHajQKrQCWMltr+yA73o1nTC4XEayfwqbZuAyhKgYfIisE2UEZ/fh
   AJsWAoOSC1bk6ieyz5pfBawP2oHWJNQnbHJBl+RmHLWV4gbIzTh9bYx7T
   ljIlX36ahn5v2SRN047haLcZ3uRDfzITonLotuzclTcKGpUlGzmEL1zLk
   mj8+rSmluOM/vR+tgOtqZ0PKRgB4x8MFawyR4h5INmBubzCEbheNSWbrV
   xclqD+nBk96f3qUVko9c5jJfbKgJ/Wt/gfSaBVU0NOGnWEX+8ORPBXPA7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="413530230"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="413530230"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 08:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="787540586"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="787540586"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2023 08:53:44 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLoSV-0000vX-1V;
        Sat, 28 Jan 2023 16:53:43 +0000
Date:   Sun, 29 Jan 2023 00:53:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/31] ext4: Convert ext4_bio_write_page() to use a folio
Message-ID: <202301290044.oKaK49Hs-lkp@intel.com>
References: <20230126202415.1682629-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-4-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20230127]
[cannot apply to tytso-ext4/dev xfs-linux/for-next linus/master v6.2-rc5 v6.2-rc4 v6.2-rc3 v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Add-FGP_WRITEBEGIN/20230128-150212
patch link:    https://lore.kernel.org/r/20230126202415.1682629-4-willy%40infradead.org
patch subject: [PATCH 03/31] ext4: Convert ext4_bio_write_page() to use a folio
config: loongarch-randconfig-r001-20230123 (https://download.01.org/0day-ci/archive/20230129/202301290044.oKaK49Hs-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f6e4c5cfaf2ef7b8ee6c5354bbbd5f1ee758746f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/fs-Add-FGP_WRITEBEGIN/20230128-150212
        git checkout f6e4c5cfaf2ef7b8ee6c5354bbbd5f1ee758746f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "bio_add_folio" [fs/ext4/ext4.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
