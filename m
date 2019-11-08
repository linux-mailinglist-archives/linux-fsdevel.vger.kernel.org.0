Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2748FF52FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 18:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKHRxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 12:53:14 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:41325 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfKHRxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:53:14 -0500
Received: by mail-il1-f175.google.com with SMTP id q15so747549ils.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 09:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9TsgJFTcfRwuc/WaCy1JpAsWZBRp62dC/cBlD5yCig=;
        b=M5diUmqrAoGpBQVNj/NZt0ynuDchzXatuHboKTn50HBE6KCQLAak+nVQyXaOcAKnX7
         Wc9plUO/jgMHq/HcqyCxMp55R3K2npPvE+D7TO/cglkFENINKLtlyLtvmiSXw5urmJhS
         Fe01qGaMgW/rpcJ5KiYaidLJ+9C4BrEC2ym59dRxNTs1wboR7Q6zVcSxAUO78StZZTTM
         Da7CqjNYfmBGkdRZJaAkMD1HQAv6AUd034rP+3d+Gzw3BI3JyZT0LJh1RFnm2Fzpm6EI
         lWF2LmmJcs5o+6FmBTU9aNQ1FDI+PtwXi+rBh+bi1hpdAjh3uXDfyriYO8eDt4kbg1d/
         5jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9TsgJFTcfRwuc/WaCy1JpAsWZBRp62dC/cBlD5yCig=;
        b=o+sGr77By5Y0bRZ0/0/z60YozkHWGx4ghvpHHKgvfhYvxRTu2r9MdlEz+fLPRBAyET
         GsCiYoBgLuiu+U6Tv+8vuhN19UoG5r8zWS98LoXPWqgIEQosfAodp6wXyrpZzZIbV9vT
         Lwhs1zna3ms8SoztLV1fd5eYUVKFBbk0nM5yEe9jzak8vxmHjFcU+Txm6p2UCjMUdtsg
         rnoqRfJBHb2EtT/1WADxKey37TNTXlHnQUhVmFXZEmNLkCGkk8rstzu7hIOAVbgIg/Y0
         a4DLLBWLoRrrRPalYsuWoMIQ8pNJau+a9q4EVjcyCVKlKCfFV9l1dayfUM5GOcLNKuHq
         f80w==
X-Gm-Message-State: APjAAAUrrjwLlYz59Aja1Avj7CtlO11ZpXVOgioje5nVwr1ZkT/TGsFi
        PLgecuOp7qi/wD/eiOivsNk9yszPxlQr50eHlN4aUw==
X-Google-Smtp-Source: APXvYqwOs6JqCzcRGiH00Hf71WJTMZ9paYvQQsox0aJ+DCKj4oP0w0FHCBKbg68rYymi75JgYW3loNUbGCT+bynPCxI=
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr13502229ilo.58.1573235592625;
 Fri, 08 Nov 2019 09:53:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com> <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
In-Reply-To: <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 09:53:01 -0800
Message-ID: <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
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

On Fri, Nov 8, 2019 at 9:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> I'd hope that there is some way to mark the cases we know about where
> we just have a flag. I'm not sure what KCSAN uses right now - is it
> just the "volatile" that makes KCSAN ignore it, or are there other
> ways to do it?

I dunno, Marco will comment on this.

I personally like WRITE_ONCE() since it adds zero overhead on generated code,
and is the facto accessor we used for many years (before KCSAN was conceived)

>
> "volatile" has huge problems with code generation for gcc. It would
> probably be fine for "not_rcu" in this case, but I'd like to avoid it
> in general otherwise, which is why I wonder if there are other
> options.
>
> But worst comes to worst, I'd be ok with a WRITE_ONCE() and a comment
> about why (and the reason being KCSAN, not the questionable
> optimization).

Ok for a single WRITE_ONCE() with a comment.

Hmm, which questionable optimization are you referring to?
