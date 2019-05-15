Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AEA1EE45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 13:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbfEOLTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 07:19:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730926AbfEOLTS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 07:19:18 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 140A8AC54039E2847CA4;
        Wed, 15 May 2019 12:19:16 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 15 May
 2019 12:19:06 +0100
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Rob Landley <rob@landley.net>, Andy Lutomirski <luto@kernel.org>,
        "Arvind Sankar" <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        <initramfs@vger.kernel.org>,
        "Silviu Vlasceanu" <Silviu.Vlasceanu@huawei.com>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <1557861511.3378.19.camel@HansenPartnership.com>
 <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
 <1557878052.2873.6.camel@HansenPartnership.com>
 <20190515005221.GB88615@rani.riverdale.lan>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <a138af12-d983-453e-f0b2-661a80b7e837@huawei.com>
Date:   Wed, 15 May 2019 13:19:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190515005221.GB88615@rani.riverdale.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/15/2019 2:52 AM, Arvind Sankar wrote:
> On Tue, May 14, 2019 at 04:54:12PM -0700, James Bottomley wrote:
>> On Tue, 2019-05-14 at 18:39 -0500, Rob Landley wrote:
>>> On 5/14/19 2:18 PM, James Bottomley wrote:
>>>>> I think Rob is right here.  If /init was statically built into
>>>>> the kernel image, it has no more ability to compromise the kernel
>>>>> than anything else in the kernel.  What's the problem here?
>>>>
>>>> The specific problem is that unless you own the kernel signing key,
>>>> which is really untrue for most distribution consumers because the
>>>> distro owns the key, you cannot build the initrd statically into
>>>> the kernel.  You can take the distro signed kernel, link it with
>>>> the initrd then resign the combination with your key, provided you
>>>> insert your key into the MoK variables as a trusted secure boot
>>>> key, but the distros have been unhappy recommending this as
>>>> standard practice.
>>>>
>>>> If our model for security is going to be to link the kernel and the
>>>> initrd statically to give signature protection over the aggregate
>>>> then we need to figure out how to execute this via the distros.  If
>>>> we accept that the split model, where the distro owns and signs the
>>>> kernel but the machine owner builds and is responsible for the
>>>> initrd, then we need to explore split security models like this
>>>> proposal.
>>>
>>> You can have a built-in and an external initrd? The second extracts
>>> over the first? (I know because once upon a time conflicting files
>>> would append. It sounds like the desired behavior here is O_EXCL fail
>>> and move on.)
>>
>> Technically yes, because the first initrd could find the second by some
>> predefined means, extract it to a temporary directory and do a
>> pivot_root() and then the second would do some stuff, find the real
>> root and do a pivot_root() again.  However, while possible, wouldn't it
>> just add to the rendezvous complexity without adding any benefits? even
>> if the first initrd is built and signed by the distro and the second is
>> built by you, the first has to verify the second somehow.  I suppose
>> the second could be tar extracted, which would add xattrs, if that's
>> the goal?
>>
>> James
>>
> You can specify multiple initrd's to the boot loader, and they get
> loaded in sequence into memory and parsed by the kernel before /init is
> launched. Currently I believe later ones will overwrite the earlier
> ones, which is why we've been talking about adding an option to prevent
> that. You don't have to mess with manually finding/parsing initramfs's
> which wouldn't even be feasible since you may not have the drivers
> loaded yet to access the device/filesystem on which they live.
> 
> Once that's done, the embedded /init is just going to do in userspace
> wht the current patch does in the kernel. So all the files in the
> external initramfs(es) would need to have IMA signatures via the special
> xattr file.

So, the scheme you are proposing is not equivalent: using the distro key
to verify signatures, compared to adding a new user key to verify the
initramfs he builds. Why would it be necessary for the user to share
responsibility with the distro, if the only files he uses come from the
distro?


> Note that if you want the flexibility to be able to load one or both of
> two external initramfs's, the current in-kernel proposal wouldn't be
> enough -- the xattr specification would have to be more flexible (eg
> reading .xattr-list* to allow each initramfs to specifiy its own
> xattrs. This sort of enhancement would be much easier to handle with the
> userspace variant.

Yes, the alternative solution is to parse .xattr-list at the time it is
extracted. The .xattr-list of each initramfs will be processed. Also,
the CPIO parser doesn't have to reopen the file after all other files
have been extracted.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
