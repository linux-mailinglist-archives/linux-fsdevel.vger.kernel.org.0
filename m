Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03EF5206
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 18:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfKHRBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 12:01:54 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:33120 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfKHRBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:53 -0500
Received: by mail-lj1-f173.google.com with SMTP id t5so6992287ljk.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 09:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=areMWrVEmfkCGN5C3vFUMp6ntvtTANx8pMI7+P+pQwk=;
        b=fTQAG1nv+Xfvawkzfroy56UyjdshaUI6tDZmA2U31BY2vRabBOWqqcIrGwEiaPTMLM
         UpxslrqN19Q5RkBzYwKrg+R9FYC+kmfTcy86WRoQeVweyUd8I+BSDcL1kR2UVpc9heaR
         8C9Z7s7NSuSZCqLYqqjNuS4lSdyWdr7omtzoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=areMWrVEmfkCGN5C3vFUMp6ntvtTANx8pMI7+P+pQwk=;
        b=kd/Ftvv+AduWjsNIxjhXkEVq7zBvQK+M6Em+gcbgrL8nNldZQFaW2Cnh3KSlDuwrme
         O7Cq1U9ILdBMuSC70cPTLx6ZNn77o9fGMmo2/tQ9bsPual+mtTv5hjOigSMiCZG/rgDF
         bOOvfUbN2kAGVkEFY4I7vGTS45EL9hBWN5DXRa0Ee7tliC+VrQzJ7V6rRY9AS9bPmgr7
         9lvwG1vkNvFRrWOsjj07Lef/eUjxhRaxHAhIz5AYf8RZ8gtnleXkunF9HBshA7N5c0bI
         xRvgR1gOU1jx2/eNIa4e13sE11GK2rsMEvijAUbVBsbrJmsK0Xte10r+d7nqnqK4Onar
         4N3g==
X-Gm-Message-State: APjAAAUUodwu1KBZ0Uh2xUUeXThLMT2FxrQ/Tc4wYajGwvOTh/FTWp6+
        +Odf/F12+H+BGEQkLR8dCyArTVcban0=
X-Google-Smtp-Source: APXvYqwulX2MtWkuzlQeEqCV9pSpzVsoiZIsaKStEyIPEPRNYtI0ANSAScYSnG6g4Xh3xPV6vgLajg==
X-Received: by 2002:a2e:9649:: with SMTP id z9mr7532858ljh.47.1573232510405;
        Fri, 08 Nov 2019 09:01:50 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r7sm2672127ljc.74.2019.11.08.09.01.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 09:01:49 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id l20so6960494lje.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 09:01:49 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr7562934ljh.82.1573232508697;
 Fri, 08 Nov 2019 09:01:48 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
In-Reply-To: <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 09:01:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
Message-ID: <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        elver@google.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 5:28 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> Linus, what do you think of the following fix ?

I think it's incredibly ugly.

I realize that avoiding the cacheline dirtying might be worth it, but
I'd like to see some indication that it actually matters and helps
from a performance angle. We've already dirtied memory fairly close,
even if it might not share a cacheline (that structure is randomized,
we've touched - or will touch - 'cred->usage') too.

Honestly, I don't think get_cred() is even in a hotpath. Most cred use
just use the current cred that doesn't need the 'get'. So the
optimization looks somewhat questionable - for all we know it just
makes things worse.

I also don't like using a "WRITE_ONCE()" without a reason for it. In
this case, the only "reason" is that KCSAN special-cases that thing.
I'd much rather have some other way to mark it.

So it just looks hacky to me.

I like that people are looking at KCSAN, but I get a very strong
feeling that right now the workarounds for KCSAN false-positives are
incredibly ugly, and not always appropriate.

There is absolutely zero need for a WRITE_ONCE() in this case. The
code would work fine if the compiler did the zero write fifty times,
and re-ordered it wildly. We have a flag that starts out set, and we
clear it.  There's really no "write-once" about it.

               Linus
