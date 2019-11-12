Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE7F9CC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 23:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLWFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 17:05:41 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34047 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLWFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:05:41 -0500
Received: by mail-ot1-f45.google.com with SMTP id 5so1923089otk.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1Pi6yOs/csYC6W72VeZEeFbZQ4f19IItGzOeKWk0k4=;
        b=pXARKt5T5Od7Y0qUkyoivMClA/o8lhR5dXBj2Fm/AC9pN9O7ok3a3Msm21JGwY60qX
         k4Eb3Sp0neG3JV3ruaQCVID3R+nN3u3mfPk/OhsCxZtu6jzzN4HgHgZonTFrZ+CGEd7A
         XZrp3NoJYL7RV2S21otE67mgwDFaFGZ7QVYOE/71MK+OLX9rK3ZJwculoQaR02oggnwK
         16NZRugVc3dzaPCD0zWW7/zXRkIAEA4rHojuloW4UeREDiJBBtB7Z7w00wqet2rnKdWB
         ovpcg9YkG55nvec27JjiclWiYbUda+AMDzzh+z3pfT/IA610wqb+Z00AOmmJx7787y4X
         X5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1Pi6yOs/csYC6W72VeZEeFbZQ4f19IItGzOeKWk0k4=;
        b=TP9CHS/xJlVQx8/M8zM8anhRZZ7xxELJKKCpVBcCiTeEiqxX88Bk+SG+wY0meFHzke
         z0dbhaNTW9PjlCuRmeKx4ooXO86pMDRSpk1xQmpZtJzM/FgJqiXO3Asp15EacUBOoFRw
         JzGo5tfMuXnfSopZt5hvTl6UgjZU87e1NSx8YQWYn7ItpV1mNHwE/chILypEppvjOCzJ
         8i3PFP6bJrsgQB/gyLl2Y1IweZqltAo98zdbpwsCJrz5p9Tdr9j0ISTwXTB9cFkC6znW
         591rX2wiJjBqK2ghvOcGkKdCFjanZPtecYMhifPjljTMCSq8Il6BNCswXwnnX3FXIVO8
         jiwA==
X-Gm-Message-State: APjAAAUKu65Mc7OnaqHZFwtXdF1e4QSPXy0VVgYa77Qr4APwq0Bia+kk
        c9fZsS6QQbySAXpTbzL+IxjC9askbJljJFxQ9LONUg==
X-Google-Smtp-Source: APXvYqzR7EP2D/z5F0a1bbJk6m4Oew+bYKpXeIPCO9xhrgHQTZvjUFzGjeYDTmLEKEpor930AQEKtB9nltkrmGUUnt0=
X-Received: by 2002:a9d:82e:: with SMTP id 43mr23431901oty.23.1573596340012;
 Tue, 12 Nov 2019 14:05:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjGd0Ce2xadkiErPWxVBT2mhyeZ4TKyih2sJwyE3ohdHw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121515400.1567-100000@iolanthe.rowland.org>
 <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com> <CAHk-=wg9yCKVdenys6FfcpAc9KSxVMOTT2DddVcj-Ofu1MYNhQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg9yCKVdenys6FfcpAc9KSxVMOTT2DddVcj-Ofu1MYNhQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Nov 2019 23:05:27 +0100
Message-ID: <CANpmjNPy45w7NdPwWLuMRon5pVUPTmJuDLuYVT-BwzgMe1+j3Q@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Eric Dumazet <edumazet@google.com>,
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

On Tue, 12 Nov 2019 at 22:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 12, 2019 at 12:58 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Honestly, my preferred model would have been to just add a comment,
> > and have the reporting tool know to then just ignore it. So something
> > like
> >
> > +               // Benign data-race on min_flt
> >                 tsk->min_flt++;
> >                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
> >
> > for the case that Eric mentioned - the tool would trigger on
> > "data-race", and the rest of the comment could/should be for humans.
> > Without making the code uglier, but giving the potential for a nice
> > leghibl.e explanation instead of a completely illegible "let's
> > randomly use WRITE_ONCE() here" or something like that.
>
> Hmm. Looking at the practicality of this, it actually doesn't look
> *too* horrible.
>
> I note that at least clang already has a "--blacklist" ability. I
> didn't find a list of complete syntax for that, and it looks like it
> might be just "whole functions" or "whole source files", but maybe the
> clang people would be willing to add "file and line ranges" to the
> blacklists?
>
> Then you could generate the blacklist with that trivial grep before
> you start the build, and -fsanitize=thread would automatically simply
> not look at those lines.
>
> For a simple first case, maybe the rule could be that the comment has
> to be on the line. A bit less legible for humans, but it could be
>
> -               tsk->min_flt++;
> +               // Benign race min_flt - statistics only
> +               tsk->min_flt++; // data-race
>
> instead.
>
> Wouldn't that be a much better annotation than having to add code?

Thanks for the suggestion.

Right now I can't say what the most reliable way to do this for KCSAN
is. Doing this through the compiler doesn't seem possible today, but
is something to look into. An alternative is to preprocess the code
based on comments somehow.

How many variations of such comments could exist?

If it's only one or two, as a counter suggestion, would a macro not be
more reliable? A macro would provide a uniform way to document intent,
but could otherwise be a no-op. The tool would have no problems
understanding the macro. For example "APPROX(tsk->min_flt++)" or
something else that documents that the computation can be approximate
e.g. in the presence of races.

Thanks,
-- Marco
