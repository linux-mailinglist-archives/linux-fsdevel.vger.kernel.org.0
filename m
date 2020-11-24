Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E502C31C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgKXUPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 15:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbgKXUPF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:15:05 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A96220897;
        Tue, 24 Nov 2020 20:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606248905;
        bh=1uE3OiCzLGLIZAGr9pL2rVM5ax6NdKMufsqI16g8Phg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kahRTY2xTKQf43H0i9dFH/aINLhMv6NuS/vq6a+aQuaTi7qLRIMUtLP4a4cL/6fxk
         /KL5zcGhnJ01ZqG0PIAca5aZmFgvZ3Slwyxp4ktgBUZuJ9C8WVdzkL0+DwrdZpeDPn
         dYCJq7IwG3QdYXMfmh0C5MIY8kveD/o5wslo4rQc=
Received: by mail-ot1-f50.google.com with SMTP id 79so36648otc.7;
        Tue, 24 Nov 2020 12:15:05 -0800 (PST)
X-Gm-Message-State: AOAM531fZ1HYWE4E5ABbH0qmQizNC9QAcf7qWLZYl6ghTX2kYDQ/BscF
        HagtWlBT5rIWY3SiDWyUcAj3zitab3xJBAHAtAM=
X-Google-Smtp-Source: ABdhPJzCz6LUoJRBkoGcpndiBFsOlruR8AoE+WOG4FWfG4gad/1eooLu5DK7ErHqUIxy141UTZnr9Dys81t4JI1eD3o=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr203752otk.251.1606248904500;
 Tue, 24 Nov 2020 12:15:04 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com> <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
 <87im9vx08i.fsf@x220.int.ebiederm.org> <87pn42r0n7.fsf@x220.int.ebiederm.org> <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
In-Reply-To: <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 24 Nov 2020 21:14:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com>
Message-ID: <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 8:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 24, 2020 at 11:55 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
> >
> > If cell happens to be dead we can remove a fair amount of generic kernel
> > code that only exists to support cell.
>
> Even if some people might still use cell (which sounds unlikely), I
> think we can remove the spu core dumping code.

The Cell blade hardware (arch/powerpc/platforms/cell/) that I'm listed
as a maintainer for is very much dead, but there is apparently still some
activity on the Playstation 3 that Geoff Levand maintains.

Eric correctly points out that the PS3 firmware no longer boots
Linux (OtherOS), but AFAIK there are both users with old firmware
and those that use a firmware exploit to run homebrew code including
Linux.

I would assume they still use the SPU and might also use the core
dump code in particular. Let's see what Geoff thinks.

       Arnd
