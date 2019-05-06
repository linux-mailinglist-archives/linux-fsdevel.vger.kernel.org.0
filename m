Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7C15672
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 01:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfEFXlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 19:41:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33850 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfEFXlD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 19:41:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck18so7162655plb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cu/5JLglbZpHB47mRPcBeCr0QHZlpel2E25udH/pb8w=;
        b=efMGrJ6hFKv1kWPIdHDNK8bAG+KmrqFIq7qrsTa6ne5vSAl2jnHP54JiVIsTJdEJDi
         CBW+7olfq5tZCbPUpejU5CnjJ1THnVL4aJ3zbedyl9GQNj8YoAcIW4iaPZ44FJEWCS1t
         Os3V8E/VAJdllE5t/eGLCt1E4LaaHPWBEM/eoUCcEKNLUHXy0yDGTVWdyCU7/lupW7kV
         DHP+LpyR+7o30TJJre/FmlFduYquWNTocbcId5NpAGjpNfC9+tp4qUt4A3fhgqSbIXLW
         CZ+MqHNnqxuSWHsxFvu1cVO/C0mj+GiMqfkDgHRnUQy6yOOean9ifprUG9mjO/Ml+tSE
         pruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cu/5JLglbZpHB47mRPcBeCr0QHZlpel2E25udH/pb8w=;
        b=tUXMKNDLVPzt2rk1gAp+QorNoPQ9C0cOE50B5Z246Zg/UrwnL+2od0GCcMz5YH7i6D
         Ux0CzWrx1eEmsPN7HptZPYEIhT+LNIHKp3Kk0IQYTRNpFgR91NcIb7rai9FNTvidYv6S
         5pxWG446U2BUzWpH4OEIYFuU59x2YqmIzEoMwvbrcs6vI/Chvn0qaeevidngChi/pIdr
         P7vcDPbzKFa0/uqUkVQ845cQj1bymDLEGPBeU543qDRIYvvOMslEZngRbc7MeGPERRb6
         JDyydD7b3G7En+B/Ki9sXzLQq9IJvjCk4u1qt0NOUPuJAZx+gG7JROuMT//034nWcYuR
         4J/A==
X-Gm-Message-State: APjAAAWGTfts4s3xO20czq3pTzBh+8EVyBLraITcDBPKGryXt51ZQIeb
        7cbmXVZJVEdQFOKjYKUpMiKoBw==
X-Google-Smtp-Source: APXvYqyvNo1wcRlCIjQJfL9ucrmYmg+degrKDwjLlQZEoxJHLyUp1v/+wMdRm0VtY/kOSZU5ltjnHw==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10mr5734832plb.18.1557186062326;
        Mon, 06 May 2019 16:41:02 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:5820:d6a2:5572:e4a3? ([2601:646:c200:1ef2:5820:d6a2:5572:e4a3])
        by smtp.gmail.com with ESMTPSA id n9sm13924474pff.59.2019.05.06.16.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 16:41:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190506191735.nmzf7kwfh7b6e2tf@yavin>
Date:   Mon, 6 May 2019 16:41:00 -0700
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
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
        containers@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A982EE7E-7E92-460A-A458-2F9C3586E9DA@amacapital.net>
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com> <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com> <20190506191735.nmzf7kwfh7b6e2tf@yavin>
To:     Aleksa Sarai <cyphar@cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 6, 2019, at 12:17 PM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
>> On 2019-05-06, Jann Horn <jannh@google.com> wrote:
>>> On Mon, May 6, 2019 at 6:56 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>>> The need to be able to scope path resolution of interpreters became
>>> clear with one of the possible vectors used in CVE-2019-5736 (which
>>> most major container runtimes were vulnerable to).
>>>=20
>>> Naively, it might seem that openat(2) -- which supports path scoping --
>>> can be combined with execveat(AT_EMPTY_PATH) to trivially scope the
>>> binary being executed. Unfortunately, a "bad binary" (usually a symlink)=

>>> could be written as a #!-style script with the symlink target as the
>>> interpreter -- which would be completely missed by just scoping the
>>> openat(2). An example of this being exploitable is CVE-2019-5736.
>>>=20
>>> In order to get around this, we need to pass down to each binfmt_*
>>> implementation the scoping flags requested in execveat(2). In order to
>>> maintain backwards-compatibility we only pass the scoping AT_* flags.
>>>=20
>>> To avoid breaking userspace (in the exceptionally rare cases where you
>>> have #!-scripts with a relative path being execveat(2)-ed with dfd !=3D
>>> AT_FDCWD), we only pass dfd down to binfmt_* if any of our new flags are=

>>> set in execveat(2).
>>=20
>> This seems extremely dangerous. I like the overall series, but not this p=
atch.
>>=20
>>> @@ -1762,6 +1774,12 @@ static int __do_execve_file(int fd, struct filena=
me *filename,
>>>=20
>>>        sched_exec();
>>>=20
>>> +       bprm->flags =3D flags & (AT_XDEV | AT_NO_MAGICLINKS | AT_NO_SYML=
INKS |
>>> +                              AT_THIS_ROOT);
>> [...]
>>> +#define AT_THIS_ROOT           0x100000 /* - Scope ".." resolution to d=
irfd (like chroot(2)). */
>>=20
>> So now what happens if there is a setuid root ELF binary with program
>> interpreter "/lib64/ld-linux-x86-64.so.2" (like /bin/su), and an
>> unprivileged user runs it with execveat(..., AT_THIS_ROOT)? Is that
>> going to let the unprivileged user decide which interpreter the
>> setuid-root process should use? =46rom a high-level perspective, opening
>> the interpreter should be controlled by the program that is being
>> loaded, not by the program that invoked it.
>=20
> I went a bit nuts with openat_exec(), and I did end up adding it to the
> ELF interpreter lookup (and you're completely right that this is a bad
> idea -- I will drop it from this patch if it's included in the next
> series).
>=20
> The proposed solutions you give below are much nicer than this patch so
> I can drop it and work on fixing those issues separately.
>=20
>> In my opinion, CVE-2019-5736 points out two different problems:
>>=20
>> The big problem: The __ptrace_may_access() logic has a special-case
>> short-circuit for "introspection" that you can't opt out of; this
>> makes it possible to open things in procfs that are related to the
>> current process even if the credentials of the process wouldn't permit
>> accessing another process like it. I think the proper fix to deal with
>> this would be to add a prctl() flag for "set whether introspection is
>> allowed for this process", and if userspace has manually un-set that
>> flag, any introspection special-case logic would be skipped.
>=20
> We could do PR_SET_DUMPABLE=3D3 for this, I guess?
>=20
>> An additional problem: /proc/*/exe can be used to open a file for
>> writing; I think it may have been Andy Lutomirski who pointed out some
>> time ago that it would be nice if you couldn't use /proc/*/fd/* to
>> re-open files with more privileges, which is sort of the same thing.
>=20
> This is something I'm currently working on a series for, which would
> boil down to some restrictions on how re-opening of file descriptors
> works through procfs.
>=20
> However, execveat() of a procfs magiclink is a bit hard to block --
> there is no way for userspace to to represent a file being "open for
> execute" so they are all "open for execute" by default and blocking it
> outright seems a bit extreme (though I actually hope to eventually add
> the ability to mark an O_PATH as "open for X" to resolveat(2) -- hence
> why I've reserved some bits).

There=E2=80=99s an O_MAYEXEC series floating around.

>=20
> (Thinking more about it, there is an argument that I should include the
> above patch into this series so that we can block re-opening of fds
> opened through resolveat(2) without explicit flags from the outset.)
>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>
