Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2C2C180E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 22:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbgKWV5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 16:57:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57998 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgKWV5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:57:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANLmhqb183588;
        Mon, 23 Nov 2020 21:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QS70EniYffD3NO8MOrygFxL3m3h1RyzaH/V0dC+MHjo=;
 b=Hn3EFG/pozRIF94rlt1UjKxA3fNixYHqSUNMNWGUBaMEePuRnCeMT/TWH1DETIRTlJ54
 p2T3B4R49Sof2BCWUOSiujuJxjnaynrk2umU+VfMdvuTUeHmjqNHZemtLCgmKxDrG1+A
 XPt7ZTVYw4hYZIQ3ajqxRLeSkElT7k6BryAtLWIkA6y3cYZkxyQJkZsE/B1c2CGhhABp
 bTlDmPKegynrlgePslwfjyWuZnwyATt+IlyuN6B8eH/j1/5z/oWKK2IOVplDJ9au/eef
 yP4/SS4YVFS9TNFJkW5U6mpJRe/lQTUn7gAPMw6Q8Z3tIEOTuN3N7d20ILU5BILsuDYE dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34xrdaqs49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 21:54:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANLpdB9006174;
        Mon, 23 Nov 2020 21:52:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34yx8j06x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 21:52:25 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ANLqHDG021845;
        Mon, 23 Nov 2020 21:52:18 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 13:52:17 -0800
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
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
 <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
 <20201123073842.GA27488@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <37f4bf02-c438-9fbd-32ea-8bedbe30c4da@oracle.com>
Date:   Mon, 23 Nov 2020 13:52:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201123073842.GA27488@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=2
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=2 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230139
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/20 11:38 PM, Michal Hocko wrote:
> On Fri 20-11-20 09:45:12, Mike Kravetz wrote:
>> On 11/20/20 1:43 AM, David Hildenbrand wrote:
> [...]
>>>>> To keep things easy, maybe simply never allow to free these hugetlb pages
>>>>> again for now? If they were reserved during boot and the vmemmap condensed,
>>>>> then just let them stick around for all eternity.
>>>>
>>>> Not sure I understand. Do you propose to only free those vmemmap pages
>>>> when the pool is initialized during boot time and never allow to free
>>>> them up? That would certainly make it safer and maybe even simpler wrt
>>>> implementation.
>>>
>>> Exactly, let's keep it simple for now. I guess most use cases of this (virtualization, databases, ...) will allocate hugepages during boot and never free them.
>>
>> Not sure if I agree with that last statement.  Database and virtualization
>> use cases from my employer allocate allocate hugetlb pages after boot.  It
>> is shortly after boot, but still not from boot/kernel command line.
> 
> Is there any strong reason for that?
> 

The reason I have been given is that it is preferable to have SW compute
the number of needed huge pages after boot based on total memory, rather
than have a sysadmin calculate the number and add a boot parameter.

>> Somewhat related, but not exactly addressing this issue ...
>>
>> One idea discussed in a previous patch set was to disable PMD/huge page
>> mapping of vmemmap if this feature was enabled.  This would eliminate a bunch
>> of the complex code doing page table manipulation.  It does not address
>> the issue of struct page pages going away which is being discussed here,
>> but it could be a way to simply the first version of this code.  If this
>> is going to be an 'opt in' feature as previously suggested, then eliminating
>> the  PMD/huge page vmemmap mapping may be acceptable.  My guess is that
>> sysadmins would only 'opt in' if they expect most of system memory to be used
>> by hugetlb pages.  We certainly have database and virtualization use cases
>> where this is true.
> 
> Would this simplify the code considerably? I mean, the vmemmap page
> tables will need to be updated anyway. So that code has to stay. PMD
> entry split shouldn't be the most complex part of that operation.  On
> the other hand dropping large pages for all vmemmaps will likely have a
> performance.

I agree with your points.  This was just one way in which the patch set
could be simplified.
-- 
Mike Kravetz
