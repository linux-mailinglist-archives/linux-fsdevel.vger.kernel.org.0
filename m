Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B9689DE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 16:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjBCPRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjBCPQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:16:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02AA6B9E;
        Fri,  3 Feb 2023 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675437266; x=1706973266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+qhJGcdQMX1iSW34SbhRnsrfh1meYsJgBSEcMcY+h0U=;
  b=M1vit82EC41+ub9gRtv4jn7vI+YjepdrTfUxlWDKF0sFDM6l0U8jS/ov
   o+hdfQHeAaX9mB+VI6HNPPJAmjF+idS2Vrq1Uw52LUnYcrMbwSseNOvfk
   AUAsz/rFMHA+FRHl1jSO1/BTjwWl9F0+BUM3ObBuOpp7oVvRfppAjoJnr
   6pq5uoK/qAhFDWZa6vrmkuYc1tDm6HJjWySxz/lRxsHYlhAdFJX21b0fw
   rz9HkLE5T74KM2mGTOp9Sng42p8naDzXFPPj7yoXz0CE9LNGVc+eAgWkP
   TBZG0B5BjWb0Dg7J8+2TeQmKX5LJUbmKRDGkNJm0JDUTDmdwr/pcnWgPQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="414978555"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="414978555"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:13:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="789722313"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="789722313"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Feb 2023 07:13:10 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNxkO-0000aZ-18;
        Fri, 03 Feb 2023 15:13:04 +0000
Date:   Fri, 3 Feb 2023 23:12:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] erofs: implement .mmap for page cache sharing
Message-ID: <202302032301.KaFzWF1g-lkp@intel.com>
References: <20230203030143.73105-8-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203030143.73105-8-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jingbo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xiang-erofs/dev-test]
[also build test WARNING on xiang-erofs/dev xiang-erofs/fixes linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbo-Xu/erofs-support-readahead-in-meta-routine/20230203-110255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20230203030143.73105-8-jefflexu%40linux.alibaba.com
patch subject: [PATCH v3 7/9] erofs: implement .mmap for page cache sharing
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230203/202302032301.KaFzWF1g-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/499758ba5c442083b32a76a3fd55b734df0c486b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jingbo-Xu/erofs-support-readahead-in-meta-routine/20230203-110255
        git checkout 499758ba5c442083b32a76a3fd55b734df0c486b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/erofs/fscache.c:435:12: warning: no previous prototype for 'erofs_fscache_share_fault' [-Wmissing-prototypes]
     435 | vm_fault_t erofs_fscache_share_fault(struct vm_fault *vmf)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/erofs_fscache_share_fault +435 fs/erofs/fscache.c

   434	
 > 435	vm_fault_t erofs_fscache_share_fault(struct vm_fault *vmf)
   436	{
   437		struct erofs_fscache_finfo *finfo = vmf->vma->vm_file->private_data;
   438	
   439		if (unlikely(vmf->pgoff >= finfo->max_idx))
   440			return VM_FAULT_SIGBUS;
   441		return filemap_fault(vmf);
   442	}
   443	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
