Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28674153DBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 04:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBFDv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 22:51:59 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10444 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBFDv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:51:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3b8d230000>; Wed, 05 Feb 2020 19:50:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Feb 2020 19:51:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Feb 2020 19:51:57 -0800
Received: from [10.2.168.158] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 03:51:57 +0000
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
 <20200206022144.GU8731@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <01e577b2-3349-15bc-32c7-b556e9f08536@nvidia.com>
Date:   Wed, 5 Feb 2020 19:48:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206022144.GU8731@bombadil.infradead.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580961059; bh=XssupI12QibVhDkrch/+dRXC2gZu6nYcUffAkr8ShLs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pILzBx3vzqkRVHivaNss9EGE4J2yb/Rf7wllGG5vAhir+ennQoC3K03UJ5icXJxWt
         Da4bcU2MpZzSdDck7FTUw/t7zPLGKqLupo/g3G4FmQAah76MBZNpVuJnPW/r93Q8Wm
         kDHgpMNXLA/E7SfNqt1YjjCU3eNqkp4Qdal3RJM4gWqfYeW7AIKWs6B4iy5/BCOv2o
         0yWVWMYgSyZByXBB/lLRcVEky70xHmLzjovqDED5kW8jtxHyXzN8qxxU1cWERUvA+O
         jvC9Y7b+tc3RjC1CQwMfy1VpxBMKIBad7GWFR43GkKhU91uIACxz8+/Lsx1XCAkTxs
         0V3GV5Vp5LSdg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/5/20 6:21 PM, Matthew Wilcox wrote:
> On Wed, Feb 05, 2020 at 02:19:34PM -0800, John Hubbard wrote:
>> So if we do this, I think we'd also want something like this (probably with
>> better wording, this is just a first draft):
>>
>> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
>> index 640934b6f7b4..8adeaa8c012e 100644
>> --- a/Documentation/core-api/xarray.rst
>> +++ b/Documentation/core-api/xarray.rst
>> @@ -66,10 +66,11 @@ pointer at every index.
>>   You can then set entries using xa_store() and get entries
>>   using xa_load().  xa_store will overwrite any entry with the
>>   new entry and return the previous entry stored at that index.  You can
>> -use xa_erase() instead of calling xa_store() with a
>> +use xa_erase() plus xas_init_marks(), instead of calling xa_store() with a
> 
> Woah, woah, woah.  xa_erase() re-initialises the marks.  Nobody's going


Yes, I get that. But I mis-wrote it, it should have read more like:

You can then set entries using xa_store() and get entries
using xa_load().  xa_store will overwrite any entry with the
new entry and return the previous entry stored at that index.  You can
use xa_erase(), instead of calling xa_store() with a
``NULL`` entry followed by xas_init_marks().  There is no difference between
an entry that has never been stored to and one that has been erased. Those,
in turn, are the same as an entry that has had ``NULL`` stored to it and
also had its marks erased via xas_init_marks().


> to change that.  Don't confuse the porcelain and plumbing APIs.
> 

The API still documents a different behavior than this patchset changes it
to, despite my imperfect attempts to update the documentation. So let's
please keep the porcelain aligned with the plumbing. :)

thanks,
-- 
John Hubbard
NVIDIA
