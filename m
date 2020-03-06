Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF217C10D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 15:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCFO6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 09:58:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45221 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgCFO6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:58:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id f21so2628093otp.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 06:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBnwvd6m9GGRqbhsxjX4JoMKUAeQbZNO8mLVzJ/I/GI=;
        b=cn8NdgPmltJKdgy+m9kDNqjqGycZMzVHjROSIydwYn9tO8Xj0E1IkfcWd5s6ogZUVP
         ggA3/DsZiXHFCDjbFPJFFr77dfLQlwzeNyP2+prS1NSc3JSOddnMBuN9Ss6nhZKII6oe
         vtYV3GHrLLjzCLcOeiAz9SveBLCWyBdU/LGrX8nqMttD9s4UzVDQfQ7yxJvXCU9LAzxF
         9lYUForhjre8PyCILO6L8Q+TGx9WmZ1znzMUAwFZWyo3bxVCMMhBu0JtUyVsOhp8WZD5
         7d8+l7IKI3MsF7z4OIa5E+UeJr5u05Mr1u3wEB6hvX+Gs0jnd+SVYp+JIDucPxeR/E1I
         BhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBnwvd6m9GGRqbhsxjX4JoMKUAeQbZNO8mLVzJ/I/GI=;
        b=Ksv0a7ph5t3GCakrVVRPxFrOKu91ox/Mg5fjUMQalhnlpMggeE+6ihuaCB/jDWNt2U
         YCEp468WmEaPP5vCcu2puxm9WOAoYorli/UC/e+4u82hwWEra77moyA7vPf0zYQY95tm
         XhX1/MpnPi+xk7HlI0yTD8+ZaOkI80Ch0v8puKYoHjjbqw+kv7WJrRhkOVqyli2EtZqO
         /MW6eIDi7n9hXhfEmf+lCUcXEXHRBYubhP+H8bEwbNaa73oh8x9NlnH/1pS37YATgN/2
         urCaWZDZsh1HUCUicFcBIfW0fK9X24h0xb1e7O1ZX5hPe58VWV5XhYQsP8SS0wxLtCmN
         9t+A==
X-Gm-Message-State: ANhLgQ24Vk4PNd1DHQ+QEeUi+SKR6d8ev2noX+RAFpm9mRoPRBZ8JDyr
        yvxuI8oIfU5Zt6sIVUpNY2mNo/7d4RdmCC9fAgV+Ww==
X-Google-Smtp-Source: ADFU+vuPkh1+W4DnP3WwhXbmDP3lqya330q4IIhQVmQhHNdsvQMZb3BCEg46WQXRldDDW/RjrGpHyeT8Joch7dusGxE=
X-Received: by 2002:a9d:7358:: with SMTP id l24mr2744832otk.228.1583506703794;
 Fri, 06 Mar 2020 06:58:23 -0800 (PST)
MIME-Version: 1.0
References: <00000000000067c6df059df7f9f5@google.com> <CACT4Y+ZVLs7O84qixsvFqk_Nur1WOaCU81RiCwDf3wOqvHB-ag@mail.gmail.com>
 <3f805e51-1db7-3e57-c9a3-15a20699ea54@kernel.dk>
In-Reply-To: <3f805e51-1db7-3e57-c9a3-15a20699ea54@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 6 Mar 2020 15:57:57 +0100
Message-ID: <CAG48ez3DUAraFL1+agBX=1JVxzh_e2GR=UpX5JUaoyi+1gQ=6w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in percpu_ref_switch_to_atomic_rcu
To:     Jens Axboe <axboe@kernel.dk>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+paulmck

On Wed, Mar 4, 2020 at 3:40 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 3/4/20 12:59 AM, Dmitry Vyukov wrote:
> > On Fri, Feb 7, 2020 at 9:14 AM syzbot
> > <syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    4c7d00cc Merge tag 'pwm/for-5.6-rc1' of git://git.kernel.o..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=12fec785e00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=e162021ddededa72
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=e017e49c39ab484ac87a
> >> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com
> >
> > +io_uring maintainers
> >
> > Here is a repro:
> > https://gist.githubusercontent.com/dvyukov/6b340beab6483a036f4186e7378882ce/raw/cd1922185516453c201df8eded1d4b006a6d6a3a/gistfile1.txt
>
> I've queued up a fix for this:
>
> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.6&id=9875fe3dc4b8cff1f1b440fb925054a5124403c3

I believe that this fix relies on call_rcu() having FIFO ordering; but
<https://www.kernel.org/doc/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html#Callback%20Registry>
says:

| call_rcu() normally acts only on CPU-local state[...] It simply
enqueues the rcu_head structure on a per-CPU list,

Is this fix really correct?
