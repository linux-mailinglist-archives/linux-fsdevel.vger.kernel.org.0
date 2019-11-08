Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10570F5310
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfKHR4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 12:56:03 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:38255 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfKHR4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:56:03 -0500
Received: by mail-io1-f41.google.com with SMTP id i13so5942473ioj.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIOSuIKsUyxB2M4djsqhXbm2T/JzMnIFwkmpg6fA+Ms=;
        b=V8oNGLl6qjTwrqheJvYzesqyiTnVno/IaIKZP7pJ0WT49dXpmErqA83AXZMdzOh2SG
         Je/FJRqdTlTebSps9vRJEZZnhUyn6Fj2UBX5ciMlsYJKfUxgPInxODDuST1cz+4KMYNH
         SuNHQQsWbmzYnw3dfuGcLU/7NjZxthkcmPq5okSnoxlVARkA/OdPsgIZoXLnMAOlMt7S
         zTdXwAgGiSxiPRc2XWy0p5rvSHw2pg+QxEvL49oKQfyV/NZQn634FIvPKmy17CH6ObwM
         7wbxbM4eY+lazZepLnUuSJ+f5XQM2rzBJYrjP0t2GzSa+cDpnD9udXUOflC/ynZOoMuK
         aKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIOSuIKsUyxB2M4djsqhXbm2T/JzMnIFwkmpg6fA+Ms=;
        b=WQg3GYycyBa1LQ+Ont1rHSOt9UJsiPOLxfLmy/uov+yP5rUC+xbvdakMzh9cpi6ic4
         9tDV8li9YwdahRQNKYowbbpzczBP1sFzwJWibzVaPmgB9N7TYkEHQIRhQzldg7+QKGdu
         8nT9/giGgmEuyOWyelaRh5ltAATSFtU1fHihdDsta0z4R8aAL1cepXE4EqQ2nADtD/Sw
         XjoD3/2qCTHoRegBO4nifOEIhpbLsHWkmXFA9XoJRx8cMdDviIc3Vmm7xHRu3k6GUhgS
         4B6d+vvw+6CKiD7PEpxJsybqNSxREQ0Fi9WFrVavf4gx8sEVnAWuNTddSHopqXPQlayt
         MQXA==
X-Gm-Message-State: APjAAAV0ESD+alexKfGYGHDWFXN3i12YaMWCIe23OrTdKN0fkxHkjeso
        6KJCrRNzXi8quwhM7M2loPucFqpp24hCS3gnGAR2eg==
X-Google-Smtp-Source: APXvYqw5kzvzbfFmFDbCNHG+gzaOMReqKjx6GVYSfTWVORZ0fuGL3qIL3c2gzxQ4/m2ex05aMkaCgR5t4+n0/KB6Phs=
X-Received: by 2002:a5d:8953:: with SMTP id b19mr12142211iot.168.1573235761783;
 Fri, 08 Nov 2019 09:56:01 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com> <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
In-Reply-To: <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 09:55:50 -0800
Message-ID: <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:53 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 8, 2019 at 9:39 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>
> > I'd hope that there is some way to mark the cases we know about where
> > we just have a flag. I'm not sure what KCSAN uses right now - is it
> > just the "volatile" that makes KCSAN ignore it, or are there other
> > ways to do it?
>
> I dunno, Marco will comment on this.
>
> I personally like WRITE_ONCE() since it adds zero overhead on generated code,
> and is the facto accessor we used for many years (before KCSAN was conceived)
>

BTW, I would love an efficient ADD_ONCE(variable, value)

Using WRITE_ONCE(variable, variable + value) is not good, since it can
not use the
optimized instructions operating directly on memory.
