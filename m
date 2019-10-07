Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588E2CDA16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 03:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfJGBRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 21:17:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43345 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfJGBRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 21:17:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so11766834ljj.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 18:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPEu43x9a4PkvKn0Oyshu4QOaWijlTG7bfT8Hr7fHfs=;
        b=f6Ncrhe7S7dXzO+O2ayfO34RS2WQe42zqTeE1J9e5gyPVQI7WmKX4jrNVerl3l/Jql
         KdRAZUJMD4rgRQmFIkC5TcRf0QJ+PyiPmL9JxsEADXqN8Qjfw2t5YT83/NWGujsIGsO0
         MVzA0b891YKEEXwYA+lM6t+Kg+idL/2VltwOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPEu43x9a4PkvKn0Oyshu4QOaWijlTG7bfT8Hr7fHfs=;
        b=PPsKV7KT0HazfIgNIXWjQFhjOzz9JomN9xF3i6+ALDG6wJ3uKDgXES2H4QnW9NxMJc
         FBEfbqbKwNyd82GQfrU/MV2XeDFZRy/PXw4TA0cNND7dKLjwHfaOge6irLDGI4QpOpoz
         FcqedhEAmYgwHnj/uBJha/M/5OtmVwVusfwc3bn37l/M1n29uFQAlYaRgDYRIRtSsrP/
         xv6yjKZBFjgeUyhP7Pj+M8aT1VygNB9qP6yD8bm82GV52Nb5lR4Qjn5PzgYtl/Mfp4Ar
         aR5foXZHRa9gPDrNYI4EtGsoHq4c4Pin5NnSq+pB2rOEOmzzL/YOfLM3Jc+UjQBkGTIx
         upBQ==
X-Gm-Message-State: APjAAAVY+3ndYgo9CyBhCr/utOo2q8lXWmCo7uy0f6Kegaek0tMjlDA+
        pxvKVhF/Xob8IGA83TayY9Z0Uxn8sJ4=
X-Google-Smtp-Source: APXvYqw/JzYR3GiS/YUiYPNPrjxiuefUDI5l/rstskpVl+aN0vtOPuCdBcqLG/+9fnGIxXBrjlmgbw==
X-Received: by 2002:a2e:2416:: with SMTP id k22mr16709097ljk.216.1570411040009;
        Sun, 06 Oct 2019 18:17:20 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id z14sm2764463ljz.10.2019.10.06.18.17.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 18:17:19 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 72so8020307lfh.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 18:17:18 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr14719103lfk.52.1570411038329;
 Sun, 06 Oct 2019 18:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com> <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
In-Reply-To: <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 18:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
Message-ID: <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 6, 2019 at 5:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> All my alpha, sparc64, and xtensa tests pass with the attached patch
> applied on top of v5.4-rc2. I didn't test any others.

Okay... I really wish my guess had been wrong.

Because fixing filldir64 isn't the problem. I can come up with
multiple ways to avoid the unaligned issues if that was the problem.

But it does look to me like the fundamental problem is that unaligned
__put_user() calls might just be broken on alpha (and likely sparc
too). Because that looks to be the only difference between the
__copy_to_user() approach and using unsafe_put_user() in a loop.

Now, I should have handled unaligned things differently in the first
place, and in that sense I think commit 9f79b78ef744 ("Convert
filldir[64]() from __put_user() to unsafe_put_user()") really is
non-optimal on architectures with alignment issues.

And I'll fix it.

But at the same time, the fact that "non-optimal" turns into "doesn't
work" is a fairly nasty issue.

> I'll (try to) send you some disassembly next.

Thanks, verified.

The "ra is at filldir64+0x64/0x320" is indeed right at the return
point of the "jsr verify_dirent_name".

But the problem isn't there - that's just left-over state. I'm pretty
sure that function worked fine, and returned.

The problem is that "pc is at 0x4" and the page fault that then
happens at that address as a result.

And that seems to be due to this:

 8c0:   00 00 29 2c     ldq_u   t0,0(s0)
 8c4:   07 00 89 2c     ldq_u   t3,7(s0)
 8c8:   03 04 e7 47     mov     t6,t2
 8cc:   c1 06 29 48     extql   t0,s0,t0
 8d0:   44 0f 89 48     extqh   t3,s0,t3
 8d4:   01 04 24 44     or      t0,t3,t0
 8d8:   00 00 22 b4     stq     t0,0(t1)

that's the "get_unaligned((type *)src)" (the first six instructions)
followed by the "unsafe_put_user()" done with a single "stq". That's
the guts of the unsafe_copy_loop() as part of
unsafe_copy_dirent_name()

And what I think happens is that it is writing to user memory that is

 (a) unaligned

 (b) not currently mapped in user space

so then the do_entUna() function tries to handle the unaligned trap,
but then it takes an exception while doing that (due to the unmapped
page), and then something in that nested exception mess causes it to
mess up badly and corrupt the register contents on stack, and it
returns with garbage in 'pc', and then you finally die with that

   Unable to handle kernel paging request at virtual address 0000000000000004
   pc is at 0x4

thing.

And yes, I'll fix that name copy loop in filldir to align the
destination first, *but* if I'm right, it means that something like
this should also likely cause issues:

  #define _GNU_SOURCE
  #include <unistd.h>
  #include <sys/mman.h>

  int main(int argc, char **argv)
  {
        void *mymap;
        uid_t *bad_ptr = (void *) 0x01;

        /* Create unpopulated memory area */
        mymap = mmap(NULL, 16384, PROT_READ | PROT_WRITE, MAP_PRIVATE
| MAP_ANONYMOUS, -1, 0);

        /* Unaligned uidpointer in that memory area */
        bad_ptr = mymap+1;

        /* Make the kernel do put_user() on it */
        return getresuid(bad_ptr, bad_ptr+1, bad_ptr+2);
  }

because that simple user mode program should cause that same "page
fault on unaligned put_user()" behavior as far as I can tell.

Mind humoring me and trying that on your alpha machine (or emulator,
or whatever)?

               Linus
