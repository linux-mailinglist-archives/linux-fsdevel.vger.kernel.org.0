Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C5C3A05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfJAQIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 12:08:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37146 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJAQIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:08:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91G2fYE014882;
        Tue, 1 Oct 2019 16:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Nrzk2ES1ecrz+SGcJEw6RJVW38HXomT1igYd0QX16Ac=;
 b=Z7T7oDvz8KVFyMvWFY2wt113a7N4h4jhObRtzBVPYQXQ47B9sPGci8JokFhkMFzDZyhy
 jGcLGKRIZ4hv1LdFPNnPc4799a30Oea4xIDADsxGXiJ//ZAphYIE2bgAES5b+aXrBfQx
 BNMjOoaXMoloCafgEcJcw0YCI/ppqiLM/Om8YTc9BBpEUNczYLSGCXotgmUK3makZevT
 c/WQmJKZsPT+gKJYj2PKATg7ojbjJvks93tXFNDGyfueIv78XmuktkQWKfZkaw2TlxXy
 xrMQJp13qmZjwS+1Hp3DtfwyJ0wGtjrYJbbzW4fXPbdqhYL8/zqXcmr1XrN8rVFngiMt HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxuq69k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 16:08:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91Frx5g037972;
        Tue, 1 Oct 2019 16:08:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vc9dhjbsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 16:08:36 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x91G8Z23014836;
        Tue, 1 Oct 2019 16:08:35 GMT
Received: from [192.168.0.100] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 09:08:34 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20191001142018.wpordswdkadac6kt@box>
Date:   Tue, 1 Oct 2019 10:08:30 -0600
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <85868A27-CA43-4AF5-B8A0-2D037C2207FD@oracle.com>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
 <20191001104558.rdcqhjdz7frfuhca@box>
 <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
 <20191001113216.3qbrkqmb2b2xtwkd@box>
 <5dc7b5c1-6d7d-90ee-9423-6eda9ecb005c@oracle.com>
 <20191001142018.wpordswdkadac6kt@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010139
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 1, 2019, at 8:20 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Tue, Oct 01, 2019 at 06:18:28AM -0600, William Kucharski wrote:
>>=20
>>=20
>> On 10/1/19 5:32 AM, Kirill A. Shutemov wrote:
>>> On Tue, Oct 01, 2019 at 05:21:26AM -0600, William Kucharski wrote:
>>>>=20
>>>>=20
>>>>> On Oct 1, 2019, at 4:45 AM, Kirill A. Shutemov =
<kirill@shutemov.name> wrote:
>>>>>=20
>>>>> On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
>>>>>>=20
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index cbe7d0619439..670a1780bd2f 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct =
file *filp, unsigned long addr,
>>>>>>=20
>>>>>> 	if (addr)
>>>>>> 		goto out;
>>>>>> -	if (!IS_DAX(filp->f_mapping->host) || =
!IS_ENABLED(CONFIG_FS_DAX_PMD))
>>>>>> -		goto out;
>>>>>>=20
>>>>>> 	addr =3D __thp_get_unmapped_area(filp, len, off, flags, =
PMD_SIZE);
>>>>>> 	if (addr)
>>>>>=20
>>>>> I think you reducing ASLR without any real indication that THP is =
relevant
>>>>> for the VMA. We need to know if any huge page allocation will be
>>>>> *attempted* for the VMA or the file.
>>>>=20
>>>> Without a properly aligned address the code will never even attempt =
allocating
>>>> a THP.
>>>>=20
>>>> I don't think rounding an address to one that would be properly =
aligned to map
>>>> to a THP if possible is all that detrimental to ASLR and without =
the ability to
>>>> pick an aligned address it's rather unlikely anyone would ever map =
anything to
>>>> a THP unless they explicitly designate an address with MAP_FIXED.
>>>>=20
>>>> If you do object to the slight reduction of the ASLR address space, =
what
>>>> alternative would you prefer to see?
>>>=20
>>> We need to know by the time if THP is allowed for this
>>> file/VMA/process/whatever. Meaning that we do not give up ASLR =
entropy for
>>> nothing.
>>>=20
>>> For instance, if THP is disabled globally, there is no reason to =
align the
>>> VMA to the THP requirements.
>>=20
>> I understand, but this code is in thp_get_unmapped_area(), which is =
only called
>> if THP is configured and the VMA can support it.
>>=20
>> I don't see it in Matthew's patchset, so I'm not sure if it was =
inadvertently
>> missed in his merge or if he has other ideas for how it would =
eventually be
>> called, but in my last patch revision the code calling it in =
do_mmap()
>> looked like this:
>>=20
>> #ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
>>        /*
>>         * If THP is enabled, it's a read-only executable that is
>>         * MAP_PRIVATE mapped, the length is larger than a PMD page
>>         * and either it's not a MAP_FIXED mapping or the passed =
address is
>>         * properly aligned for a PMD page, attempt to get an =
appropriate
>>         * address at which to map a PMD-sized THP page, otherwise =
call the
>>         * normal routine.
>>         */
>>        if ((prot & PROT_READ) && (prot & PROT_EXEC) &&
>>                (!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE) &&
>>                (!(flags & MAP_FIXED)) && len >=3D HPAGE_PMD_SIZE) {
>=20
> len and MAP_FIXED is already handled by thp_get_unmapped_area().
>=20
> 	if (prot & (PROT_READ|PROT_WRITE|PROT_READ) =3D=3D =
(PROT_READ|PROT_EXEC) &&
> 		(flags & MAP_PRIVATE)) {

It is, but I wanted to avoid even calling it if conditions weren't =
right.

Checking twice is non-optimal but I didn't want to alter the existing =
use of
the routine for anon THP.

>=20
>=20
>>                addr =3D thp_get_unmapped_area(file, addr, len, pgoff, =
flags);
>>=20
>>                if (addr && (!(addr & ~HPAGE_PMD_MASK))) {
>=20
> This check is broken.
>=20
> For instance, if pgoff is one, (addr & ~HPAGE_PMD_MASK) has to be =
equal to
> PAGE_SIZE to have chance to get a huge page in the mapping.
>=20

If the address isn't PMD-aligned, we will never be able to map it with a =
THP
anyway.

The current code is designed to only map a THP if the VMA allows for it =
and
it can map the entire THP starting at an aligned address.

You can't map a THP at the PMD level at an address that isn't PMD =
aligned.

Perhaps I'm missing a use case here.

>>                        /*
>>                         * If we got a suitable THP mapping address, =
shut off
>>                         * VM_MAYWRITE for the region, since it's =
never what
>>                         * we would want.
>>                         */
>>                        vm_maywrite =3D 0;
>=20
> Wouldn't it break uprobe, for instance?

I'm not sure; does uprobe allow COW to insert the probe even for =
mappings
explicitly marked read-only?

Thanks,
     Bill

