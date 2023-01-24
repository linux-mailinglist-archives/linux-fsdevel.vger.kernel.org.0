Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F1A679519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 11:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjAXKYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 05:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjAXKX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:23:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA356E8E;
        Tue, 24 Jan 2023 02:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674555838; x=1706091838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=61NCGxLzSHjHHBUNqAQPKXIjKCww1YdhsHSX3vKpaAU=;
  b=PdEcyh7ZC6m2aZgFM961OqF3a0q8EahZUY6S2ZCtHJQIESUR00j8DBF1
   4DcbfExmA2B5lTklqzgws4nWZhR5I+qOlfairGYbEyk59gDmzOuCKtJHD
   By6I/Geu2qvbaEmhPr6mAlHWmAOchamwI/QEEG9Vfz87SUKMfFG+kL9qM
   8pbH4wlY4p3YAS45V9frN44kkWAq6m6Q7MIdkAwhgjEY1YgdZZ+RIxD/L
   tamKFPwGvbLLkcluEocEbPbqgxH+X1lFuiCZFocvSSnEN4wstbA7+/YHj
   IgZOUfwebeLi6lIdiZ2vmYDSZfxm7+HOZn8sBJcYvlpFz8k1UNwKXsRbh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326300343"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="326300343"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 02:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="770252842"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="770252842"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2023 02:23:50 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKGSz-0006Ke-0R;
        Tue, 24 Jan 2023 10:23:49 +0000
Date:   Tue, 24 Jan 2023 18:23:20 +0800
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
Subject: Re: [PATCH v8 2/4] userfaultfd: split mwriteprotect_range()
Message-ID: <202301241831.AYRPKsH5-lkp@intel.com>
References: <20230124084323.1363825-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-3-usama.anjum@collabora.com>
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

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.2-rc5]
[cannot apply to next-20230124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230124-164601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230124084323.1363825-3-usama.anjum%40collabora.com
patch subject: [PATCH v8 2/4] userfaultfd: split mwriteprotect_range()
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230124/202301241831.AYRPKsH5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2806717805539421b82e971890ebbaf83b3deee4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230124-164601
        git checkout 2806717805539421b82e971890ebbaf83b3deee4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/mm/init_32.o: in function `userfaultfd_wp_async':
   init_32.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: arch/x86/mm/init_32.o: in function `wp_range_async':
>> init_32.c:(.text+0x3): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: arch/x86/mm/fault.o: in function `userfaultfd_wp_async':
   fault.c:(.text+0x8cd): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: arch/x86/mm/fault.o: in function `wp_range_async':
   fault.c:(.text+0x8d0): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: arch/x86/mm/pgtable.o: in function `userfaultfd_wp_async':
   pgtable.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: arch/x86/mm/pgtable.o: in function `wp_range_async':
   pgtable.c:(.text+0x3): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: kernel/fork.o: in function `userfaultfd_wp_async':
   fork.c:(.text+0x5bb): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: kernel/fork.o: in function `wp_range_async':
   fork.c:(.text+0x5be): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: kernel/sysctl.o: in function `userfaultfd_wp_async':
   sysctl.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: kernel/sysctl.o: in function `wp_range_async':
   sysctl.c:(.text+0x3): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: kernel/sys.o: in function `userfaultfd_wp_async':
   sys.c:(.text+0xb5e): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: kernel/sys.o: in function `wp_range_async':
   sys.c:(.text+0xb61): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: kernel/events/core.o: in function `userfaultfd_wp_async':
   core.c:(.text+0x404c): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: kernel/events/core.o: in function `wp_range_async':
   core.c:(.text+0x404f): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/filemap.o: in function `userfaultfd_wp_async':
   filemap.c:(.text+0x7c5): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/filemap.o: in function `wp_range_async':
   filemap.c:(.text+0x7c8): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/page-writeback.o: in function `userfaultfd_wp_async':
   page-writeback.c:(.text+0xb69): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/page-writeback.o: in function `wp_range_async':
   page-writeback.c:(.text+0xb6c): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/folio-compat.o: in function `userfaultfd_wp_async':
   folio-compat.c:(.text+0xc): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/folio-compat.o: in function `wp_range_async':
   folio-compat.c:(.text+0xf): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/readahead.o: in function `userfaultfd_wp_async':
   readahead.c:(.text+0x128): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/readahead.o: in function `wp_range_async':
   readahead.c:(.text+0x12b): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/swap.o: in function `userfaultfd_wp_async':
   swap.c:(.text+0x6e5): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/swap.o: in function `wp_range_async':
   swap.c:(.text+0x6e8): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/vmscan.o: in function `userfaultfd_wp_async':
   vmscan.c:(.text+0xf96): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/vmscan.o: in function `wp_range_async':
   vmscan.c:(.text+0xf99): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/shmem.o: in function `userfaultfd_wp_async':
   shmem.c:(.text+0x91): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/shmem.o: in function `wp_range_async':
   shmem.c:(.text+0x94): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/util.o: in function `userfaultfd_wp_async':
   util.c:(.text+0x2b): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/util.o: in function `wp_range_async':
   util.c:(.text+0x2e): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/vmstat.o: in function `userfaultfd_wp_async':
   vmstat.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/vmstat.o: in function `wp_range_async':
   vmstat.c:(.text+0x3): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/compaction.o: in function `userfaultfd_wp_async':
   compaction.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/compaction.o: in function `wp_range_async':
   compaction.c:(.text+0x3): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/workingset.o: in function `userfaultfd_wp_async':
   workingset.c:(.text+0x181): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/workingset.o: in function `wp_range_async':
   workingset.c:(.text+0x184): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/debug.o: in function `userfaultfd_wp_async':
   debug.c:(.text+0xb9): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/debug.o: in function `wp_range_async':
   debug.c:(.text+0xbc): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/gup.o: in function `userfaultfd_wp_async':
   gup.c:(.text+0x2ae): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/gup.o: in function `wp_range_async':
   gup.c:(.text+0x2b1): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/memory.o: in function `userfaultfd_wp_async':
   memory.c:(.text+0x737): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/memory.o: in function `wp_range_async':
   memory.c:(.text+0x73a): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/mincore.o: in function `userfaultfd_wp_async':
   mincore.c:(.text+0x149): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mincore.o: in function `wp_range_async':
   mincore.c:(.text+0x14c): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/mlock.o: in function `userfaultfd_wp_async':
   mlock.c:(.text+0x90e): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mlock.o: in function `wp_range_async':
   mlock.c:(.text+0x911): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/mmap.o: in function `userfaultfd_wp_async':
   mmap.c:(.text+0x4d8): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mmap.o: in function `wp_range_async':
   mmap.c:(.text+0x4db): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/mmu_gather.o: in function `userfaultfd_wp_async':
   mmu_gather.c:(.text+0x29): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mmu_gather.o: in function `wp_range_async':
   mmu_gather.c:(.text+0x2c): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here
   ld: mm/mprotect.o: in function `userfaultfd_wp_async':
   mprotect.c:(.text+0x45): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mprotect.o: in function `wp_range_async':
   mprotect.c:(.text+0x48): multiple definition of `wp_range_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x6): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
