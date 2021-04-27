Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE52936CD7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhD0VBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbhD0VBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:01:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974DC061574;
        Tue, 27 Apr 2021 14:00:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id CD8901F420C0
Subject: Re: [PATCH] generic/453: Exclude filenames that are not supported by
 exfat
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, krisman@collabora.com,
        preichl@redhat.com, kernel@collabora.com
References: <20210425223105.1855098-1-shreeya.patel@collabora.com>
 <20210426003430.GH235567@casper.infradead.org>
 <a49ecbfb-2011-0c7c-4405-b4548d22389d@collabora.com>
 <20210426123734.GK235567@casper.infradead.org>
 <bc7a33e8-7e9c-8045-e90e-bb53ec4f2c61@collabora.com>
 <20210427181116.GH3122235@magnolia>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <bfe0fa5b-c23b-a07f-6ebd-addbff62bae5@collabora.com>
Date:   Wed, 28 Apr 2021 02:30:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427181116.GH3122235@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 27/04/21 11:41 pm, Darrick J. Wong wrote:
> On Tue, Apr 27, 2021 at 04:43:05PM +0530, Shreeya Patel wrote:
>> On 26/04/21 6:07 pm, Matthew Wilcox wrote:
>>> On Mon, Apr 26, 2021 at 05:27:51PM +0530, Shreeya Patel wrote:
>>>> On 26/04/21 6:04 am, Matthew Wilcox wrote:
>>>>> On Mon, Apr 26, 2021 at 04:01:05AM +0530, Shreeya Patel wrote:
>>>>>> exFAT filesystem does not support the following character codes
>>>>>> 0x0000 - 0x001F ( Control Codes ), /, ?, :, ", \, *, <, |, >
>>>>> ummm ...
>>>>>
>>>>>> -# Fake slash?
>>>>>> -setf "urk\xc0\xafmoo" "FAKESLASH"
>>>>> That doesn't use any of the explained banned characters.  It uses 0xc0,
>>>>> 0xaf.
>>>>>
>>>>> Now, in utf-8, that's an nonconforming sequence.  "The Unicode and UCS
>>>>> standards require that producers of UTF-8 shall use the shortest form
>>>>> possible, for example, producing a two-byte sequence with first byte 0xc0
>>>>> is nonconforming.  Unicode 3.1 has added the requirement that conforming
>>>>> programs must not accept non-shortest forms in their input."
>>>>>
>>>>> So is it that exfat is rejecting nonconforming sequences?  Or is it
>>>>> converting the nonconforming sequence from 0xc0 0xaf to the conforming
>>>>> sequence 0x2f, and then rejecting it (because it's '/')?
>>>>>
>>>> No, I don't think exfat is not converting nonconforming sequence from 0xc0
>>>> 0xaf
>>>> to the conforming sequence 0x2f.
>>>> Because I get different outputs when tried with both ways.
>>>> When I create a file with "urk\xc0\xafmoo", I get output as "Operation not
>>>> permitted"
>>>> and when I create it as "urk\x2fmoo", it gives "No such file or directory
>>>> error" or
>>>> you can consider this error as "Invalid argument"
>>>> ( because that's what I get when I try for other characters like |, :, ?,
>>>> etc )
>>> I think we need to understand this before skipping the test.  Does it
>>> also fail, eg, on cifs, vfat, jfs or udf?
>>
>> I tested it for VFAT, UDF and JFS and following are the results.
>>
>>
>> 1. VFAT ( as per wikipedia 0x00-0x1F 0x7F " * / : < > ? \ | are reserved
>> characters)
>>
>> For \x2f - /var/mnt/scratch/test-453/urk/moo.txt: No such file or directory
>>
>> For \xc0\xaf) - /var/mnt/scratch/test-453/urk��moo.txt: Invalid argument
>>
>> Also gives error for Box filename
>>
>> ( this is very much similar to exfat, the only difference is that I do not
>> get Operation not permitted when
>> using \xc0\xaf, instead it gives invalid argument.)
> vfat checks for those invalid characters, see msdos_format_name() and
> vfat_is_used_badchars().
>
> TBH I think these tests (g/453 and g/454) are probably only useful for
> filesystems that allow unrestricted byte streams for names.


So it means I should just not run this test for all the fs that have 
some restricted characters.
But what about the other filenames which work fine. Don't we want to 
test them?


>> 2. UDF ( as per wikipedia - only NULL cannot be used )
>>
>> For \x2f - /var/mnt/scratch/test-453/urk/moo.txt: No such file or directory
>>
>> For \xc0\xaf - creates filename something like this 'urk??moo.txt' and does
>> not throw any error.
>> ( But this seems to be invalid and should have thrown some error)
>>
>> Also gives error for dotdot entry.
>>
>> I am not sure why UDF was giving error for / and dot dot entry but then
>> I read the following for UDF in one of the man pages which justifies the
>> above errors I think
>>
>> "Invalid characters such as "NULL" and "/" and  invalid  file
>> names  such  as "." and ".." will be translated according to
>> the following rule:
>>
>> Replace the invalid character with an "_," then  append  the
>> file name with # followed by a 4 digit hex representation of
>> the 16-bit CRC of the original FileIdentifier. For  example,
>> the file name ".." will become "__#4C05" "
>>
>> Source - http://www-it.desy.de/cgi-bin/man-cgi?udfs+7
> That's Solaris.
Sorry missed that.
>
>> 3. JFS ( as per Wikipedia NULL cannot be used )
>>
>> For \x2f - /var/mnt/scratch/test-453/urk/moo.txt: No such file or directory
>>
>> For \xc0\xaf - Works fine
>>
>> Again not sure why / is failing here. Did not find much resource about the
>> restricted filenames for JFS.
> "/" is a path separator, it should always return ENOENT (unless you
> created $SCRATCH_MNT/test-453/urk/moo.txt).  0x2f is the ascii encoding
> for a slash.


Hmmm, makes sense. Myabe that is why we are using \xc0\xaf instead of \x2f.


>
>> So as per above all the results, it seems like using \x2f fails for all but
>> \xc0\xaf does work for JFS.
> <nod>
>
> --D
>
>>
>>>> Box filename also fails with "Invalid argument" error.
>>>>
>>>>
