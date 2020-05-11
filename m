Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1221CD328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgEKHqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 03:46:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46070 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKHqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 03:46:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id k133so14121675oih.12;
        Mon, 11 May 2020 00:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yJ6ElOmiCSyE9da4JBaYJBkgTCIAd7AfbCRMY3E6sk=;
        b=CYgJuZ4uypKOO7akrvDzrgeG0+luXAu1rsayCe7ORe03spcvQoouZAZ/hHAgv7GsLE
         VBazfrnHjJcMVRdaOELsqm3jifzqBc8lUnUEFayOlgAknCldcC1ptX79Yvo64k9WqowY
         DIc8WbEKalmQp5v18VAIrdinyB9NKhcWzoR/I2fAE0ULy6jb/jDSlCDAkqaa/vTOXUsY
         HlZUNUqhUIuq9h6+ICTMpW7lFA8IbDXh8NhdQOw+JSu7a+iMVmLrb5PEFFDz9PXFheTb
         70/4Fo3h7g18VpCdhUNkflqBUShF4Gw4uRQiJ4Eqnn0LRKkYxREciR1our9j17AZqlg3
         +zOw==
X-Gm-Message-State: AGi0PuZ8VV4gxFIxHnJJ1huBFN2IEXztT1MSIbYFPCT5oknAUEs9XMep
        PEx9CL1Fz1d8zXffLbr0uRFi2VBGyhjapyPxuJk=
X-Google-Smtp-Source: APiQypIoFxa7a3EUthZ/8xx0aZ//Vc0pDLpqFY6DB0zkXv6WP4wkoKn8ne3ghzK30RcpwYDHtmi30TMFV3MiIELEMLg=
X-Received: by 2002:aca:895:: with SMTP id 143mr18042949oii.153.1589183188927;
 Mon, 11 May 2020 00:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200510075510.987823-1-hch@lst.de>
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 May 2020 09:46:17 +0200
Message-ID: <CAMuHMdXazsBw0mjJd0uFHQud7qbb5-Uw-PTDB3+-M=huRWOfgQ@mail.gmail.com>
Subject: Re: sort out the flush_icache_range mess
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Michal Simek <monstr@monstr.eu>,
        Jessica Yu <jeyu@kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        alpha <linux-alpha@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Sun, May 10, 2020 at 9:55 AM Christoph Hellwig <hch@lst.de> wrote:
> none of which really are used by a typical MMU enabled kernel, as a.out can
> only be build for alpha and m68k to start with.

Quoting myself:
"I think it's safe to assume no one still runs a.out binaries on m68k."
http://lore.kernel.org/r/CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
