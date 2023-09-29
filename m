Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F260C7B31DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjI2L6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjI2L6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:58:32 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D42A1B4;
        Fri, 29 Sep 2023 04:58:30 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7abbe1067d1so4256329241.0;
        Fri, 29 Sep 2023 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695988709; x=1696593509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGtvKe2G8zhEWEUoqeoOHZOQEydFRztgt+R9qFXT7kA=;
        b=kQCna8pkOnFqOaaHLU/6nHn0BHv7oUal67gqsKNglZZgOGetOCgjkGjByaYfYe0H2e
         5INFSWfjXJsKcvXMVuCgZBoqax+ImJMu4uAOdlhttumvYGx4Nf4E4OqK20NVHtthA1Oy
         kyN28uEDyFDJvRhCb3lBISnI1KQkGc/0UZHJcmMjiahA/e+P0k9CGtMbDjJg+i15ccRt
         8hPS+gaW72NRmW/ef8+jVxz9g3xXe5FmMZpcOLHz2XR2eOCpqpwRbTvfMlEQB3DBwUFs
         TPe5HlEpJ0f9XWEIaDYe/htK4BkLEIUn3fiq5H+yB7PYVjRvBFKiH3rdsbthBKe8MJCy
         T75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695988709; x=1696593509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGtvKe2G8zhEWEUoqeoOHZOQEydFRztgt+R9qFXT7kA=;
        b=U0UBNPD7365uU3xFXhvLEArkO14OHzGX4VG4cua0uy+nw5iDalgijboQQSE9wAlS8f
         w3VncA2vG28JZL4CvVcnlfq7YpLRWvUq6O//H4czBJ9hYxs31PSKbpIqC5tAstlLtfeg
         LaQ5/AAu6xs6tOM48segsAU4x+9Z0NSUSWObdzCNwZZx4KG4CgcJd9wsk+9hr9aKNGXk
         XEPGmenEbn3HTAV22Eb/Z4d8OT9ckOMZAYmOmrQklIrsVOSjLTL8KlQyamtE9K+2Q5SD
         UdqXBpNe9Xs0A8hONLOG7AoRkz7jzXGtN8o0BgDLK63r83JzM8WRC4TZyropQX2ChnHA
         IVYQ==
X-Gm-Message-State: AOJu0YyYb9AG398rIufPOXUDgBSjOIBhXKp5pM09W10F7VRrXuQbZ2ec
        du58QPFIeaBWwz6jLK5210sm3Wx4txuTfk7x8z8=
X-Google-Smtp-Source: AGHT+IGMMN6s4OUwobMuA4Eoln5lK/Dv0G+T3lg6T4TSgvSyTkPusHq5nf34rqmXYh4plgnMzGUopqnDq7aGYRrUioY=
X-Received: by 2002:a67:e9ca:0:b0:44d:4dd6:796b with SMTP id
 q10-20020a67e9ca000000b0044d4dd6796bmr3819884vso.15.1695988709517; Fri, 29
 Sep 2023 04:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230929031716.it.155-kees@kernel.org>
In-Reply-To: <20230929031716.it.155-kees@kernel.org>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Fri, 29 Sep 2023 12:58:18 +0100
Message-ID: <CAKbZUD3dxYqb4RSnXFs9ehWymXe15pt8ra232WAD_msJsBF_BQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] binfmt_elf: Support segments with 0 filesz and
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
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 4:24=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Hi,
>
> This is the continuation of the work Eric started for handling
> "p_memsz > p_filesz" in arbitrary segments (rather than just the last,
> BSS, segment). I've added the suggested changes:
>
>  - drop unused "elf_bss" variable
>  - refactor load_elf_interp() to use elf_load()
>  - refactor load_elf_library() to use elf_load()
>  - report padzero() errors when PROT_WRITE is present
>  - drop vm_brk()
>
> Thanks!
>
> -Kees
>
> v4:
>  - refactor load_elf_library() too
>  - don't refactor padzero(), just test in the only remaining caller
>  - drop now-unused vm_brk()
> v3: https://lore.kernel.org/all/20230927033634.make.602-kees@kernel.org
> v2: https://lore.kernel.org/lkml/87sf71f123.fsf@email.froward.int.ebieder=
m.org
> v1: https://lore.kernel.org/lkml/87jzsemmsd.fsf_-_@email.froward.int.ebie=
derm.org
>
> Eric W. Biederman (1):
>   binfmt_elf: Support segments with 0 filesz and misaligned starts
>
> Kees Cook (5):
>   binfmt_elf: elf_bss no longer used by load_elf_binary()
>   binfmt_elf: Use elf_load() for interpreter
>   binfmt_elf: Use elf_load() for library
>   binfmt_elf: Only report padzero() errors when PROT_WRITE
>   mm: Remove unused vm_brk()
>
>  fs/binfmt_elf.c    | 214 ++++++++++++++++-----------------------------
>  include/linux/mm.h |   3 +-
>  mm/mmap.c          |   6 --
>  mm/nommu.c         |   5 --
>  4 files changed, 76 insertions(+), 152 deletions(-)

Sorry for taking so long to take a look at this.
While I didn't test PPC64 (I don't own PPC64 hardware, and I wasn't
the original reporter), I did manage to craft a reduced test case of:

a.out:

Program Headers:
 Type           Offset             VirtAddr           PhysAddr
                FileSiz            MemSiz              Flags  Align
 PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
                0x00000000000001f8 0x00000000000001f8  R      0x8
 INTERP         0x0000000000000238 0x0000000000000238 0x0000000000000238
                0x0000000000000020 0x0000000000000020  R      0x1
     [Requesting program interpreter: /home/pfalcato/musl/lib/libc.so]
 LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                0x0000000000000428 0x0000000000000428  R      0x1000
 LOAD           0x0000000000001000 0x0000000000001000 0x0000000000001000
                0x00000000000000cd 0x00000000000000cd  R E    0x1000
 LOAD           0x0000000000002000 0x0000000000002000 0x0000000000002000
                0x0000000000000084 0x0000000000000084  R      0x1000
 LOAD           0x0000000000002e50 0x0000000000003e50 0x0000000000003e50
                0x00000000000001c8 0x00000000000001c8  RW     0x1000
 DYNAMIC        0x0000000000002e50 0x0000000000003e50 0x0000000000003e50
                0x0000000000000180 0x0000000000000180  RW     0x8
 GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                0x0000000000000000 0x0000000000000000  RW     0x10
 GNU_RELRO      0x0000000000002e50 0x0000000000003e50 0x0000000000003e50
                0x00000000000001b0 0x00000000000001b0  R      0x1

/home/pfalcato/musl/lib/libc.so:
Program Headers:
 Type           Offset             VirtAddr           PhysAddr
                FileSiz            MemSiz              Flags  Align
 PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
                0x0000000000000230 0x0000000000000230  R      0x8
 LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                0x0000000000049d9c 0x0000000000049d9c  R      0x1000
 LOAD           0x0000000000049da0 0x000000000004ada0 0x000000000004ada0
                0x0000000000057d30 0x0000000000057d30  R E    0x1000
 LOAD           0x00000000000a1ad0 0x00000000000a3ad0 0x00000000000a3ad0
                0x00000000000005f0 0x00000000000015f0  RW     0x1000
 LOAD           0x00000000000a20c0 0x00000000000a60c0 0x00000000000a60c0
                0x0000000000000428 0x0000000000002f80  RW     0x1000
 DYNAMIC        0x00000000000a1f38 0x00000000000a3f38 0x00000000000a3f38
                0x0000000000000110 0x0000000000000110  RW     0x8
 GNU_RELRO      0x00000000000a1ad0 0x00000000000a3ad0 0x00000000000a3ad0
                0x00000000000005f0 0x0000000000002530  R      0x1
 GNU_EH_FRAME   0x0000000000049d10 0x0000000000049d10 0x0000000000049d10
                0x0000000000000024 0x0000000000000024  R      0x4
 GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                0x0000000000000000 0x0000000000000000  RW     0x0
 NOTE           0x0000000000000270 0x0000000000000270 0x0000000000000270
                0x0000000000000018 0x0000000000000018  R      0x4

Section to Segment mapping:
 Segment Sections...
  00
  01     .note.gnu.build-id .dynsym .gnu.hash .hash .dynstr .rela.dyn
.rela.plt .rodata .eh_frame_hdr .eh_frame
  02     .text .plt
  03     .data.rel.ro .dynamic .got .toc
  04     .data .got.plt .bss
  05     .dynamic
  06     .data.rel.ro .dynamic .got .toc
  07     .eh_frame_hdr
  08
  09     .note.gnu.build-id


So on that end, you can take my

Tested-by: Pedro Falcato <pedro.falcato@gmail.com>

Although this still doesn't address the other bug I found
(https://github.com/heatd/elf-bug-questionmark), where segments can
accidentally overwrite cleared BSS if we end up in a situation where
e.g we have the following segments:

Program Headers:
 Type           Offset             VirtAddr           PhysAddr
                FileSiz            MemSiz              Flags  Align
 LOAD           0x0000000000001000 0x0000000000400000 0x0000000000400000
                0x0000000000000045 0x0000000000000045  R E    0x1000
 LOAD           0x0000000000002000 0x0000000000401000 0x0000000000401000
                0x000000000000008c 0x000000000000008c  R      0x1000
 LOAD           0x0000000000000000 0x0000000000402000 0x0000000000402000
                0x0000000000000000 0x0000000000000801  RW     0x1000
 LOAD           0x0000000000002801 0x0000000000402801 0x0000000000402801
                0x0000000000000007 0x0000000000000007  RW     0x1000
 NOTE           0x0000000000002068 0x0000000000401068 0x0000000000401068
                0x0000000000000024 0x0000000000000024         0x4

Section to Segment mapping:
 Segment Sections...
  00     .text
  01     .rodata .note.gnu.property .note.gnu.build-id
  02     .bss
  03     .data
  04     .note.gnu.build-id

since the mmap of .data will end up happening over .bss.

--=20
Pedro
