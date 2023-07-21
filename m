Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B275BC9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 04:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGUC6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 22:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGUC6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:58:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDDA2690;
        Thu, 20 Jul 2023 19:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689908286; x=1721444286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kAfnjUsMkeVOvOzOihPjEhY2+hkQ8lG+O+rh2M9hN3I=;
  b=H9rmotCwT4ckzQWswhxn4Ib6CiDiPsJiNXD7UGG0w1dk6JNMKwnaMQtz
   zmY8JadwDEYag8h1JCh7xZD5/2XHr+3L2U0dAT3UqUyGEjMAhf9ypk2ah
   7pAql0yy3QDyhmZ2KaYJixiGH0t5ecCxhAf6fh5vWkwEqNn9FQLMNiLt7
   3wiET+S8XA+75TV97domAi/mCbW/NfWvIJ3qpmKxOGiDUgqoXyrqzHKe8
   w9D2du8wYQLtqsfve/0HSF3HHOWHgVWZMx9D3IGszljnzFOeccsGS4vNX
   qvbRxW/b6IcOVKgJAVm1XCk0eYfgSuAg9YQ5L4T8bmGfwtZWxZEsRvCKt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="365817081"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="365817081"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 19:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898560727"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898560727"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 19:57:57 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMgKz-0006nV-0O;
        Fri, 21 Jul 2023 02:57:54 +0000
Date:   Fri, 21 Jul 2023 10:56:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        David Hildenbrand <david@redhat.com>, Greg KH <greg@kroah.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Message-ID: <202307211030.2CJH6TkM-lkp@intel.com>
References: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michał,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/Re-fs-proc-task_mmu-Implement-IOCTL-for-efficient-page-table-scanning/20230721-033050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux%40rere.qmqm.pl
patch subject: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
config: arc-randconfig-r035-20230720 (https://download.01.org/0day-ci/archive/20230721/202307211030.2CJH6TkM-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307211030.2CJH6TkM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307211030.2CJH6TkM-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_test_walk':
   fs/proc/task_mmu.c:1921:13: error: implicit declaration of function 'userfaultfd_wp_async'; did you mean 'userfaultfd_wp'? [-Werror=implicit-function-declaration]
    1921 |         if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
         |             ^~~~~~~~~~~~~~~~~~~~
         |             userfaultfd_wp
   fs/proc/task_mmu.c: In function 'pagemap_scan_pte_hole':
>> fs/proc/task_mmu.c:2200:19: error: implicit declaration of function 'uffd_wp_range' [-Werror=implicit-function-declaration]
    2200 |         int err = uffd_wp_range(vma, addr, end - addr, true);
         |                   ^~~~~~~~~~~~~
   fs/proc/task_mmu.c: In function 'pagemap_scan_init_bounce_buffer':
   fs/proc/task_mmu.c:2290:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2290 |         p->vec_out = (void __user *)p->arg.vec;
         |                      ^
   fs/proc/task_mmu.c: At top level:
   fs/proc/task_mmu.c:1967:13: warning: 'pagemap_scan_backout_range' defined but not used [-Wunused-function]
    1967 | static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/uffd_wp_range +2200 fs/proc/task_mmu.c

  2182	
  2183	static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
  2184					 int depth, struct mm_walk *walk)
  2185	{
  2186		struct pagemap_scan_private *p = walk->private;
  2187		struct vm_area_struct *vma = walk->vma;
  2188		int ret;
  2189	
  2190		if (!vma || !pagemap_scan_is_interesting_page(p->cur_vma_category, p))
  2191			return 0;
  2192	
  2193		ret = pagemap_scan_output(p->cur_vma_category, p, addr, &end);
  2194		if (addr == end)
  2195			return ret;
  2196	
  2197		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
  2198			return ret;
  2199	
> 2200		int err = uffd_wp_range(vma, addr, end - addr, true);
  2201		if (err < 0)
  2202			ret = err;
  2203	
  2204		return ret;
  2205	}
  2206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
