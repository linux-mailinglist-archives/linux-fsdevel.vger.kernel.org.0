Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42F21CD2AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEKHgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 03:36:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43167 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKHgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 03:36:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id g14so6750963otg.10;
        Mon, 11 May 2020 00:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3VY/12wWR1zHjOHzyqluXVdqy0F7FQQDSlqPm2Zx5o=;
        b=WISBKD8zngMa/sxm0rbjQnTv5eZowsRN0mqPKYfAyoVGuf57iuK9HextObXljasIu1
         l8oJdjM6c3m3bH3ip51ro3MrXqX+Dbq4iqcbO8pIqkinR7H06FB00VQq5R5eOXHBzU2u
         FhodXVKLiQIbYkHDhNNOaNBgcYewCz7rkPjPWOjJ24jNwEXZ3TG9BXqHiiEX8G+vXzdD
         e3QsK/IfU3Y1FXvIDkmGULb479xWExYdPQfGweXQrvEXiOYMgcTOhNyYtICMGfedvEbe
         rIOR3Leq83aN9UI99Bj6E68VMH+0ZNwbCac9lw2+oTNcrq+gEUYBf4t0uAhU5iHhDHS6
         eRSQ==
X-Gm-Message-State: AGi0PuYvtKik3pQqF7qOf4JdgswojWWBe6cmx6ssuL6OcwfH7ggKplmH
        zf7E0OdKufweCLggjPwtBOFJXF9Wrpjug7YvIRpgy1V6
X-Google-Smtp-Source: APiQypLU+moEt/plrIiBoDJtx6y9Ecp1jwHNmsr5IHgDhGkXTabpMRQH56iYz7dU/N/BpO7atrGAmOYhZDTTv1TixAM=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr11274742otm.145.1589182577008;
 Mon, 11 May 2020 00:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200510075510.987823-1-hch@lst.de> <20200510075510.987823-22-hch@lst.de>
In-Reply-To: <20200510075510.987823-22-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 May 2020 09:36:05 +0200
Message-ID: <CAMuHMdXS-ygT01KfhS0y9WcYbi9HKdQL7Q1HXgUZdayzQb_qSA@mail.gmail.com>
Subject: Re: [PATCH 21/31] mm: rename flush_icache_user_range to flush_icache_user_page
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 10, 2020 at 9:57 AM Christoph Hellwig <hch@lst.de> wrote:
> The function currently known as flush_icache_user_range only operates
> on a single page.  Rename it to flush_icache_user_page as we'll need
> the name flush_icache_user_range for something else soon.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/include/asm/cacheflush_mm.h  |  4 ++--
>  arch/m68k/mm/cache.c                   |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
