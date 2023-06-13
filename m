Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F472DFAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 12:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbjFMKg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 06:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbjFMKgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:36:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB51E55;
        Tue, 13 Jun 2023 03:35:57 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F391660000E;
        Tue, 13 Jun 2023 11:35:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686652555;
        bh=HbdSMphLp1/aGNarPBMTAmoMfCdZYDwXjyzqGZPOGtA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=eCbyTU2BUbopMEp0/l014XJDWH7zLmxfwh6N+IuQqSPT8pAD5HNik18UCjw7Dsc7G
         /vqmj4fttKTO0BVCwJiqnn48/01nNX5aJ0czU9q13HY6d5YgAECt/27yeFOtmBpd5+
         1cpwi9XnJK3ImYUXPXD7oHwevazumaZiK+213l1QbvXH3obGgIQcOM8NZ+b6+7nVDX
         nRzqIZebJjG/SqbTFdtsx9sGMAlu6nQlFv73gbfOQKnr0k8dXPJ3QIrX4IWQdOrzEQ
         /Y962W7NI2pvyTejjNeSukWiaANvS0kljQtCv2nU/ewwoBDQK0Q3Wtevvf6mii2biX
         uqIW8Jt3z6Rcg==
Message-ID: <0e6b318a-bbf8-3701-00af-1802c6347897@collabora.com>
Date:   Tue, 13 Jun 2023 15:35:44 +0500
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
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>
References: <20230406074005.1784728-3-usama.anjum@collabora.com>
 <202304061914.N1Hmx12N-lkp@intel.com>
 <e3c82373-256a-6297-bcb4-5e1179a2cbe2@collabora.com>
 <9d8b5b8e-47c9-16dd-050a-45d917d73c07@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <9d8b5b8e-47c9-16dd-050a-45d917d73c07@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vineet,

It seems arc architecture supports CONFIG_TRANSPARENT_HUGEPAGE, but it
doesn't define HPAGE_SIZE. It only defines PAGE_SIZE in
include/uapi/asm/page.h? AFAIK HPAGE_SIZE must be defined when
CONFIG_TRANSPARENT_HUGEPAGE is enabled. What can be the solution here for arc?

Should I just compile out this code for arc architecture specifically?

Thanks,
Usama


On 6/7/23 10:45 AM, Muhammad Usama Anjum wrote:
> On 4/6/23 5:56 PM, Muhammad Usama Anjum wrote:
>> On 4/6/23 4:40 PM, kernel test robot wrote:
>>> Hi Muhammad,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on akpm-mm/mm-everything]
>>> [also build test ERROR on next-20230406]
>>> [cannot apply to linus/master v6.3-rc5]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230406-154314
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>>> patch link:    https://lore.kernel.org/r/20230406074005.1784728-3-usama.anjum%40collabora.com
>>> patch subject: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
>>> config: arc-randconfig-r023-20230405 (https://download.01.org/0day-ci/archive/20230406/202304061914.N1Hmx12N-lkp@intel.com/config)
>>> compiler: arceb-elf-gcc (GCC) 12.1.0
>>> reproduce (this is a W=1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # https://github.com/intel-lab-lkp/linux/commit/f13abb36f64c77913509da8ca157512d2fb9f031
>>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>>         git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230406-154314
>>>         git checkout f13abb36f64c77913509da8ca157512d2fb9f031
>>>         # save the config file
>>>         mkdir build_dir && cp config build_dir/.config
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/proc/
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Link: https://lore.kernel.org/oe-kbuild-all/202304061914.N1Hmx12N-lkp@intel.com/
>>>
>>> All error/warnings (new ones prefixed by >>):
>>>
>>>    fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
>>>>> fs/proc/task_mmu.c:1921:37: error: 'HPAGE_SIZE' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
>>>     1921 |                     ((end - start < HPAGE_SIZE) ||
>>>          |                                     ^~~~~~~~~~
>>>          |                                     PAGE_SIZE
>> It seems arc architecture supports CONFIG_TRANSPARENT_HUGEPAGE, but it
>> doesn't define HPAGE_SIZE. It only defines PAGE_SIZE in
>> include/uapi/asm/page.h? AFAIK HPAGE_SIZE must be defined when
>> CONFIG_TRANSPARENT_HUGEPAGE is enabled. What can be the solution here for arc?
> I'm still looking for solution. Vineet do you have some thoughts?
> 
>>
>> The remaining build failures are because the wrong tree. I base my patches
>> on latest next, while the bot has based patches on mm-everything. I guess
>> today's next would have latest mm stuff, a rebase would make things correct
>> or I'll shift to mm-everything.
>>
>>
> 

-- 
BR,
Muhammad Usama Anjum
