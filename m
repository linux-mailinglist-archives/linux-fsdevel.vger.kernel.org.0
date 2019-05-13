Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00A11B653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 14:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfEMMrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 08:47:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729976AbfEMMrA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 08:47:00 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5B80448035ABDDE81A3F;
        Mon, 13 May 2019 13:46:58 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 13 May
 2019 13:46:57 +0100
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <initramfs@vger.kernel.org>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
Date:   Mon, 13 May 2019 14:47:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/13/2019 11:07 AM, Rob Landley wrote:
> 
> 
> On 5/13/19 2:49 AM, Roberto Sassu wrote:
>> On 5/12/2019 9:43 PM, Arvind Sankar wrote:
>>> On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
>>>> On 5/12/19 7:52 AM, Mimi Zohar wrote:
>>>>> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
>>>>>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
>>>>>>> This proposal consists in marshaling pathnames and xattrs in a file called
>>>>>>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
>>>>>>> been extracted.
>>>>>>
>>>>>> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
>>>>>> be done equivalently by the initramfs' /init? Why is kernel involvement
>>>>>> actually required here?
>>>>>
>>>>> It's too late.  The /init itself should be signed and verified.
>>>>
>>>> If the initramfs cpio.gz image was signed and verified by the extractor, how is
>>>> the init in it _not_ verified?
>>>>
>>>> Ro
>>>
>>> Wouldn't the below work even before enforcing signatures on external
>>> initramfs:
>>> 1. Create an embedded initramfs with an /init that does the xattr
>>> parsing/setting. This will be verified as part of the kernel image
>>> signature, so no new code required.
>>> 2. Add a config option/boot parameter to panic the kernel if an external
>>> initramfs attempts to overwrite anything in the embedded initramfs. This
>>> prevents overwriting the embedded /init even if the external initramfs
>>> is unverified.
>>
>> Unfortunately, it wouldn't work. IMA is already initialized and it would
>> verify /init in the embedded initial ram disk.
> 
> So you made broken infrastructure that's causing you problems. Sounds unfortunate.

The idea is to be able to verify anything that is accessed, as soon as
rootfs is available, without distinction between embedded or external
initial ram disk.

Also, requiring an embedded initramfs for xattrs would be an issue for
systems that use it for other purposes.


>> The only reason why
>> opening .xattr-list works is that IMA is not yet initialized
>> (late_initcall vs rootfs_initcall).
> 
> Launching init before enabling ima is bad because... you didn't think of it?

No, because /init can potentially compromise the integrity of the
system.


>> Allowing a kernel with integrity enforcement to parse the CPIO image
>> without verifying it first is the weak point.
> 
> If you don't verify the CPIO image then in theory it could have anything in it,
> yes. You seem to believe that signing individual files is more secure than
> signing the archive. This is certainly a point of view.

As I wrote above, signing the CPIO image would be more secure, if this
option is available. However, a disadvantage would be that you have to
sign the CPIO image every time a file changes.


>> However, extracted files
>> are not used, and before they are used they are verified. At the time
>> they are verified, they (included /init) must already have a signature
>> or otherwise access would be denied.
> 
> You build infrastructure that works a certain way, the rest of the system
> doesn't fit your assumptions, so you need to change the rest of the system to
> fit your assumptions.

Requiring file metadata to make decisions seems reasonable. Also
mandatory access controls do that. The objective of this patch set is to
have uniform behavior regardless of the filesystem used.


>> This scheme relies on the ability of the kernel to not be corrupted in
>> the event it parses a malformed CPIO image.
> 
> I'm unaware of any buffer overruns or wild pointer traversals in the cpio
> extraction code. You can fill up all physical memory with initramfs and lock the
> system hard, though.
> 
> It still only parses them at boot time before launching PID 1, right? So you
> have a local physical exploit and you're trying to prevent people from working
> around your Xbox copy protection without a mod chip?

What do you mean exactly?


>> Mimi suggested to use
>> digital signatures to prevent this issue, but it cannot be used in all
>> scenarios, since conventional systems generate the initial ram disk
>> locally.
> 
> So you use a proprietary init binary you can't rebuild from source, and put it
> in a cpio where /dev/urandom is a file with known contents? Clearly, not
> exploitable at all. (And we update the initramfs.cpio but not the kernel because
> clearly keeping the kernel up to date is less important to security...)

By signing the CPIO image, the kernel wouldn't even attempt to parse it,
as the image would be rejected by the boot loader if the signature is
invalid.


> Whatever happened to https://lwn.net/Articles/532778/ ? Modules are signed
> in-band in the file, but you need xattrs for some reason?

Appending just the signature would be possible. It won't work if you
have multiple metadata for the same file.

Also appending the signature alone won't solve the parsing issue. Still,
the kernel has to parse something that could be malformed.

Roberto


>> Roberto
> 
> Rob
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
