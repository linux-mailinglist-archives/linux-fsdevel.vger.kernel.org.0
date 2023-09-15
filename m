Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75677A2A45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 00:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjIOWPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 18:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbjIOWPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:15:22 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A383;
        Fri, 15 Sep 2023 15:15:17 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a754db0fbcso930929241.2;
        Fri, 15 Sep 2023 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694816117; x=1695420917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW9H8bI2FfYEr6xLbYMxYe/FGxKReRHQFVdj7VLT7eU=;
        b=GNsNSlAtpYNaxDFZ4gBHAHbLvQUMYJBx1h1RcbD6ekTVc1EMYsxYe3rdJnasYb2dDu
         7txaNIIfUqWB2Vi1fGNNrbVn+32unsWUpBkuPWcu0DtkYyyb9yQPqNgcxT0cEVirYXeD
         ra5r/M8fa+4Q2dJmztwO19r/1AhMyOCPl8XBRMskWUQKLCKegZB86FjSzHdkN8DKQXmX
         S5a/0B0qUu9s+1KWmbLgvLt4D3uI+0+I5M6eoOcF53TklVjH49yO9DP+nNmDO0jzqLgs
         Pv5XAWbC0saqoIil21XpY8yvAZaCWZ5MoxJOGy/Dhnze9klsGVztGicFiBNl7leOWOqg
         opDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694816117; x=1695420917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FW9H8bI2FfYEr6xLbYMxYe/FGxKReRHQFVdj7VLT7eU=;
        b=ucc2Enin4oXB9AnwMUMy64N0VzMwSPux/s1u3eRhzgauYVnFcpxreZ53PfnhDP6CQF
         afqpMp0NI0fZTlSyIIPDBbtwvD7vlhjUResE7SaT4phWL0kueHpVxvcPQZjxXmi2uynx
         owswJBVQz7Xzy5cioYylQ0ri/moQ7LjJCo5yzAleLq1wKuAqnuJBY/ZtDHdh3XA1jyku
         3lAFvzy3sTpxHooWuwt8YRIYzAaDFuc4K5SIoo2mhknUjuRbPkx9LAyFvIAOxrS4fbJX
         91Sf0KOQE5txWP6QcUEK1c72XCDacWDKzgNYhIm1LT4/6S59AopsIIt62ikjYw2o4ecY
         1X8Q==
X-Gm-Message-State: AOJu0YwnaAZaQNEXoFD7/oKxZD87L2+qA8RQ57bZyMR6o96lG6S1ob0S
        odWe+QWvUrwkBO/CuXqjZVNqpZF1wj2QvmBDuzcmjOiEvmw=
X-Google-Smtp-Source: AGHT+IH2PdPTUw08lT2fcsZTF/CCSNgQEAW9QLws2GcpxFI3uqViNbUSgxXsb3UzuNSmLvKvJ3VpKl/eT8RUX/yGHR4=
X-Received: by 2002:a67:e30e:0:b0:44d:5298:5bfa with SMTP id
 j14-20020a67e30e000000b0044d52985bfamr3495256vsf.2.1694816116783; Fri, 15 Sep
 2023 15:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
In-Reply-To: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Fri, 15 Sep 2023 23:15:05 +0100
Message-ID: <CAKbZUD2r7e673gDF8un8vw4GAVgMLG=Lk7F0-HfK5Mz59Sxzxw@mail.gmail.com>
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sebastian Ott <sebott@redhat.com>,
        stable@vger.kernel.org
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

On Fri, Sep 15, 2023 at 4:54=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> When allocating the pages for bss the start address needs to be rounded
> down instead of up.
> Otherwise the start of the bss segment may be unmapped.
>
> The was reported to happen on Aarch64:
>
> Memory allocated by set_brk():
> Before: start=3D0x420000 end=3D0x420000
> After:  start=3D0x41f000 end=3D0x420000
>
> The triggering binary looks like this:
>
>     Elf file type is EXEC (Executable file)
>     Entry point 0x400144
>     There are 4 program headers, starting at offset 64
>
>     Program Headers:
>       Type           Offset             VirtAddr           PhysAddr
>                      FileSiz            MemSiz              Flags  Align
>       LOAD           0x0000000000000000 0x0000000000400000 0x000000000040=
0000
>                      0x0000000000000178 0x0000000000000178  R E    0x1000=
0
>       LOAD           0x000000000000ffe8 0x000000000041ffe8 0x000000000041=
ffe8
>                      0x0000000000000000 0x0000000000000008  RW     0x1000=
0
>       NOTE           0x0000000000000120 0x0000000000400120 0x000000000040=
0120
>                      0x0000000000000024 0x0000000000000024  R      0x4
>       GNU_STACK      0x0000000000000000 0x0000000000000000 0x000000000000=
0000
>                      0x0000000000000000 0x0000000000000000  RW     0x10
>
>      Section to Segment mapping:
>       Segment Sections...
>        00     .note.gnu.build-id .text .eh_frame
>        01     .bss
>        02     .note.gnu.build-id
>        03
>
> Reported-by: Sebastian Ott <sebott@redhat.com>
> Closes: https://lore.kernel.org/lkml/5d49767a-fbdc-fbe7-5fb2-d99ece3168cb=
@redhat.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>
> I'm not really familiar with the ELF loading process, so putting this
> out as RFC.
>
> A example binary compiled with aarch64-linux-gnu-gcc 13.2.0 is available
> at https://test.t-8ch.de/binfmt-bss-repro.bin
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 7b3d2d491407..4008a57d388b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -112,7 +112,7 @@ static struct linux_binfmt elf_format =3D {
>
>  static int set_brk(unsigned long start, unsigned long end, int prot)
>  {
> -       start =3D ELF_PAGEALIGN(start);
> +       start =3D ELF_PAGESTART(start);
>         end =3D ELF_PAGEALIGN(end);
>         if (end > start) {
>                 /*

I don't see how this change can be correct. set_brk takes the start of
.bss as the start, so doing ELF_PAGESTART(start) will give you what
may very well be another ELF segment. In the common case, you'd map an
anonymous page on top of someone's .data, which will misload the ELF.

The current logic looks OK to me (gosh this code would ideally take a
good refactoring...). I still can't quite tell how padzero() (in the
original report) is -EFAULTing though.

--=20
Pedro
