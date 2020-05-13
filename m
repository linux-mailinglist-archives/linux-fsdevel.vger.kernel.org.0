Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDEA1D04FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 04:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEMCcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 22:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEMCcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 22:32:50 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E05CC061A0E
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 19:32:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so20171228oif.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 19:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w05U4Ty4fjXvusSYkJgWcKh14hiK/1j5qmU3u7mm4Gk=;
        b=zro3iuWtE97dmQ2yHOnvFSySz6cnEaOXpjCj7UrvI6HN1BoVBQATbBys+y8DGiKzn8
         4e6gLMlpVYQR4pf6Sd/w32BfJdggxxqXNsZhm02yjJkagHlLAHfiKdHcve3uHOH6m4f1
         QJB7XnkShMgbga+ToPaDQ7SoC0ox+6cG4W8sXyO4YkgFLoyu2SLqtgwOwoGjJc0SNBvx
         m0fyuQ265Gx9qXMmG/6jCzVx6SjOJvkL2vpE0aZWoJ1fUl0NV3i53l9+SjWzeWiwOfvz
         ahm888waBPeeJ5ZLoVKa6U7TJFqjxlUKCgdF2YMnqpAg3dBmWVdgKm6CIfZ6HweoHeQZ
         pyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w05U4Ty4fjXvusSYkJgWcKh14hiK/1j5qmU3u7mm4Gk=;
        b=qKkXzxOQ2jyGfLjpmzEujUX2pr44rjgNsSDus/EicIYjXEue6cAdTxEOxGhyLv0gtW
         6S4uUj+Rv1P7Awc/Mn5m6wCDaHlFAh3j1bRX73PtnGj69akaAI26DUepKAwv6r381oys
         BOrZ0et1uByIcHjFA73PLsk8Lgsk3EiS9oOgUcR0IxHbr35FDQ0BMikY3T3co/aguqBq
         udkd49d2nCZ++hE6TEEZJISUoP2HB/DKQtLd6XPtGKOP7bF2f40TxN8QdvMLKgXyF6fT
         28839KGaFYKmGND321nvKF0NMqG8hiNyp3jACoEYZ6I9tr8N/xu0uM4tsVu18c1HJrzE
         3l9w==
X-Gm-Message-State: AGi0PuZ5U6i5UhQUx9afzBjQ4x0lpbS7lNRXT7IzhrNx8+WpmTGsDS5N
        TgC73A1GmNkdRlm17e3+bgJGHw==
X-Google-Smtp-Source: APiQypKejIA0kmvj/Qz9PYOoadZzdtDminPHwnrVp5To0Q93DoZzo/+2d+BBBnoTnejQtKo4vIlOMw==
X-Received: by 2002:aca:1007:: with SMTP id 7mr26354929oiq.139.1589337168640;
        Tue, 12 May 2020 19:32:48 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id m189sm5841682oig.12.2020.05.12.19.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:32:47 -0700 (PDT)
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org> <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org>
 <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <6f282d0a-b448-14e9-cd4f-92cce99cc36f@landley.net>
Date:   Tue, 12 May 2020 21:39:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/12/20 7:20 PM, Linus Torvalds wrote:
> On Tue, May 12, 2020 at 11:46 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> I am still thinking about this one, but here is where I am at.  At a
>> practical level passing the file descriptor of the script to interpreter
>> seems like something we should encourage in the long term.  It removes
>> races and it is cheaper because then the interpreter does not have to
>> turn around and open the script itself.
> 
> Yeah, I think we should continue to support it, because I think it's
> the right thing to do (and we might just end up having compatibility
> issues if we don't).
...
>> It is possible although unlikely for userspace to find the file
>> descriptor without consulting AT_EXECFD so just to be conservative I
>> think we should install the file descriptor in begin_new_exec even if
>> the next interpreter does not support AT_EXECFD.
> 
> Ack. I think the AT_EXECFD thing is a sign that this isn't internal to
> binfmt_misc, but it also shouldn't be gating this issue. In reality,
> ELF is the only real binary format that matters - the script/misc
> binfmts are just indirection entries - and it supports AT_EXECFD, so
> let's just ignore the theoretical case of "maybe nobody exposes it".

Would this potentially make the re-exec-yourself case easier to do at some
point? (Which nommu needs to do, and /proc/self/exe isn't always available.)

Here's the first time I asked about that:

https://lore.kernel.org/lkml/200612261823.07927.rob@landley.net/

Here's the most recent:

https://lkml.org/lkml/2017/9/5/246

Here's someone else asking and being basically told "chroot isn't a thing":

http://lkml.iu.edu/hypermail/linux/kernel/0906.3/00584.html

(See also "CVE-2019-5736" and the workarounds thereto.)

Rob

P.S. Yes I'm aware it would only work properly with static binaries. Not the
first thing that's true for.
