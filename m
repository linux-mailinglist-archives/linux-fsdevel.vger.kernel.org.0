Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1826260B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKKRxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 12:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiKKRxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:53:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8193EE0C9;
        Fri, 11 Nov 2022 09:53:36 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 328A36602A42;
        Fri, 11 Nov 2022 17:53:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668189214;
        bh=BJ+AWNRBs37O/vroIuOnKRKFU1FAcznNxa7O4t+Ettc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Z03RLoa3WDhoNF5Y4ua4HmTWVwMby4WPymL6xf7siE/EuA304MBUiSvsfJvqyVPOx
         sqfx44mJq43DdpUoeaZLKSp3427dPKhyx88oVTBWYLXwwnmwa/p9quY3m0peV50OVu
         c5O6fLvD3beQjQU0eDYLdDpBTcIDizHeyNWU6vbg7ZwP5VpMqjfFWu7nZ7vlq4dZ8a
         e0QthQi6T7PGOZr4+oYFH9ljB2QJ6M0vgH5u22ttm/1tCsuEgxv6yioiGUGWz58IPZ
         YyKYBCZF+ANfPG4DrElkxbGHy3LHFtYgYM4IB+Ru1OhxAqMXQR2sThA6Mynq+tVxJ7
         teMuH7aFm/4eg==
Message-ID: <d69b349e-fe8d-5ffc-01cb-8ec05fc32be9@collabora.com>
Date:   Fri, 11 Nov 2022 22:53:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v6 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <greg@kroah.com>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        Paul Gofman <pgofman@codeweavers.com>
References: <20221109102303.851281-3-usama.anjum@collabora.com>
 <202211120107.cYLiq2cH-lkp@intel.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202211120107.cYLiq2cH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've fixed these build failure for the next patch iteration. Please comment
and review on the patch. I'll wait for a few days before sending next version.

On 11/11/22 10:13 PM, kernel test robot wrote:
> Hi Muhammad,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20221109]
> [also build test ERROR on v6.1-rc4]
> [cannot apply to shuah-kselftest/next shuah-kselftest/fixes linus/master v6.1-rc4 v6.1-rc3 v6.1-rc2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/Implement-IOCTL-to-get-and-or-the-clear-info-about-PTEs/20221109-182618
> patch link:    https://lore.kernel.org/r/20221109102303.851281-3-usama.anjum%40collabora.com
> patch subject: [PATCH v6 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about PTEs
> config: arm-buildonly-randconfig-r006-20221111
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 463da45892e2d2a262277b91b96f5f8c05dc25d0)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/b329378abd03a741ff7250ec1b60292c893476da
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Muhammad-Usama-Anjum/Implement-IOCTL-to-get-and-or-the-clear-info-about-PTEs/20221109-182618
>         git checkout b329378abd03a741ff7250ec1b60292c893476da
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> fs/proc/task_mmu.c:1882:41: error: use of undeclared identifier 'HPAGE_SIZE'
>                            if ((IS_CLEAR_OP(p) && (end - addr < HPAGE_SIZE))) {
>                                                                 ^
>    1 error generated.
> 
> 
> vim +/HPAGE_SIZE +1882 fs/proc/task_mmu.c
> 
>   1856	
>   1857	static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long addr,
>   1858					  unsigned long end, struct mm_walk *walk)
>   1859	{
>   1860		struct pagemap_scan_private *p = walk->private;
>   1861		struct vm_area_struct *vma = walk->vma;
>   1862		unsigned int len;
>   1863		spinlock_t *ptl;
>   1864		int ret = 0;
>   1865		pte_t *pte;
>   1866		bool dirty_vma = (p->flags & PAGEMAP_NO_REUSED_REGIONS) ?
>   1867				 (false) : (vma->vm_flags & VM_SOFTDIRTY);
>   1868	
>   1869		if ((walk->vma->vm_end < addr) || (p->max_pages && p->found_pages == p->max_pages))
>   1870			return 0;
>   1871	
>   1872		end = min(end, walk->vma->vm_end);
>   1873	
>   1874		ptl = pmd_trans_huge_lock(pmd, vma);
>   1875		if (ptl) {
>   1876			if (dirty_vma || check_soft_dirty_pmd(vma, addr, pmd, false)) {
>   1877				/*
>   1878				 * Break huge page into small pages if operation needs to be performed is
>   1879				 * on a portion of the huge page or the return buffer cannot store complete
>   1880				 * data.
>   1881				 */
>> 1882				if ((IS_CLEAR_OP(p) && (end - addr < HPAGE_SIZE))) {
>   1883					spin_unlock(ptl);
>   1884					split_huge_pmd(vma, pmd, addr);
>   1885					goto process_smaller_pages;
>   1886				}
>   1887	
>   1888				if (IS_GET_OP(p)) {
>   1889					len = (end - addr)/PAGE_SIZE;
>   1890					if (p->max_pages && p->found_pages + len > p->max_pages)
>   1891						len = p->max_pages - p->found_pages;
>   1892	
>   1893					ret = add_to_out(dirty_vma ||
>   1894							 check_soft_dirty_pmd(vma, addr, pmd, false),
>   1895							 vma->vm_file, pmd_present(*pmd), is_swap_pmd(*pmd),
>   1896							 p, addr, len);
>   1897				}
>   1898				if (!ret && IS_CLEAR_OP(p))
>   1899					check_soft_dirty_pmd(vma, addr, pmd, true);
>   1900			}
>   1901			spin_unlock(ptl);
>   1902			return 0;
>   1903		}
>   1904	
>   1905	process_smaller_pages:
>   1906		if (pmd_trans_unstable(pmd))
>   1907			return 0;
>   1908	
>   1909		pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>   1910		for (; addr < end && !ret && (!p->max_pages || (p->found_pages < p->max_pages))
>   1911		     ; pte++, addr += PAGE_SIZE) {
>   1912			if (IS_GET_OP(p))
>   1913				ret = add_to_out(dirty_vma || check_soft_dirty(vma, addr, pte, false),
>   1914						 vma->vm_file, pte_present(*pte),
>   1915						 is_swap_pte(*pte), p, addr, 1);
>   1916			if (!ret && IS_CLEAR_OP(p))
>   1917				check_soft_dirty(vma, addr, pte, true);
>   1918		}
>   1919		pte_unmap_unlock(pte - 1, ptl);
>   1920		cond_resched();
>   1921	
>   1922		return 0;
>   1923	}
>   1924	
> 

-- 
BR,
Muhammad Usama Anjum
