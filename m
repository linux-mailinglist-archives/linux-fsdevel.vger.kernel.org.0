Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18BC26901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfEVRWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 13:22:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32961 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727365AbfEVRWj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 13:22:39 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 05CF417966E92720806F;
        Wed, 22 May 2019 18:22:37 +0100 (IST)
Received: from [10.204.65.201] (10.204.65.201) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 22 May
 2019 18:22:31 +0100
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     <hpa@zytor.com>, Arvind Sankar <nivedita@alum.mit.edu>
CC:     <viro@zeniv.linux.org.uk>, <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <arnd@arndb.de>,
        <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <20190517210219.GA5998@rani.riverdale.lan>
 <d48f35a1-aab1-2f20-2e91-5e81a84b107f@zytor.com>
 <20190517221731.GA11358@rani.riverdale.lan>
 <7bdca169-7a01-8c55-40e4-a832e876a0e5@huawei.com>
 <9C5B9F98-2067-43D3-B149-57613F38DCD4@zytor.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <2ceb1f01-88fb-d383-daee-e38348a2f075@huawei.com>
Date:   Wed, 22 May 2019 19:22:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9C5B9F98-2067-43D3-B149-57613F38DCD4@zytor.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.201]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/2019 6:17 PM, hpa@zytor.com wrote:
> On May 20, 2019 2:39:46 AM PDT, Roberto Sassu <roberto.sassu@huawei.com> wrote:
>> On 5/18/2019 12:17 AM, Arvind Sankar wrote:
>>> On Fri, May 17, 2019 at 02:47:31PM -0700, H. Peter Anvin wrote:
>>>> On 5/17/19 2:02 PM, Arvind Sankar wrote:
>>>>> On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
>>>>>>
>>>>>> Ok... I just realized this does not work for a modular initramfs,
>> composed at load time from multiple files, which is a very real
>> problem. Should be easy enough to deal with: instead of one large file,
>> use one companion file per source file, perhaps something like
>> filename..xattrs (suggesting double dots to make it less likely to
>> conflict with a "real" file.) No leading dot, as it makes it more
>> likely that archivers will sort them before the file proper.
>>>>> This version of the patch was changed from the previous one exactly
>> to deal with this case --
>>>>> it allows for the bootloader to load multiple initramfs archives,
>> each
>>>>> with its own .xattr-list file, and to have that work properly.
>>>>> Could you elaborate on the issue that you see?
>>>>>
>>>>
>>>> Well, for one thing, how do you define "cpio archive", each with its
>> own
>>>> .xattr-list file? Second, that would seem to depend on the ordering,
>> no,
>>>> in which case you depend critically on .xattr-list file following
>> the
>>>> files, which most archivers won't do.
>>>>
>>>> Either way it seems cleaner to have this per file; especially if/as
>> it
>>>> can be done without actually mucking up the format.
>>>>
>>>> I need to run, but I'll post a more detailed explanation of what I
>> did
>>>> in a little bit.
>>>>
>>>> 	-hpa
>>>>
>>> Not sure what you mean by how do I define it? Each cpio archive will
>>> contain its own .xattr-list file with signatures for the files within
>>> it, that was the idea.
>>>
>>> You need to review the code more closely I think -- it does not
>> depend
>>> on the .xattr-list file following the files to which it applies.
>>>
>>> The code first extracts .xattr-list as though it was a regular file.
>> If
>>> a later dupe shows up (presumably from a second archive, although the
>>> patch will actually allow a second one in the same archive), it will
>>> then process the existing .xattr-list file and apply the attributes
>>> listed within it. It then will proceed to read the second one and
>>> overwrite the first one with it (this is the normal behaviour in the
>>> kernel cpio parser). At the end once all the archives have been
>>> extracted, if there is an .xattr-list file in the rootfs it will be
>>> parsed (it would've been the last one encountered, which hasn't been
>>> parsed yet, just extracted).
>>>
>>> Regarding the idea to use the high 16 bits of the mode field in
>>> the header that's another possibility. It would just require
>> additional
>>> support in the program that actually creates the archive though,
>> which
>>> the current patch doesn't.
>>
>> Yes, for adding signatures for a subset of files, no changes to the ram
>> disk generator are necessary. Everything is done by a custom module. To
>> support a generic use case, it would be necessary to modify the
>> generator to execute getfattr and the awk script after files have been
>> placed in the temporary directory.
>>
>> If I understood the new proposal correctly, it would be task for cpio
>> to
>> read file metadata after the content and create a new record for each
>> file with mode 0x18000, type of metadata encoded in the file name and
>> metadata as file content. I don't know how easy it would be to modify
>> cpio. Probably the amount of changes would be reasonable.
>>
>> The kernel will behave in a similar way. It will call do_readxattrs()
>> in
>> do_copy() for each file. Since the only difference between the current
>> and the new proposal would be two additional calls to do_readxattrs()
>> in
>> do_name() and unpack_to_rootfs(), maybe we could support both.
>>
>> Roberto
> 
> The nice thing with explicit metadata is that it doesn't have to contain the filename per se, and each file is self-contained. There is a reason why each cpio header starts with the magic number: each cpio record is formally independent and can be processed in isolation.  The TRAILER!!! thing is a huge wart in the format, although in practice TRAILER!!! always has a mode of 0 and so can be distinguished from an actual file.
> 
> The use of mode 0x18000 for metadata allows for optional backwards compatibility for extraction; for encoding this can be handled with very simple postprocessing.
> 
> So my suggestion would be to have mode 0x18000 indicate extended file metadata, with the filename of the form:
> 
> optional_filename!XXXXX!
> 
> ... where XXXXX indicates the type of metadata (e.g. !XATTR!). The optional_filename prefix allows an unaware decoder to extract to a well-defined name; simple postprocessing would be able to either remove (for size) or add (for compatibility) this prefix. It would be an error for this prefix, if present, to not match the name of the previous file.

Actually, I defined '..metadata..' as special name to indicate that the
file contains metadata. Then, the content of the file is a set of:

struct metadata_hdr {
         char c_size[8];     /* total size including c_size field */
         char c_version;     /* header version */
         char c_type;        /* metadata type */
         char c_metadata[];  /* metadata */
} __packed;

init/initramfs.c now has a specific parser for c_type. Currently, I
implemented a parser for xattrs, which expects data in the format:

<xattr #N name>\0<xattr #N value>

I checked if it is possible to use bit 17:16 to identify files with
metadata, but both the cpio and the kernel use unsigned short.

I already modified gen_init_cpio and cpio. I modify at run-time the list
of files to be included in the image by adding a temporary file, that
each time is set with the xattrs of the previously processed file.

The output of cpio -t looks like:

--
.
..metadata..
bin
..metadata..
dev
..metadata..
dev/console
..metadata..
--

Would it be ok? If you prefer that I add the format to the file name or
you/anyone has a comment about this proposal, please let me know so that
I make the changes before sending a new version of the patch set.

Thanks

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
