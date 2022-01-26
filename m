Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92449C87D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 12:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiAZLTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 06:19:07 -0500
Received: from mx1.mailbun.net ([170.39.20.100]:35954 "EHLO mx1.mailbun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240588AbiAZLTG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:19:06 -0500
Received: from [192.168.1.5] (unknown [172.58.104.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id 89A5711A484;
        Wed, 26 Jan 2022 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643195946;
        bh=raidN3KhEb8zPHzR6MMb0YsMuDUbxTjPizLkNy2Z5Qo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=DiVo/OzLPrcIHb10qvSv+tIwXC0yMKq+h9med80u2dtHhiuvK3R1q/rsZ+Wu+kW6Y
         NyQMV4u3NUtAh0MnUZj4Gz8WOViMcB69k7DPdezRMINiPY+GWzhZxwpyrXICZ2g2gw
         JmpB8nsoTQDGq7Y6auDIpb2lwfx4lKxEhyJccQgV7HmNDHpFj24ygnO4VrywEO1LYv
         OpU1TkTKcTaTKNZyb4rIRIrlPO+Peuzko+0MDx04Jph97S/ELIAlZPGX7kgKJ9yBsv
         n/soYKkMblnwR/9QeNwTVZ+tJI69gE2EZo5BDlYRh9vsPISQXLw0Zy/S/XSEmXuYtG
         5A4lSwkISSItw==
Date:   Wed, 26 Jan 2022 05:18:58 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <39480927-B17F-4573-B335-7FCFD81AB997@chromium.org>
Message-ID: <44b4472d-1d50-c43f-dbb1-953532339fb4@dereferenced.org>
References: <20220126043947.10058-1-ariadne@dereferenced.org> <202201252241.7309AE568F@keescook> <39480927-B17F-4573-B335-7FCFD81AB997@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, 25 Jan 2022, Kees Cook wrote:

>
>
> On January 25, 2022 10:42:41 PM PST, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Jan 26, 2022 at 04:39:47AM +0000, Ariadne Conill wrote:
>>> The first argument to argv when used with execv family of calls is
>>> required to be the name of the program being executed, per POSIX.
>>>
>>> By validating this in do_execveat_common(), we can prevent execution
>>> of shellcode which invokes execv(2) family syscalls with argc < 1,
>>> a scenario which is disallowed by POSIX, thus providing a mitigation
>>> against CVE-2021-4034 and similar bugs in the future.
>>>
>>> The use of -EFAULT for this case is similar to other systems, such
>>> as FreeBSD and OpenBSD.
>>>
>>> Interestingly, Michael Kerrisk opened an issue about this in 2008,
>
> For v2 please include a URL for this. I assume you mean this one?
> https://bugzilla.kernel.org/show_bug.cgi?id=8408

Yes, that's the one.  I honestly need to rewrite that commit message 
anyway.

>>> but there was no consensus to support fixing this issue then.
>>> Hopefully now that CVE-2021-4034 shows practical exploitative use
>>> of this bug in a shellcode, we can reconsider.
>>>
>>> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
>>
>> Yup. Agreed. For context:
>> https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt
>>
>>> ---
>>>  fs/exec.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/exec.c b/fs/exec.c
>>> index 79f2c9483302..de0b832473ed 100644
>>> --- a/fs/exec.c
>>> +++ b/fs/exec.c
>>> @@ -1897,8 +1897,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>>>  	}
>>>
>>>  	retval = count(argv, MAX_ARG_STRINGS);
>>> -	if (retval < 0)
>>> +	if (retval < 1) {
>>> +		retval = -EFAULT;
>>>  		goto out_free;
>>> +	}
>
> Actually, no, this needs to be more carefully special-cased to avoid masking error returns from count(). (e.g. -E2BIG would vanish with this patch.)
>
> Perhaps just add:
>
> if (retval == 0) {
>        retval = -EFAULT;
>        goto out_free;
> }

Alright.  I will do that in v2.

>>
>> There shouldn't be anything legitimate actually doing this in userspace.
>
> I spoke too soon.
>
> Unfortunately, this is not the case:
> https://codesearch.debian.net/search?q=execve%5C+*%5C%28%5B%5E%2C%5D%2B%2C+*NULL&literal=0
>
> Lots of stuff likes to do:
> execve(path, NULL, NULL);
>
> Do these things depend on argc==0 would be my next question...

I looked at these, and these seem to basically be lazily-written test 
cases which should be fixed.  I didn't see any example of real-world 
applications doing this.  As noted in some of the test cases, there are 
comments like "Solaris doesn't support this," etc.

So I think having this as a config option at the very least makes a lot of 
sense.  If users really need to run legacy code where execv() works with 
argc < 1, then they could just run a kernel that allows that nonsense, 
just like how Linux doesn't necessarily support the old a.out binary 
format today, unless it is enabled.

Ariadne
