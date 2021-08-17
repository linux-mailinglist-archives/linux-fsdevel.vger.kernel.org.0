Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B43EF070
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhHQQvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 12:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhHQQvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629219027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8f7fF91cLNQ/eZUDORo18HDZ0NWJEdq4cFwDyEoL7s=;
        b=THDiVdJqnnU8OtJdG/wJwuJPI/yncYxClSRHn/edQwlzzCkhD97+9gQHDxnEVAi3vaRhVi
        33ioC9ErIlEt6pGkolb8QlFkNOWFMT2qQoXpkUnNfs41izf3MbgIQv6CtZsk/XqMRtJkpn
        ASIrgRhVQInuv8W+YfTbjCj5WW3jDEE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-p2RuyBKkND2K_KHtlcgpUg-1; Tue, 17 Aug 2021 12:50:26 -0400
X-MC-Unique: p2RuyBKkND2K_KHtlcgpUg-1
Received: by mail-wm1-f69.google.com with SMTP id r21-20020a05600c35d5b02902e685ef1f76so958827wmq.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 09:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P8f7fF91cLNQ/eZUDORo18HDZ0NWJEdq4cFwDyEoL7s=;
        b=M60g7lDcEMZGS4T/tMaFdjMBN3lJ/r+0ePQe3W8uXQoFnHb4I0h7lHZ9mCt5JRHeXD
         eRHbhyc9kvA+dyHWzVuyJrwvCzIyy3169R9Snws9aTYlXfDrBIfRc9Bre7zvrXUsELi+
         7Q4Wpb3Jquwq82HxAnC+DAuFrm4cOG8iWUIQ8OT8HFzrjvCiEUEC2YVBO9CHDdYNEMQD
         YaQX4ZchM1A63+QnqWlLyV/t6775KM13Sy76bofnRGs48w+Lsf47EDYMCgLp1LD6XUtw
         Z9aM5HjvsbnpOKEDmrTwo1eqMm2vMhx9PKTG1EutTIAx+EVWF3/mfdOBR5LYd1I10t8q
         /v9g==
X-Gm-Message-State: AOAM533frtiiW6U52BWjSfQIUMpkZd0fXjvLmxE1LkStghEcmYqBnpmp
        g/oGimXWntNLmc+c9DSVgIbcPbPNQF1NY918WwOXrmFsz6RqWVXnGtY32SVj6XvM2zJ6mOHj8hr
        pStwzuYwi4DdFPdxLwVs+x9nOrw==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr4347815wmi.131.1629219024786;
        Tue, 17 Aug 2021 09:50:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKK9RYJJ+cmjTKcg0wST41h29nu8sSNhpqAJJXsGepas3/C+2BUjvnI0Z8CS8mLXjdRCe+aQ==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr4347781wmi.131.1629219024617;
        Tue, 17 Aug 2021 09:50:24 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c6.dip0.t-ipconnect.de. [91.12.101.198])
        by smtp.gmail.com with ESMTPSA id p14sm2588600wmc.16.2021.08.17.09.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 09:50:24 -0700 (PDT)
Subject: Re: Removing Mandatory Locks
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <YRcyqbpVqwwq3P6n@casper.infradead.org> <87k0kkxbjn.fsf_-_@disp2133>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c65c4e42-9661-1321-eaf8-61b1d6f8990a@redhat.com>
Date:   Tue, 17 Aug 2021 18:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87k0kkxbjn.fsf_-_@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.08.21 18:48, Eric W. Biederman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> On Fri, Aug 13, 2021 at 05:49:19PM -0700, Andy Lutomirski wrote:
>>> [0] we have mandatory locks, too. Sigh.
>>
>> I'd love to remove that.  Perhaps we could try persuading more of the
>> distros to disable the CONFIG option first.
> 
> Yes.  The support is disabled in RHEL8.

kernel-ark also seems to not set it for Fedora and ARK

redhat/configs/common/generic/CONFIG_MANDATORY_FILE_LOCKING:# 
CONFIG_MANDATORY_FILE_LOCKING is not set


-- 
Thanks,

David / dhildenb

