Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E03F49D0E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbiAZRiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbiAZRiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:38:06 -0500
Received: from mx1.mailbun.net (unknown [IPv6:2602:fd37:1::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC96C06173B;
        Wed, 26 Jan 2022 09:38:06 -0800 (PST)
Received: from [2607:fb90:d98b:8818:5079:94eb:24d5:e5c3] (unknown [172.58.104.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id A045511A595;
        Wed, 26 Jan 2022 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643218685;
        bh=cDleLCbBOwwONbneglMHpi+rUM2ZJO+uFBj5SQRt27A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=JDJU564HgMIWY8EJaGmUKAK7tTwQMg7H6FUkUM5BGYmxx085N/m8KYgiGWtHqOCUf
         C3w8+1iyBj7aOeEak3/MbKJ3zPWVGSYRN02xavPFmDq7bqaoQ9LvM/KeNf8zOJPjlK
         yvY5IERzKPdJmVB5h4ReZTlTl1obP0SlBmOXgAFUm3Y1Li5qxzuGDxVl9W6T0Vwfg5
         N9lDSTKgNZJy7MGRXfrLRoJFQAmDIQpOcERWQFQVseJSC3WG809jko9EIGGH7Rld7w
         njPImFUEB4pPI6fxgh3+QZMgLwNLA+HWZylc8PFiNWEsq9G+rwLN/6NrYHZEQArWeI
         yRbpLJrPIG/Og==
Date:   Wed, 26 Jan 2022 11:37:58 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     Rich Felker <dalias@libc.org>
cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <20220126132729.GA7942@brightrain.aerifal.cx>
Message-ID: <92b53c82-1588-36b3-b09b-e7c334e87e@dereferenced.org>
References: <20220126043947.10058-1-ariadne@dereferenced.org> <20220126132729.GA7942@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 26 Jan 2022, Rich Felker wrote:

> On Wed, Jan 26, 2022 at 04:39:47AM +0000, Ariadne Conill wrote:
>> The first argument to argv when used with execv family of calls is
>> required to be the name of the program being executed, per POSIX.
>
> That's not quite the story. The relevant text is a "should", meaning
> that to be "strictly conforming" an application has to follow the
> convention, but still can't assume its invoker did. (Note that most
> programs do not aim to be "strictly conforming"; it's not just the
> word strictly applied as an adjective to conforming, but a definition
> of its own imposing very stringent portability conditions beyond what
> the standard already imposes.) Moreover, POSIX (following ISO C, after
> this was changed from early C drafts) rejected making it a
> requirement. This is documented in the RATIONALE for execve:
>
>    Early proposals required that the value of argc passed to main()
>    be "one or greater". This was driven by the same requirement in
>    drafts of the ISO C standard. In fact, historical implementations
>    have passed a value of zero when no arguments are supplied to the
>    caller of the exec functions. This requirement was removed from
>    the ISO C standard and subsequently removed from this volume of
>    POSIX.1-2017 as well. The wording, in particular the use of the
>    word should, requires a Strictly Conforming POSIX Application to
>    pass at least one argument to the exec function, thus guaranteeing
>    that argc be one or greater when invoked by such an application.
>    In fact, this is good practice, since many existing applications
>    reference argv[0] without first checking the value of argc.
>
> Source: https://pubs.opengroup.org/onlinepubs/9699919799/functions/execve.html
>
> Note that despite citing itself as POSIX.1-2017 above, this is not a
> change in the 2017 edition; it's just the way they self-cite. As far
> as I can tell, the change goes back to prior to the first publication
> of the standard.

This was clarified in the v2 commit text.

>> By validating this in do_execveat_common(), we can prevent execution
>> of shellcode which invokes execv(2) family syscalls with argc < 1,
>> a scenario which is disallowed by POSIX, thus providing a mitigation
>> against CVE-2021-4034 and similar bugs in the future.
>>
>> The use of -EFAULT for this case is similar to other systems, such
>> as FreeBSD and OpenBSD.
>
> I don't like this choice of error, since in principle EFAULT should
> never happen when you haven't invoked memory-safety-violating UB.
> Something like EINVAL would be more appropriate. But if the existing
> practice for systems that do this is to use EFAULT, it's probably best
> to do the same thing.

It turns out that OpenBSD uses -EINVAL for this, see 
https://github.com/openbsd/src/commit/74212563870067f5b1e271876e1ec5a2fdf2f2e0

>
>> Interestingly, Michael Kerrisk opened an issue about this in 2008,
>> but there was no consensus to support fixing this issue then.
>> Hopefully now that CVE-2021-4034 shows practical exploitative use
>> of this bug in a shellcode, we can reconsider.
>
> I'm not really opposed to attempting to change this with consensus
> (like, actually proposing it on the Austin Group tracker), but a less
> invasive change would be just enforcing it for the case where exec is
> a privilege boundary (suid/sgid/caps). There's really no motivation
> for changing longstanding standard behavior in a
> non-privilege-boundary case.

It would be nice for the Austin Group to clarify this, but I think this is 
a "common sense" issue.  I don't think execve(2) with argc < 1 is 
"standard behavior" too, as many other systems outside Linux fail to 
execve(2) when argc < 1.

Ariadne
