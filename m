Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7CB67961F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 12:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjAXLFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 06:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjAXLFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:05:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185314480;
        Tue, 24 Jan 2023 03:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674558300; x=1706094300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u+FzOBKj0QPqSqfYENp7du/NiCKXB3DsBUyRD+FK49U=;
  b=HUPaJ5ZA4+MUF+z1xAJ9r1mZHldnwvOu29135fTria8JfIhRej/IUlTP
   peKrbstMi2IpIoAkoVgn4gFCx8O3h/7f+EAkSOM+HQ8eDoftryEBNd62h
   28Zywf/sNwKWOXwMA3ifraDzNguugISYoFUWM7Gq5aywX9CAM6w98FwKR
   Rh4dV7XbE9eh3HCAcMWqfo1yqjNJKroWLmBmrF6q+XsypC29NE1ljcJHq
   Wj4Kb+MDu72b69k8JMAWk93iIC43cQj8DI5HVPSBkZj2fc2mQQNLeN047
   URWqP4reETR2yo46ejHgeAyBW04kN7W7xyjzrAr+52gYsK5Gxs4zG8MNJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314171048"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="314171048"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 03:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="835924857"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="835924857"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2023 03:04:51 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKH6g-0006Mo-36;
        Tue, 24 Jan 2023 11:04:50 +0000
Date:   Tue, 24 Jan 2023 19:04:48 +0800
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
Message-ID: <202301241800.pdnow11d-lkp@intel.com>
References: <20230124084323.1363825-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-2-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.2-rc5 next-20230124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230124-164601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230124084323.1363825-2-usama.anjum%40collabora.com
patch subject: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230124/202301241800.pdnow11d-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/59e98aec663b7ca8fd5f3b3d2a0f17f777f425c4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230124-164601
        git checkout 59e98aec663b7ca8fd5f3b3d2a0f17f777f425c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/mm_inline.h:9,
                    from kernel/fork.c:46:
>> include/linux/userfaultfd_k.h:278:5: warning: no previous prototype for 'userfaultfd_wp_async' [-Wmissing-prototypes]
     278 | int userfaultfd_wp_async(struct vm_area_struct *vma)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     162 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:862:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     862 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:957:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     957 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/hugetlb.h:14,
                    from kernel/sysctl.c:46:
>> include/linux/userfaultfd_k.h:278:5: warning: no previous prototype for 'userfaultfd_wp_async' [-Wmissing-prototypes]
     278 | int userfaultfd_wp_async(struct vm_area_struct *vma)
         |     ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/mm_inline.h:9,
                    from mm/memory.c:44:
>> include/linux/userfaultfd_k.h:278:5: warning: no previous prototype for 'userfaultfd_wp_async' [-Wmissing-prototypes]
     278 | int userfaultfd_wp_async(struct vm_area_struct *vma)
         |     ^~~~~~~~~~~~~~~~~~~~
   mm/memory.c: In function 'wp_huge_pmd':
   mm/memory.c:4824:33: error: implicit declaration of function 'set_pmd_at'; did you mean 'set_pte_at'? [-Werror=implicit-function-declaration]
    4824 |                                 set_pmd_at(vmf->vma->vm_mm, vmf->address, vmf->pmd,
         |                                 ^~~~~~~~~~
         |                                 set_pte_at
   cc1: some warnings being treated as errors
--
   In file included from include/linux/hugetlb.h:14,
                    from fs/proc/meminfo.c:6:
>> include/linux/userfaultfd_k.h:278:5: warning: no previous prototype for 'userfaultfd_wp_async' [-Wmissing-prototypes]
     278 | int userfaultfd_wp_async(struct vm_area_struct *vma)
         |     ^~~~~~~~~~~~~~~~~~~~
   fs/proc/meminfo.c:22:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      22 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~


vim +/userfaultfd_wp_async +278 include/linux/userfaultfd_k.h

   277	
 > 278	int userfaultfd_wp_async(struct vm_area_struct *vma)
   279	{
   280		return false;
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
