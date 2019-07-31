Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1345F7D143
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfGaWkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 18:40:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38416 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfGaWkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:40:37 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so20148417ioa.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2019 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=egRpxJBa9oK7OchDbNGXXbbAvoOMUOmZrCvbt5gO8zI=;
        b=QvM5gURgmBtYYb5ewAA6jGZY4ljdEgJDQkLHHqVikVD66zPlOj6SuWDfLaZFvi4LUF
         FQdJPeaP2xBSfu5VhEpovno9nnLQOcyhglyYB0pRP4JDwGr0eAqZbpbagc3uUt7s9USv
         Mpj2IzZzl+bJl5mUIlw221ntI2T0Gd3i5626L0lZpF3NQf2YbT9pIlRRSe+aFdedyfsu
         M2J7DASUn+cy4TT7B8G64SBFNLwKRalGaUFXLhzgYJLwUMSwiCHsd5R54xYkxPti/wZi
         C3bY3XL25Z5iZQrpq93tCxIGxwS4lBIYfZ/mctkv1io4wB2KYJZz7fo2JWv6xUDgj8Db
         lqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=egRpxJBa9oK7OchDbNGXXbbAvoOMUOmZrCvbt5gO8zI=;
        b=kxAvcUte4mmAu015ohrnrJtTy8gvloiZ++/c9j2CjT55HC5eYYeMhwdOEYIftkD3jT
         NS1Yw8k+XCptIdXevXnXI0fyTwery/oNT/77/YRYJ5PJTXf+cQ2luRXcBvfXRHzQKWF9
         Flj/H/ykgHliAx3UB/280b+K5nq5/tcXQLwRlDpnj0DQv8eGu2BiOJf3k7D/NohCb0d7
         eMOYd+6wmPuy2pwaVmfthdMCSkiu+58dcQfTFrpApf45JkEgXJoC+XIW2R3riHng5fif
         4/Wm69u+S0C8mvK4zloN1Q45sHKE0W+Pend2iCksej8FJRnyCUYeli5Xq0GI1PqO5Edc
         KIbQ==
X-Gm-Message-State: APjAAAWAQfrhqs1EEoqpR76EJZOxcUbJzyihYAeTTMi67s3vYwtSPW31
        Q9HwFAgU9Uuew+yaAbaCYJqKRw==
X-Google-Smtp-Source: APXvYqwrG00LBhTpDLsR7IvSvLbPRzUfGNUjyuov0y6Pr5JYCZwHs6hWm99dQiGbrjWMUvsaR2nw9Q==
X-Received: by 2002:a6b:f406:: with SMTP id i6mr44093290iog.110.1564612836637;
        Wed, 31 Jul 2019 15:40:36 -0700 (PDT)
Received: from localhost ([170.10.65.222])
        by smtp.gmail.com with ESMTPSA id a7sm56245658iok.19.2019.07.31.15.40.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 15:40:35 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:40:35 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alexandre Ghiti <alex@ghiti.fr>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 14/14] riscv: Make mmap allocation top-down by
 default
In-Reply-To: <20190730055113.23635-15-alex@ghiti.fr>
Message-ID: <alpine.DEB.2.21.9999.1907311538460.22372@viisi.sifive.com>
References: <20190730055113.23635-1-alex@ghiti.fr> <20190730055113.23635-15-alex@ghiti.fr>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 30 Jul 2019, Alexandre Ghiti wrote:

> In order to avoid wasting user address space by using bottom-up mmap
> allocation scheme, prefer top-down scheme when possible.
> 
> Before:
> root@qemuriscv64:~# cat /proc/self/maps
> 00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
> 00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
> 00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
> 00018000-00039000 rw-p 00000000 00:00 0          [heap]
> 1555556000-155556d000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
> 155556d000-155556e000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
> 155556e000-155556f000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
> 155556f000-1555570000 rw-p 00000000 00:00 0
> 1555570000-1555572000 r-xp 00000000 00:00 0      [vdso]
> 1555574000-1555576000 rw-p 00000000 00:00 0
> 1555576000-1555674000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
> 1555674000-1555678000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
> 1555678000-155567a000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
> 155567a000-15556a0000 rw-p 00000000 00:00 0
> 3fffb90000-3fffbb1000 rw-p 00000000 00:00 0      [stack]
> 
> After:
> root@qemuriscv64:~# cat /proc/self/maps
> 00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
> 00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
> 00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
> 2de81000-2dea2000 rw-p 00000000 00:00 0          [heap]
> 3ff7eb6000-3ff7ed8000 rw-p 00000000 00:00 0
> 3ff7ed8000-3ff7fd6000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fd6000-3ff7fda000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fda000-3ff7fdc000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fdc000-3ff7fe2000 rw-p 00000000 00:00 0
> 3ff7fe4000-3ff7fe6000 r-xp 00000000 00:00 0      [vdso]
> 3ff7fe6000-3ff7ffd000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
> 3ff7ffd000-3ff7ffe000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
> 3ff7ffe000-3ff7fff000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
> 3ff7fff000-3ff8000000 rw-p 00000000 00:00 0
> 3fff888000-3fff8a9000 rw-p 00000000 00:00 0      [stack]
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv

As Alex notes, this patch depends on "[PATCH] riscv: kbuild: add virtual 
memory system selection":

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1907301218560.3486@viisi.sifive.com/T/#t

which will likely go up during v5.3-rc.


- Paul
