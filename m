Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44596262D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfEVLO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 07:14:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35923 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfEVLO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 07:14:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id a17so1791287qth.3;
        Wed, 22 May 2019 04:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ii2+g1Yuy9p+Tzu5oDaDkK4iSzLT2e87aOjge7d8qc=;
        b=keuCaNyCYa5wuGOKQCjm5gU6hA9etviUXq6CnrRmZa68ySOQpFMqaxxWEXswWYsFdS
         J3iNFLyNza5SCQzXwW5fRzUx/tHhF7CIDng26y2ns5dsVzSmOlGMlutzPFd60O159+xJ
         GJH//mRSm9v18NXO4bjtL45B2+FzeRHS03CQsARX84E2dlqzTtQAB0JPjcipm0zu+OuY
         iDUh44gXg4muI91Iz+blGE/OXR2CH441TS2dMv2kk1cjWoCVzpnnIqdx+Ov5Z7vhI//t
         SDPWbs0Ll5PT570wtW80FsAUwy4vnx+i9JbCAevOWp/1VgQfT7+269yK6xjnHFNxd4K1
         75GQ==
X-Gm-Message-State: APjAAAVk22qUQi15+iEvkUervratb4VTSdl9WxbPiAZaM359xxlBkHIs
        QMzBNrBNokwaZGwB40WG4oe8hzH9/+k7xiqiaM4=
X-Google-Smtp-Source: APXvYqwrHwCBCiCay5soyp1JKsXm50OnDnZUTKbJgG6Y5QmYOfB72om3Cm14f1T0mKTgl9Z2jcJv2ycTGPBYZJMgMQs=
X-Received: by 2002:ac8:2433:: with SMTP id c48mr59157201qtc.18.1558523698039;
 Wed, 22 May 2019 04:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190516085810.31077-1-rpenyaev@suse.de> <20190516085810.31077-14-rpenyaev@suse.de>
 <CAK8P3a2-fN_BHEnEHvf4X9Ysy4t0_SnJetQLvFU1kFa3OtM0fQ@mail.gmail.com>
 <41b847c48ccbe0c406bd54c16fbc1bf0@suse.de> <20190521193312.42a3fdda1774b1922730e459@linux-foundation.org>
In-Reply-To: <20190521193312.42a3fdda1774b1922730e459@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 May 2019 13:14:41 +0200
Message-ID: <CAK8P3a3GWVNraxowtPmdZnF3moJ8=zkkD6F_1-885614HiVP3g@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] epoll: implement epoll_create2() syscall
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Azat Khuzhin <azat@libevent.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 4:33 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 16 May 2019 12:20:50 +0200 Roman Penyaev <rpenyaev@suse.de> wrote:
> > On 2019-05-16 12:03, Arnd Bergmann wrote:
> > > On Thu, May 16, 2019 at 10:59 AM Roman Penyaev <rpenyaev@suse.de>
> > > wrote:
> > >>
> > >> epoll_create2() is needed to accept EPOLL_USERPOLL flags
> > >> and size, i.e. this patch wires up polling from userspace.
> > >
> > > Could you add the system call to all syscall*.tbl files at the same
> > > time here?
> >
> > For all other archs, you mean?  Sure.  But what is the rule of thumb?
> > Sometimes people tend to add to the most common x86 and other tables
> > are left untouched, but then you commit the rest, e.g.
> >
> > commit 39036cd2727395c3369b1051005da74059a85317
> > Author: Arnd Bergmann <arnd@arndb.de>
> > Date:   Thu Feb 28 13:59:19 2019 +0100
> >
> >      arch: add pidfd and io_uring syscalls everywhere
> >
>
> I thought the preferred approach was to wire up the architectures on
> which the submitter has tested the syscall, then allow the arch
> maintainers to enable the syscall independently?

I'm hoping to change that practice now, as it has not worked well
in the past:

- half the architectures now use asm-generic/unistd.h, so they are
  already wired up at the same time, regardless of testing
- in the other half, not adding them at the same time actually
  made it harder to test, as it was significantly harder to figure
  out how to build a modified kernel for a given architecture
  than to run the test case
- Not having all architectures add a new call at the same time caused
  the architectures to get out of sync when some got added and others
  did not. Now that we use the same numbers across all architectures,
  that would be even more confusing.

My plan for the long run is to only have one file to which new
system calls get added in the future.

> And to help them in this, provide a test suite for the new syscall
> under tools/testing/selftests/.
>
> https://github.com/rouming/test-tools/blob/master/userpolled-epoll.c
> will certainly help but I do think it would be better to move the test
> into the kernel tree to keep it maintained and so that many people run
> it in their various setups on an ongoing basis.

No disagreement on that.

      Arnd
