Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8959E39FD93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 19:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhFHR20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 13:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhFHR20 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:28:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 752536136D;
        Tue,  8 Jun 2021 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623173193;
        bh=quLPk8hf1rTsI/xDu+n2XJpKuLPzI5budPumpjnNExg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BzsBwSngPLULxxPD6oB4tsxncLu2Xc8OBaztzdTDKmYZZ5qr1mDI/jNZWGmEW3ynD
         N4YKqlrlp1/SxNQ2ppnMpRDsl6tIfj18eHsqKOvbuxIa8CrC2takPVQ0yqFfiUO/ls
         AJhV/UxK5syg4kFKzNGeEdAfxQW6elZBw46CRkAKlg+mumbkoyF9XQGa/H6jOLrZTa
         BNazLU1YGSeTLVDuLsCTt7vKyMqEs6CovHtqujL7UjMucc23T6hLCbTtFTRtwGzZdZ
         lpPCIrReBi+xIXYuBUZPXo8WFDfH4Y8RTQyvQ6VOIDDzcOBidx3A/slQvjQw+ufFyh
         9e0vUf1WLgbBQ==
Subject: Re: [PATCH RFC] x86: remove toolchain check for X32 ABI capability
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jethro Beekman <jethro@fortanix.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
References: <20210227183910.221873-1-masahiroy@kernel.org>
 <CAK7LNASL_X43_nMTz1CZQB+jiLCRAJbh-wQdc23QV0pWceL_Lw@mail.gmail.com>
 <20210228064936.zixrhxlthyy6fmid@24bbad8f3778>
 <CAK7LNASY_+_38XEMLZAf7txr4EdukkcFL8pnGGe2XyhQ9F4oDQ@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <1992c9cf-739e-d98f-85c0-bbcf7df123ea@kernel.org>
Date:   Tue, 8 Jun 2021 10:26:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNASY_+_38XEMLZAf7txr4EdukkcFL8pnGGe2XyhQ9F4oDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Masahiro,

On 6/7/2021 12:39 AM, Masahiro Yamada wrote:
> On Sun, Feb 28, 2021 at 3:49 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Sun, Feb 28, 2021 at 12:15:16PM +0900, Masahiro Yamada wrote:
>>> On Sun, Feb 28, 2021 at 3:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>
>>>> This commit reverts 0bf6276392e9 ("x32: Warn and disable rather than
>>>> error if binutils too old").
>>>>
>>>> The help text in arch/x86/Kconfig says enabling the X32 ABI support
>>>> needs binutils 2.22 or later. This is met because the minimal binutils
>>>> version is 2.23 according to Documentation/process/changes.rst.
>>>>
>>>> I would not say I am not familiar with toolchain configuration, but
>>>
>>> I mean:
>>> I would not say I am familiar ...
>>> That is why I added RFC.
>>>
>>> I appreciate comments from people who are familiar
>>> with toolchains (binutils, llvm).
>>>
>>> If this change is not safe,
>>> we can move this check to Kconfig at least.
>>
>> Hi Masahiro,
>>
>> As Fangrui pointed out, there are two outstanding issues with x32 with
>> LLVM=1, both seemingly related to LLVM=1.
> 
> Is this still a problem for Clang built Linux?
> 
> 
> 
>> https://github.com/ClangBuiltLinux/linux/issues/514
> 
> I am not tracking the status.
> What was the conclusion?

This appears to no longer be reproducible so I closed it.

>> https://github.com/ClangBuiltLinux/linux/issues/1141
> 
> 
> This got marked "unreproducible"

I just had a look at this and it is still reproducible (see the bug for 
details).

>> Additionally, there appears to be one from Arnd as well but that one has
>> received no triage yet.
>>
>> https://github.com/ClangBuiltLinux/linux/issues/1205
> 
> Same as well.

Yeah, I cannot reproduce this.

It seems like a Kconfig test would still be best for the issue above, if 
it is not too much to maintain.

Cheers,
Nathan
