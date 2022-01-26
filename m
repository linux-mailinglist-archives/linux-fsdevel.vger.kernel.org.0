Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291AD49D10A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbiAZRlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243976AbiAZRlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:41:19 -0500
Received: from mx1.mailbun.net (unknown [IPv6:2602:fd37:1::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F501C061757;
        Wed, 26 Jan 2022 09:41:12 -0800 (PST)
Received: from [2607:fb90:d98b:8818:5079:94eb:24d5:e5c3] (unknown [172.58.104.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id EDAB011A595;
        Wed, 26 Jan 2022 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643218872;
        bh=XYekf48ntM/kh4vSP+nndPBCo9zhvgRhtN0lPYqJVco=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=hc1mVR1qLyvqQdekWLJd3uyW6lKB6L94CBUFeTp64s3yuNZx9aSf45GnIXKOHQTVH
         C4KIgU73JSDWhVIZcT9Uxtg4OooT39J2WvdtL3i0FbJ7+63o87cPucAGyBkn1PvLky
         Ui/ePTHHAc+tfxILvtJtQ2rTty/tJRPeXWMGzyIjf/Tdw20LXwm2qEYIi2m65vxNfZ
         Gf9kO8ZE0czEM5i62LwIxG4IlJ7PMiPaec2UeNrazMV5Rl9YFQ/jSf2kMZe+pdiAZ8
         Uj13HpWGlGh0wKxFblVCEoJICnB/k3hkNgslnOzdaGgCb52HdQbue2CY2K14Q2fAHL
         40Vtsq+FOOixg==
Date:   Wed, 26 Jan 2022 11:41:05 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <YfFddcQyHHofTwgg@casper.infradead.org>
Message-ID: <15915be5-49c-77ba-d9f9-cf612f8211cb@dereferenced.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org> <YfFddcQyHHofTwgg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 26 Jan 2022, Matthew Wilcox wrote:

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
>
> I don't object to the concept, but it's a more common pattern in Linux
> to do this:
>
> 	retval = count(argv, MAX_ARG_STRINGS);
> +	if (retval == 0)
> +		retval = -EFAULT;
> 	if (retval < 0)
> 		goto out_free;

Yeah, that seems fine.  We can of course do it that way, which I will 
revise the patch to do if we decide to stick with denial over making a 
"safe" argv instead.

> (aka I like my bikesheds painted in Toasty Eggshell)

Toasty Eggshell is a nice color for a bikeshed :)

Ariadne
