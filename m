Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8553DF9C76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLVsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:48:39 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:35286 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726906AbfKLVsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:48:39 -0500
Received: (qmail 6266 invoked by uid 2102); 12 Nov 2019 16:48:38 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Nov 2019 16:48:38 -0500
Date:   Tue, 12 Nov 2019 16:48:38 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
In-Reply-To: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 12 Nov 2019, Linus Torvalds wrote:

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

Just to be perfectly clear, then:

Your feeling is that we don't need to tell the compiler anything at all 
about these races, because if a compiler generates code that is 
non-robust against such things then you don't want to use it for the 
kernel.

And as a corollary, the only changes you want to make to the source
code are things that tell KCSAN not to worry about these races when
they occur.

Right?

> +		// Benign data-race on min_flt
> 		tsk->min_flt++;
> 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);

I suggest grouping the accesses into classes somehow, and telling KCSAN
that races between accesses in the same class are okay but racing
accesses in different classes should trigger a warning.  That would
give the tool a better chance of finding genuine races.

Alan Stern

