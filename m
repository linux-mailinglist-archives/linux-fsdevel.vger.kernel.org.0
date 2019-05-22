Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5135E267E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfEVQRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 12:17:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48639 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfEVQRu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 12:17:50 -0400
Received: from [IPv6:2607:fb90:3635:972:9c5a:d1ae:8e8f:2fe7] ([IPv6:2607:fb90:3635:972:9c5a:d1ae:8e8f:2fe7])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x4MGHSn03691732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 22 May 2019 09:17:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4MGHSn03691732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558541852;
        bh=B44ya3o9B6nqq6f/Jtd+b4WU9Xx+2DYOyzI8sYcDzls=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=uiMj7ouDv0CJJx/tuZx6jO74+sdp1REU90ooSB5Z2URjHChSQMIkPIXIgJMaLqcHa
         bgEb0yw6vbjDRwDz/Zr6gDDaS+dL3mG1tPZRFlc022fMDsV52ZkgTF1ddn0xI3z4Em
         HuOBuls8ENM4Tcuc7zIgk48oTAtnymU9JL0g09dmlanScR1N1Gz1kpJ5cDziwPUff0
         mfjYAwaA8ljFJzgZOFWvwzAtpRjKvEfVBrDqv/QKMMt6KYfHWtAD2Cvqt038kxD+WO
         0nGzFStMwoRl+WNfWH7w8+nXamRR8ZYWrNivWRM6y53fGfep7+6iEaik56YK0htho6
         oOVdD/InCq6wA==
Date:   Wed, 22 May 2019 09:17:24 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <7bdca169-7a01-8c55-40e4-a832e876a0e5@huawei.com>
References: <20190517165519.11507-1-roberto.sassu@huawei.com> <20190517165519.11507-3-roberto.sassu@huawei.com> <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com> <20190517210219.GA5998@rani.riverdale.lan> <d48f35a1-aab1-2f20-2e91-5e81a84b107f@zytor.com> <20190517221731.GA11358@rani.riverdale.lan> <7bdca169-7a01-8c55-40e4-a832e876a0e5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
CC:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com
From:   hpa@zytor.com
Message-ID: <9C5B9F98-2067-43D3-B149-57613F38DCD4@zytor.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 20, 2019 2:39:46 AM PDT, Roberto Sassu <roberto=2Esassu@huawei=2Ecom=
> wrote:
>On 5/18/2019 12:17 AM, Arvind Sankar wrote:
>> On Fri, May 17, 2019 at 02:47:31PM -0700, H=2E Peter Anvin wrote:
>>> On 5/17/19 2:02 PM, Arvind Sankar wrote:
>>>> On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor=2Ecom wrote:
>>>>>
>>>>> Ok=2E=2E=2E I just realized this does not work for a modular initram=
fs,
>composed at load time from multiple files, which is a very real
>problem=2E Should be easy enough to deal with: instead of one large file,
>use one companion file per source file, perhaps something like
>filename=2E=2Exattrs (suggesting double dots to make it less likely to
>conflict with a "real" file=2E) No leading dot, as it makes it more
>likely that archivers will sort them before the file proper=2E
>>>> This version of the patch was changed from the previous one exactly
>to deal with this case --
>>>> it allows for the bootloader to load multiple initramfs archives,
>each
>>>> with its own =2Exattr-list file, and to have that work properly=2E
>>>> Could you elaborate on the issue that you see?
>>>>
>>>
>>> Well, for one thing, how do you define "cpio archive", each with its
>own
>>> =2Exattr-list file? Second, that would seem to depend on the ordering,
>no,
>>> in which case you depend critically on =2Exattr-list file following
>the
>>> files, which most archivers won't do=2E
>>>
>>> Either way it seems cleaner to have this per file; especially if/as
>it
>>> can be done without actually mucking up the format=2E
>>>
>>> I need to run, but I'll post a more detailed explanation of what I
>did
>>> in a little bit=2E
>>>
>>> 	-hpa
>>>
>> Not sure what you mean by how do I define it? Each cpio archive will
>> contain its own =2Exattr-list file with signatures for the files within
>> it, that was the idea=2E
>>=20
>> You need to review the code more closely I think -- it does not
>depend
>> on the =2Exattr-list file following the files to which it applies=2E
>>=20
>> The code first extracts =2Exattr-list as though it was a regular file=
=2E
>If
>> a later dupe shows up (presumably from a second archive, although the
>> patch will actually allow a second one in the same archive), it will
>> then process the existing =2Exattr-list file and apply the attributes
>> listed within it=2E It then will proceed to read the second one and
>> overwrite the first one with it (this is the normal behaviour in the
>> kernel cpio parser)=2E At the end once all the archives have been
>> extracted, if there is an =2Exattr-list file in the rootfs it will be
>> parsed (it would've been the last one encountered, which hasn't been
>> parsed yet, just extracted)=2E
>>=20
>> Regarding the idea to use the high 16 bits of the mode field in
>> the header that's another possibility=2E It would just require
>additional
>> support in the program that actually creates the archive though,
>which
>> the current patch doesn't=2E
>
>Yes, for adding signatures for a subset of files, no changes to the ram
>disk generator are necessary=2E Everything is done by a custom module=2E =
To
>support a generic use case, it would be necessary to modify the
>generator to execute getfattr and the awk script after files have been
>placed in the temporary directory=2E
>
>If I understood the new proposal correctly, it would be task for cpio
>to
>read file metadata after the content and create a new record for each
>file with mode 0x18000, type of metadata encoded in the file name and
>metadata as file content=2E I don't know how easy it would be to modify
>cpio=2E Probably the amount of changes would be reasonable=2E
>
>The kernel will behave in a similar way=2E It will call do_readxattrs()
>in
>do_copy() for each file=2E Since the only difference between the current
>and the new proposal would be two additional calls to do_readxattrs()
>in
>do_name() and unpack_to_rootfs(), maybe we could support both=2E
>
>Roberto

The nice thing with explicit metadata is that it doesn't have to contain t=
he filename per se, and each file is self-contained=2E There is a reason wh=
y each cpio header starts with the magic number: each cpio record is formal=
ly independent and can be processed in isolation=2E  The TRAILER!!! thing i=
s a huge wart in the format, although in practice TRAILER!!! always has a m=
ode of 0 and so can be distinguished from an actual file=2E

The use of mode 0x18000 for metadata allows for optional backwards compati=
bility for extraction; for encoding this can be handled with very simple po=
stprocessing=2E

So my suggestion would be to have mode 0x18000 indicate extended file meta=
data, with the filename of the form:

optional_filename!XXXXX!

=2E=2E=2E where XXXXX indicates the type of metadata (e=2Eg=2E !XATTR!)=2E=
 The optional_filename prefix allows an unaware decoder to extract to a wel=
l-defined name; simple postprocessing would be able to either remove (for s=
ize) or add (for compatibility) this prefix=2E It would be an error for thi=
s prefix, if present, to not match the name of the previous file=2E

I do agree that the delayed processing of an =2Exattr-list as you describe=
 ought to work even with a modular initramfs=2E


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
