Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F727253A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 07:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjFGFpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 01:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFGFp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:45:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC97719AE;
        Tue,  6 Jun 2023 22:45:27 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 25F176606EEC;
        Wed,  7 Jun 2023 06:45:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686116726;
        bh=v41rsZme1rrV0UDXeZHFRH87LHFl+vrfIF59dWd8644=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Ln2fFhtz2qsFxNskc9DRPGajGdxp019E1vLoMvosoin3RKletQ2orcyC4YuLjdY01
         JaU4b7GQoLlwbozJ1Pw7BhRChJhPo50bbAELcTyIfidtwcBQI5bSObpoECpaJNvmFv
         1GN/DP6+j4yf0qwtmBvOl8tu6HNklqehJLGA+VVFtg5QbnukNQ0eYEj1XGJxg2p7AZ
         eemWiFjsUaVBmknD97DhWLz899nKupk6A28+TQApefSnWZ8BqxCHd1rM9mQ1CpiFmf
         +wWJxnECNVIIU9y7uSXuESRQqhuRGh72rzTCmti9Ian7gJJtJgNSYasZ25DJK3kZBS
         bZbwZJONntqCw==
Message-ID: <9d8b5b8e-47c9-16dd-050a-45d917d73c07@collabora.com>
Date:   Wed, 7 Jun 2023 10:45:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>,
        kernel test robot <lkp@intel.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
References: <20230406074005.1784728-3-usama.anjum@collabora.com>
 <202304061914.N1Hmx12N-lkp@intel.com>
 <e3c82373-256a-6297-bcb4-5e1179a2cbe2@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <e3c82373-256a-6297-bcb4-5e1179a2cbe2@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/6/23 5:56 PM, Muhammad Usama Anjum wrote:
> On 4/6/23 4:40 PM, kernel test robot wrote:
>> Hi Muhammad,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on akpm-mm/mm-everything]
>> [also build test ERROR on next-20230406]
>> [cannot apply to linus/master v6.3-rc5]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230406-154314
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>> patch link:    https://lore.kernel.org/r/20230406074005.1784728-3-usama.anjum%40collabora.com
>> patch subject: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
>> config: arc-randconfig-r023-20230405 (https://download.01.org/0day-ci/archive/20230406/202304061914.N1Hmx12N-lkp@intel.com/config)
>> compiler: arceb-elf-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/intel-lab-lkp/linux/commit/f13abb36f64c77913509da8ca157512d2fb9f031
>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>         git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230406-154314
>>         git checkout f13abb36f64c77913509da8ca157512d2fb9f031
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/proc/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Link: https://lore.kernel.org/oe-kbuild-all/202304061914.N1Hmx12N-lkp@intel.com/
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>    fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
>>>> fs/proc/task_mmu.c:1921:37: error: 'HPAGE_SIZE' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
>>     1921 |                     ((end - start < HPAGE_SIZE) ||
>>          |                                     ^~~~~~~~~~
>>          |                                     PAGE_SIZE
> It seems arc architecture supports CONFIG_TRANSPARENT_HUGEPAGE, but it
> doesn't define HPAGE_SIZE. It only defines PAGE_SIZE in
> include/uapi/asm/page.h? AFAIK HPAGE_SIZE must be defined when
> CONFIG_TRANSPARENT_HUGEPAGE is enabled. What can be the solution here for arc?
I'm still looking for solution. Vineet do you have some thoughts?

> 
> The remaining build failures are because the wrong tree. I base my patches
> on latest next, while the bot has based patches on mm-everything. I guess
> today's next would have latest mm stuff, a rebase would make things correct
> or I'll shift to mm-everything.
> 
> 

-- 
BR,
Muhammad Usama Anjum
