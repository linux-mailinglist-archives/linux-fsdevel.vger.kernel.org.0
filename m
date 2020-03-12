Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E54182C58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 10:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCLJY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 05:24:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:37434 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgCLJY2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:24:28 -0400
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1jCK4M-0004oB-TH; Thu, 12 Mar 2020 12:23:59 +0300
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Snitzer <snitzer@redhat.com>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, riteshh@linux.ibm.com,
        krisman@collabora.com, surajjs@amazon.com,
        Dmitry Monakhov <dmonakhov@gmail.com>,
        mbobrowski@mbobrowski.org, Eric Whitney <enwlinux@gmail.com>,
        sblbir@amazon.com, Khazhismel Kumykov <khazhy@google.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <20200302165637.GA6826@mit.edu>
 <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
 <C4175F35-E9D4-4B79-B1A0-047A51DE3287@dilger.ca>
 <46c1ed68-ba2f-5738-1257-8fd1b6b87023@virtuozzo.com>
 <B6B72600-AB08-42F5-A9FF-0A0D2189CAFB@dilger.ca>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <326d9ec9-6671-61af-57a0-e1c3f72f658c@virtuozzo.com>
Date:   Thu, 12 Mar 2020 12:23:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <B6B72600-AB08-42F5-A9FF-0A0D2189CAFB@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.03.2020 03:31, Andreas Dilger wrote:
> On Mar 11, 2020, at 2:29 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> On 11.03.2020 22:26, Andreas Dilger wrote:
>>> On Mar 3, 2020, at 2:57 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>
>>>> On 02.03.2020 19:56, Theodore Y. Ts'o wrote:
>>>>> Kirill,
>>>>>
>>>>> In a couple of your comments on this patch series, you mentioned
>>>>> "defragmentation".  Is that because you're trying to use this as part
>>>>> of e4defrag, or at least, using EXT4_IOC_MOVE_EXT?
>>>>>
>>>>> If that's the case, you should note that input parameter for that
>>>>> ioctl is:
>>>>>
>>>>> struct move_extent {
>>>>> 	__u32 reserved;		/* should be zero */
>>>>> 	__u32 donor_fd;		/* donor file descriptor */
>>>>> 	__u64 orig_start;	/* logical start offset in block for orig */
>>>>> 	__u64 donor_start;	/* logical start offset in block for donor */
>>>>> 	__u64 len;		/* block length to be moved */
>>>>> 	__u64 moved_len;	/* moved block length */
>>>>> };
>>>>>
>>>>> Note that the donor_start is separate from the start of the file that
>>>>> is being defragged.  So you could have the userspace application
>>>>> fallocate a large chunk of space for that donor file, and then use
>>>>> that donor file to defrag multiple files if you want to close pack
>>>>> them.
>>>>
>>>> The practice shows it's not so. Your suggestion was the first thing we tried,
>>>> but it works bad and just doubles/triples IO.
>>>>
>>>> Let we have two files of 512Kb, and they are placed in separate 1Mb clusters:
>>>>
>>>> [[512Kb file][512Kb free]][[512Kb file][512Kb free]]
>>>>
>>>> We want to pack both of files in the same 1Mb cluster. Packed together on block
>>>> device, they will be in the same server of underlining distributed storage file
>>>> system. This gives a big performance improvement, and this is the price I aimed.
>>>>
>>>> In case of I fallocate a large hunk for both of them, I have to move them
>>>> both to this new hunk. So, instead of moving 512Kb of data, we will have to move
>>>> 1Mb of data, i.e. double size, which is counterproductive.
>>>>
>>>> Imaging another situation, when we have
>>>> [[1020Kb file]][4Kb free]][[4Kb file][1020Kb free]]
>>>>
>>>> Here we may just move [4Kb file] into [4Kb free]. But your suggestion again
>>>> forces us to move 1Mb instead of 4Kb, which makes IO 256 times worse! This is
>>>> terrible! And this is the thing I try prevent with finding a new interface.
>>>
>>> One idea I had, which may work for your use case, is to run fallocate() on
>>> the *1MB-4KB file* to allocate the last 4KB in that hunk, then use that block
>>> as the donor file for the 1MB+4KB file.  The ext4 allocation algorithms should
>>> always give you that 4KB chunk if it is free, and that avoids the need to try
>>> and force the allocator to select that block through some other method.
>>
>> Do you mean the following:
>>
>> 1)fallocate() 4K at the end of *1MB-4KB* the first file (==> this increases the file length).
> 
> You can use FALLOCATE_KEEP_SIZE to avoid changing the size of the file.

Ok, but there still remains the problem with fallocation of a block in front of target file:

[4KB hole][1MB-4KB file][hole][4KB file]

Is there a high-probably way that ext4 allocator returns a block before target file?

>> 2)EXT4_IOC_MOVE_EXT *4KB* the second file in that new hunk.
>> 3)truncate 4KB at the end of the first file.
>>
>> If so, this can't be an online defrag, since some process may want to increase
>> *1MB-4KB* file in between. This will just bring to data corruption.
> 
> You previously stated that one of the main reasons to do the defrag is because
> the files are not being modified.  It would be possible to detect the case of
> the file being modified by the file version and/or size and/or time change
> before removing the fallocated block.

Yes, files should not be modified in parallel, but there is no 100% guarantee.
It's almost 100% by statistics, but since there is multi-user system (I defrag
fs on VPS), there are possible exceptions. And the whole architecture must be
safe in any cases.

File version does not look acceptable for online defrag, since there is no a way,
which allows to check the version and to remove fallocated block *atomically*.

>> Another problem is that power lose between 1 and 3 will result in that file
>> length remain *1MB* instead of *1MB-4KB*.
> 
> With FALLOCATE_KEEP_SIZE you can just use this file as the donor file to
> allocate the blocks, then migrate it to another file without having written
> anything into it.

In case of some task decides to write into fallocated block, there will be data
corruption.
