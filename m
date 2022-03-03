Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577684CBD1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 12:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiCCLtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 06:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiCCLtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:49:24 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D40C9904;
        Thu,  3 Mar 2022 03:48:38 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K8Tf31kmczZdNk;
        Thu,  3 Mar 2022 19:43:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 19:48:35 +0800
Subject: Re: [PATCH 4/8] mm: thp: only regular file could be THP eligible
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Yang Shi <shy828301@gmail.com>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kbuild@lists.01.org>, <vbabka@suse.cz>,
        <kirill.shutemov@linux.intel.com>, <songliubraving@fb.com>,
        <riel@surriel.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <akpm@linux-foundation.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <darrick.wong@oracle.com>
References: <202203020034.2Ii9kTrs-lkp@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6c8b9d6b-fc31-11d6-c5d4-c18b3854b4e9@huawei.com>
Date:   Thu, 3 Mar 2022 19:48:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202203020034.2Ii9kTrs-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/3/3 19:43, Dan Carpenter wrote:
> Hi Yang,
> 
> url:    https://github.com/0day-ci/linux/commits/Yang-Shi/Make-khugepaged-collapse-readonly-FS-THP-more-consistent/20220301-075903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: arm64-randconfig-m031-20220227 (https://download.01.org/0day-ci/archive/20220302/202203020034.2Ii9kTrs-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> include/linux/huge_mm.h:179 file_thp_enabled() warn: variable dereferenced before check 'vma->vm_file' (see line 177)
> mm/khugepaged.c:468 hugepage_vma_check() error: we previously assumed 'vma->vm_file' could be null (see line 455)
> include/linux/huge_mm.h:179 file_thp_enabled() warn: variable dereferenced before check 'vma->vm_file' (see line 177)
> 
> vim +179 include/linux/huge_mm.h
> 
> 2224ed1155c07b Yang Shi     2022-02-28  175  static inline bool file_thp_enabled(struct vm_area_struct *vma)
> 2224ed1155c07b Yang Shi     2022-02-28  176  {
> 2224ed1155c07b Yang Shi     2022-02-28 @177  	struct inode *inode = vma->vm_file->f_inode;
>                                                                       ^^^^^^^^^^^^^^
> Dereference.
> 
> 2224ed1155c07b Yang Shi     2022-02-28  178  
> 2224ed1155c07b Yang Shi     2022-02-28 @179  	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) && vma->vm_file &&
>                                                                                                     ^^^^^^^^^^^^
> Checked too late.

Yep. We should check vma->vm_file first before we access vma->vm_file->f_inode.

Thanks.

> 
> 2224ed1155c07b Yang Shi     2022-02-28  180  	       (vma->vm_flags & VM_EXEC) &&
> 2224ed1155c07b Yang Shi     2022-02-28  181  	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
> 2224ed1155c07b Yang Shi     2022-02-28  182  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> .
> 

