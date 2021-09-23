Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2F415BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 12:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhIWKCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 06:02:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40026 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWKCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:02:45 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9655622308;
        Thu, 23 Sep 2021 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632391273;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzJP1NacuRrgyoFRt4Ocp3ynHeVYoUlVZdZtaHi2uBE=;
        b=iKFB2v0lDs03sugqu0Q8wHXo3HNjI9ogoEkYBh7xRrfRqEAtOfWbd2+4O8e+1PXbOlQh6j
        X9kBnJ+m9TluSiKGzk/1iXGV11ptPNYTLtku1zq+CQTxYL95l+ND8ulHSPuEj+3ZzBV2Mn
        pikn9ttaONfoVNQJyeSPSEapY90g+RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632391273;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzJP1NacuRrgyoFRt4Ocp3ynHeVYoUlVZdZtaHi2uBE=;
        b=As0XRGUSDMSN0X6e0YkkmOOs1WrEAm2X429Mo3aBaWRx8duMlnAXU3N22wHQFkMVACE5L2
        3m5uyfsRfzuh4MAw==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 8DCA525D3C;
        Thu, 23 Sep 2021 10:01:12 +0000 (UTC)
References: <20210921130127.24131-1-rpalethorpe@suse.com>
 <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
 <87o88mkor1.fsf@suse.de> <87lf3qkk72.fsf@suse.de> <87ilytkngp.fsf@suse.de>
 <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: ia32 signed long treated as x64 unsigned int by __ia32_sys*
Reply-To: rpalethorpe@suse.de
In-reply-to: <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
Date:   Thu, 23 Sep 2021 11:01:09 +0100
Message-ID: <87fstvlifu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Sep 22, 2021 at 10:46 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>> Richard Palethorpe <rpalethorpe@suse.de> writes:
>
>> >
>> > Then the output is:
>> >
>> > [   11.252268] io_pgetevents(f7f19000, 4294967295, 1, ...)
>> > [   11.252401] comparing 4294967295 <= 1
>> > io_pgetevents02.c:114: TPASS: invalid min_nr: io_pgetevents() failed as expected: EINVAL (22)
>> > [   11.252610] io_pgetevents(f7f19000, 1, 4294967295, ...)
>> > [   11.252748] comparing 1 <= 4294967295
>> > io_pgetevents02.c:103: TFAIL: invalid max_nr: io_pgetevents() passed unexpectedly
>>
>> and below is the macro expansion for the automatically generated 32bit to
>> 64bit io_pgetevents. I believe it is casting u32 to s64, which appears
>> to mean there is no sign extension. I don't know if this is the expected
>> behaviour?
>
> Thank you for digging through this, I meant to already reply once more yesterday
> but didn't get around to that.

Thanks, no problem. I suppose this will effect other systemcalls as
well. Which if nothing else is a pain for testing.

>
>>     __typeof(__builtin_choose_expr(
>>         (__builtin_types_compatible_p(typeof((long)0), typeof(0LL)) ||
>>          __builtin_types_compatible_p(typeof((long)0), typeof(0ULL))),
>>         0LL, 0L)) min_nr,
>>     __typeof(__builtin_choose_expr(
>>         (__builtin_types_compatible_p(typeof((long)0), typeof(0LL)) ||
>>          __builtin_types_compatible_p(typeof((long)0), typeof(0ULL))),
>>         0LL, 0L)) nr,
>
> The part that I remembered is in arch/s390/include/asm/syscall_wrapper.h,
> which uses this version instead:
>
> #define __SC_COMPAT_CAST(t, a)                                          \
> ({                                                                      \
>         long __ReS = a;                                                 \
>                                                                         \
>         BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&              \
>                      !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t) &&           \
>                      !__TYPE_IS_LL(t));                                 \
>         if (__TYPE_IS_L(t))                                             \
>                 __ReS = (s32)a;                                         \
>         if (__TYPE_IS_UL(t))                                            \
>                 __ReS = (u32)a;                                         \
>         if (__TYPE_IS_PTR(t))                                           \
>                 __ReS = a & 0x7fffffff;                                 \
>         if (__TYPE_IS_LL(t))                                            \
>                 return -ENOSYS;                                         \
>         (t)__ReS;                                                       \
> })
>
> This also takes care of s390-specific pointer conversion, which is the
> reason for needing an architecture-specific wrapper, but I suppose the
> handling of signed arguments as done in s390 should also be done
> everywhere else.
>
> I also noticed that only x86 and s390 even have separate entry
> points for normal syscalls when called in compat mode, while
> the others all just zero the upper halves of the registers in the
> low-level entry code and then call the native entry point.
>
>         Arnd

It looks to me like aarch64 also has something similar? At any rate, I
can try to fix it for x86 and investigate what else might be effected.

-- 
Thank you,
Richard.
