Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDFB68322C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 17:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjAaQFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 11:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjAaQFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:05:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877A0460B5;
        Tue, 31 Jan 2023 08:04:42 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1817E6602EBA;
        Tue, 31 Jan 2023 16:04:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675181080;
        bh=bWKosL3FqQvGKVbLtHwh+SviC5G8f7DqaNQ3HiK29gg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=mwyaDxKJAgsiN57aH1NG+118IRW4nXqfCENped3PNLTVXscFLnCORdHU0Y7018s7e
         a/xzkXGtIHGAUNgO92cQeor2oHe1iEjqRos1cyJficaxPOxybgB/Bjhe0dPuW34Ojv
         RfCkTGF9ARvcNY02mCp8+ScZ37tkKNUjN3earw5U5qAt14LGzgw04cjRxx3vETcpyZ
         fniY/yXMn+IR7xGkfAsUXwQlv23+37inwe6p7QcVaLxUy+32ig754ma4g7Bey4C9GK
         /iTCphurFTH3Yge6p0oZDKvFe0WqqDdGrUEcjV8xRlYU8CF7wMDkT66ORWpS+w7SKF
         C8TcyeBZH42KQ==
Message-ID: <ef9c0a5a-4697-c21f-0da5-aa5698cdcb6b@collabora.com>
Date:   Tue, 31 Jan 2023 21:04:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        oe-kbuild-all@lists.linux.dev,
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
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
References: <20230131083257.3302830-3-usama.anjum@collabora.com>
 <202301312359.8WtBkSkQ-lkp@intel.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202301312359.8WtBkSkQ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/31/23 8:52 PM, kernel test robot wrote:
> Hi Muhammad,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on shuah-kselftest/fixes]
> [also build test ERROR on linus/master v6.2-rc6 next-20230131]
> [cannot apply to shuah-kselftest/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230131-163537
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git fixes
> patch link:    https://lore.kernel.org/r/20230131083257.3302830-3-usama.anjum%40collabora.com
> patch subject: [PATCH v9 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about PTEs
> config: arc-defconfig (https://download.01.org/0day-ci/archive/20230131/202301312359.8WtBkSkQ-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/11677b6b7fda958031115ea40aa219fc32c7dea4
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230131-163537
>         git checkout 11677b6b7fda958031115ea40aa219fc32c7dea4
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
>>> fs/proc/task_mmu.c:1927:17: error: implicit declaration of function 'uffd_wp_range' [-Werror=implicit-function-declaration]
>     1927 |                 uffd_wp_range(walk->mm, vma, start, addr - start, true);
>          |                 ^~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
I'll fix this by adding the following patch in next version:

--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -190,6 +190,11 @@ static inline vm_fault_t handle_userfault(struct
vm_fault *vmf,
        return VM_FAULT_SIGBUS;
 }

+static inline void uffd_wp_range(struct mm_struct *dst_mm, struct
vm_area_struct *vma,
+                                unsigned long start, unsigned long len,
bool enable_wp)
+{
+}
+




> 
> 
> vim +/uffd_wp_range +1927 fs/proc/task_mmu.c
> 
>   1915	
>   1916		pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
>   1917		if (IS_GET_OP(p)) {
>   1918			for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
>   1919				ret = pagemap_scan_output(!is_pte_uffd_wp(*pte), vma->vm_file,
>   1920							  pte_present(*pte), is_swap_pte(*pte), p, addr, 1);
>   1921				if (ret)
>   1922					break;
>   1923			}
>   1924		}
>   1925		pte_unmap_unlock(pte - 1, ptl);
>   1926		if ((!ret || ret == -ENOSPC) && IS_WP_ENGAGE_OP(p) && (addr - start))
>> 1927			uffd_wp_range(walk->mm, vma, start, addr - start, true);
>   1928	
>   1929		cond_resched();
>   1930		return ret;
>   1931	}
>   1932	
> 

-- 
BR,
Muhammad Usama Anjum
