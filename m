Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E84A723D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 14:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344510AbiBBNwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 08:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344541AbiBBNwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:52:44 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9CC06173D;
        Wed,  2 Feb 2022 05:52:43 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id z15so12618252vkp.13;
        Wed, 02 Feb 2022 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrtQqWd/LgMqmSVv1/9+8qzI7p+FENvHBb0XUxBtq6w=;
        b=XfFSyenWWCOxiPR7sd8wyA4pPwSRw8+E3dLJJih/ci/kin16nIYX+qoRIvVq+m910L
         YQ9g0+GU/sLeb4iDfoNnTBULoRsUsqi5h5DOBZHD7HfKjv0V2uyTgCl9pzn8Y/8jpOG1
         a0R3nwg8UBr0etMbL46X29gJKRlJfwOSq/cbttOu5NZez03qZDnsjAd0nnYQr3qsMbYG
         GsFGVfqPH8EhgjW/IsNMTNJbBUGMdF1al9YWZC5KR6N1Qh2DMJfzfbDU6hPuQv4unqY2
         B6Sh83rbXkx7jGG8QJbS5oKyIed94fQ90muJbMRbznowqLqI6oeSt83PQYscys0hCIn3
         uMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrtQqWd/LgMqmSVv1/9+8qzI7p+FENvHBb0XUxBtq6w=;
        b=AYNUgoc6Omn/StoDT/pik2BWVopOYzKg6Txf75baa/Wegbv3xtYlG4GJa79v9ovl+n
         jvSHuZMdhWwzRjgJCxk2wCA0/sENdEykHJ9vCweT5c7sjAbg/3jViNUgg+0L6yBgjSbj
         StiZuMJihTXbQ0vc+aP4ffIAQrN1VIsf7QKOY6fJc+NaRmuvkCsfllHjXf/Hxc9cyUJz
         Tgwfvtj2ztk0a87VlPnWkEw2X7f0P2NvP0BkXFosqAiVCl1chAgMATOhSecS0cpPfaOx
         bIeu8Eo4y6f8giMLnPpYL+ueOAVESjWq3Sk2uFy0PRbLAeRKUlO1SGavblwerYm5uB1k
         l7uw==
X-Gm-Message-State: AOAM530Zp5ijXLsPPq7InSi95hsEpNR+UfiSdx6R7cCuW5mgc3UVhBFe
        /iJXW+cTk8wz7A/JjUE6W+WGrJDDyaS/NefAJg==
X-Google-Smtp-Source: ABdhPJxaKYpd6bp0XEgE4Lw/o/AGJQ7X8tYz0IBqU2gzTTaQ6Qdf2jLZ9HyPic3+C6dbllXnvjhL1NWc9/H08T3U4YY=
X-Received: by 2002:a1f:aace:: with SMTP id t197mr12740476vke.36.1643809962517;
 Wed, 02 Feb 2022 05:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20220202121433.3697146-1-rppt@kernel.org>
In-Reply-To: <20220202121433.3697146-1-rppt@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 2 Feb 2022 13:52:31 +0000
Message-ID: <CALjTZvZiEOtVcpTm+fgAvCB6T88GzbGEZcdrQ77MLD7hJnnJ9w@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf: fix PT_LOAD p_align values for loaders
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Mike,

On Wed, 2 Feb 2022 at 12:14, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Rui Salvaterra reported that Aisleroit solitaire crashes with "Wrong
> __data_start/_end pair" assertion from libgc after update to v5.17-rc1.
>
> Bisection pointed to commit 9630f0d60fec ("fs/binfmt_elf: use PT_LOAD
> p_align values for static PIE") that fixed handling of static PIEs, but
> made the condition that guards load_bias calculation to exclude loader
> binaries.
>
> Restoring the check for presence of interpreter fixes the problem.
>
> Fixes: 9630f0d60fec ("fs/binfmt_elf: use PT_LOAD p_align values for static PIE")
> Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 605017eb9349..9e11e6f13e83 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1117,7 +1117,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                          * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
>                          */
>                         alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
> -                       if (alignment > ELF_MIN_ALIGN) {
> +                       if (interpreter || alignment > ELF_MIN_ALIGN) {
>                                 load_bias = ELF_ET_DYN_BASE;
>                                 if (current->flags & PF_RANDOMIZE)
>                                         load_bias += arch_mmap_rnd();
> --
> 2.34.1
>

The patch does fix the problem for me, and is thus

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks,
Rui
