Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED721B8245
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 00:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDXW6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 18:58:33 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2181 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXW6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:58:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea36f090000>; Fri, 24 Apr 2020 15:58:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 Apr 2020 15:58:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 Apr 2020 15:58:30 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Apr
 2020 22:58:30 +0000
Received: from [10.2.53.96] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Apr
 2020 22:58:29 +0000
Subject: Re: [regression] Re: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
 <20200211001536.1027652-7-jhubbard@nvidia.com>
 <20200424121846.5ee2685f@w520.home>
 <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
 <20200424141548.5afdd2bb@w520.home>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <665ffb48-d498-90f4-f945-997a922fc370@nvidia.com>
Date:   Fri, 24 Apr 2020 15:58:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424141548.5afdd2bb@w520.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587769097; bh=eWq6lnMyYMCE4u6Qo5YJg74M9siYA8iyhwQdRnlfX1c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=c2hKhoEuSh1BAJrQqwmQ4yRX74kL6heQtFpgh7vdU0THjF65L33iCiD03eDW+FA/A
         gPzdByilynRgl6PXyZbjbFqiMAPfg2MC2yWKEUmWV3hNz2kXS0FG1vD8v0ladCzvkp
         ensNbePajMC62D3wlNBE0ggKDFPB7iksWmuTz/TmgzRz66HITXTAXbFjLQsDogUOac
         89EWT/bWRcVSdjG/Jj1uvJd+YfWM6Dzo6LnQHChsW1bmPSswJ20xCCbZ+ZSP/f5ouO
         xEjzb7jndBL51nmhtJ3vfyuBMCtIVJy+ryq2i429v4MB4nctSJU5bnSnOJtk2esANH
         vYuZIhb4iJBWA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-24 13:15, Alex Williamson wrote:
> On Fri, 24 Apr 2020 12:20:03 -0700
> John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> On 2020-04-24 11:18, Alex Williamson wrote:
>> ...
>>> Hi John,
>>>
>>> I'm seeing a regression bisected back to this commit (3faa52c03f44
>>> mm/gup: track FOLL_PIN pages).  I've attached some vfio-pci test code
>>> that reproduces this by mmap'ing a page of MMIO space of a device and
>>> then tries to map that through the IOMMU, so this should be attempting
>>> a gup/pin of a PFNMAP page.  Previously this failed gracefully (-EFAULT),
>>> but now results in:
>>
>>
>> Hi Alex,
>>
>> Thanks for this report, and especially for source code to test it,
>> seeing as how I can't immediately spot the problem just from the crash
>> data so far.  I'll get set up and attempt a repro.
>>
>> Actually this looks like it should be relatively easier than the usual
>> sort of "oops, we leaked a pin_user_pages() or unpin_user_pages() call,
>> good luck finding which one" report that I fear the most. :) This one
>> looks more like a crash that happens directly, when calling into the
>> pin_user_pages_remote() code. Which should be a lot easier to solve...
>>
>> btw, if you are set up for it, it would be nice to know what source file
>> and line number corresponds to the RIP (get_pfnblock_flags_mask+0x22)
>> below. But if not, no problem, because I've likely got to do the repro
>> in any case.
> 
> Hey John,
> 
> TBH I'm feeling a lot less confident about this bisect.  This was
> readily reproducible to me on a clean tree a bit ago, but now it
> eludes me.  Let me go back and figure out what's going on before you
> spend any more time on it.  Thanks,
> 

OK. But I'm keeping the repro program! :)  It made it quick and easy to
set up a vfio test, so it was worth doing in any case.

Anyway, I wanted to double check this just out of paranoia, and so
now I have a data point for you: your test program runs and passes for
me using today's linux.git kernel, with an NVIDIA GPU as the vfio
device, and the kernel log is clean. No hint of any problems.

I traced it a little bit:

# sudo bpftrace -e kprobe:__get_user_pages { @[kstack()] = count(); }
Attaching 1 probe...
^C
...
@[
     __get_user_pages+1
     __gup_longterm_locked+176
     vaddr_get_pfn+104
     vfio_pin_pages_remote+113
     vfio_dma_do_map+760
     vfio_iommu_type1_ioctl+761
     ksys_ioctl+135
     __x64_sys_ioctl+22
     do_syscall_64+90
     entry_SYSCALL_64_after_hwframe+73
]: 1

...and also verified that it's not actually pinning any pages with that
path:

$ grep foll_pin /proc/vmstat
nr_foll_pin_acquired 0
nr_foll_pin_released 0


Good luck and let me know if it starts pointing to FOLL_PIN or gup, etc.

thanks,
-- 
John Hubbard
NVIDIA
