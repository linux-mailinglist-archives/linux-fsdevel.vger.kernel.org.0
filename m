Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7AC6831E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjAaPxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjAaPxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:53:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA55234FC;
        Tue, 31 Jan 2023 07:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675180386; x=1706716386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ul30YowJ/hdgvarujvqemzj4xp48ISoRMAjzYZ6+Ks4=;
  b=KEKX41lRVWmH21uy9eZSMOEtxa8afPoMrgyCz3A+L9dJIPaReLQ3lXx7
   PqT9/wpMchA2WAbtTagg/rHqpBGojjrOcIS/xcgo+h+9CJC0eLeTUJFrw
   Nn/sAWAx2uAMRfPQp7KhJVoeyASG9qkqXhe/bz3LY0l2WKacMRs4iJJ/9
   2MvsArmddKv4UDPGHyPU3OE3TNrKrH+bBixTWo48r47fRXlmm1MpyKCfu
   1wGbwjWvNJfE7ajZoLkMLsYFOpYyMhGb3wLz4aKcc0urzRdQsRLubQVa/
   TxB9zuydZEQlvPm2hEtY3OtIXhE791DYmKRJgaec9vTN0ETcEZQ0r8WKM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329983898"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="329983898"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 07:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909953990"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="909953990"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 07:52:59 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMswM-0004WY-1B;
        Tue, 31 Jan 2023 15:52:58 +0000
Date:   Tue, 31 Jan 2023 23:52:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v9 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <202301312359.8WtBkSkQ-lkp@intel.com>
References: <20230131083257.3302830-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131083257.3302830-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shuah-kselftest/fixes]
[also build test ERROR on linus/master v6.2-rc6 next-20230131]
[cannot apply to shuah-kselftest/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230131-163537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git fixes
patch link:    https://lore.kernel.org/r/20230131083257.3302830-3-usama.anjum%40collabora.com
patch subject: [PATCH v9 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about PTEs
config: arc-defconfig (https://download.01.org/0day-ci/archive/20230131/202301312359.8WtBkSkQ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/11677b6b7fda958031115ea40aa219fc32c7dea4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230131-163537
        git checkout 11677b6b7fda958031115ea40aa219fc32c7dea4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
>> fs/proc/task_mmu.c:1927:17: error: implicit declaration of function 'uffd_wp_range' [-Werror=implicit-function-declaration]
    1927 |                 uffd_wp_range(walk->mm, vma, start, addr - start, true);
         |                 ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/uffd_wp_range +1927 fs/proc/task_mmu.c

  1915	
  1916		pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
  1917		if (IS_GET_OP(p)) {
  1918			for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
  1919				ret = pagemap_scan_output(!is_pte_uffd_wp(*pte), vma->vm_file,
  1920							  pte_present(*pte), is_swap_pte(*pte), p, addr, 1);
  1921				if (ret)
  1922					break;
  1923			}
  1924		}
  1925		pte_unmap_unlock(pte - 1, ptl);
  1926		if ((!ret || ret == -ENOSPC) && IS_WP_ENGAGE_OP(p) && (addr - start))
> 1927			uffd_wp_range(walk->mm, vma, start, addr - start, true);
  1928	
  1929		cond_resched();
  1930		return ret;
  1931	}
  1932	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
