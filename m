Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC112E03AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 02:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgLVBHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 20:07:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46990 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgLVBHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:07:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BM14IOk151290;
        Tue, 22 Dec 2020 01:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Fc7G0fgK0I429Ii98eG0hLPZcQPGWoWFakSC2k2BDQQ=;
 b=Wl5nIrDhaF75FKhjFOBShmiRapZRxrEg0nKsnxkTeg5QQrvIfyen9gHJEEUSEyc9NkNw
 Pk63BGXRzehr+7K6PV2WJt5JOhjpdMg1UtHavt+QA/npINhJTM4jl8kVxD8q6rut/TQd
 H71zH91HNIecJsqMzP8dBAeoh/OCNRiGNkWYPrRsztNByvio0YXWb2XUwWOAOaUdbgzQ
 FsmzRrxn5CIa7mKMkaC4jQGvbtXlbVTsUD+xnYudzS7Bk3tArNPdaOMw0bREfVF4SvYV
 GEWzTkJjIzQg0EX00bQ8eKMWXnlnj7r8Pym9F2XdcvkKuhNqrHxOHP7NnrNPLR8rWtQE Qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35k0d11ann-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:06:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BM11Ylj027527;
        Tue, 22 Dec 2020 01:04:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35k0e0fpt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 01:04:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BM13vID000643;
        Tue, 22 Dec 2020 01:03:58 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Dec 2020 17:03:57 -0800
Subject: Re: [External] Re: [PATCH v10 03/11] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-4-songmuchun@bytedance.com>
 <20201221091123.GB14343@linux>
 <CAMZfGtVnS=_m4fpGBfDpOpdgzP02QCteUQn-gGiLADWfGiVJ=A@mail.gmail.com>
 <20201221134345.GA19324@linux>
 <CAMZfGtVTqYXOvTHSay-6WS+gtDSCtcN5ksnkj8hJgrUs_XWoWQ@mail.gmail.com>
 <20201221180019.GA2884@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <238fcaca-b1f6-7bed-9307-72377eefb15f@oracle.com>
Date:   Mon, 21 Dec 2020 17:03:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201221180019.GA2884@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012220004
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:00 AM, Oscar Salvador wrote:
> On Mon, Dec 21, 2020 at 11:52:30PM +0800, Muchun Song wrote:
>> On Mon, Dec 21, 2020 at 9:44 PM Oscar Salvador <osalvador@suse.de> wrote:
>>>
>>> On Mon, Dec 21, 2020 at 07:25:15PM +0800, Muchun Song wrote:
>>>
>>>> Should we add a BUG_ON in vmemmap_remap_free() for now?
>>>>
>>>>         BUG_ON(reuse != start + PAGE_SIZE);
>>>
>>> I do not think we have to, plus we would be BUG_ing for some specific use
>>> case in "generic" function.
>>
>> The vmemmap_remap_range() walks page table range [start, end),
>> if reuse is equal to (start + PAGE_SIZE), the range can adjust to
>> [start - PAGE_SIZE, end). But if not, we need some work to
>> implement the "generic" function.
>>
>>   - adjust range to [min(start, reuse), end) and call
>>     vmemmap_remap_rangeand which skip the hole
>>     which is [reuse + PAGE_SIZE, start) or [end, reuse).
>>   - call vmemmap_remap_range(reuse, reuse + PAGE_SIZE)
>>     to get the reuse page.Then, call vmemmap_remap_range(start, end)
>>     again to remap.
>>
>> Which one do you prefer?
> 
> I would not overcomplicate things at this stage.
> Just follow my sugestion and add a BUG_ON as you said, that might be the
> easier way now.
> We can overthink this in the future when some other usecases come
> around, right?

I too like the suggestion of specifying the reuse address.  It is better
than than relying on 'start + PAGE_SIZE' or even 'start - PAGE_SIZE' as
in the previous version.

However, if we do allow this then we can not allow just any reuse address
without complicating the code.  Why?  Because the code would also need to
do a page table walk to validate reuse addr.  In the current code, that is
handled as long as reuse address is part of the range we are walking.

I see two assumptions in the current code:
1) reuse address is part of the range
2) remap_pte is found 'first' in table walk before we start remapping.

In the current use case, the 'reuse addr' is always going to be the start
of the page table range we walk.  Correct?  If so, perhaps it would just
be simpler for now to have range be
[reuse addr, last page mapped to reuse addr].  IOW, always have the range
start with reuse addr and all subsequent pages in the range are mapped to
reuse addr.  I know it is not very generic or flexible.  But, it might be
easier to understand than the adjustments (+- PAGE_SIZE) currently being
made in the code.

Just a thought.
-- 
Mike Kravetz
