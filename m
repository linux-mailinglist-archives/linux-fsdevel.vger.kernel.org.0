Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A349D5E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 00:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiAZXHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 18:07:52 -0500
Received: from mx1.mailbun.net ([170.39.20.100]:42888 "EHLO mx1.mailbun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbiAZXHw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:07:52 -0500
Received: from [2607:fb90:d98b:8818:f877:8b4d:b8e:5ef5] (unknown [172.58.109.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id 4098911A817;
        Wed, 26 Jan 2022 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643238472;
        bh=4jbgQdEYB/Ogcs9D1+o31MmOrg2MwhNco7JGwQ6xy9w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=QSPTUoomDAqer1KGHVfncm5b4qTeKVefbWYv/t88Dl6BoD1i4XrQJXAAKRv2WlBgw
         kmAz63xLLfDyC3lz1qW9caCHtb42xZkZ/OEErIZJuHNOhCpY68SWBeGqQpbl/kb+Ir
         0QG3VKzwSFeFoqgX4vr/ikJvc3Qw49mkbhOAKuGWbRRhDL/4df3sUuYP5uNME52Cbt
         AhoFbMlCyyODAbcFbautiRTFpGKMyFo9Eb0zspWUDh4N1pFkjddkiSaEZfIRzwQNhV
         WLzGsIGgC/aDYJ3Gx9I7utgNfzAQod5iL3eZIbDAZHnCf26yAzIKScsewXua4HzFuz
         gD40nnVtDEbLg==
Date:   Wed, 26 Jan 2022 17:07:45 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <202201261440.0C13601104@keescook>
Message-ID: <85834b6e-a0e-eefc-7cf6-2ca37798cdf@dereferenced.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org> <202201261202.EC027EB@keescook> <a8fef39-27bf-b25f-7cfe-21782a8d3132@dereferenced.org> <202201261239.CB5D7C991A@keescook> <5e963fab-88d4-2039-1cf4-6661e9bd16b@dereferenced.org> <202201261323.9499FA51@keescook>
 <64e91dc2-7f5c-6e8-308e-414c82a8ae6b@dereferenced.org> <202201261440.0C13601104@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 26 Jan 2022, Kees Cook wrote:

> On Wed, Jan 26, 2022 at 03:30:13PM -0600, Ariadne Conill wrote:
>> Hi,
>>
>> On Wed, 26 Jan 2022, Kees Cook wrote:
>>
>>> On Wed, Jan 26, 2022 at 03:13:10PM -0600, Ariadne Conill wrote:
>>>> Looks good to me, but I wonder if we shouldn't set an argv of
>>>> {bprm->filename, NULL} instead of {"", NULL}.  Discussion in IRC led to the
>>>> realization that multicall programs will try to use argv[0] and might crash
>>>> in this scenario.  If we're going to fake an argv, I guess we should try to
>>>> do it right.
>>>
>>> They're crashing currently, though, yes? I think the goal is to move
>>> toward making execve(..., NULL, NULL) just not work at all. Using the
>>> {"", NULL} injection just gets us closer to protecting a bad userspace
>>> program. I think things _should_ crash if they try to start depending
>>> on this work-around.
>>
>> Is there a reason to spawn a program, just to have it crash, rather than
>> just denying it to begin with, though?
>
> I think the correct behavior here is to unconditionally reject a NULL
> argv -- and I wish this had gotten fixed in 2008. :P Given the code we've
> found that depends on NULL argv, I think we likely can't make the change
> outright, so we're down this weird rabbit hole of trying to reject what we
> can and create work-around behaviors for the cases that currently exist.
> I think new users of the new work-around shouldn't be considered. We'd
> prefer they get a rejection, etc.
>
>> I mean, it all seems fine enough, and perhaps I'm just a bit picky on the
>> colors and flavors of my bikesheds, so if you want to go with this patch,
>> I'll be glad to carry it in the Alpine security update I am doing to make
>> sure the *other* GLib-using SUID programs people find don't get exploited in
>> the same way.
>
> They "don't break userspace" guideline is really "don't break userspace
> if someone notices". :P Since this is a mitigation (not strictly a
> security flaw fix), changes to userspace behavior tend to be very
> conservatively viewed by Linus. ;)
>
> My preference is the earlier very simple version to fix this:
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 79f2c9483302..aabadcf4a525 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1897,6 +1897,8 @@ static int do_execveat_common(int fd, struct filename *filename,
> 	}
>
> 	retval = count(argv, MAX_ARG_STRINGS);
> +	if (reval == 0)
> +		retval = -EINVAL;
> 	if (retval < 0)
> 		goto out_free;
> 	bprm->argc = retval;
>
> So, I guess we should start there and send a patch to valgrind?

Yes, seems reasonable, though without the typo :)

Since you've already written the patch, do you want to proceed with it?
If so, I can work on the Valgrind tests.

Ariadne
