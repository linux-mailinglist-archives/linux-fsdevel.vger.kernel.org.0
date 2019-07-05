Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556086064E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 15:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfGENDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 09:03:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39171 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfGENDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:03:08 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so3468468ioh.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2019 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpRqpOEyos9gWVI1KI/vAHqH4Vkw1K4vS/+vG+O4M0M=;
        b=h83wm51N3b9RabIloRjdWAnEOC+c2ImXGh+hgmGj9lO8K8kgTY1/0CLpXIjAZvwaX/
         0qfkwrKKGV72ZlSVF7+yVw8hFbl6nZH+ZWeje+qe1vKc3AarWUHxn+63MtvQqOmlIeSg
         nvWl+/M6ygAn65l2oZ7KBjaDmP3lzfWMo3Cm9O5qDTX0Ymncl5kURYgRd1T5gmCQMPYF
         5FVCLpzMYum5OV1yH6p43O/9FUDUIwtpTMe0bYGQCXiWkFxtbcMMvvVP8wUkDyrX3f9B
         ojfkwX0SIcJLI8SOGVSUzHE++uzxLQyGMhO+Nd+22YPWyYiprZUiQpGwu0mJN3gULwah
         ZGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpRqpOEyos9gWVI1KI/vAHqH4Vkw1K4vS/+vG+O4M0M=;
        b=aEcA2UwbvLZLFadyg4xEz6w2Ek18U6rDnL2scPFHiqgu8NoAOjSrfi3w3gLOGchDQA
         Kl9DQzBebpsuOg1CGXQqMZxy+4w0ic6GlapSElmuEfRhgzh4uyAw0x58jKluTBUHNoXQ
         r2x0cwLWuCcvZ2gDn40uj6zDgzd5WTqGwYV1O8WfU0Squanu7gSHBcwAac+x9oGQEXOm
         ZdQ4vhpUarltFe/VNw7OLBi6eWA3wuPtZSSRWVMFJHmDXVNL1gSfgnx1llXBXUbHbJb4
         48bo8z204mHfvC4wlAvXqzBSFokkC3z4Ulk37TXSOhi//7Ut2TWGDEDZ+rmBLCd3Mxl7
         oYig==
X-Gm-Message-State: APjAAAWtmx5MzCAKVge2FHkaJdM8ITITk6dpFTQaF5vZYLpBlgUGGFyg
        XSPe2xqG2i1kJ1iDAVb6wj98X+9Tt9vrbq/gDjq/AQ==
X-Google-Smtp-Source: APXvYqzikCIRRm6GKiKDXwi/hI0nEYiWh5ayabFF03vNzuu9ihfvXwabo/dqnt4HiGji3FAZ2BKPmf9rRBzJJFA4FEs=
X-Received: by 2002:a02:c7c9:: with SMTP id s9mr4323307jao.82.1562331787454;
 Fri, 05 Jul 2019 06:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb362d058b96d54d@google.com> <20190618140239.GA17978@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629203927.GA686@sol.localdomain> <CACT4Y+aAqEyJdjTzRksGuFmnTjDHbB9yS6bPsK52sz3+jhxNbw@mail.gmail.com>
 <20190701151808.GA790@sol.localdomain>
In-Reply-To: <20190701151808.GA790@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 15:02:54 +0200
Message-ID: <CACT4Y+ZR98hxgG9GC0ijC_o0UuYdYEY2pAnf01nBLNTjhG4+Vw@mail.gmail.com>
Subject: Re: general protection fault in do_move_mount (2)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hannes Reinecke <hare@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 1, 2019 at 5:18 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > FYI, it also isn't really appropriate for syzbot to bisect all bugs in new
> > > syscalls to wiring them up to x86, and then blame all the x86 maintainers.
> > > Normally such bugs will be in the syscall itself, regardless of architecture.
> >
> > Agree. Do you think it's something worth handling automatically
> > (stands out of the long tail of other inappropriate cases)? If so, how
> > could we detect such cases? It seems that some of these predicates are
> > quite hard to program. Similar things happen with introduction of new
> > bug detection tools and checks, wiring any functionality to new access
> > points and similar things.
> >
>
> Yes, this case could easily be automatically detected (most of the time) by
> listing the filenames changed in the commit, and checking whether they all match
> the pattern syscall.*\.tbl.  Sure, it's not common, but it could be alongside
> other similar straightforward checks like checking for merge commits and
> checking for commits that only modify Documentation/.
>
> I'm not even asking for more correct bisection results at this point, I'm just
> asking for fewer bad bisection results.


Agree, if we implement a common framework for doing this type of
checks and affecting reporting in some fixed set of ways, adding more
rules can make sense even if they don't affect lots of cases. I filed
https://github.com/google/syzkaller/issues/1271 for this.

There are several open questions, though.
1. The syscall.*\.tbl change is formally the right bisection result
and it communicates a bit of potentially useful information. Do we
want to handle them differently from, say, Documentation/* changes
which are significantly a different type "incorrect".
2. You mentioned merges. It seems that they can be just anything:
completely incorrect results; formally correct, but not the change
that introduced the bug; as well as the totally right commit to blame.
Are you sure we should mark all of them as completely incorrect?
