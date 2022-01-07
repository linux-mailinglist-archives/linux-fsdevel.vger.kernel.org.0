Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8549487327
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 07:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiAGGlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 01:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiAGGlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 01:41:02 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5293C061245;
        Thu,  6 Jan 2022 22:41:01 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o185so1110239ybc.12;
        Thu, 06 Jan 2022 22:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uft5SNmCUYH/4LsuZcNHSZqtW5wt4J0g/joxJK/IOOc=;
        b=BYcBYUWKdfwX2cIp/9B3Lh+01mGBKcOL6zrXIuF74WaMVm6jXkQAVk/sTP/DjUb3XR
         oHOlupyFT4PDvH09jEFQ0xp/buGhbo+HDqenSlYPyis/yuI917iu+xNZ7joeBlC4xoXs
         QKuHWLiy8RdGBRgTwzwkh6fsOQ74Jhc5WvnNImcPcZOfvxarl8wyG1oonhWCepZWPZmP
         xsYOv7N3k6wuuQ0igqdpFW5zbwWIwe//hVhYuCTZKwn9uHuQlBv6uKcAuVs4VeM6Opze
         nAh+o5B15QdYtDx/+zA9poaRTJ32i5uVxYjYJPTnc69XjKZHcBeornANNuPIQ+ZzwAR0
         SaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uft5SNmCUYH/4LsuZcNHSZqtW5wt4J0g/joxJK/IOOc=;
        b=xQ6LdV9tTA+ANXd8hu/Zuk4+GVZzIVtx/6A3IpktCh+7FLgGsm2MdPg9viqAQUXyCH
         vV5sSr8Ex+T1dW01x9+nD8cIqmpCLhGAn7b83JlO0SSh5/o+oVy7mftCaDf2r/jziVvw
         l9dT6vXBNq1NamYzLjxUh48Z/K4bBvatayivIL7S57ERD9bV3gTzXZxViAAjiwaVq6jV
         sEqm9Ix5PWagj9ADmOqQyHpqMgAFmOsYT7c6JSo3ZUXtf/yR7hfqG+x2+QWua76UHPsC
         qRj5QlRAHwFemDHzv3jjyU85y/mZmo6gqB0u3sUxTMDSYxen09A/+iSmXZVmWzcNKT93
         pwXw==
X-Gm-Message-State: AOAM533WhjY7Q3KPtRXcpQb+bOLZw41zFRMgPRMH1eqnMDiFXc5DkKEg
        immTzDaZnw/5H7W/xsPoWcZCpPHfK1x+Qp5LNVE=
X-Google-Smtp-Source: ABdhPJx999Drhi+3awoScOG1JFjBCWxkktxoQrLaxkoATFE7C2HzJ2Gr61gd1O06Yvbc85LPaG2bBWvj7JfRpXr2p3o=
X-Received: by 2002:a25:2cd0:: with SMTP id s199mr66404026ybs.234.1641537661030;
 Thu, 06 Jan 2022 22:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20220106232513.143014-1-akirakawata1@gmail.com>
In-Reply-To: <20220106232513.143014-1-akirakawata1@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 7 Jan 2022 07:40:50 +0100
Message-ID: <CAKXUXMwzULZHmfx5T74cjG++gd8mFKVOR7Z4aS8RabKnXWGOdQ@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND 0/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 7, 2022 at 12:25 AM Akira Kawata <akirakawata1@gmail.com> wrote:
>
>  These patches fix a bug in AT_PHDR calculation.
>
>  We cannot calculate AT_PHDR as the sum of load_addr and exec->e_phoff.
>  This is because exec->e_phoff is the offset of PHDRs in the file and the
>  address of PHDRs in the memory may differ from it. These patches fix the
>  bug by calculating the address of program headers from PT_LOADs
>  directly.
>
>  Sorry for my latency.
>
>  Changes in v4
>  - Reflecting comments from Lukas, add a refactoring commit.
>

Thanks for removing the dead store with your refactoring as a small
stylistic change, but I really think that Kees Cook's comment that you
simply removed an important feature is much more important to address.
There was no reply to that and it seems that Kees hypothesis that the
feature has been removed, was not questioned by anyone.

Lukas

>  Changes in v3:
>  - Fix a reported bug from kernel test robot.
>
>  Changes in v2:
>  - Remove unused load_addr from create_elf_tables.
>  - Improve the commit message. *** SUBJECT HERE ***
>
> Akira Kawata (2):
>   fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
>   fs/binfmt_elf: Refactor load_elf_binary function
>
>  fs/binfmt_elf.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
>
> base-commit: 4eee8d0b64ecc3231040fa68ba750317ffca5c52
> --
> 2.25.1
>
