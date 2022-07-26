Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150DB580FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiGZJUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 05:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiGZJUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:20:52 -0400
X-Greylist: delayed 1005 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Jul 2022 02:20:50 PDT
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD41AB7CA;
        Tue, 26 Jul 2022 02:20:50 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 26Q9KV9H010717;
        Tue, 26 Jul 2022 18:20:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 26Q9KV9H010717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658827233;
        bh=jAi6WIE7Ga+hcpDaT8/hAmVlh1UhlLzNBX+v4tGhP00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nmy2A4QfWNhePEWIy7C8WjY/4QoqASlvJ/ml8ZTAS487jA63hyBgmTWD+cUyBqWoi
         TdRA5S8vMiB9KOJB0ukHdJZ5Fz351MS6xliy/kUsa+v8QoRSx1lBe+uNoRNaCl10id
         y9iZiVgT3OjG6LMB11O5d4P811LokbhjiPCS2KKzP0tvYoxagbyqbq4G70YJjQgvUA
         2t8nrrg0HF+FgRu97wm6RgkmI4fCTlwmg/XLnRkIhuKb+g1PYK91B075AnCFuCbspV
         xW5S+yTA0ZPapHjuKTYXrdeOaYcSJ/TBFuIhMsNGud6TyFYf967gOn8VbKC644PmkS
         yKGDxKY5rGXjA==
X-Nifty-SrcIP: [209.85.221.51]
Received: by mail-wr1-f51.google.com with SMTP id q18so8856778wrx.8;
        Tue, 26 Jul 2022 02:20:32 -0700 (PDT)
X-Gm-Message-State: AJIora/3HUUFm/n+ADGF9KMfiS4lNyPPiDIsZJHtwdaCf6ZPkmYsdUmu
        xBJqbdk+S4Xw8uXD6YgqSLO2Fll7eHR2PE/R6gI=
X-Google-Smtp-Source: AGRyM1t7Kx1C0baN6EjA6pV/hItVqT8bfpSoFu2GvJ+9FcfpvUAVrsBlpJhaNkd0uIBUN/R3V6tPG8wlmWbVz3uncl0=
X-Received: by 2002:a5d:50c4:0:b0:21e:8776:bb95 with SMTP id
 f4-20020a5d50c4000000b0021e8776bb95mr6011589wrt.461.1658827230909; Tue, 26
 Jul 2022 02:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220722022416.137548-1-mfo@canonical.com> <20220722022416.137548-3-mfo@canonical.com>
In-Reply-To: <20220722022416.137548-3-mfo@canonical.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Jul 2022 18:19:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTN55RE18vXjMuAUO37kMeawBD4G=UcS6_j7U0asCZEA@mail.gmail.com>
Message-ID: <CAK7LNARTN55RE18vXjMuAUO37kMeawBD4G=UcS6_j7U0asCZEA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] modpost: deduplicate section_rel[a]()
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:24 AM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
>
> Now both functions are almost identical, and we can again generalize
> the relocation types Elf_Rela/Elf_Rel with Elf_Rela, and handle some
> differences with conditionals on section header type (SHT_RELA/REL).
>
> The important bit is to make sure the loop increment uses the right
> size for pointer arithmethic.
>
> The original reason for split functions to make program logic easier
> to follow; commit 5b24c0715fc4 ("kbuild: code refactoring in modpost").
>
> Hopefully these 2 commits may help improving that, without an impact
> in understanding the code due to generalization of relocation types.
>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> ---
>  scripts/mod/modpost.c | 61 ++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 38 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 4c1038dccae0..d1ed67fa290b 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1794,63 +1794,49 @@ static int get_relx_sym(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *rela,
>         return 0;
>  }
>
> -static void section_rela(const char *modname, struct elf_info *elf,
> +/* The caller must ensure sechdr->sh_type == SHT_RELA or SHT_REL. */
> +static void section_relx(const char *modname, struct elf_info *elf,
>                          Elf_Shdr *sechdr)
>  {
>         Elf_Sym  *sym;
> -       Elf_Rela *rela;
> +       Elf_Rela *relx; /* access .r_addend in SHT_RELA _only_! */
>         Elf_Rela r;
> +       size_t relx_size;
>         const char *fromsec;
>
>         Elf_Rela *start = (void *)elf->hdr + sechdr->sh_offset;
>         Elf_Rela *stop  = (void *)start + sechdr->sh_size;
>
>         fromsec = sech_name(elf, sechdr);
> -       fromsec += strlen(".rela");
> +       if (sechdr->sh_type == SHT_RELA) {
> +               relx_size = sizeof(Elf_Rela);
> +               fromsec += strlen(".rela");
> +       } else if (sechdr->sh_type == SHT_REL) {
> +               relx_size = sizeof(Elf_Rel);
> +               fromsec += strlen(".rel");
> +       } else {
> +               error("%s: [%s.ko] not relocation section\n", fromsec, modname);


Nit.

modname already contains the suffix  ".o".

For vmlinux, the error message will print like this:
[vmlinux.o.ko]





> +               return;
> +       }
> +
>         /* if from section (name) is know good then skip it */
>         if (match(fromsec, section_white_list))
>                 return;
>
> -       for (rela = start; rela < stop; rela++) {
> -               if (get_relx_sym(elf, sechdr, rela, &r, &sym))
> +       for (relx = start; relx < stop; relx = (void *)relx + relx_size) {
> +               if (get_relx_sym(elf, sechdr, relx, &r, &sym))
>                         continue;
>
>                 switch (elf->hdr->e_machine) {
>                 case EM_RISCV:
> -                       if (!strcmp("__ex_table", fromsec) &&
> +                       if (sechdr->sh_type == SHT_RELA &&
> +                           !strcmp("__ex_table", fromsec) &&
>                             ELF_R_TYPE(r.r_info) == R_RISCV_SUB32)
>                                 continue;
>                         break;
>                 }
>
> -               if (is_second_extable_reloc(start, rela, fromsec))
> -                       find_extable_entry_size(fromsec, &r);
> -               check_section_mismatch(modname, elf, &r, sym, fromsec);
> -       }
> -}
> -
> -static void section_rel(const char *modname, struct elf_info *elf,
> -                       Elf_Shdr *sechdr)
> -{
> -       Elf_Sym *sym;
> -       Elf_Rel *rel;
> -       Elf_Rela r;
> -       const char *fromsec;
> -
> -       Elf_Rel *start = (void *)elf->hdr + sechdr->sh_offset;
> -       Elf_Rel *stop  = (void *)start + sechdr->sh_size;
> -
> -       fromsec = sech_name(elf, sechdr);
> -       fromsec += strlen(".rel");
> -       /* if from section (name) is know good then skip it */
> -       if (match(fromsec, section_white_list))
> -               return;
> -
> -       for (rel = start; rel < stop; rel++) {
> -               if (get_relx_sym(elf, sechdr, (Elf_Rela *)rel, &r, &sym)
> -                       continue;
> -
> -               if (is_second_extable_reloc(start, rel, fromsec))
> +               if (is_second_extable_reloc(start, relx, fromsec))
>                         find_extable_entry_size(fromsec, &r);
>                 check_section_mismatch(modname, elf, &r, sym, fromsec);
>         }
> @@ -1877,10 +1863,9 @@ static void check_sec_ref(const char *modname, struct elf_info *elf)
>         for (i = 0; i < elf->num_sections; i++) {
>                 check_section(modname, elf, &elf->sechdrs[i]);
>                 /* We want to process only relocation sections and not .init */
> -               if (sechdrs[i].sh_type == SHT_RELA)
> -                       section_rela(modname, elf, &elf->sechdrs[i]);
> -               else if (sechdrs[i].sh_type == SHT_REL)
> -                       section_rel(modname, elf, &elf->sechdrs[i]);
> +               if (sechdrs[i].sh_type == SHT_RELA ||
> +                   sechdrs[i].sh_type == SHT_REL)
> +                       section_relx(modname, elf, &elf->sechdrs[i]);
>         }
>  }
>
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
