Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2C81A9B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 00:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEKWkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 18:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfEKWkB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 18:40:01 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA60F2184D
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 22:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557614400;
        bh=6aAVxVoG0YErbZEF5yAMdrjDFqc8XWrGVGwGxXiD2h8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oOZpwkFy4KvTDWQ5x5WmN/Wa2/j/gcwfjt6x79ZL178HwDByZxOuKJdbpmoh5MPbi
         Q9L2idDgToQpAZDmoMzdQolUzlnxexTRLumvHOVlxwJkKKLK5rfwiShuaMuNv4Sneh
         xYPL1JqnSu3BKdnF/2mH8CY5/L/nb0cln6QvsWkc=
Received: by mail-wm1-f47.google.com with SMTP id m20so8740769wmg.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 15:39:59 -0700 (PDT)
X-Gm-Message-State: APjAAAXruaqDs1PJupowZtAzrz2FcMvAuUS4bWEvEWkJh6gwr82zNC+O
        DXoALb8svgj7xEbZVG5oWSDMHUNvGMUdRgQrJunHjQ==
X-Google-Smtp-Source: APXvYqw8wpn9vXY9rQ/LMQUH9mP2L9fR7s63JaX9ok1OnI1y0hE/ySixRfj2P53nN+TZ8buAf8WBOkoM5tw1kuhN8ZY=
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr11759062wmh.32.1557614396632;
 Sat, 11 May 2019 15:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 11 May 2019 15:39:45 -0700
X-Gmail-Original-Message-ID: <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com>
Message-ID: <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On May 11, 2019, at 10:21 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>
>> On Sat, May 11, 2019 at 1:00 PM Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>
>> A better =E2=80=9Cspawn=E2=80=9D API should fix this.
>
> Andy, stop with the "spawn would be better".

It doesn=E2=80=99t have to be spawn per se.  But the current situation suck=
s.

>
> Notice? None of the real problems are about execve or would be solved
> by any spawn API. You just think that because you've apparently been
> talking to too many MS people that think fork (and thus indirectly
> execve()) is bad process management.
>
>

I=E2=80=99ve literally never spoken to an MS person about it.

What container managers and init systems *want* is a way to drop
privileges, change namespaces, etc and then run something in a
controlled way so that the intermediate states aren=E2=80=99t dangerous. An
API for this could be spawn-like or exec-like =E2=80=94 that particular
distinction is beside the point.  Having personally written code that
mucks with namepsaces, I've wanted two particular abilities that are
both quite awkward:

a) Change all my UIDs and GIDs to match a container, enter that
container's namespaces, and run some binary in the container's
filesystem, all atomically enough that I don't need to worry about
accidentally leaking privileges into the container.  A
super-duper-non-dumpable mode would kind of allow this, but I'd worry
that there's some other hole besides ptrace() and /proc/self.

b) Change all my UIDs and GIDs to match a container, enter that
container's namespaces, and run some binary that is *not* in the
container's filesystem.  This happens, for example, if the container's
mount namespace has no exec mounts at all.  We don't have a fantastic
way to do this at all right now due to /proc/self/exe.

Regardless, the actual CVE at hand would have been nicely avoided if
writing to /proc/self/exe didn=E2=80=99t work, and I see no reason we can=
=E2=80=99t
make that happen.

I suppose we could also consider a change to disable /proc/self/exe if
it's not reachable from /proc/self/root.  By "disable", I mean that
readlink() should maybe still work, but actually trying to open it
could probably fail safely.
