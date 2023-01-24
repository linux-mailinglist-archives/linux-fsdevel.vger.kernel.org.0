Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB467958D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 11:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjAXKpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 05:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjAXKpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:45:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FA45270;
        Tue, 24 Jan 2023 02:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674557098; x=1706093098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WI/N8dDuCaM5YVFVz7TJ6+nVIPfjf/MOxR1dR63wjdc=;
  b=DXSWqjKIhgkb2rxRbv8DufBH1jXh+qQ99Qvb2yCLBPQ/vDWgKd1ITqN6
   cEV0tUNwBzSU1Fb9Lk7EazxskLVfvCIPmJ8g/WxpNSStlOMB0m7FdvIwU
   RsYd3jkOLIIpDHDxR8tJAGVMrUWKraV/Nf9go5uSKQVLrcwY16bhIbdku
   DuF2vkeOm5ywelslYJoVHbPQEyMI5SYlLqndvOyOSCUzgm0vgGBpdrYCa
   Beezx1J54QlsVXZ9905FMGxzxI4lF3MdnrwCAsqDWX1fxis61mR3syqmK
   LPlWB+4AeZX+k65ILy0Nvlp9NjYuQ1eLvEhNm1ZuGPCzhLwSIPiBwd8NA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323961542"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="323961542"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 02:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694291570"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="694291570"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2023 02:44:50 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKGnJ-0006LQ-2P;
        Tue, 24 Jan 2023 10:44:49 +0000
Date:   Tue, 24 Jan 2023 18:43:59 +0800
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
Subject: Re: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
Message-ID: <202301241804.zHrFxA0L-lkp@intel.com>
References: <20230124084323.1363825-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-2-usama.anjum@collabora.com>
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
[also build test ERROR on shuah-kselftest/fixes linus/master v6.2-rc5 next-20230124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230124-164601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230124084323.1363825-2-usama.anjum%40collabora.com
patch subject: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230124/202301241804.zHrFxA0L-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/59e98aec663b7ca8fd5f3b3d2a0f17f777f425c4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230124-164601
        git checkout 59e98aec663b7ca8fd5f3b3d2a0f17f777f425c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/mm/init_32.o: in function `userfaultfd_wp_async':
>> init_32.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: arch/x86/mm/fault.o: in function `userfaultfd_wp_async':
   fault.c:(.text+0x8cd): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: arch/x86/mm/pgtable.o: in function `userfaultfd_wp_async':
   pgtable.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: kernel/fork.o: in function `userfaultfd_wp_async':
   fork.c:(.text+0x5bb): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: kernel/sysctl.o: in function `userfaultfd_wp_async':
   sysctl.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: kernel/sys.o: in function `userfaultfd_wp_async':
   sys.c:(.text+0xb5e): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: kernel/events/core.o: in function `userfaultfd_wp_async':
   core.c:(.text+0x404c): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/filemap.o: in function `userfaultfd_wp_async':
   filemap.c:(.text+0x7c5): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/page-writeback.o: in function `userfaultfd_wp_async':
   page-writeback.c:(.text+0xb69): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/folio-compat.o: in function `userfaultfd_wp_async':
   folio-compat.c:(.text+0xc): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/readahead.o: in function `userfaultfd_wp_async':
   readahead.c:(.text+0x128): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/swap.o: in function `userfaultfd_wp_async':
   swap.c:(.text+0x6e5): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/vmscan.o: in function `userfaultfd_wp_async':
   vmscan.c:(.text+0xf96): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/shmem.o: in function `userfaultfd_wp_async':
   shmem.c:(.text+0x91): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/util.o: in function `userfaultfd_wp_async':
   util.c:(.text+0x2b): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/vmstat.o: in function `userfaultfd_wp_async':
   vmstat.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/compaction.o: in function `userfaultfd_wp_async':
   compaction.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/workingset.o: in function `userfaultfd_wp_async':
   workingset.c:(.text+0x181): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/debug.o: in function `userfaultfd_wp_async':
   debug.c:(.text+0xb9): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/gup.o: in function `userfaultfd_wp_async':
   gup.c:(.text+0x2ae): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/memory.o: in function `userfaultfd_wp_async':
   memory.c:(.text+0x737): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mincore.o: in function `userfaultfd_wp_async':
   mincore.c:(.text+0x149): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mlock.o: in function `userfaultfd_wp_async':
   mlock.c:(.text+0x90e): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mmap.o: in function `userfaultfd_wp_async':
   mmap.c:(.text+0x4d8): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mmu_gather.o: in function `userfaultfd_wp_async':
   mmu_gather.c:(.text+0x29): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mprotect.o: in function `userfaultfd_wp_async':
   mprotect.c:(.text+0x45): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/mremap.o: in function `userfaultfd_wp_async':
   mremap.c:(.text+0x36b): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/page_vma_mapped.o: in function `userfaultfd_wp_async':
   page_vma_mapped.c:(.text+0x28): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/pagewalk.o: in function `userfaultfd_wp_async':
   pagewalk.c:(.text+0x30d): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/pgtable-generic.o: in function `userfaultfd_wp_async':
   pgtable-generic.c:(.text+0x0): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/rmap.o: in function `userfaultfd_wp_async':
   rmap.c:(.text+0x655): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/vmalloc.o: in function `userfaultfd_wp_async':
   vmalloc.c:(.text+0x1546): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: mm/page_alloc.o: in function `userfaultfd_wp_async':
   page_alloc.c:(.text+0xdb1): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: fs/splice.o: in function `userfaultfd_wp_async':
   splice.c:(.text+0x6f8): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   ld: security/commoncap.o: in function `userfaultfd_wp_async':
   commoncap.c:(.text+0x8b): multiple definition of `userfaultfd_wp_async'; arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
