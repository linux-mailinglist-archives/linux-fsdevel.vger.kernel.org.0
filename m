Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7476B036B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 10:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCHJxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 04:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCHJxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:53:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D1AD03C;
        Wed,  8 Mar 2023 01:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678269167; x=1709805167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dxQJct6f43Jx0UnkB4zNZyJRb1ubXcUEMzADERU/HTo=;
  b=i4qA8kB9wpNWkbradAv19TUkDihJzH+V4+5n2BZoEYHiAZ0etZT8kbTg
   +GppTfBdDtTkVz7ZpKB5L2TfwfIzlXgzv81vNQYwGwL7+DKqvGlI4m51M
   J6Rgo+V16I0+HbHOuIFeAhR6SGgeYnawsTEZcrsiAjj1mkytHWGBpCnJc
   3SU+6KKIiea7qYsFzq6MUOrGomBemRVqi5TRdcpP/dRsxOaebIH9a3exD
   9btRN3kMP4HmcwmiySNRbvYJR7YT0XCUQgGaxeucOY4jfluwFofC53Q8N
   6kLoe3ZYo1SLZD6H2MRf5FGE85zjr4vRtv/WkUH0hg7mI9aVMpVm8Jqz0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333584672"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333584672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 01:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679277486"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="679277486"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2023 01:52:42 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZqTR-00021x-1W;
        Wed, 08 Mar 2023 09:52:41 +0000
Date:   Wed, 8 Mar 2023 17:51:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len
 arguments
Message-ID: <202303081703.nwxAgIVH-lkp@intel.com>
References: <20230306225024.264858-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306225024.264858-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Axel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc1]
[cannot apply to akpm-mm/mm-everything next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Axel-Rasmussen/mm-userfaultfd-rename-functions-for-clarity-consistency/20230307-065203
patch link:    https://lore.kernel.org/r/20230306225024.264858-5-axelrasmussen%40google.com
patch subject: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len arguments
config: x86_64-randconfig-a011-20230306 (https://download.01.org/0day-ci/archive/20230308/202303081703.nwxAgIVH-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cee642b93be3ae01c7cc737c0176cbc16074a25a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Axel-Rasmussen/mm-userfaultfd-rename-functions-for-clarity-consistency/20230307-065203
        git checkout cee642b93be3ae01c7cc737c0176cbc16074a25a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303081703.nwxAgIVH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/userfaultfd.c:577:52: error: passing 'const struct uffdio_range *' to parameter of incompatible type 'struct uffdio_range'
                   return  mfill_atomic_hugetlb(dst_vma, src_start, dst, flags);
                                                                    ^~~
   mm/userfaultfd.c:463:29: note: passing argument to parameter 'dst' here
                                       struct uffdio_range dst,
                                                           ^
   1 error generated.


vim +577 mm/userfaultfd.c

   508	
   509	static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
   510						    unsigned long src_start,
   511						    const struct uffdio_range *dst,
   512						    atomic_t *mmap_changing,
   513						    uffd_flags_t flags)
   514	{
   515		struct vm_area_struct *dst_vma;
   516		ssize_t err;
   517		pmd_t *dst_pmd;
   518		unsigned long src_addr, dst_addr;
   519		long copied;
   520		struct page *page;
   521	
   522		/*
   523		 * Sanitize the command parameters:
   524		 */
   525		BUG_ON(dst->start & ~PAGE_MASK);
   526		BUG_ON(dst->len & ~PAGE_MASK);
   527	
   528		/* Does the address range wrap, or is the span zero-sized? */
   529		BUG_ON(src_start + dst->len <= src_start);
   530		BUG_ON(dst->start + dst->len <= dst->start);
   531	
   532		src_addr = src_start;
   533		dst_addr = dst->start;
   534		copied = 0;
   535		page = NULL;
   536	retry:
   537		mmap_read_lock(dst_mm);
   538	
   539		/*
   540		 * If memory mappings are changing because of non-cooperative
   541		 * operation (e.g. mremap) running in parallel, bail out and
   542		 * request the user to retry later
   543		 */
   544		err = -EAGAIN;
   545		if (mmap_changing && atomic_read(mmap_changing))
   546			goto out_unlock;
   547	
   548		/*
   549		 * Make sure the vma is not shared, that the dst range is
   550		 * both valid and fully within a single existing vma.
   551		 */
   552		err = -ENOENT;
   553		dst_vma = find_dst_vma(dst_mm, dst);
   554		if (!dst_vma)
   555			goto out_unlock;
   556	
   557		err = -EINVAL;
   558		/*
   559		 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
   560		 * it will overwrite vm_ops, so vma_is_anonymous must return false.
   561		 */
   562		if (WARN_ON_ONCE(vma_is_anonymous(dst_vma) &&
   563		    dst_vma->vm_flags & VM_SHARED))
   564			goto out_unlock;
   565	
   566		/*
   567		 * validate 'mode' now that we know the dst_vma: don't allow
   568		 * a wrprotect copy if the userfaultfd didn't register as WP.
   569		 */
   570		if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
   571			goto out_unlock;
   572	
   573		/*
   574		 * If this is a HUGETLB vma, pass off to appropriate routine
   575		 */
   576		if (is_vm_hugetlb_page(dst_vma))
 > 577			return  mfill_atomic_hugetlb(dst_vma, src_start, dst, flags);
   578	
   579		if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
   580			goto out_unlock;
   581		if (!vma_is_shmem(dst_vma) &&
   582		    (flags & MFILL_ATOMIC_MODE_MASK) == MFILL_ATOMIC_CONTINUE)
   583			goto out_unlock;
   584	
   585		/*
   586		 * Ensure the dst_vma has a anon_vma or this page
   587		 * would get a NULL anon_vma when moved in the
   588		 * dst_vma.
   589		 */
   590		err = -ENOMEM;
   591		if (!(dst_vma->vm_flags & VM_SHARED) &&
   592		    unlikely(anon_vma_prepare(dst_vma)))
   593			goto out_unlock;
   594	
   595		while (src_addr < src_start + dst->len) {
   596			pmd_t dst_pmdval;
   597	
   598			BUG_ON(dst_addr >= dst->start + dst->len);
   599	
   600			dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
   601			if (unlikely(!dst_pmd)) {
   602				err = -ENOMEM;
   603				break;
   604			}
   605	
   606			dst_pmdval = pmdp_get_lockless(dst_pmd);
   607			/*
   608			 * If the dst_pmd is mapped as THP don't
   609			 * override it and just be strict.
   610			 */
   611			if (unlikely(pmd_trans_huge(dst_pmdval))) {
   612				err = -EEXIST;
   613				break;
   614			}
   615			if (unlikely(pmd_none(dst_pmdval)) &&
   616			    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
   617				err = -ENOMEM;
   618				break;
   619			}
   620			/* If an huge pmd materialized from under us fail */
   621			if (unlikely(pmd_trans_huge(*dst_pmd))) {
   622				err = -EFAULT;
   623				break;
   624			}
   625	
   626			BUG_ON(pmd_none(*dst_pmd));
   627			BUG_ON(pmd_trans_huge(*dst_pmd));
   628	
   629			err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
   630					       src_addr, &page, flags);
   631			cond_resched();
   632	
   633			if (unlikely(err == -ENOENT)) {
   634				void *page_kaddr;
   635	
   636				mmap_read_unlock(dst_mm);
   637				BUG_ON(!page);
   638	
   639				page_kaddr = kmap_local_page(page);
   640				err = copy_from_user(page_kaddr,
   641						     (const void __user *) src_addr,
   642						     PAGE_SIZE);
   643				kunmap_local(page_kaddr);
   644				if (unlikely(err)) {
   645					err = -EFAULT;
   646					goto out;
   647				}
   648				flush_dcache_page(page);
   649				goto retry;
   650			} else
   651				BUG_ON(page);
   652	
   653			if (!err) {
   654				dst_addr += PAGE_SIZE;
   655				src_addr += PAGE_SIZE;
   656				copied += PAGE_SIZE;
   657	
   658				if (fatal_signal_pending(current))
   659					err = -EINTR;
   660			}
   661			if (err)
   662				break;
   663		}
   664	
   665	out_unlock:
   666		mmap_read_unlock(dst_mm);
   667	out:
   668		if (page)
   669			put_page(page);
   670		BUG_ON(copied < 0);
   671		BUG_ON(err > 0);
   672		BUG_ON(!copied && !err);
   673		return copied ? copied : err;
   674	}
   675	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
