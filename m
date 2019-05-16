Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4E20556
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfEPLmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:42:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32944 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbfEPLmv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:42:51 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A54C148E50E23ECD1918;
        Thu, 16 May 2019 12:42:48 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 16 May
 2019 12:42:42 +0100
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Rob Landley <rob@landley.net>,
        Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        <initramfs@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
References: <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <1557861511.3378.19.camel@HansenPartnership.com>
 <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
 <1557878052.2873.6.camel@HansenPartnership.com>
 <20190515005221.GB88615@rani.riverdale.lan>
 <a138af12-d983-453e-f0b2-661a80b7e837@huawei.com>
 <20190515160834.GA81614@rani.riverdale.lan>
 <ce65240a-4df6-8ebc-8360-c01451e724f0@huawei.com>
 <20190516052934.GA68777@rani.riverdale.lan>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <ac930347-9a36-0e84-1f93-cd98e63de403@huawei.com>
Date:   Thu, 16 May 2019 13:42:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190516052934.GA68777@rani.riverdale.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/16/2019 7:29 AM, Arvind Sankar wrote:
> On Wed, May 15, 2019 at 07:06:52PM +0200, Roberto Sassu wrote:
>> On 5/15/2019 6:08 PM, Arvind Sankar wrote:
>>> On Wed, May 15, 2019 at 01:19:04PM +0200, Roberto Sassu wrote:
>>>> On 5/15/2019 2:52 AM, Arvind Sankar wrote:
>>> I don't understand what you mean? The IMA hashes are signed by some key,
>>> but I don't see how what that key is needs to be different between the
>>> two proposals. If the only files used are from the distro, in my scheme
>>> as well you can use the signatures and key provided by the distro. If
>>> they're not, then in your scheme as well you would have to allow for a
>>> local signing key to be used. Both schemes are using the same
>>> .xattr-list file, no?
>>
>> I was referring to James's proposal to load an external initramfs from
>> the embedded initramfs. If the embedded initramfs opens the external
>> initramfs when IMA is enabled, the external initramfs needs to be
>> signed with a local signing key. But I read your answer that this
>> wouldn't be feasible. You have to specify all initramfs in the boot
>> loader configuration.
>>
>> I think deferring IMA initialization is not the safest approach, as it
>> cannot be guaranteed for all possible scenarios that there won't be any
>> file read before /init is executed.
>>
>> But if IMA is enabled, there is the problem of who signs .xattr-list.
>> There should be a local signing key that it is not necessary if the user
>> only accesses distro files.
>>
> I think that's a separate issue. If you want to allow people to be able
> to put files onto the system that will be IMA verified, they need to
> have some way to locally sign them whether it's inside an initramfs or
> on a real root filesystem.

Yes. But this shouldn't be a requirement. If I have only files signed by
the distro, I should be able to do appraisal without a local signing
key.

I made an IMA extension called IMA Digest Lists, that extracts reference
digests from RPM headers and performs appraisal based on the loaded
white lists.  The only keys that must be in the kernel for signature
verification are the PGP keys of the distro (plus the public key for the
RPM parser, which at the moment is different).

.xattr-list is generated by my custom dracut module and contains the
signature of the digest lists and the parser.


>>> Right, I guess this would be sort of the minimal "modification" to the
>>> CPIO format to allow it to support xattrs.
>>
>> I would try to do it without modification of the CPIO format. However,
>> at the time .xattr-list is parsed (in do_copy() before .xattr-list is
>> closed), it is not guaranteed that all files are extracted. These must
>> be created before xattrs are added, but the file type must be correct,
>> otherwise clean_path() removes the existing file with xattrs.
>>
>> Roberto
>>
>> -- 
>> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
>> Managing Director: Bo PENG, Jian LI, Yanli SHI
> 
> Right by "modification" in quotes I meant the format is actually the
> same, but the kernel now interprets it a bit differently.
> 
> Regarding the order you don't have to handle that in the kernel. The
> kernel CPIO format is already restricted in that directories have to be
> specified before the files that contain them for example. It can very
> well be restricted so that an .xattr-list can only specify xattrs for
> files that were already extracted, else you bail out with an error. The
> archive creation tooling can easily handle that. If someone wants to
> shoot themselves in the foot by trying to add more files/replace
> existing files after the .xattr-list its ok, the IMA policy will prevent
> such files from being accessed and they can fix the archive for the next
> boot.

Unfortunately, dracut sorts the files before adding them to the CPIO
image (.xattr-list is at the beginning). I could move xattrs from the
existing file to the file with different mode, but this makes the code
more complex. I think it is better to call do_readxattrs() after files
are extracted, or when .xattr-list is going to be replaced by another
one in the next initramfs.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
