Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75AA2B87F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 23:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKRW4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 17:56:41 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43336 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKRW4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:56:41 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIMsVvI085507;
        Wed, 18 Nov 2020 22:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XxpL9XzMtnUsCDI1cqX0tLBID7hXFz4WaVSnV84QLvM=;
 b=OJeWjm92ss0S+LtenEBUdFtR4jItyL3Fnm/idn1wY4j4Dhq648st2BlTO9zuuaHgwUm5
 N9NHOueq7j/c5ZDfPkUTLk3rOSPJikawqaon9pFVcYKAxewXy3QiLJJ/7iUHx14Ts9OH
 YBtmiERRWpQ8fpzvrpjQPgSSJ9itkZpktH8AKK10jcHRByT5pO04vNjI5ZRtYOUN22zD
 tGpGwOHqoLiNEOIpa/nZHqaw4sucbSRl3dTv9zM42JYHI4uskS1dcxD/CVjsPuh4qy9h
 PPD/BkUM893cJdZiit5zxtJ/A1ahN6yNVSJVuvAb8vEwW72vr52ofWs+8O33NHo66WPX 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34t4rb2sce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 22:54:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIMfel8052638;
        Wed, 18 Nov 2020 22:54:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34uspvd68x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 22:54:31 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AIMsRgd025515;
        Wed, 18 Nov 2020 22:54:28 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 14:54:27 -0800
Subject: Re: [PATCH v4 04/21] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-5-songmuchun@bytedance.com>
 <20201116133310.GA32129@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e2e367e3-a130-576e-906c-12f69db18af8@oracle.com>
Date:   Wed, 18 Nov 2020 14:54:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201116133310.GA32129@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=2 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180157
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/20 5:33 AM, Oscar Salvador wrote:
> On Fri, Nov 13, 2020 at 06:59:35PM +0800, Muchun Song wrote:
>> +void __init hugetlb_vmemmap_init(struct hstate *h)
>> +{
>> +	unsigned int order = huge_page_order(h);
>> +	unsigned int vmemmap_pages;
>> +
>> +	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
>> +	/*
>> +	 * The head page and the first tail page are not to be freed to buddy
>> +	 * system, the others page will map to the first tail page. So there
> "the remaining pages" might be more clear.
> 
>> +	 * are (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
> "that can be freed"
> 
>> +	 *
>> +	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? This is
>> +	 * not expected to happen unless the system is corrupted. So on the
>> +	 * safe side, it is only a safety net.
>> +	 */
>> +	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
>> +		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
>> +	else
>> +		h->nr_free_vmemmap_pages = 0;
> 
> This made think of something.
> Since struct hstate hstates is global, all the fields should be defined to 0.
> So, the following assignments in hugetlb_add_hstate:
> 
>         h->nr_huge_pages = 0;
>         h->free_huge_pages = 0;
> 
> should not be needed.
> Actually, we do not initialize other values like resv_huge_pages
> or surplus_huge_pages.
> 
> If that is the case, the "else" could go.
> 
> Mike?

Correct.  Those assignments have been in the code for a very long time.

> The changes itself look good to me.
> I think that putting all the vemmap stuff into hugetlb-vmemmap.* was
> the right choice.

Agree!
-- 
Mike Kravetz
