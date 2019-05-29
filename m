Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12162E09A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfE2PKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 11:10:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37987 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE2PKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 11:10:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so81354pgl.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3NHqlVoLnqt1FPrdV3/ouU8QWVDF9XpBsDFRA3M9mXw=;
        b=l+25soU2r8L+HSnZwz7EAeGteROjLCaBLCfS46AdyKGmDYKRETwB+6CGZChZimiUfP
         ngVccUx/aZUDVBs0m8Q6cnbIeBz+Ja6u69OL2s7TVX30cdjUYRMMccUhgfG1CYKw78w+
         V1GIr0ftPCaKGc4AmHhHWk3Zogl1mCnO9ptqHVKKToXX415UW1dMo35OeNYX06d1JgZD
         xhdFQfY5MumAWyV4kWY8VLCPmPdGF+cKN9nOJ3CM5JcUSf8XUJaAk+xc7Mfifq2VAu+u
         D30p/HP8SCPBwTglWYYKym7xOMHHs9DhBLdqzjV3ph0mfKCf4upZUCDb0df1YbQF2S8d
         aO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3NHqlVoLnqt1FPrdV3/ouU8QWVDF9XpBsDFRA3M9mXw=;
        b=oFgXZ1N1DJAOfxjXDRYo32KTJXwxyHeSxnWIBLk9xoLskrtAY/FSIsK55EwjwT+p3+
         zhslXQwkJ/Kl7IZ3X/XF8NetekYzx+mE5z4OcpFmbfqZcND4mIJl8JplHv62Ox3P5t+n
         T3P+i5CJ8SWIXvGcCsv2bPeaFdegxHxOFcjrgwZ3GLAsVWoCs9bOd4xAQF0AoyUSWiAH
         vrs/I/aHLcBFVy74j7t4aTzCCQnPeNftlu7TQXRB2+fp4ffhxRhVKP54Zc9WtoEuN3LP
         KL0mTPKCdSbtYlYBipj6MUK+BvoMasEkoX6o9eqcCGNoBVg8t9WKT/Q20s9xhk/nQhoO
         FNdg==
X-Gm-Message-State: APjAAAX5uZ2dJv9OMMv3qK6azRRTYWA1VtNf/OZeY7VRuxRbFHdD0pPr
        ynsHfyY8PglP6rgOoAa8vPqnXA==
X-Google-Smtp-Source: APXvYqxm6x95Oz3ytQOQ6KJ6h+yMYOZG9THlrGBNRRjjiDeEhH7rSiaxnIXU6uXMK+p7Io1TQQBNsQ==
X-Received: by 2002:a62:1ec1:: with SMTP id e184mr83655828pfe.185.1559142604091;
        Wed, 29 May 2019 08:10:04 -0700 (PDT)
Received: from ?IPv6:2600:100f:b10c:ace6:b862:4204:5f4a:fe22? ([2600:100f:b10c:ace6:b862:4204:5f4a:fe22])
        by smtp.gmail.com with ESMTPSA id f38sm14162147pgm.85.2019.05.29.08.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:10:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v8 01/10] namei: obey trailing magic-link DAC permissions
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190524031109.v24r6typyug2rlto@yavin>
Date:   Wed, 29 May 2019 08:10:00 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9712F80E-1016-4DB7-996D-B423E07A1C1F@amacapital.net>
References: <20190520133305.11925-1-cyphar@cyphar.com> <20190520133305.11925-2-cyphar@cyphar.com> <CALCETrVCwe49q5mu=f6jTYNSgosQSjjY5chukMPo6eZtQGqo5g@mail.gmail.com> <20190523020009.mi25uziu2b3whf4l@yavin> <20190524031109.v24r6typyug2rlto@yavin>
To:     Aleksa Sarai <cyphar@cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 23, 2019, at 8:11 PM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
>> On 2019-05-23, Aleksa Sarai <cyphar@cyphar.com> wrote:
>>> On 2019-05-22, Andy Lutomirski <luto@kernel.org> wrote:
>>> What are actual examples of uses for this exception?  Breaking
>>> selftests is not, in and of itself, a huge problem.
>>=20
>> Not as far as I know. All of the re-opening users I know of do re-opens
>> of O_PATH or are re-opening with the same (or fewer) privileges. I also
>> ran this for a few days on my laptop without this exception, and didn't
>> have any visible issues.
>=20
> I have modified the patch to WARN_ON(may_open_magiclink() =3D=3D -EACCES).=

>=20
> So far (in the past day on my openSUSE machines) I have only seen two
> programs which have hit this case: kbd[1]'s "loadkeys" and "kbd_mode"
> binaries. In addition to there not being any user-visible errors -- they
> actually handle permission errors gracefully!
>=20
>  static int
>  open_a_console(const char *fnam)
>  {
>      int fd;
>=20
>      /*
>       * For ioctl purposes we only need some fd and permissions
>       * do not matter. But setfont:activatemap() does a write.
>       */
>      fd =3D open(fnam, O_RDWR);
>      if (fd < 0)
>          fd =3D open(fnam, O_WRONLY);
>      if (fd < 0)
>          fd =3D open(fnam, O_RDONLY);
>      if (fd < 0)
>          return -1;
>      return fd;
>  }
>=20
> The above gets called with "/proc/self/fd/0" as an argument (as well as
> other console candidates like "/dev/console"). And setfont:activatemap()
> actually does handle read-only fds:
>=20
>  static void
>  send_escseq(int fd, const char *seq, int n)
>  {
>      if (write(fd, seq, n) !=3D n) /* maybe fd is read-only */
>          printf("%s", seq);
>  }
>=20
>  void activatemap(int fd)
>  {
>      send_escseq(fd, "\033(K", 3);
>  }
>=20
> So, thus far, not only have I not seen anything go wrong -- the only
> program which actually hits this case handles the error gracefully.
> Obviously we got lucky here, but the lack of any users of this
> mis-feature leads me to have some hope that we can block it without
> anyone noticing.
>=20
> But I emphatically do not want to break userspace here (except for
> attackers, obviously).

Hmm. This will break any script that does echo foo >/dev/stdin too.

Just to throw an idea out there, what if the open were allowed if the file m=
ode is sufficient or if the magic link target is openable with the correct m=
ode without magic?  In other words, first check as in your code but without t=
he exception and, if that check fails, then walk the same path that d_path w=
ould return and see if it would work as a normal open?  Of course, that seco=
nd attempt would need to disable magic links to avoid recursing.  I=E2=80=99=
m not sure I love this idea...

Otherwise, I imagine we can live with the exception, especially if the new o=
pen API turns it off by default.
