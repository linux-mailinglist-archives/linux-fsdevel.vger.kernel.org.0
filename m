Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE18EF7929
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 17:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKKQv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 11:51:29 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:41585 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfKKQv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:51:28 -0500
Received: by mail-lf1-f53.google.com with SMTP id j14so10408952lfb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 08:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeNceNPo4fD73RiaH/hTBoQsDr0kmiNbYJTGEnnIYNQ=;
        b=JmJIJEsYG9Wpj4YU/56e8ykDzFdN2fR4vGH46xHy3bkh2I24Hnn5R/34gNiaGVe8A0
         +rVGaLTkWv6CwWmzdAT4f5P6hMwCoAq6LfbYEKOIFQw5NJ+7EEWplIoj/gNrKAbvmwqO
         i4JZsCoqZ1wP4f7j3+yTHe9LMpjypC2/CgyEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeNceNPo4fD73RiaH/hTBoQsDr0kmiNbYJTGEnnIYNQ=;
        b=WhNPg88DJp4VePRrtuJsBae70pm6sajhBVBhx/xsRkHeB+sFnKPu64Gq4D0eEgjvB/
         rttTFLN80S1TVhghokxt2lgAZz7/EOrP5nWekOCeW/ISEXD8D1X7gZzjuEeA7IcIW3is
         SYXORzFPt4rl46Zq9eow7XAncL60btwlugHGikw+k09S4PT5h/Eyt7MdKHecPwRAOF7w
         0GBEr4U0rPiPNSyk6Uwxij53QP9iqKLWVdSBH8y8bOhWiZzQZ6ZbVR7eekJLwYcAqQPU
         uhhM9JSWpAxQ5CaPbdOjQVm1Vcc30j4ql0vQDEagdpYjBEQaEi2ACgcDSG1M1LjtsPi+
         OWrA==
X-Gm-Message-State: APjAAAXxp6g2gyNDKclrWryFVLbW+sj9W/qFjI0Z7KFQkfTqm39jKD8X
        6zEJNDMNNF/olvAb7DX/A/XLPysDyQk=
X-Google-Smtp-Source: APXvYqyd104Rq8G0ktG1r3Of9uicPvC2SZGUsIB4sXN6Iup+rqKNNzEXPFpjpbZEXVVAyhr8AwIzDQ==
X-Received: by 2002:a19:800a:: with SMTP id b10mr16713817lfd.15.1573491085294;
        Mon, 11 Nov 2019 08:51:25 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id t9sm2624204ljj.19.2019.11.11.08.51.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 08:51:23 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id n21so14556780ljg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 08:51:23 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr16952774ljh.82.1573491083270;
 Mon, 11 Nov 2019 08:51:23 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 08:51:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
Message-ID: <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 7:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> I dislike the explicit annotation approach, because it shifts the
> burden of proving correctness from the automatic verifier to the
> programmer.

Yes.

However, sometimes explicit annotations are very useful as
documentation and as showing of intent even if they might not change
behavior or code generation.

But they generally should never _replace_ checking - in fact, the
annotations themselves should hopefully be checked for correctness
too.

So a good annotation would implicitly document intent, but it should
also be something that we can check being true, so that we also have
the check that reality actually _matches_ the intent too. Because
misleading and wrong documentation is worse than no documentation at
all.

Side note: an example of a dangerous annotation is the one that Eric
pointed out, where a 64-bit read in percpu_counter_read_positive()
could be changed to READ_ONCE(), and we would compile it cleanly, but
on 32-bit it wouldn't actually be atomic.

We at one time tried to actually verify that READ/WRITE_ONCE() was
done only on types that could actually be accessed atomically (always
ignoring alpha because the pain is not worth it), but it showed too
many problems.

So now we silently accept things that aren't actually atomic. We do
access them "once" in the sense that we don't allow the compiler to
reload it, but it's not "once" in the LKMM sense of one single value.

That's ok for some cases. But it's actually a horrid horrid thing from
a documentation standpoint, and I hate it, and it's dangerous.

                Linus
