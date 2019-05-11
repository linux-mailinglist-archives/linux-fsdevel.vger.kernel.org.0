Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544271A895
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEKRAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 13:00:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47096 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEKRAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 13:00:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so4867842pfm.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jZwCSftxJ8jGLP4AOxqI82+D69OlL58PjFg7M2MhcPg=;
        b=MLbHwTI1YOsIPzVKr77SniYja0eFxYm6pUzvO6ZOGv6xtO1LSTe7DrZ5OnxOMxLOYj
         BCJK/KQHgD9Bo2Cms6d/suLf3ujHpz6Q6wSX6BTSEPOYmdc+uobvATnhQ1gxsSFMNEFx
         15ie5t1upui2XLIrMplBHkFq8NaEnsPGXE1WOVW7Xy6h/wCR8Xugr4NIa+GwPer8chMo
         24aAsFtZ/ye7n+0/mLGDbAkLYugePfX9RRINUb+ZhyTIzmMwtXZjNqTpwSvJNn+RpVIF
         v90ZAgJyGlmQwdpMW+y/xvzXjE00AVz/EqPo1hI7s4oZDxTp8MxYoaFX19LOXZflO+As
         HRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jZwCSftxJ8jGLP4AOxqI82+D69OlL58PjFg7M2MhcPg=;
        b=ChiOCelvuK5D42GiE4waxml15vwPN8mVgDVZi0u05A77cJg5CSJ+nJOY0SKG8Nz5b8
         aVTFlgZeqie/s/8V4GrcW15FHBi+Lt9fxcJwt8UXDa8PyBJKZPd38oPUbabJ7pAO6G9M
         FDVogWunVuv6lPz3/BAmmLowawAdwtgWNF8ek/CEDXEdQHCi3Utldcp9KC5NpERT2YGa
         /E/xu1oRrW7oKfUkaf4lvDQ3ZoVZiGUEOamnwF5ZYdn4klXMMo8FBYtInEAwMgptzouw
         kO4zOtLbs/4npLa1HIE68a5QeWtceQg5pA4OP6YLwqL0p2gq2bNBOLcNK0rVUhTl6SMK
         MFfw==
X-Gm-Message-State: APjAAAXzISNDgoQf6XFzOS6aueEQTzr7IGiaRW1Shn5PKOB8/vRHtltp
        M/oKkMAvPqivrsug5kcPkde0Eg==
X-Google-Smtp-Source: APXvYqxDTUyInHaUluwo6C7js6tTl9bgGutACKTBYZ7Zz8eRhD+O5JQUeYs9OffRM+3dXwWvEQa3hg==
X-Received: by 2002:a63:d816:: with SMTP id b22mr21540940pgh.16.1557594051790;
        Sat, 11 May 2019 10:00:51 -0700 (PDT)
Received: from ?IPv6:2600:1010:b006:1d0d:7d97:e542:5c4a:fdf6? ([2600:1010:b006:1d0d:7d97:e542:5c4a:fdf6])
        by smtp.gmail.com with ESMTPSA id a3sm9014995pgl.74.2019.05.11.10.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:00:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190510225527.GA59914@google.com>
Date:   Sat, 11 May 2019 10:00:47 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com> <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com> <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com> <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com> <20190510225527.GA59914@google.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 10, 2019, at 3:55 PM, Jann Horn <jannh@google.com> wrote:
>=20
>> On Fri, May 10, 2019 at 02:20:23PM -0700, Andy Lutomirski wrote:
>>> On Fri, May 10, 2019 at 1:41 PM Jann Horn <jannh@google.com> wrote:
>>>=20
>>>> On Tue, May 07, 2019 at 05:17:35AM +1000, Aleksa Sarai wrote:
>>>>> On 2019-05-06, Jann Horn <jannh@google.com> wrote:
>>>>> In my opinion, CVE-2019-5736 points out two different problems:
>>>>>=20
>>>>> The big problem: The __ptrace_may_access() logic has a special-case
>>>>> short-circuit for "introspection" that you can't opt out of; this
>>>>> makes it possible to open things in procfs that are related to the
>>>>> current process even if the credentials of the process wouldn't permit=

>>>>> accessing another process like it. I think the proper fix to deal with=

>>>>> this would be to add a prctl() flag for "set whether introspection is
>>>>> allowed for this process", and if userspace has manually un-set that
>>>>> flag, any introspection special-case logic would be skipped.
>>>>=20
>>>> We could do PR_SET_DUMPABLE=3D3 for this, I guess?
>>>=20
>>> Hmm... I'd make it a new prctl() command, since introspection is
>>> somewhat orthogonal to dumpability. Also, dumpability is per-mm, and I
>>> think the introspection flag should be per-thread.
>>=20
>> I've lost track of the context here, but it seems to me that
>> mitigating attacks involving accidental following of /proc links
>> shouldn't depend on dumpability.  What's the actual problem this is
>> trying to solve again?
>=20
> The one actual security problem that I've seen related to this is
> CVE-2019-5736. There is a write-up of it at
> <https://blog.dragonsector.pl/2019/02/cve-2019-5736-escape-from-docker-and=
.html>
> under "Successful approach", but it goes more or less as follows:
>=20
> A container is running that doesn't use user namespaces (because for
> some reason I don't understand, apparently some people still do that).
> An evil process is running inside the container with UID 0 (as in,
> GLOBAL_ROOT_UID); so if the evil process inside the container was able
> to reach root-owned files on the host filesystem, it could write into
> them.
>=20
> The container engine wants to spawn a new process inside the container.
> It forks off a child that joins the container's namespaces (including
> PID and mount namespaces), and then the child calls execve() on some
> path in the container.

I think that, at this point, the task should be considered owned by the cont=
ainer.  Maybe we should have a better API than execve() to execute a program=
 in a safer way, but fiddling with dumpability seems like a band-aid.  In fa=
ct, the process is arguably pwned even *before* execve.

A better =E2=80=9Cspawn=E2=80=9D API should fix this.  In the mean time, I t=
hink it should be assumed that, if you join a container=E2=80=99s namespaces=
, you are at its mercy.

> The attacker replaces the executable in the container with a symlink
> to /proc/self/exe and replaces a library inside the container with a
> malicious one.

Cute.

> When the container engine calls execve(), intending to run an executable
> inside the container, it instead goes through ptrace_may_access() using
> the introspection short-circuit and re-executes its own executable
> through the jumped symlink /proc/self/exe (which is normally unreachable
> for the container). After the execve(), the process loads an evil
> library from inside the container and is under the control of the
> container.
> Now the container controls a process whose /proc/self/exe is a jumped
> symlink to a host executable, and the container can write into it.
>=20
> Some container engines are now using an extremely ugly hack to work
> around this - whenever they want to enter a container, they copy the
> host binary into a new memfd and execute that to avoid exposing the
> original host binary to containers:
> <https://github.com/opencontainers/runc/commit/0a8e4117e7f715d5fbeef398405=
813ce8e88558b>
>=20
>=20
> In my opinion, the problems here are:
>=20
> - Apparently some people run untrusted containers without user
>   namespaces. It would be really nice if people could not do that.
>   (Probably the biggest problem here.)

> - ptrace_may_access() has a short-circuit that permits a process to
>   unintentionally look at itself even if it has dropped privileges -
>   here, it permits the execve("/proc/self/exe", ...) that would
>   normally be blocked by the check for CAP_SYS_PTRACE if the process
>   is nondumpable.

I don=E2=80=99t see this as a problem.  Dumpable is about protecting a task f=
rom others, not about protecting a task against itself.

> - You can use /proc/*/exe to get a writable fd.

This is IMO the real bug.=
