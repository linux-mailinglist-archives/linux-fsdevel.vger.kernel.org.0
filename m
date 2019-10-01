Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99313C324E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 13:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfJALVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 07:21:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfJALVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:21:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91BJMdV134962;
        Tue, 1 Oct 2019 11:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=SZSjO6UNaZjumDTG5dmovcI4DXMpTOl7kZ7b++1MnZg=;
 b=JJL3Lir4saN5IQpMnoz8keJ7VHriQJoQelVTKKtN9O1Utf6j/1ZiDaq31hglj93UzB5a
 09hZuKZ+bhzI78yUlpeS5JGE489b7tHQcwwiSTXEZh9lq1zBlnM9kjUW4D/7IIpDP096
 lR/4hIUZzNzaoNGdhvz3j33JhgyNcixr9nUXDXuzY7y+/gdi0HxVbv/rxrz+M3BGUltK
 THZKcQMAz6XWAxiiXs1GPXiv+BgcUnTVU0xWV9HHCFsag+gML26Mzj/y0OL5XBfsVN3g
 I+Uk5AdlxbdLMEZzDsH0UA8InM0yI5tGcbJE33ejqNo8nrh2CHli8pQtykJqIYtYRC1q xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2va05rn1au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 11:21:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91BI8SW046498;
        Tue, 1 Oct 2019 11:21:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vbnqcq6ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 11:21:28 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91BLR8j014531;
        Tue, 1 Oct 2019 11:21:27 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 04:21:27 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.18\))
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20191001104558.rdcqhjdz7frfuhca@box>
Date:   Tue, 1 Oct 2019 05:21:26 -0600
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
 <20191001104558.rdcqhjdz7frfuhca@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3594.4.18)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010104
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 1, 2019, at 4:45 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
>>=20
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index cbe7d0619439..670a1780bd2f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file =
*filp, unsigned long addr,
>>=20
>> 	if (addr)
>> 		goto out;
>> -	if (!IS_DAX(filp->f_mapping->host) || =
!IS_ENABLED(CONFIG_FS_DAX_PMD))
>> -		goto out;
>>=20
>> 	addr =3D __thp_get_unmapped_area(filp, len, off, flags, =
PMD_SIZE);
>> 	if (addr)
>=20
> I think you reducing ASLR without any real indication that THP is =
relevant
> for the VMA. We need to know if any huge page allocation will be
> *attempted* for the VMA or the file.

Without a properly aligned address the code will never even attempt =
allocating
a THP.

I don't think rounding an address to one that would be properly aligned =
to map
to a THP if possible is all that detrimental to ASLR and without the =
ability to
pick an aligned address it's rather unlikely anyone would ever map =
anything to
a THP unless they explicitly designate an address with MAP_FIXED.

If you do object to the slight reduction of the ASLR address space, what
alternative would you prefer to see?

    -- Bill=
