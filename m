Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21201C54AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgEELpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 07:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728608AbgEELpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 07:45:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CCFC061A41
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 04:45:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so1242763ljg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIfWdRq9yyjwaPNLBB1WhcLPviYtpHs1y/6Em0UoQzc=;
        b=N4hxmyzj9lyf6o8bph0ivG/R3yiX7+7av0Z3hbRgE3G1P9nJfWcbLP48L+DmBUPdRL
         iS7tdHnci9lYc5jibCU27M9cIyiBouV3TGfHBxmomzZlTAA+K4jvmlfO+0PUY5gOJwWk
         INzBNV9RdyU4hz+KA3qMcbJKjE4Nef1pYkIpykiFiNhgkJ8IjX1SCD4/KaX9gsrjw7UM
         PqB5v5UISICWvKpUwJeHeWlT+kuUlYh2Fy7unW4FPr071vxBMvN/2bqL0KNaC/NHAxF/
         T4cTLz3YQkpT0ozMLHkIMjfiTRUu5z91/BjdSvFzNbqdymSh9Jx5aHZO1PEyCLvLAOi3
         ZMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIfWdRq9yyjwaPNLBB1WhcLPviYtpHs1y/6Em0UoQzc=;
        b=PqNgEX+r9XVXtS6L/N3roZT8LqhdplyDVsKFDEMl9WkXm1V1vt7lG9gs+uZr3PXkk7
         acoZbU8s0erEMmigeg4tUaGm13pepdGpWkp+8nO3IpElbLnYkvnEfn2nyYDVZ9ubW1CO
         RJrvTUMXxhykckQs8GiQTmt5fHITMtny1HPw95Q+44LkvDPv8pPYi2AE4KM3AlWH2mbU
         j3wn3ySeifg/GkQ2KvnkBLFA26PgupfidtPXJDFvU5lg6BgdG5xTnvRG5A0lCR5AnIcE
         YmpOdBmD6A2Z5MMbgmYI7T2jPv6XFG21v3MJH1kcQCWL5TnCBUJHBslknaX4T1vM+QoE
         AD5Q==
X-Gm-Message-State: AGi0PuZNqRcuNEsROZbHk1M/3KcftkjhlWToUOTre55BjW4PT+MJ0f7J
        RcmP8nuspG/fvt+21N+Ko+PRdqndvyNkuTbOItMbcg==
X-Google-Smtp-Source: APiQypJYtnxQWEbjes9DIO+nQO7CpHNG6KYJaneU9CBZe2/UNds1SHP++W+raV03+mh53wSUVZj+nsFewgw6YpANntc=
X-Received: by 2002:a2e:b17a:: with SMTP id a26mr1481524ljm.215.1588679100508;
 Tue, 05 May 2020 04:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com> <20200429214954.44866-4-jannh@google.com>
 <20200505105023.GB17400@lst.de>
In-Reply-To: <20200505105023.GB17400@lst.de>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 May 2020 13:44:34 +0200
Message-ID: <CAG48ez26DT2v7QQEbbur8LL+tQskrTBLCW+eW__RTOpezte6rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] coredump: Refactor page range dumping into common helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 12:50 PM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Apr 29, 2020 at 11:49:52PM +0200, Jann Horn wrote:
> > Both fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c need to dump ranges of pages
> > into the coredump file. Extract that logic into a common helper.
> >
> > Any other binfmt that actually wants to create coredumps will probably need
> > the same function; so stop making get_dump_page() depend on
> > CONFIG_ELF_CORE.
>
> Why is the #ifdef CONFIG_ELF_CORE in gup.c removed when the only
> remaining caller is under the same ifdef?

Oh, whoops, good point - I should go put that back.
