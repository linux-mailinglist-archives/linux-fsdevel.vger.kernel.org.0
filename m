Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA91F91F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 19:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfEORGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 13:06:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32943 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfEORGy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 13:06:54 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9408C8E5CBF113525311;
        Wed, 15 May 2019 18:06:51 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 15 May
 2019 18:06:45 +0100
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
References: <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <1557861511.3378.19.camel@HansenPartnership.com>
 <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
 <1557878052.2873.6.camel@HansenPartnership.com>
 <20190515005221.GB88615@rani.riverdale.lan>
 <a138af12-d983-453e-f0b2-661a80b7e837@huawei.com>
 <20190515160834.GA81614@rani.riverdale.lan>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <ce65240a-4df6-8ebc-8360-c01451e724f0@huawei.com>
Date:   Wed, 15 May 2019 19:06:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190515160834.GA81614@rani.riverdale.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/15/2019 6:08 PM, Arvind Sankar wrote:
> On Wed, May 15, 2019 at 01:19:04PM +0200, Roberto Sassu wrote:
>> On 5/15/2019 2:52 AM, Arvind Sankar wrote:
>>> You can specify multiple initrd's to the boot loader, and they get
>>> loaded in sequence into memory and parsed by the kernel before /init is
>>> launched. Currently I believe later ones will overwrite the earlier
>>> ones, which is why we've been talking about adding an option to prevent
>>> that. You don't have to mess with manually finding/parsing initramfs's
>>> which wouldn't even be feasible since you may not have the drivers
>>> loaded yet to access the device/filesystem on which they live.
>>>
>>> Once that's done, the embedded /init is just going to do in userspace
>>> wht the current patch does in the kernel. So all the files in the
>>> external initramfs(es) would need to have IMA signatures via the special
>>> xattr file.
>>
>> So, the scheme you are proposing is not equivalent: using the distro key
>> to verify signatures, compared to adding a new user key to verify the
>> initramfs he builds. Why would it be necessary for the user to share
>> responsibility with the distro, if the only files he uses come from the
>> distro?
>>
> I don't understand what you mean? The IMA hashes are signed by some key,
> but I don't see how what that key is needs to be different between the
> two proposals. If the only files used are from the distro, in my scheme
> as well you can use the signatures and key provided by the distro. If
> they're not, then in your scheme as well you would have to allow for a
> local signing key to be used. Both schemes are using the same
> .xattr-list file, no?

I was referring to James's proposal to load an external initramfs from
the embedded initramfs. If the embedded initramfs opens the external
initramfs when IMA is enabled, the external initramfs needs to be
signed with a local signing key. But I read your answer that this
wouldn't be feasible. You have to specify all initramfs in the boot
loader configuration.

I think deferring IMA initialization is not the safest approach, as it
cannot be guaranteed for all possible scenarios that there won't be any
file read before /init is executed.

But if IMA is enabled, there is the problem of who signs .xattr-list.
There should be a local signing key that it is not necessary if the user
only accesses distro files.


> If the external initramfs is to be signed, and it is built locally, in
> both schemes there will have to be a provision for a local signing key,
> but this key in any case is verified by the bootloader so there can't
> be a difference between the two schemes since they're the same there.
> 
> What is the difference you're seeing here?
>>
>>> Note that if you want the flexibility to be able to load one or both of
>>> two external initramfs's, the current in-kernel proposal wouldn't be
>>> enough -- the xattr specification would have to be more flexible (eg
>>> reading .xattr-list* to allow each initramfs to specifiy its own
>>> xattrs. This sort of enhancement would be much easier to handle with the
>>> userspace variant.
>>
>> Yes, the alternative solution is to parse .xattr-list at the time it is
>> extracted. The .xattr-list of each initramfs will be processed. Also,
>> the CPIO parser doesn't have to reopen the file after all other files
>> have been extracted.
>>
>> Roberto
> Right, I guess this would be sort of the minimal "modification" to the
> CPIO format to allow it to support xattrs.

I would try to do it without modification of the CPIO format. However,
at the time .xattr-list is parsed (in do_copy() before .xattr-list is
closed), it is not guaranteed that all files are extracted. These must
be created before xattrs are added, but the file type must be correct,
otherwise clean_path() removes the existing file with xattrs.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
