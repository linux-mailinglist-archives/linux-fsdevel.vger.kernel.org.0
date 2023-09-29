Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44477B3207
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 14:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjI2MGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 08:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjI2MGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:06:52 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E52193;
        Fri, 29 Sep 2023 05:06:50 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7ae12c28776so2411162241.0;
        Fri, 29 Sep 2023 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695989209; x=1696594009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WklKxHvJ4lWh9tljSeh/U+ySuT04KyfAmm6d+l7zSl4=;
        b=CK3fGtVS2+Ej5iStNIV6ZP21iddjgppxLiPbxk76P1AtfGsOdzKwq9QkKJM5bpxl4d
         RH1DdnaW/wOUbi+kRMci6awoEA8PRSGrY+qfPCVx0I4qGEq5IXv+9+v1Sl6vEiTC0K0V
         4r8g9gnvNRMxPBoyrSGRUQmyqAvDHuchyVOf7cVeK5Q2jIf60oa6jpx7zIxz6lo3EeZH
         BFR5OEBInl/0Zll3XpY0qTfBsIgf9x54h0iN8qkDxm/Is4STI2Gj31P4r+u/qseiGwYi
         /i93DhOrrLOwz/brccRGyfQ2sWBZNyVtR0VQCefim4wsEczs3Lzit+bNJYR9BMZlj9xD
         j0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695989209; x=1696594009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WklKxHvJ4lWh9tljSeh/U+ySuT04KyfAmm6d+l7zSl4=;
        b=ABexkTOccNVmmzRwPjC+CXP1xc1J5Hw+JvjgmyZBpMymHLCbUZp3xrodw4tRdMNb40
         9bNmGc37AoIHLwQPkSoUOEofWxVtw/u0q/QU9ZNHifhLxP/NoA/SfjnvuYcrWToD42p5
         TkYn82ngoz2W90NcITDHEYmFNooFAV3bM7u8y+YEnZgsUfSN5ADVG4E0inylr3OJEIF6
         Da8FpnWM7f14+9gK7zAboozx46uBLPsgmJq/hsWU5vDDbNxz71UqojiVnjnjz4/sJrJ2
         qjdg02sWjJca7IdY5JXRJQvG94lzplpogZzfrorJR7UICZkqfxkLxgI5v7zZjY2NFaKe
         ZzKA==
X-Gm-Message-State: AOJu0YyNsa/KDKEzqJSU2GYecSJ+BmAgEeIaJJKxLzQhAgo4gOx5CX5s
        mr0L60NtRTxySkAZ1o6thUecfk5XT6ffmohBDTc=
X-Google-Smtp-Source: AGHT+IHPnnp9Tml6BPyPUla6wu4iber8g42aabZ9OhsBHrXPZZSJc8ot7WEgSaDN7oTUpTxc+9F3wRzKXu/a/+Psc84=
X-Received: by 2002:a05:6102:d4:b0:452:94b8:2fe9 with SMTP id
 u20-20020a05610200d400b0045294b82fe9mr2992035vsp.21.1695989209499; Fri, 29
 Sep 2023 05:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230929031716.it.155-kees@kernel.org> <20230929032435.2391507-1-keescook@chromium.org>
In-Reply-To: <20230929032435.2391507-1-keescook@chromium.org>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Fri, 29 Sep 2023 13:06:38 +0100
Message-ID: <CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShxbHHA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 4:24=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Implement a helper elf_load() that wraps elf_map() and performs all
> of the necessary work to ensure that when "memsz > filesz" the bytes
> described by "memsz > filesz" are zeroed.
>
> An outstanding issue is if the first segment has filesz 0, and has a
> randomized location. But that is the same as today.
>
> In this change I replaced an open coded padzero() that did not clear
> all of the way to the end of the page, with padzero() that does.
>
> I also stopped checking the return of padzero() as there is at least
> one known case where testing for failure is the wrong thing to do.
> It looks like binfmt_elf_fdpic may have the proper set of tests
> for when error handling can be safely completed.
>
> I found a couple of commits in the old history
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
> that look very interesting in understanding this code.
>
> commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail")
> commit c6e2227e4a3e ("[SPARC64]: Missing user access return value checks =
in fs/binfmt_elf.c and fs/compat.c")
> commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2")
>
> Looking at commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fai=
l"):
> >  commit 39b56d902bf35241e7cba6cc30b828ed937175ad
> >  Author: Pavel Machek <pavel@ucw.cz>
> >  Date:   Wed Feb 9 22:40:30 2005 -0800
> >
> >     [PATCH] binfmt_elf: clearing bss may fail
> >
> >     So we discover that Borland's Kylix application builder emits weird=
 elf
> >     files which describe a non-writeable bss segment.
> >
> >     So remove the clear_user() check at the place where we zero out the=
 bss.  I
> >     don't _think_ there are any security implications here (plus we've =
never
> >     checked that clear_user() return value, so whoops if it is a proble=
m).
> >
> >     Signed-off-by: Pavel Machek <pavel@suse.cz>
> >     Signed-off-by: Andrew Morton <akpm@osdl.org>
> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> It seems pretty clear that binfmt_elf_fdpic with skipping clear_user() fo=
r
> non-writable segments and otherwise calling clear_user(), aka padzero(),
> and checking it's return code is the right thing to do.
>
> I just skipped the error checking as that avoids breaking things.
>
> And notably, it looks like Borland's Kylix died in 2005 so it might be
> safe to just consider read-only segments with memsz > filesz an error.
>
> Reported-by: Sebastian Ott <sebott@redhat.com>
> Reported-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Closes: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@we=
issschuh.net
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Link: https://lore.kernel.org/r/87sf71f123.fsf@email.froward.int.ebiederm=
.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
>  1 file changed, 48 insertions(+), 63 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 7b3d2d491407..2a615f476e44 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -110,25 +110,6 @@ static struct linux_binfmt elf_format =3D {
>
>  #define BAD_ADDR(x) (unlikely((unsigned long)(x) >=3D TASK_SIZE))
>
> -static int set_brk(unsigned long start, unsigned long end, int prot)
> -{
> -       start =3D ELF_PAGEALIGN(start);
> -       end =3D ELF_PAGEALIGN(end);
> -       if (end > start) {
> -               /*
> -                * Map the last of the bss segment.
> -                * If the header is requesting these pages to be
> -                * executable, honour that (ppc32 needs this).
> -                */
> -               int error =3D vm_brk_flags(start, end - start,
> -                               prot & PROT_EXEC ? VM_EXEC : 0);
> -               if (error)
> -                       return error;
> -       }
> -       current->mm->start_brk =3D current->mm->brk =3D end;
> -       return 0;
> -}
> -
>  /* We need to explicitly zero any fractional pages
>     after the data section (i.e. bss).  This would
>     contain the junk from the file that should not
> @@ -406,6 +387,51 @@ static unsigned long elf_map(struct file *filep, uns=
igned long addr,
>         return(map_addr);
>  }
>
> +static unsigned long elf_load(struct file *filep, unsigned long addr,
> +               const struct elf_phdr *eppnt, int prot, int type,
> +               unsigned long total_size)
> +{
> +       unsigned long zero_start, zero_end;
> +       unsigned long map_addr;
> +
> +       if (eppnt->p_filesz) {
> +               map_addr =3D elf_map(filep, addr, eppnt, prot, type, tota=
l_size);
> +               if (BAD_ADDR(map_addr))
> +                       return map_addr;
> +               if (eppnt->p_memsz > eppnt->p_filesz) {
> +                       zero_start =3D map_addr + ELF_PAGEOFFSET(eppnt->p=
_vaddr) +
> +                               eppnt->p_filesz;
> +                       zero_end =3D map_addr + ELF_PAGEOFFSET(eppnt->p_v=
addr) +
> +                               eppnt->p_memsz;
> +
> +                       /* Zero the end of the last mapped page */
> +                       padzero(zero_start);
> +               }
> +       } else {
> +               map_addr =3D zero_start =3D ELF_PAGESTART(addr);
> +               zero_end =3D zero_start + ELF_PAGEOFFSET(eppnt->p_vaddr) =
+
> +                       eppnt->p_memsz;

What happens if a previous segment has mapped ELF_PAGESTART(addr)?
Don't we risk mapping over that?
Whereas AFAIK old logic would just padzero the bss bytes.

--=20
Pedro
