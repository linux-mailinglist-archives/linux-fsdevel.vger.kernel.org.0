Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB44316F352
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 00:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgBYX2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 18:28:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41566 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgBYX0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01PNMc1P018859;
        Tue, 25 Feb 2020 23:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ONA6ceIt15v6qfseSGoHjJPttxmoDpsTdTLYyZFF+c0=;
 b=Yta1JXZcYRNRzrBMPDSm7A2H6ynkekmIf5+71/zLUIH4PzB+AVmsVnIemg4MNjcNmZjm
 qg7zsXAgBaO30ZDFrmI1usnmFUa09YfGV0hi7BqikKZB/5MxojI4WRLVNgmcp1NQRWyg
 MtQ5nY+GkkRRP7A+Lwi7ICYYpOlvMQU5UTFzVIiciefV0PiR7hW7ZEmFtWqJ1ICc5ZKv
 3qUNFNY0JwfTXnd+THvEwTU9WHcCnRNrxvvahVAB8KwL21CGWBDKEvsocAa6vldfmQem
 F+Q0riyU2YDGDnS6+TKAv1RwnfQ6YJc5qZam5x4A+EIVOSXXtuhFZROP0jIBE5LHswEV 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ydct3034a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 23:26:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01PNGcH2149500;
        Tue, 25 Feb 2020 23:26:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ydcs8h6bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 23:26:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01PNQFFM012171;
        Tue, 25 Feb 2020 23:26:15 GMT
Received: from [10.159.230.155] (/10.159.230.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Feb 2020 15:26:15 -0800
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To:     Dan Williams <dan.j.williams@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
 <CAPcyv4ghusuMsAq8gSLJKh1fiKjwa8R_-ojVgjsttoPRqBd_Sg@mail.gmail.com>
 <x49blpop00m.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCA_oR8_8+zhAhMnqOga9GcpMX97S+x8_UD6zLEQ0Cew@mail.gmail.com>
 <x49sgizodni.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gUM47QgGKvK4ZVUek6f=ABT7hRFX47-DQiD6AcrxtRHA@mail.gmail.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <f4085f6f-8305-2e50-fffc-07f5fc116017@oracle.com>
Date:   Tue, 25 Feb 2020 15:26:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gUM47QgGKvK4ZVUek6f=ABT7hRFX47-DQiD6AcrxtRHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=8 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=8 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250162
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/24/2020 4:26 PM, Dan Williams wrote:
> On Mon, Feb 24, 2020 at 1:53 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>>>> Let's just focus on reporting errors when we know we have them.
>>>
>>> That's the problem in my eyes. If software needs to contend with
>>> latent error reporting then it should always contend otherwise
>>> software has multiple error models to wrangle.
>>
>> The only way for an application to know that the data has been written
>> successfully would be to issue a read after every write.  That's not a
>> performance hit most applications are willing to take.  And, of course,
>> the media can still go bad at a later time, so it only guarantees the
>> data is accessible immediately after having been written.
>>
>> What I'm suggesting is that we should not complete a write successfully
>> if we know that the data will not be retrievable.  I wouldn't call this
>> adding an extra error model to contend with.  Applications should
>> already be checking for errors on write.
>>
>> Does that make sense? Are we talking past each other?
> 
> The badblock list is late to update in both directions, late to add
> entries that the scrub needs to find and late to delete entries that
> were inadvertently cleared by cache-line writes that did not first
> ingest the poison for a read-modify-write. So I see the above as being
> wishful in using the error list as the hard source of truth and
> unfortunate to up-level all sub-sector error entries into full
> PAGE_SIZE data offline events.

Sorry, don't mean to distract the discussion, but I'm wondering if
anyone has noticed SIGBUS with si_code = MCEERR_AO in a single process 
poison test over a dax-xfs file?  There is only 1 poison in the
file which has been consumed, it's the recovery code path (hole punch/
munmap/mmap/pwrite/read) that encounters the _AO. I'm confident that
latent error isn't the scenario per ARS scrub. Also, the _AO appears
rarely. This is un-explainable given the kernel MCE pmem handling
implementation.

> 
> I'm hoping we can find a way to make the error handling more fine
> grained over time, but for the current patch, managing the blast
> radius as PAGE_SIZE granularity at least matches the zero path with
> the write path.

Maybe the new filesystem op for clearing pmem poison should insist on
4K alignment? because in hwpoison_clear() the starting pfn is given
by PHYS_PFN which rounds down to the nearest page, so we might inadvertently
clear the poison bit and 'noce' bit from a page when we only cleared a
poison e.g. in the second half of the page.

BTW, set_mce_nospec() doesn't seem to work in 5.5 release,
   [ 2321.209382] Could not invalidate pfn=0x1850600 from 1:1 map
I will see if I can find more information.

> 
>>> Setting that aside we can start with just treating zeroing the same as
>>> the copy_from_iter() case and fail the I/O at the dax_direct_access()
>>> step.
>>
>> OK.
>>
>>> I'd rather have a separate op that filesystems can use to clear errors
>>> at block allocation time that can be enforced to have the correct
>>> alignment.
>>
>> So would file systems always call that routine instead of zeroing, or
>> would they first check to see if there are badblocks?
> 
> The proposal is that filesystems distinguish zeroing from free-block
> allocation/initialization such that the fsdax implementation directs
> initialization to a driver callback. This "initialization op" would
> take care to check for poison and clear it. All other dax paths would
> not consult the badblocks list.

thanks!
-jane


> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
