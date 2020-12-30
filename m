Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F42E7A91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgL3PpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 10:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgL3PpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:45:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957EC06179B
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Dec 2020 07:44:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id p22so15730461edu.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Dec 2020 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hBnQDw081gPYRJZ5sSOQpvtWrIndiY9aAJP6hoGoCI=;
        b=jF9zBs3u6j4Qo5O+462fi/y8Z3H2Rg/kS494qsVJ1AZwXnP4CZKBWtNfWVC4M+XY2L
         a4QSfGMk/T0BX8WKgAXjGmwlhjMR7jUfuM2MJMUhMMzVoz9BLvH3vgISA3wl+9ipOCg7
         0Qetw+q4d2hE88fpkR4idIMOjFu7r0tivYhG8TVkhRtIgbM86B8C7RpW5EP6KPEYDHtC
         vItSy1oO9aljOyRk1izLO06eG2w4wHJ+0sSw2J77SK31m7y6YeOFi1L64eSfXn/5DXnp
         hbTTEwqrK98bNoVh9B93pHxvRkTOtAv++3QeaGy3wk9I8XYNKJVnZC34WbIzngDe6Wgn
         Is7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hBnQDw081gPYRJZ5sSOQpvtWrIndiY9aAJP6hoGoCI=;
        b=tRCfUr7naJjnshCk5w1biOhktFCX8ohXlQqlT1di6ax8LxM7zvXxXNuia1gAF//wD0
         OrzCGJupuz/kSsTlazoXrtUYRaIMq9GG4/NTojND8rVhnbWh9nrZx4Qa14ZcwIidG4O5
         r/NGBI4IqhK/G4DBJQ7RTrzm1O7EeDkOJTnxzGsw4Ol5/pEKicPqV8Ll7jkPJN/HEFfK
         Ad5Wtvkv/APdWGcQaGLal0rSG73mHCoerAWaOZVWhElkpcmIHfH5Npjjcmw35hBoURBY
         UD9NFf23XajR9nl8po+Y0enR9fPhZz09sFiOexvcMnBZ5FTc13Gm4q8HfUlZp8JyOVdo
         kjNA==
X-Gm-Message-State: AOAM531ktSyPK2NQ+e6qLp50XE4Ym5jzZWdhdTfr4or1OrjTkzBZgBK0
        5zf8MOkDx+ILKOTumXN+faWFFqCc+dedI3cBTA7ruQ==
X-Google-Smtp-Source: ABdhPJzdhrxVcS8QaW5SwjUUsVlQzNcZNKy+323jJeGcsyxbQ7R92UwEPNUX1N2RLnmmTIXQIt78Z+E0q7QwZmHhaZE=
X-Received: by 2002:a50:b5c5:: with SMTP id a63mr50773533ede.227.1609343058152;
 Wed, 30 Dec 2020 07:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20201013013416.390574-1-dima@arista.com> <20201013013416.390574-3-dima@arista.com>
 <CADyq12y4WAjT7O3_4E3FmBv4dr5fY6utQZod1UN0Xv8PhOAnQA@mail.gmail.com> <d25ad10c-6f67-8c11-18c3-0193b8ea14c4@arista.com>
In-Reply-To: <d25ad10c-6f67-8c11-18c3-0193b8ea14c4@arista.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 30 Dec 2020 07:43:42 -0800
Message-ID: <CADyq12w0+ZA6nwJOtJJ-66vHuq4aWwQw22NOUymz7KQa9DXqHQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm/mremap: For MREMAP_DONTUNMAP check security_vm_enough_memory_mm()
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ah, you're right. This individual patch looks good to me.

Brian

On Mon, Dec 28, 2020 at 11:12 AM Dmitry Safonov <dima@arista.com> wrote:
>
> On 12/28/20 6:21 PM, Brian Geffon wrote:
> > This looks good to me with a small comment.
> >
> >>         if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
> >>                 /* OOM: unable to split vma, just get accounts right */
> >> -               if (vm_flags & VM_ACCOUNT)
> >> +               if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
> >>                         vm_acct_memory(new_len >> PAGE_SHIFT);
> >
> > Checking MREMAP_DONTUNMAP in the do_munmap path is unnecessary as
> > MREMAP_DONTUNMAP will have already returned by this point.
>
> In this code it is also used as err-path. In case move_page_tables()
> fails to move all page tables or .mremap() callback fails, the new VMA
> is unmapped.
>
> IOW, MREMAP_DONTUNMAP returns under:
> :       if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
>
> --
>           Dima
