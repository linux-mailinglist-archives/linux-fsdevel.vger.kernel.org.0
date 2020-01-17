Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4174914131A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 22:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgAQVac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 16:30:32 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39981 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgAQVac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:30:32 -0500
Received: by mail-yb1-f193.google.com with SMTP id l197so5158990ybf.7;
        Fri, 17 Jan 2020 13:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StE2NY3HtsEMqXd4ZB/pMSObV0z3IPCkBkqgILuERJs=;
        b=bukzU4gWyvcWbsHRtX9EFKOAS9LpRKz+Cxy+vdFOYfaSP+sodL+FfCiBz9COHKFG4f
         7AjuvJJ6xwC1F9LRFNlSEy5EMnV4ob0ru5dFTSP+gfHCmSGIS/xOu4+sp9y5Z5zBYfz3
         hK+K4WMzDV2Nx8Je5LY27QECnp9+nmaLgfqwRXP6eSd5uHxqJPFQzQWcml5UXKuXUjxN
         NNXPm5DPUzIIGdGr02+V8M2Pl+9TK7yTldiZJmCE1rXXtIl4vYxcdgII1B+BUQRKrcJx
         zKoQM4gNjIfHjUUmmqIZnJhhKCQ2Q5XPmtbD/qn2GEJrebMJOLhmZjYb93pUen15ixQk
         sF9A==
X-Gm-Message-State: APjAAAXB5pQqcdeqntcjOQL9EO1zarjrIkPscUWUhVrI5uI3vgou/ciA
        fXfFS4Vi4SyasjA8+2gBR7+Ib4+5NrryZ6/ktwA=
X-Google-Smtp-Source: APXvYqyydCcuBvXqI6tlUiplDf/E1iuWoEaUxAHjE4jekm6pKid2lg4rYKaCqMgIhDE5T7Z5+6c5101kFWsYqSx9pNk=
X-Received: by 2002:a25:3604:: with SMTP id d4mr28915145yba.290.1579296631352;
 Fri, 17 Jan 2020 13:30:31 -0800 (PST)
MIME-Version: 1.0
References: <c6ed1ca0-3e39-714c-9590-54e13695b9b9@redhat.com>
 <CAHk-=wink2z6EtvhKfhSvfC2hKBseVU8UWsM+HLsQP9x3mD7Xw@mail.gmail.com>
 <5c184396-7cc8-ee72-2335-dce9a977c8d4@redhat.com> <b70a0334-63be-b3a5-6f8a-714fbe4637c7@redhat.com>
In-Reply-To: <b70a0334-63be-b3a5-6f8a-714fbe4637c7@redhat.com>
From:   Akemi Yagi <toracat@elrepo.org>
Date:   Fri, 17 Jan 2020 13:30:20 -0800
Message-ID: <CABA31DpOsnDxL8VcwRebU8RmAMqv9UAc5zRe8oz14f3-TeWSQA@mail.gmail.com>
Subject: Re: Performance regression introduced by commit b667b8673443 ("pipe:
 Advance tail pointer inside of wait spinlock in pipe_read()")
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:11 AM Waiman Long <longman@redhat.com> wrote:
>
> On 1/17/20 12:29 PM, Waiman Long wrote:
> > On 1/17/20 12:05 PM, Linus Torvalds wrote:

> >> GNU make v4.2.1 is buggy. The fix was done over two years ago, but
> >> there hasn't been a new release since then, so a lot of distributions
> >> have the buggy version..
> >>
> >> The fix is commit b552b05 ("[SV 51159] Use a non-blocking read with
> >> pselect to avoid hangs.") In the make the git tree.
> >>      Linus
> >
> > Yes, I did use make v4.2.1 which is the version that is shipped in
> > RHEL8. I will build new make and try it.

> > Longman
> >
> I built a make with the lastest make git tree and the problem was gone
> with the new make. So it was a bug in make not the kernel. Sorry for the
> noise.
>
> Longman

If you are using RHEL8, building your own make is the only solution at
this time. There is a bugzilla entry filed for this make bug but the
progress is slow:

https://bugzilla.redhat.com/show_bug.cgi?id=1774790

The same bug in Fedora make was dealt with fairly quickly, thanks to
the great "pressure" from Linus. ;-)

Akemi
