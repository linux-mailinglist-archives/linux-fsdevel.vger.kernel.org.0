Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021E749D454
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiAZVNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 16:13:20 -0500
Received: from mx1.mailbun.net ([170.39.20.100]:42884 "EHLO mx1.mailbun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231972AbiAZVNU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:13:20 -0500
Received: from [2607:fb90:d98b:8818:5079:94eb:24d5:e5c3] (unknown [172.58.104.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id D9D0A1029F2;
        Wed, 26 Jan 2022 21:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643231597;
        bh=GAOjAJ3c30htNr0VwlzMoqZwg5WqFiJEH15Vi5OoL+Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=UNQIecEH29ceagkeWm6bKihu3Lpy/5kLi990DINx2gyiOSiZbQkIhzYmgNKDmVhY7
         miG8KgMN1LXxMUyOPBpLYhWjzzvm23JLXpavmBmtfm8oQQU/x/xCC8B0hrTz/IaqGB
         LvldT20qUgrU+uxRTPljXjoI6uoE5HHv0Ujx37FgaYe1WKk7dAkj5e68/13FbDdwi8
         XAOX+zwkipY2h107RtBOe33EON66RGQzx+BxUdyPSGCk6CQXKLdhkT8EiyFzj3TUb8
         ow2wxnj6B5sXPs2cIDgd53j3/QG6jkIWfh3LxvKYg7BCXrbZyPH5Fc2IQkpp4nU0dd
         koD5bIfIexd/Q==
Date:   Wed, 26 Jan 2022 15:13:10 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <202201261239.CB5D7C991A@keescook>
Message-ID: <5e963fab-88d4-2039-1cf4-6661e9bd16b@dereferenced.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org> <202201261202.EC027EB@keescook> <a8fef39-27bf-b25f-7cfe-21782a8d3132@dereferenced.org> <202201261239.CB5D7C991A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 26 Jan 2022, Kees Cook wrote:

> On Wed, Jan 26, 2022 at 02:23:59PM -0600, Ariadne Conill wrote:
>> Hi,
>>
>> On Wed, 26 Jan 2022, Kees Cook wrote:
>>
>>> On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
>>>> In several other operating systems, it is a hard requirement that the
>>>> first argument to execve(2) be the name of a program, thus prohibiting
>>>> a scenario where argc < 1.  POSIX 2017 also recommends this behaviour,
>>>> but it is not an explicit requirement[0]:
>>>>
>>>>     The argument arg0 should point to a filename string that is
>>>>     associated with the process being started by one of the exec
>>>>     functions.
>>>>
>>>> To ensure that execve(2) with argc < 1 is not a useful gadget for
>>>> shellcode to use, we can validate this in do_execveat_common() and
>>>> fail for this scenario, effectively blocking successful exploitation
>>>> of CVE-2021-4034 and similar bugs which depend on this gadget.
>>>>
>>>> The use of -EFAULT for this case is similar to other systems, such
>>>> as FreeBSD, OpenBSD and Solaris.  QNX uses -EINVAL for this case.
>>>>
>>>> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
>>>> but there was no consensus to support fixing this issue then.
>>>> Hopefully now that CVE-2021-4034 shows practical exploitative use
>>>> of this bug in a shellcode, we can reconsider.
>>>>
>>>> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
>>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
>>>>
>>>> Changes from v1:
>>>> - Rework commit message significantly.
>>>> - Make the argv[0] check explicit rather than hijacking the error-check
>>>>   for count().
>>>>
>>>> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
>>>> ---
>>>>  fs/exec.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/fs/exec.c b/fs/exec.c
>>>> index 79f2c9483302..e52c41991aab 100644
>>>> --- a/fs/exec.c
>>>> +++ b/fs/exec.c
>>>> @@ -1899,6 +1899,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>>>>  	retval = count(argv, MAX_ARG_STRINGS);
>>>>  	if (retval < 0)
>>>>  		goto out_free;
>>>> +	if (retval == 0) {
>>>> +		retval = -EFAULT;
>>>> +		goto out_free;
>>>> +	}
>>>>  	bprm->argc = retval;
>>>>
>>>>  	retval = count(envp, MAX_ARG_STRINGS);
>>>> --
>>>> 2.34.1
>>>
>>> Okay, so, the dangerous condition is userspace iterating through envp
>>> when it thinks it's iterating argv.
>>>
>>> Assuming it is not okay to break valgrind's test suite:
>>> https://sources.debian.org/src/valgrind/1:3.18.1-1/none/tests/execve.c/?hl=22#L22
>>> we cannot reject a NULL argv (test will fail), and we cannot mutate
>>> argc=0 into argc=1 (test will enter infinite loop).
>>>
>>> Perhaps we need to reject argv=NULL when envp!=NULL, and add a
>>> pr_warn_once() about using a NULL argv?
>>
>> Sure, I can rework the patch to do it for only the envp != NULL case.
>>
>> I think we should combine it with the {NULL, NULL} padding patch in this
>> case though, since it appears to work, that way the execve(..., NULL, NULL)
>> case gets some protection.
>
> I don't think the padding will actually work correctly, for the reason
> Jann pointed out. My testing shows that suddenly my envp becomes NULL,
> but libc is just counting argc to find envp to pass into main.
>
>>> I note that glibc already warns about NULL argv:
>>> argc0.c:7:3: warning: null argument where non-null required (argument 2)
>>> [-Wnonnull]
>>>    7 |   execve(argv[0], NULL, envp);
>>>      |   ^~~~~~
>>>
>>> in the future we could expand this to only looking at argv=NULL?
>>
>> I don't think musl's headers generate a diagnostic for this, but main(0,
>> {NULL}) is not a supported use-case at least as far as Alpine is concerned.
>> I am sure it is the same with the other musl distributions.
>>
>> Will send a v3 patch with this logic change and move to EINVAL shortly.
>
> I took a spin too. Refuses execve(..., NULL, !NULL), injects "" argv[0]
> for execve(..., NULL, NULL):
>
>
> diff --git a/fs/exec.c b/fs/exec.c
> index a098c133d8d7..0565089d5f9e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1917,9 +1917,40 @@ static int do_execveat_common(int fd, struct filename *filename,
> 	if (retval < 0)
> 		goto out_free;
>
> -	retval = copy_strings(bprm->argc, argv, bprm);
> -	if (retval < 0)
> -		goto out_free;
> +	if (likely(bprm->argc > 0)) {
> +		retval = copy_strings(bprm->argc, argv, bprm);
> +		if (retval < 0)
> +			goto out_free;
> +	} else {
> +		const char * const argv0 = "";
> +
> +		/*
> +		 * Start making some noise about the argc == NULL case that
> +		 * POSIX doesn't like and other Unix-like systems refuse.
> +		 */
> +		pr_warn_once("process '%s' used a NULL argv\n", bprm->filename);
> +
> +		/*
> +		 * Refuse to execute when argc == 0 and envc > 0, since this
> +		 * can lead to userspace iterating envp if it fails to check
> +		 * for argc == 0.
> +		 *
> +		 * i.e. continue to allow: execve(path, NULL, NULL);
> +		 */
> +		if (bprm->envc > 0) {
> +			retval = -EINVAL;
> +			goto out_free;
> +		}
> +
> +		/*
> +		 * Force an argv of {"", NULL} if argc == 0 so that broken
> +		 * userspace that assumes argc != 0 will not be surprised.
> +		 */
> +		bprm->argc = 1;
> +		retval = copy_strings_kernel(bprm->argc, &argv0, bprm);
> +		if (retval < 0)
> +			goto out_free;
> +	}
>
> 	retval = bprm_execve(bprm, fd, filename, flags);
> out_free:

Looks good to me, but I wonder if we shouldn't set an argv of 
{bprm->filename, NULL} instead of {"", NULL}.  Discussion in IRC led to 
the realization that multicall programs will try to use argv[0] and might 
crash in this scenario.  If we're going to fake an argv, I guess we should 
try to do it right.

Ariadne
