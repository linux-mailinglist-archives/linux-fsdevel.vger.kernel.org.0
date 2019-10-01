Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECBC3411
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 14:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfJAMSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 08:18:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54642 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJAMSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:18:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91C8wjG175385;
        Tue, 1 Oct 2019 12:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=dcLYJvPK24WEL/GkiHEqYn8VO4YkXFlAa6MpcIoc3SY=;
 b=MDu/IhfXGIhNz//977B0rKXUpa1lZY1yJNdFTIPRlSe+ifg4CdYd6X0NMGjp2rs9i9qf
 cYVQZrY/6v9513GKS4GIUF4bwZKOS5lCfJai6w8F/VYycKUmBseZXR2FWOJmKzgippoH
 nwGvm6ymmn8L4A4E7EAe5LEbV2zVNFen0NwyVTQtjNORf35kYbbDjaHkK9tXnUBbdxph
 V62cqwMJUF52lzhGqAkHEqXZ1QBxPOL8QZQgaq5xBA8/s9qiu+Kp+EQxPdMuJkbyAkj2
 zddo+lAVqOO6SnfvUK0UDQkTQfcl6zA+aHbRoEU3WSKGlVypn3gDxxTCnvurMRw21cJq Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2va05rnaks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 12:18:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91C8hrB090887;
        Tue, 1 Oct 2019 12:18:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vbsm1vfmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 12:18:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91CIT4o017825;
        Tue, 1 Oct 2019 12:18:29 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 05:18:29 -0700
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
 <20191001104558.rdcqhjdz7frfuhca@box>
 <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
 <20191001113216.3qbrkqmb2b2xtwkd@box>
From:   William Kucharski <william.kucharski@oracle.com>
Message-ID: <5dc7b5c1-6d7d-90ee-9423-6eda9ecb005c@oracle.com>
Date:   Tue, 1 Oct 2019 06:18:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001113216.3qbrkqmb2b2xtwkd@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/1/19 5:32 AM, Kirill A. Shutemov wrote:
> On Tue, Oct 01, 2019 at 05:21:26AM -0600, William Kucharski wrote:
>>
>>
>>> On Oct 1, 2019, at 4:45 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>>>
>>> On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index cbe7d0619439..670a1780bd2f 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>>>>
>>>> 	if (addr)
>>>> 		goto out;
>>>> -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
>>>> -		goto out;
>>>>
>>>> 	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
>>>> 	if (addr)
>>>
>>> I think you reducing ASLR without any real indication that THP is relevant
>>> for the VMA. We need to know if any huge page allocation will be
>>> *attempted* for the VMA or the file.
>>
>> Without a properly aligned address the code will never even attempt allocating
>> a THP.
>>
>> I don't think rounding an address to one that would be properly aligned to map
>> to a THP if possible is all that detrimental to ASLR and without the ability to
>> pick an aligned address it's rather unlikely anyone would ever map anything to
>> a THP unless they explicitly designate an address with MAP_FIXED.
>>
>> If you do object to the slight reduction of the ASLR address space, what
>> alternative would you prefer to see?
> 
> We need to know by the time if THP is allowed for this
> file/VMA/process/whatever. Meaning that we do not give up ASLR entropy for
> nothing.
> 
> For instance, if THP is disabled globally, there is no reason to align the
> VMA to the THP requirements.

I understand, but this code is in thp_get_unmapped_area(), which is only called
if THP is configured and the VMA can support it.

I don't see it in Matthew's patchset, so I'm not sure if it was inadvertently
missed in his merge or if he has other ideas for how it would eventually be 
called, but in my last patch revision the code calling it in do_mmap() looked 
like this:

#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
         /*
          * If THP is enabled, it's a read-only executable that is
          * MAP_PRIVATE mapped, the length is larger than a PMD page
          * and either it's not a MAP_FIXED mapping or the passed address is
          * properly aligned for a PMD page, attempt to get an appropriate
          * address at which to map a PMD-sized THP page, otherwise call the
          * normal routine.
          */
         if ((prot & PROT_READ) && (prot & PROT_EXEC) &&
                 (!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE) &&
                 (!(flags & MAP_FIXED)) && len >= HPAGE_PMD_SIZE) {
                 addr = thp_get_unmapped_area(file, addr, len, pgoff, flags);

                 if (addr && (!(addr & ~HPAGE_PMD_MASK))) {
                         /*
                          * If we got a suitable THP mapping address, shut off
                          * VM_MAYWRITE for the region, since it's never what
                          * we would want.
                          */
                         vm_maywrite = 0;
                 } else
                         addr = get_unmapped_area(file, addr, len, pgoff, flags);
         } else {
#endif

So I think that meets your expectations regarding ASLR.

    -- Bill
