Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8834FF9E0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 00:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKLXR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 18:17:58 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38211 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfKLXR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:17:58 -0500
Received: by mail-il1-f193.google.com with SMTP id u17so12342172ilq.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 15:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wmRZDK37oUqP6+uI5Wq9SWuQ2Hmj0XKslCBjAECKVc=;
        b=pfU5LFrMse1pSEkfylHbI3ThR2Y+Cw7OHPuSu2xiSoUYEvgyeHgdPu8QvG6CkhvCoe
         WJYwzI1mqsA88zP/CjDJaF5Oz69q6+PW1qcnYJeuXy1pMh7Ba4hEZxRqZ+Q0u6o/dWM/
         sVhx8vWPyecAQJtPiHMSx17SBrSEkZR+JDy3lcS/miLEsPYK9TNgNf8HPBTsr9f3Oh0r
         /LBvR7yiViw18qkXpc4NKNV2xoNgEMV7UtGA0PvfFyCtlbsuCrP3VYbIQ/XHEnPScUkB
         9GbS5RJ0I5dG+TQeq409bAOKeH6NU5DeP7mupTUsfMdSQGpJlr8ppG2clQtN7+vkfXSO
         v7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wmRZDK37oUqP6+uI5Wq9SWuQ2Hmj0XKslCBjAECKVc=;
        b=FVTCh6LvrFDxERddiu1sWdocm9ZcDn7BIiBDaJaq3n0m1a25/mk0g5/h7TKn8b5ejk
         Sb+l3eWd3dCjUQ1mzkP7otpd1OGtTZxID3m3YxwUrSPUHpAxk+PBD0IIhsrAx0ElnenU
         nLDRI2p0hE1oTOlb+hqxm8f3yr5myqpwhTaj4trx6zVOWKtQjwJwetTe07+/jWBAmO20
         DiQe3YHs2zJedvneLSL8ryUxtP7OYPxGuzd/7SfPdVAjSLnzmFI56A4ulwRgiASrWtxz
         hb6Hg+WRqnWXvRCozTnIbEpcRJsLxOFUimYWNjLJ/J0Wn7DHyGRTZzN+iA0XxDSNOpZF
         4GHA==
X-Gm-Message-State: APjAAAXiXJzEEkoFioWF15sKE0fA6OImBNvvzMkfOabx9/Wd+lZtyVXB
        eMnCB5N2c5xeWda99yAedQlez3x/A90slNfPnSbtWQ==
X-Google-Smtp-Source: APXvYqwgnU/a21nfBNFsr9Op7EWEfA1m/SMTKYo3W1G2U2UNy2dJ91UWK8OVcS5yBL8G3n/K45v4vX9Pr75HtsohL8U=
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr505883ilc.168.1573600677105;
 Tue, 12 Nov 2019 15:17:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com> <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Nov 2019 15:17:44 -0800
Message-ID: <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
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

On Tue, Nov 12, 2019 at 2:44 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 02:07:03PM -0800, Eric Dumazet wrote:
> >
> > I would prefer some kind of explicit marking, instead of a comment.
> >
> > Even if we prefer having a sane compiler, having these clearly
> > annotated can help
> > code readability quite a lot.
>
> Annotating every line where tsk->min_flt is used with a comment
> or explicit macro seems like a lot of churn.
> How about adding an attribute to a field ?
> Or an attribute to a type?
>
> clang attributes can be easily exteneded. We add bpf specific attributes
> that are known to clang only when 'clang -target bpf' is used.
> There could be x86 or generic attributes.
> Then one can do:
> typedef unsigned long __attribute__((ignore_data_race)) racy_u64;
> struct task_struct {
>    racy_u64 min_flt;
> };
>
> Hopefully less churn and clear signal to clang.

Hmm we have the ' volatile'  attribute on jiffies, and it causes
confusion already :p

arch/x86/kernel/apic/apic.c:904:        jif_start = READ_ONCE(jiffies);
arch/x86/kernel/apic/apic.c:927:
unsigned long jif_now = READ_ONCE(jiffies);
kernel/sched/wait_bit.c:218:    unsigned long now = READ_ONCE(jiffies);
kernel/sched/wait_bit.c:232:    unsigned long now = READ_ONCE(jiffies);
kernel/time/timer.c:891:        jnow = READ_ONCE(jiffies);
kernel/time/timer.c:1681:       unsigned long now = READ_ONCE(jiffies);
net/rxrpc/conn_client.c:1111:           now = READ_ONCE(jiffies);
