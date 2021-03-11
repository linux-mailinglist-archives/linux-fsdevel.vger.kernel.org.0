Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0473380F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 23:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCKWzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 17:55:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47640 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCKWzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:55:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BMnf4x115224;
        Thu, 11 Mar 2021 22:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=plSnUdBNvny7Ct7a8NuaqDGnQYwwr4B6qgGyUtk/DSU=;
 b=Msup728Ns4Ep4HZxxAMhehA9El1ybe+B5r/r357QamrJjOas3nTMuu4f9WLbOt1rqT4j
 O/TsgrpU16UrPraEtlWljTNBA2pIeBRFwqbM89ypogW+ujxgDcLuiaAvsW99JLrKIGXm
 phkOt1w4OZRco4aGUsOSeVOj+PU4i84dcF+IegRCZzd7qCfZOGaFsrl7FN4YC26xP9nO
 5hAVmdMPqxiZSQutnvVrtVOkz0cOn+wsmB9wrBov/xIog5RnMLXP7H0uHZRGy77FN+7P
 I5NYkVAQ+qTjzfBCpV+wsKS09bIUW2EJk+EivYEL6EixViltpspVW3VtpD0cRPrvJcpG jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3742cnga2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 22:53:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BMjAIf112036;
        Thu, 11 Mar 2021 22:53:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 374kgvn1tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 22:53:31 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12BMrBos023537;
        Thu, 11 Mar 2021 22:53:11 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Mar 2021 14:53:10 -0800
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
 <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
 <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
 <20210310214909.GY2696@paulmck-ThinkPad-P72>
 <68bc8cc9-a15b-2e97-9a2a-282fe6e9bd3f@oracle.com>
 <20210310232851.GZ2696@paulmck-ThinkPad-P72>
 <YEnXllhPEQhT0CRt@dhcp22.suse.cz> <YEoKa5oSm/hdgt5V@dhcp22.suse.cz>
 <45f434da-b55b-da61-be36-c248a301f688@oracle.com>
Message-ID: <4d4851fd-f0fd-9bfe-d271-b53891fdab6f@oracle.com>
Date:   Thu, 11 Mar 2021 14:53:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <45f434da-b55b-da61-be36-c248a301f688@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110121
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/11/21 9:59 AM, Mike Kravetz wrote:
> On 3/11/21 4:17 AM, Michal Hocko wrote:
>>> Yeah per cpu preempt counting shouldn't be noticeable but I have to
>>> confess I haven't benchmarked it.
>>
>> But all this seems moot now http://lkml.kernel.org/r/YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net
>>
> 
> The proper fix for free_huge_page independent of this series would
> involve:
> 
> - Make hugetlb_lock and subpool lock irq safe
> - Hand off freeing to a workque if the freeing could sleep
> 
> Today, the only time we can sleep in free_huge_page is for gigantic
> pages allocated via cma.  I 'think' the concern about undesirable
> user visible side effects in this case is minimal as freeing/allocating
> 1G pages is not something that is going to happen at a high frequency.
> My thinking could be wrong?
> 
> Of more concern, is the introduction of this series.  If this feature
> is enabled, then ALL free_huge_page requests must be sent to a workqueue.
> Any ideas on how to address this?
> 

Thinking about this more ...

A call to free_huge_page has two distinct outcomes
1) Page is freed back to the original allocator: buddy or cma
2) Page is put on hugetlb free list

We can only possibly sleep in the first case 1.  In addition, freeing a
page back to the original allocator involves these steps:
1) Removing page from hugetlb lists
2) Updating hugetlb counts: nr_hugepages, surplus
3) Updating page fields
4) Allocate vmemmap pages if needed as in this series
5) Calling free routine of original allocator

If hugetlb_lock is irq safe, we can perform the first 3 steps under that
lock without issue.  We would then use a workqueue to perform the last
two steps.  Since we are updating hugetlb user visible data under the
lock, there should be no delays.  Of course, giving those pages back to
the original allocator could still be delayed, and a user may notice
that.  Not sure if that would be acceptable?  I think Muchun had a
similar setup just for vmemmmap allocation in an early version of this
series.

This would also require changes to where accounting is done in
dissolve_free_huge_page and update_and_free_page as mentioned elsewhere.

P.S. We could further optimize to check for the possibility of sleeping
(cma or vmemmap) and only send to workqueue in those cases.
-- 
Mike Kravetz
