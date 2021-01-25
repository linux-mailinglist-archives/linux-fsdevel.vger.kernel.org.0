Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBD3020F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 05:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbhAYEJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 23:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbhAYEJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:09:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2CFC061573;
        Sun, 24 Jan 2021 20:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+IJV3bEfZ7kR0QePaso8V0y8l7olQ2am3PHLp7mjaRk=; b=P/iaNSkwB7i3Vy7vJfDCjMsweS
        xHuL9HuKIv3j4vS9CVemwEi4aJW+VXHPhkvmHlRF0nLhZqtylwMkIlMvErBn+iAxt2UIZff+o7RGS
        s8RtUiG/PTSJYPN8EpF/Oi2CwfXTLsdAtRowR9lwR+KNqwuZQwuF4X56t8k95/SYycRYTcIgRbNjM
        r6fBCZITTai9e+6jxL0ICLZyfKa3JNc3SpWDixf1x32YjxUwN6lcZsTjI7Y9RDkiNxtuhzy+rImqP
        u+bVbFOMu2aWa4kms1lmQ94LONlSnADzHivTgXjExKPRzhtQ7GkZVq1NPOH4bC9BZa9TWvQYQv5y/
        5mmcnKJw==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l3tBR-0000iE-Pd; Mon, 25 Jan 2021 04:08:58 +0000
Subject: Re: [External] Re: [PATCH v13 02/12] mm: hugetlb: introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-3-songmuchun@bytedance.com>
 <472a58b9-12cb-3c3-d132-13dbae5174f0@google.com>
 <CAMZfGtUGT6UP3aBEGmMvahOu5akvqoVoiXQqQvAdY82P6VGiTg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eef4ff8b-f3e3-6ae0-bae8-243bd0c8add0@infradead.org>
Date:   Sun, 24 Jan 2021 20:08:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUGT6UP3aBEGmMvahOu5akvqoVoiXQqQvAdY82P6VGiTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/21 8:06 PM, Muchun Song wrote:
> On Mon, Jan 25, 2021 at 7:58 AM David Rientjes <rientjes@google.com> wrote:
>>
>>
>> On Sun, 17 Jan 2021, Muchun Song wrote:
>>
>>> The HUGETLB_PAGE_FREE_VMEMMAP option is used to enable the freeing
>>> of unnecessary vmemmap associated with HugeTLB pages. The config
>>> option is introduced early so that supporting code can be written
>>> to depend on the option. The initial version of the code only
>>> provides support for x86-64.
>>>
>>> Like other code which frees vmemmap, this config option depends on
>>> HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
>>> used to register bootmem info. Therefore, make sure
>>> register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
>>> is defined.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  arch/x86/mm/init_64.c |  2 +-
>>>  fs/Kconfig            | 18 ++++++++++++++++++
>>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>> index 0a45f062826e..0435bee2e172 100644
>>> --- a/arch/x86/mm/init_64.c
>>> +++ b/arch/x86/mm/init_64.c
>>> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
>>>
>>>  static void __init register_page_bootmem_info(void)
>>>  {
>>> -#ifdef CONFIG_NUMA
>>> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
>>>       int i;
>>>
>>>       for_each_online_node(i)
>>> diff --git a/fs/Kconfig b/fs/Kconfig
>>> index 976e8b9033c4..e7c4c2a79311 100644
>>> --- a/fs/Kconfig
>>> +++ b/fs/Kconfig
>>> @@ -245,6 +245,24 @@ config HUGETLBFS
>>>  config HUGETLB_PAGE
>>>       def_bool HUGETLBFS
>>>
>>> +config HUGETLB_PAGE_FREE_VMEMMAP
>>> +     def_bool HUGETLB_PAGE
>>
>> I'm not sure I understand the rationale for providing this help text if
>> this is def_bool depending on CONFIG_HUGETLB_PAGE.  Are you intending that
>> this is actually configurable and we want to provide guidance to the admin
>> on when to disable it (which it currently doesn't)?  If not, why have the
>> help text?
> 
> This is __not__ configurable. Seems like a comment to help others
> understand this option. Like Randy said.

Yes, it could be written with '#' (or "comment") comment syntax instead of as help text.

thanks.

>>
>>> +     depends on X86_64
>>> +     depends on SPARSEMEM_VMEMMAP
>>> +     depends on HAVE_BOOTMEM_INFO_NODE
>>> +     help
>>> +       The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
>>> +       some vmemmap pages associated with pre-allocated HugeTLB pages.
>>> +       For example, on X86_64 6 vmemmap pages of size 4KB each can be
>>> +       saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
>>> +       each can be saved for each 1GB HugeTLB page.
>>> +
>>> +       When a HugeTLB page is allocated or freed, the vmemmap array
>>> +       representing the range associated with the page will need to be
>>> +       remapped.  When a page is allocated, vmemmap pages are freed
>>> +       after remapping.  When a page is freed, previously discarded
>>> +       vmemmap pages must be allocated before remapping.
>>> +
>>>  config MEMFD_CREATE
>>>       def_bool TMPFS || HUGETLBFS
>>>
> 


-- 
~Randy

