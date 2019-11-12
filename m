Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50877F9BBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKLVOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:14:03 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:45996 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfKLVN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:58 -0500
Received: by mail-lf1-f46.google.com with SMTP id v8so11374lfa.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9XIZS7SU3RS49LRENl5SM7lOZ7kZM4P3ixT/QNzhdE=;
        b=UwY9cZA3V5T0vyNv2V661JB/VTL10yx6gFYc1xtgKQgONfocJfi8ojlq33WVjM/r+L
         cwAON8sR7dBpJMPq9/fq/cuIi8qLzAUszVs0iJ7LDN8D1o4e199T+fOpPSZOiTetQnuj
         Y+nhBGmk1z4MO+7U+QjWjCyy2lbljWp+V5Ag8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9XIZS7SU3RS49LRENl5SM7lOZ7kZM4P3ixT/QNzhdE=;
        b=IV2jpod26RcccFRNDWNbCpglpQ0I/+CBLisDj72CMbPvsk4RhvsnQsX5EYDmcydL0n
         mLp2Zr9FiA/l3sosglaqeU348/8ZUYgkxsAWtvEa8iWYKB2YG6Iyg+otCYUROMmZm5eP
         TfzMWAy/La+SjTtz2Pd258mI+2GYNdBbyWrVL/87buuTjFzxqrR7LPzubmlAJvhUskw/
         dxBPF4i5vcijrKSrnSND9nbJlvM62QBDXx4LRl42Yl87st39jAOUEFjiu9gix4elJB0L
         9QhabQ1waVEYvDxktWWHFuxZqpHlKpeuH6w3araYHbTSWjrDqRQDm/jTfBVVzjHexaef
         hs0g==
X-Gm-Message-State: APjAAAUyJOjxN0lZQkocp7HoG4EhhUNRn7cL75a5xOYwlkhQxwU06axl
        frVhdlr9ze3JadlUNHrz3Gs2iR1qrzI=
X-Google-Smtp-Source: APXvYqwU4FTF1mj+niXbX3V3VqkpIbjUOU32X9XwlKKG76z/VwexbS7g1oPjnP//iunlKIWkXc/qcg==
X-Received: by 2002:ac2:53ae:: with SMTP id j14mr11696079lfh.3.1573593235846;
        Tue, 12 Nov 2019 13:13:55 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b28sm10915649ljp.9.2019.11.12.13.13.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 13:13:52 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id d22so32322lji.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:52 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr21906891lji.1.1573593232214;
 Tue, 12 Nov 2019 13:13:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjGd0Ce2xadkiErPWxVBT2mhyeZ4TKyih2sJwyE3ohdHw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121515400.1567-100000@iolanthe.rowland.org> <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
In-Reply-To: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 13:13:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9yCKVdenys6FfcpAc9KSxVMOTT2DddVcj-Ofu1MYNhQ@mail.gmail.com>
Message-ID: <CAHk-=wg9yCKVdenys6FfcpAc9KSxVMOTT2DddVcj-Ofu1MYNhQ@mail.gmail.com>
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

On Tue, Nov 12, 2019 at 12:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, my preferred model would have been to just add a comment,
> and have the reporting tool know to then just ignore it. So something
> like
>
> +               // Benign data-race on min_flt
>                 tsk->min_flt++;
>                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
>
> for the case that Eric mentioned - the tool would trigger on
> "data-race", and the rest of the comment could/should be for humans.
> Without making the code uglier, but giving the potential for a nice
> leghibl.e explanation instead of a completely illegible "let's
> randomly use WRITE_ONCE() here" or something like that.

Hmm. Looking at the practicality of this, it actually doesn't look
*too* horrible.

I note that at least clang already has a "--blacklist" ability. I
didn't find a list of complete syntax for that, and it looks like it
might be just "whole functions" or "whole source files", but maybe the
clang people would be willing to add "file and line ranges" to the
blacklists?

Then you could generate the blacklist with that trivial grep before
you start the build, and -fsanitize=thread would automatically simply
not look at those lines.

For a simple first case, maybe the rule could be that the comment has
to be on the line. A bit less legible for humans, but it could be

-               tsk->min_flt++;
+               // Benign race min_flt - statistics only
+               tsk->min_flt++; // data-race

instead.

Wouldn't that be a much better annotation than having to add code?

               Linus
