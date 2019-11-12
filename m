Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1089F9B5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 21:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKLU7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 15:59:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38060 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLU7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:59:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so6027ljh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 12:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnvOYwfa6qDRGH1va7JtPEY4MALggxuc4YXJOwSoKVY=;
        b=bIPT90I+28Y1aSlcbzKemY/unFev3VpktnoJsw2rog25WeOeiXV2YOJCa+ttkBwlSO
         ZR69063yp6U5gZ2TTJIVI23n0ZboiBREakXYprN90R8ijIWb1A+8wIOx1iFnvuHiZoSD
         h/KA9xiVfnbLgjycX8QDmV+3dLXhmJg195C1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnvOYwfa6qDRGH1va7JtPEY4MALggxuc4YXJOwSoKVY=;
        b=Swz7lZCAc/6FhuxqDdT8AIhlsN0H0qzPhN1aHbafP8mFFMmToFTZ93GGHGxPEakPGr
         gS3T/IEyC048u43Udi0bMwxl6YC9P3cn1VQu3B3+FVZhk0+sQsZwb80fLLQ0vR14Mssv
         GcyDYk6GIx0kNyNooUac4xF5nWa6nXUPYqCIOB6mKStshrAMRHN5MxmfG/O0BkEJNfoP
         9aQ2XxNQmKod+mt4c1V6LQ/XL5OEXypwGk4gnKaU2tH58p14VJXsYkiP9+cqR+3Yfat0
         PTKaGWbsXP5nopOvDpYbEluBmklhV8zAT3xcQP1Ac129tVViSeG4FqL2J6mrsN7FxknT
         m9kg==
X-Gm-Message-State: APjAAAUx5gnF8TZnf2GxDzWnSHUzq3QtmwH3QJy9dcPoBA7jnDlkKWph
        Fmu2cpM6pgE6US/O/ukXg0bSLqge01U=
X-Google-Smtp-Source: APXvYqxjr/whQ3xqlmPS5jTI4nY0/aZ4S5LDzJpuFNweeWtpVbeZmEmBatUXmBJ1BbOuO4gKjgWrLg==
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr22034749ljh.184.1573592354325;
        Tue, 12 Nov 2019 12:59:14 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f25sm9141865ljp.100.2019.11.12.12.59.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 12:59:13 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id z12so14006985lfj.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 12:59:12 -0800 (PST)
X-Received: by 2002:a19:c790:: with SMTP id x138mr21291173lff.61.1573592352459;
 Tue, 12 Nov 2019 12:59:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjGd0Ce2xadkiErPWxVBT2mhyeZ4TKyih2sJwyE3ohdHw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121515400.1567-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911121515400.1567-100000@iolanthe.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 12:58:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
Message-ID: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
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

On Tue, Nov 12, 2019 at 12:29 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> I'm trying to solve a real problem: How to tell KCSAN and the compiler
> that we don't care about certain access patterns which result in
> hardware-level races, and how to guarantee that the object code will
> still work correctly when those races occur.  Not telling the compiler
> anything is a head-in-the-sand approach that will be dangerous in the
> long run.

I don't actually know how KCSAN ends up reading the annotations, but
since it's apparently not using the 'volatile' as a marker.

[ Goes off and fetches the thing ]

Ugh, that's just nasty.

Honestly, my preferred model would have been to just add a comment,
and have the reporting tool know to then just ignore it. So something
like

+               // Benign data-race on min_flt
                tsk->min_flt++;
                perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);

for the case that Eric mentioned - the tool would trigger on
"data-race", and the rest of the comment could/should be for humans.
Without making the code uglier, but giving the potential for a nice
leghibl.e explanation instead of a completely illegible "let's
randomly use WRITE_ONCE() here" or something like that.

Could the KCSAN code be taught to do something like that by simply not
instrumenting it? Or, as mentioned, just have the reporting logic
maybe have a list of those comments (easily generated with some
variation of "git grep -in data-race" or something) and logic to just
ignore any report that comes from a line below that kind of comment?

Because I do not see a pretty way to annotate random things like this
that actually makes the code more legible. The READ_ONCE/WRITE_ONCE
annotations have not imho improved the code quality.

                 Linus
