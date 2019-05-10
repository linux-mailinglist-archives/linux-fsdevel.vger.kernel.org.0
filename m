Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A997A198A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfEJG42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 02:56:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32931 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbfEJG42 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 02:56:28 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 80FC5F410DD9BCBB68F2;
        Fri, 10 May 2019 07:56:26 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 10 May
 2019 07:56:16 +0100
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Rob Landley <rob@landley.net>, <viro@zeniv.linux.org.uk>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <hpa@zytor.com>,
        <arnd@arndb.de>, <james.w.mcmechan@gmail.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <fca8e601-1144-1bb8-c007-518651f624a5@landley.net>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <bf0d02fc-d6ce-ef1d-bb7d-7ca14432c6fd@huawei.com>
Date:   Fri, 10 May 2019 08:56:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <fca8e601-1144-1bb8-c007-518651f624a5@landley.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/2019 8:34 PM, Rob Landley wrote:
> On 5/9/19 6:24 AM, Roberto Sassu wrote:
>> This patch set aims at solving the following use case: appraise files from
>> the initial ram disk. To do that, IMA checks the signature/hash from the
>> security.ima xattr. Unfortunately, this use case cannot be implemented
>> currently, as the CPIO format does not support xattrs.
>>
>> This proposal consists in marshaling pathnames and xattrs in a file called
>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
>> been extracted.
> 
> So it's in-band signalling that has a higher peak memory requirement.

This can be modified. Now I allocate the memory necessary for the path
and all xattrs of a file (max: .xattr-list size - 10 bytes). I could
process each xattr individually (max: 255 + 1 + 65536 bytes).


>> The difference with another proposal
>> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
>> included in an image without changing the image format, as opposed to
>> defining a new one. As seen from the discussion, if a new format has to be
>> defined, it should fix the issues of the existing format, which requires
>> more time.
> 
> So you've explicitly chosen _not_ to address Y2038 while you're there.

Can you be more specific?

Thanks

Roberto


> Rob
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
