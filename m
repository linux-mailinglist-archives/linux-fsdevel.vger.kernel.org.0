Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224D3212BE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 20:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgGBSGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgGBSGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:06:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D85C08C5DD
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 11:06:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so29799112ljp.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXeahw42GKg9juA4uBvpVeENM2KNGrSYvX0lCAxHaNg=;
        b=SAc0P6TZQfW4FQsf2+lBD6w+OSrGuXoO/P2PmSMr9aJV7th8BuILaQ/KWCoOqTwRky
         Z+eIAa2Z4MCcV67tYB3E39MCwT1aVIIJBvvu6hNQ/ndKZHjjvkLbORwFnofChsGG7dJ/
         +O1yGNrkWF0L9ihdnRiytVkIkOBqnPy0jQXsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXeahw42GKg9juA4uBvpVeENM2KNGrSYvX0lCAxHaNg=;
        b=P7H3urEmJ/nW9QkIp+rFHlIsz+ciLobFZg1mt1Vks93Zj84YILB7A00GOPoQ3b6aDJ
         BBZSwju5PKTyo8FdxsbbJi/sRONgNjHQdQ5yfhO7TqAKZGywfmTSNEC2awsdrud8UukB
         NJY6ZfjQUwJmKJq9C+NUmG9snPOk5fjIlT15YlQx4VwYyMHygvW0bMjwBG9iVAtj+v+2
         mfIX+Kkcbr84PJDYYJWL38xFoqd6itfYPvJdSjK7f/y+AFsMYKG4bSuG1Ofp8TCLLJtN
         AquBu79iU16hUrEfSWN9acBqEkfNLxxoA14f9O5hlr4E7SZN8WAccSwJpKSnZrVvc+5V
         FE7A==
X-Gm-Message-State: AOAM530ENOph7H2iyMnRoNuBvVCue1Z4PJ9mOu1VdZ0ecyDMMwJUKWdP
        +e7FutGTegsCg0VB+iralBGXGqub98I=
X-Google-Smtp-Source: ABdhPJy9YXSZXeD6qrj0VYzpMcApvCaMz0yxtOQHzrW42Jyq7vxTaFW6Na6k0H4AxB6Ph405B6XRgA==
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr18190021ljp.226.1593713194394;
        Thu, 02 Jul 2020 11:06:34 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id v24sm3619935lfo.4.2020.07.02.11.06.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 11:06:33 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h22so26219334lji.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 11:06:33 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr11620388lji.371.1593713192759;
 Thu, 02 Jul 2020 11:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
In-Reply-To: <20200702165120.1469875-3-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 11:06:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
Message-ID: <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
Subject: Re: [RFC 2/4] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> shouldn't trigger any filesystem I/O for the actual request or for
> readahead.  This allows to do tentative reads out of the page cache as
> some filesystems allow, and to take the appropriate locks and retry the
> reads only if the requested pages are not cached.

This looks sane to me, except for this part:
>                 if (!PageUptodate(page)) {
> -                       if (iocb->ki_flags & IOCB_NOWAIT) {
> +                       if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO)) {
>                                 put_page(page);
>                                 goto would_block;
>                         }

This path doesn't actually initiate reads at all - it waits for
existing reads to finish.

So I think it should only check for IOCB_NOWAIT.

Of course, if you want to avoid both new reads to be submitted _and_
avoid waiting for existing pending reads, you should just set both
flags, and you get the semantics you want. So for your case, this may
not make any difference.

But if the issue is a deadlock where the code can block for IO, but
not call back down to the filesystem for new IO (because it holds a
lock that the filesystem might need) then this patch as-is is wrong,
because it disallows even that case.

              Linus
