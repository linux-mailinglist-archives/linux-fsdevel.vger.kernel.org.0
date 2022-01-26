Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70249D35D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 21:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiAZUYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 15:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiAZUYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:24:09 -0500
Received: from mx1.mailbun.net (unknown [IPv6:2602:fd37:1::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E10C06161C;
        Wed, 26 Jan 2022 12:24:07 -0800 (PST)
Received: from [2607:fb90:d98b:8818:5079:94eb:24d5:e5c3] (unknown [172.58.104.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id EBDBBE0E1E;
        Wed, 26 Jan 2022 20:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643228646;
        bh=unMLJ93l5bXRQagJHUJJZiZSzDz3UCGTstIa9PckNN4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=NhCGMOcJ+ycxrhEJSkJLQw5eOWe9M99S29/PjGA5+P0eDmgDSbZ1mwaYW5HA+kiGT
         e72+Plp/owfKiaVVOTKHXoIyS0FxSDLG4oy8Ov1SQkuuvAJwfnFda0AoTHMEQ6y+vA
         o4ADMShg9PhqH+tvUXoTyyyzflxr4Ucf2qg9IjM7f8k201cSu69+/xGUI6toP3amwp
         oQn9v/ccMY38XgLQMNfAdfDyK5dJCY7sGVKRrOUwV6/uspdFjfdOgldv0DV+8EEnTM
         Fcovc2cAhcKmFrWXg3uAnMsnL6XRCPc4lfxj2MJhU8MSU8YRo1Up9hKLHX8BkAaRyR
         BeS5vIIN5Zokw==
Date:   Wed, 26 Jan 2022 14:23:59 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <202201261202.EC027EB@keescook>
Message-ID: <a8fef39-27bf-b25f-7cfe-21782a8d3132@dereferenced.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org> <202201261202.EC027EB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 26 Jan 2022, Kees Cook wrote:

> On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
>> In several other operating systems, it is a hard requirement that the
>> first argument to execve(2) be the name of a program, thus prohibiting
>> a scenario where argc < 1.  POSIX 2017 also recommends this behaviour,
>> but it is not an explicit requirement[0]:
>>
>>     The argument arg0 should point to a filename string that is
>>     associated with the process being started by one of the exec
>>     functions.
>>
>> To ensure that execve(2) with argc < 1 is not a useful gadget for
>> shellcode to use, we can validate this in do_execveat_common() and
>> fail for this scenario, effectively blocking successful exploitation
>> of CVE-2021-4034 and similar bugs which depend on this gadget.
>>
>> The use of -EFAULT for this case is similar to other systems, such
>> as FreeBSD, OpenBSD and Solaris.  QNX uses -EINVAL for this case.
>>
>> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
>> but there was no consensus to support fixing this issue then.
>> Hopefully now that CVE-2021-4034 shows practical exploitative use
>> of this bug in a shellcode, we can reconsider.
>>
>> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
>>
>> Changes from v1:
>> - Rework commit message significantly.
>> - Make the argv[0] check explicit rather than hijacking the error-check
>>   for count().
>>
>> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
>> ---
>>  fs/exec.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 79f2c9483302..e52c41991aab 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1899,6 +1899,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>>  	retval = count(argv, MAX_ARG_STRINGS);
>>  	if (retval < 0)
>>  		goto out_free;
>> +	if (retval == 0) {
>> +		retval = -EFAULT;
>> +		goto out_free;
>> +	}
>>  	bprm->argc = retval;
>>
>>  	retval = count(envp, MAX_ARG_STRINGS);
>> --
>> 2.34.1
>
> Okay, so, the dangerous condition is userspace iterating through envp
> when it thinks it's iterating argv.
>
> Assuming it is not okay to break valgrind's test suite:
> https://sources.debian.org/src/valgrind/1:3.18.1-1/none/tests/execve.c/?hl=22#L22
> we cannot reject a NULL argv (test will fail), and we cannot mutate
> argc=0 into argc=1 (test will enter infinite loop).
>
> Perhaps we need to reject argv=NULL when envp!=NULL, and add a
> pr_warn_once() about using a NULL argv?

Sure, I can rework the patch to do it for only the envp != NULL case.

I think we should combine it with the {NULL, NULL} padding patch in this 
case though, since it appears to work, that way the execve(..., NULL, 
NULL) case gets some protection.

> I note that glibc already warns about NULL argv:
> argc0.c:7:3: warning: null argument where non-null required (argument 2)
> [-Wnonnull]
>    7 |   execve(argv[0], NULL, envp);
>      |   ^~~~~~
>
> in the future we could expand this to only looking at argv=NULL?

I don't think musl's headers generate a diagnostic for this, but main(0, 
{NULL}) is not a supported use-case at least as far as Alpine is 
concerned.  I am sure it is the same with the other musl distributions.

Will send a v3 patch with this logic change and move to EINVAL shortly.

Ariadne
