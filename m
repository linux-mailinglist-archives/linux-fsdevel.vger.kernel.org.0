Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375D41C805
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfENLwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 07:52:42 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32937 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfENLwm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 07:52:42 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 69C94883796B5B036EF3;
        Tue, 14 May 2019 12:52:40 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 14 May
 2019 12:52:38 +0100
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
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <49965ffd-dd57-ffe5-4a2f-73cdfb387848@landley.net>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <de91ef53-6bb3-b937-8773-5f6b34e1acb7@huawei.com>
Date:   Tue, 14 May 2019 13:52:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <49965ffd-dd57-ffe5-4a2f-73cdfb387848@landley.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/2019 8:06 AM, Rob Landley wrote:
> On 5/13/19 7:47 AM, Roberto Sassu wrote:
>> On 5/13/2019 11:07 AM, Rob Landley wrote:
>>>>> Wouldn't the below work even before enforcing signatures on external
>>>>> initramfs:
>>>>> 1. Create an embedded initramfs with an /init that does the xattr
>>>>> parsing/setting. This will be verified as part of the kernel image
>>>>> signature, so no new code required.
>>>>> 2. Add a config option/boot parameter to panic the kernel if an external
>>>>> initramfs attempts to overwrite anything in the embedded initramfs. This
>>>>> prevents overwriting the embedded /init even if the external initramfs
>>>>> is unverified.
>>>>
>>>> Unfortunately, it wouldn't work. IMA is already initialized and it would
>>>> verify /init in the embedded initial ram disk.
>>>
>>> So you made broken infrastructure that's causing you problems. Sounds
>>> unfortunate.
>>
>> The idea is to be able to verify anything that is accessed, as soon as
>> rootfs is available, without distinction between embedded or external
>> initial ram disk.
> 
> If /init is in the internal one and you can't overwrite files with an external
> one, all your init has to be is something that applies the xattrs, enables your
> paranoia mode, and then execs something else.

Shouldn't file metadata be handled by the same code that extracts the
content? Instead, file content is extracted by the kernel, and we are
adding another step to the boot process, to execute a new binary with a
link to libc.

 From the perspective of a remote verifier that checks the software
running on the system, would it be easier to check less than 150 lines
of code, or a CPIO image containing a binary + libc?


> Heck, I do that sort of set up in shell scripts all the time. Running the shell
> script as PID 1 and then having it exec the "real init" binary at the end:
> 
> https://github.com/landley/mkroot/blob/83def3cbae21/mkroot.sh#L205
> 
> If your first init binary is in the initramfs statically linked into the kernel
> image, and the cpio code is doing open(O_EXCL), then it's as verified as any
> other kernel code and runs "securely" until it decides to run something else.
> 
>> Also, requiring an embedded initramfs for xattrs would be an issue for
>> systems that use it for other purposes.
> 
> I'm the guy who wrote the initmpfs code. (And has pending patches to improve it
> that will probably never go upstream because I'm a hobbyist and dealing with the
>   linux-kernel clique is the opposite of fun. I'm only in this conversation
> because I was cc'd.)
> 
> You can totally use initramfs for lots of purposes simultaneously.

Yes, I agree. However, adding an initramfs to initialize another
initramfs when you can simply extract file content and metadata with the
same parser, this for me it is difficult to justify.


>>>> The only reason why
>>>> opening .xattr-list works is that IMA is not yet initialized
>>>> (late_initcall vs rootfs_initcall).
>>>
>>> Launching init before enabling ima is bad because... you didn't think of it?
>>
>> No, because /init can potentially compromise the integrity of the
>> system.
> 
> Which isn't a problem if it was statically linked in the kernel, or if your
> external cpio.gz was signed. You want a signed binary but don't want the
> signature _in_ the binary...

It is not just for binaries. How you would deal with arbitrary file
formats?


>>>> Allowing a kernel with integrity enforcement to parse the CPIO image
>>>> without verifying it first is the weak point.
>>>
>>> If you don't verify the CPIO image then in theory it could have anything in it,
>>> yes. You seem to believe that signing individual files is more secure than
>>> signing the archive. This is certainly a point of view.
>>
>> As I wrote above, signing the CPIO image would be more secure, if this
>> option is available. However, a disadvantage would be that you have to
>> sign the CPIO image every time a file changes.
> 
> Which is why there's a cpio in the kernel and an external cpio loaded via the
> old initrd mechanism and BOTH files wind up in the cpio and there's a way to
> make it O_EXCL so it can't overwrite, and then the /init binary inside the
> kernel's cpio can do any other weird verification you need to do before anything
> else gets a chance to run so why are you having ring 0 kernel code read a file
> out of the filesystem and act upon it?

The CPIO parser already invokes many system calls.


> (Heck, you can mv /newinit /init before the exec /init so the file isn't on the
> system anymore by the time the other stuff gets to run...)
> 
>>>> However, extracted files
>>>> are not used, and before they are used they are verified. At the time
>>>> they are verified, they (included /init) must already have a signature
>>>> or otherwise access would be denied.
>>>
>>> You build infrastructure that works a certain way, the rest of the system
>>> doesn't fit your assumptions, so you need to change the rest of the system to
>>> fit your assumptions.
>>
>> Requiring file metadata to make decisions seems reasonable. Also
>> mandatory access controls do that. The objective of this patch set is to
>> have uniform behavior regardless of the filesystem used.
> 
> If it's in the file's contents you get uniform behavior regardless of the
> filesystem used. And "mandatory access controls do that" is basically restating
> what _I_ said in the paragraph above.

As I said, that does not work with arbitrary file formats.


> The "infrastructure you have that works a certain way" is called "mandatory
> access controls". Good to know. Your patch changes the rest of the system to
> match the assumptions of the new code, because changing those assumptions
> appears literally unthinkable.

All I want to do is to have the same behavior as if there is no initial
ram disk. And given that inode-based MACs read the labels from xattrs,
the assumption that the system provides xattrs even in the inital ram
disk seems reasonable.


>>>> This scheme relies on the ability of the kernel to not be corrupted in
>>>> the event it parses a malformed CPIO image.
>>>
>>> I'm unaware of any buffer overruns or wild pointer traversals in the cpio
>>> extraction code. You can fill up all physical memory with initramfs and lock the
>>> system hard, though.
>>>
>>> It still only parses them at boot time before launching PID 1, right? So you
>>> have a local physical exploit and you're trying to prevent people from working
>>> around your Xbox copy protection without a mod chip?
>>
>> What do you mean exactly?
> 
> That you're not remotely the first person to do this?
> 
> You're attempting to prevent anyone from running third party code on your system
> without buying a license from you first. You're creating a system with no user
> serviceable parts, that only runs authorized software from the Apple Store or
> other walled garden. No sideloading allowed.

This is one use case. The main purpose of IMA is to preserve the
integrity of the Trusted Computing Base (TCB, the critical part of the
system), or to detect integrity violations without enforcement. This is
done by ensuring that the software comes from the vendor. Applications
owned by users are allowed to run, as the Discrectionary Access Control
(DAC) prevents attacks to the TCB. I'm working on a more advanced scheme
that relies on MAC.


> Which is your choice, sure. But why do you need new infrastructure to do it?
> People have already _done_ this. They're just by nature proprietary and don't
> like sharing with the group when not forced by lawyers, so they come up with
> ways that don't involve modifying GPLv2 software (or shipping GPLv3 software,
> ever, for any reason).
> 
>>>> Mimi suggested to use
>>>> digital signatures to prevent this issue, but it cannot be used in all
>>>> scenarios, since conventional systems generate the initial ram disk
>>>> locally.
>>>
>>> So you use a proprietary init binary you can't rebuild from source, and put it
>>> in a cpio where /dev/urandom is a file with known contents? Clearly, not
>>> exploitable at all. (And we update the initramfs.cpio but not the kernel because
>>> clearly keeping the kernel up to date is less important to security...)
>>
>> By signing the CPIO image, the kernel wouldn't even attempt to parse it,
>> as the image would be rejected by the boot loader if the signature is
>> invalid.
> 
> So you have _more_ assumptions tripping you up. Great. So add a signature in a
> format your bootloader doesn't recognize, since it's the kernel that should
> verify it, not your bootloader?
> 
> It sounds like your problem is bureaucratic, not technical.

The boot loader verifies the CPIO image, when this is possible. The
kernel verifies individual files when the CPIO image is not signed.

If a remote verifier wants to verify the measurement of the CPIO image,
and he only has reference digests for each file, he has to build the
CPIO image with files reference digests were calculated from, and in the
same way it was done by the system target of the evaluation.


>>> Whatever happened to https://lwn.net/Articles/532778/ ? Modules are signed
>>> in-band in the file, but you need xattrs for some reason?
>>
>> Appending just the signature would be possible. It won't work if you
>> have multiple metadata for the same file.
> 
> Call the elf sections SIG1 SIG2 SIG3, or have a section full of keyword=value
> strings? How is this a hard problem?
> 
>> Also appending the signature alone won't solve the parsing issue. Still,
>> the kernel has to parse something that could be malformed.
> 
> Your new in-band signaling file you're making xattrs from could be malformed,
> one of the xattrs you add could be "banana=aaaaaaaaaaaaaaaaaaaaaaaaaaa..." going
> on for 12 megabytes...

ksys_lsetxattr() checks the limits.

Roberto


> Rob
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
