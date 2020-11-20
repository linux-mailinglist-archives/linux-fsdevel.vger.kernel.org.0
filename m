Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A432BB1C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 18:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgKTRuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 12:50:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59454 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgKTRuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:50:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKHiKab085881;
        Fri, 20 Nov 2020 17:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HkTZ4CSSxljvRW9Lfagdl0uRUw/ox4XrwUVE77wSp0A=;
 b=JlO0jSGOJ/DQY1Wli/S+WBXyu97vGK0LjLd0YXiZ36bR99Xd2/lc7oh60LnmKVx9X1Et
 9/0GoB+e7fYnk6UCyW89XGzJBdioBtNucpuDikoMn+i4cMz31Ycvd4JPkFkv3+urVXe/
 CuqN79YS9XEW3F6TtywDw513IV+7e/V+juZRNWOYh9NSYb34VWdVfByTK2WaPDH14gtq
 S9Q4mmymit7zZ9eLzhPhOdWvp9JbQVbgeYXVnRdfoV6SP5J4593XqGoP1yyxKwQOwCPa
 FIGw9QqfURY2lUA6G33y8PD6DqdmScd00xC7l2XU0+VgLkTpr1p+KJTQqENa8su/63d0 EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34t76mbv0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 17:47:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKHigUH188342;
        Fri, 20 Nov 2020 17:45:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34ts61ukf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 17:45:26 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AKHjFGl014981;
        Fri, 20 Nov 2020 17:45:16 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Nov 2020 09:45:15 -0800
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
 <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
 <20201120093912.GM3200@dhcp22.suse.cz>
 <eda50930-05b5-0ad9-2985-8b6328f92cec@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
Date:   Fri, 20 Nov 2020 09:45:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <eda50930-05b5-0ad9-2985-8b6328f92cec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=2 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200122
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/20/20 1:43 AM, David Hildenbrand wrote:
> On 20.11.20 10:39, Michal Hocko wrote:
>> On Fri 20-11-20 10:27:05, David Hildenbrand wrote:
>>> On 20.11.20 09:42, Michal Hocko wrote:
>>>> On Fri 20-11-20 14:43:04, Muchun Song wrote:
>>>> [...]
>>>>
>>>> Thanks for improving the cover letter and providing some numbers. I have
>>>> only glanced through the patchset because I didn't really have more time
>>>> to dive depply into them.
>>>>
>>>> Overall it looks promissing. To summarize. I would prefer to not have
>>>> the feature enablement controlled by compile time option and the kernel
>>>> command line option should be opt-in. I also do not like that freeing
>>>> the pool can trigger the oom killer or even shut the system down if no
>>>> oom victim is eligible.
>>>>
>>>> One thing that I didn't really get to think hard about is what is the
>>>> effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
>>>> invalid when racing with the split. How do we enforce that this won't
>>>> blow up?
>>>
>>> I have the same concerns - the sections are online the whole time and
>>> anybody with pfn_to_online_page() can grab them
>>>
>>> I think we have similar issues with memory offlining when removing the
>>> vmemmap, it's just very hard to trigger and we can easily protect by
>>> grabbing the memhotplug lock.
>>
>> I am not sure we can/want to span memory hotplug locking out to all pfn
>> walkers. But you are right that the underlying problem is similar but
>> much harder to trigger because vmemmaps are only removed when the
>> physical memory is hotremoved and that happens very seldom. Maybe it
>> will happen more with virtualization usecases. But this work makes it
>> even more tricky. If a pfn walker races with a hotremove then it would
>> just blow up when accessing the unmapped physical address space. For
>> this feature a pfn walker would just grab a real struct page re-used for
>> some unpredictable use under its feet. Any failure would be silent and
>> hard to debug.
> 
> Right, we don't want the memory hotplug locking, thus discussions regarding rcu. Luckily, for now I never saw a BUG report regarding this - maybe because the time between memory offlining (offline_pages()) and memory/vmemmap getting removed (try_remove_memory()) is just too long. Someone would have to sleep after pfn_to_online_page() for quite a while to trigger it.
> 
>>
>> [...]
>>> To keep things easy, maybe simply never allow to free these hugetlb pages
>>> again for now? If they were reserved during boot and the vmemmap condensed,
>>> then just let them stick around for all eternity.
>>
>> Not sure I understand. Do you propose to only free those vmemmap pages
>> when the pool is initialized during boot time and never allow to free
>> them up? That would certainly make it safer and maybe even simpler wrt
>> implementation.
> 
> Exactly, let's keep it simple for now. I guess most use cases of this (virtualization, databases, ...) will allocate hugepages during boot and never free them.

Not sure if I agree with that last statement.  Database and virtualization
use cases from my employer allocate allocate hugetlb pages after boot.  It
is shortly after boot, but still not from boot/kernel command line.

Somewhat related, but not exactly addressing this issue ...

One idea discussed in a previous patch set was to disable PMD/huge page
mapping of vmemmap if this feature was enabled.  This would eliminate a bunch
of the complex code doing page table manipulation.  It does not address
the issue of struct page pages going away which is being discussed here,
but it could be a way to simply the first version of this code.  If this
is going to be an 'opt in' feature as previously suggested, then eliminating
the  PMD/huge page vmemmap mapping may be acceptable.  My guess is that
sysadmins would only 'opt in' if they expect most of system memory to be used
by hugetlb pages.  We certainly have database and virtualization use cases
where this is true.
-- 
Mike Kravetz
