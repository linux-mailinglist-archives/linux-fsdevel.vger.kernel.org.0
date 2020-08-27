Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFC1254BCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 19:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgH0ROL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0ROK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:14:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D9C06121B
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:14:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so7318479ljn.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4prkjP1Ku3b1Mujmm7MQBoZsalaGZICkCWqtSa9I0Q=;
        b=PSw0ZaM0WvUn6MpwD6It0gaG27/wObSq1kVFCBecFjxl05M3hm/lJJJSvazPfJVOQT
         cjVnniEJR+1KQCr4oYfPbro+6zzdFrXrfxKFeKe1p1C/CgSLgLHArfWn+EP8lW7qYQ49
         w0N1GHWVrfxOkaIDPpbVBPi4jLmvTyf7sMt34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4prkjP1Ku3b1Mujmm7MQBoZsalaGZICkCWqtSa9I0Q=;
        b=RpakvzrxT5JxZxS6zIC7/pmZNqG6T2bJEHK0usPvzgmpHgiP6a3zcuYoDXavT/Yu7D
         62KC8p0ZZvkYuiW8r80BBMRFc5r/ZeXdAYWs3NsjMb4jb/KzFBQBRj16ZvIoDlKr93kP
         kH6UIn4P9+N79Pox9+dMPGB7VkGJJptlRSOGL0RRRbk7bjm2CWCEC/sBhM3w+yVph1PK
         5aLKZcJXZffvMEMwQcAmsscLieZhoAr1V6Cb6zlAqFU3R88QfEQcH3jV7jQnV8giDmcW
         neR7XiApy2I4DygMViMLl69CvhleF/pTJzmQ/mVXKlEy2mj44ZoIS4De0zrQl9iB9PEQ
         dzIg==
X-Gm-Message-State: AOAM531tSQAze3ZapgZt82r1Aq0NY6oa8scq1W4ULHwZm8zVBtoVUYGg
        kD39W4GI0K5FXm/36TD0qwaJJyKGLjEKXg==
X-Google-Smtp-Source: ABdhPJwiiA6VBWdJQltMfCvwko3nqIw7HfgJVDeYejhz4q0rsF1JeTuYYxAilR1pZldTnkU89A+MCA==
X-Received: by 2002:a05:651c:216:: with SMTP id y22mr9492194ljn.329.1598548447608;
        Thu, 27 Aug 2020 10:14:07 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 4sm596297ljq.92.2020.08.27.10.14.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:14:07 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t6so7271454ljk.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:14:06 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr10986895ljp.312.1598548445374;
 Thu, 27 Aug 2020 10:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com> <20200827114932.3572699-7-jannh@google.com>
In-Reply-To: <20200827114932.3572699-7-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 10:13:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=QXUkKXLzyWxJ49L80Heu2Z_RoHSahRt+zPq8W4du=g@mail.gmail.com>
Message-ID: <CAHk-=wj=QXUkKXLzyWxJ49L80Heu2Z_RoHSahRt+zPq8W4du=g@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] mm/gup: Take mmap_lock in get_dump_page()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 4:50 AM Jann Horn <jannh@google.com> wrote:
>
> Properly take the mmap_lock before calling into the GUP code from
> get_dump_page(); and play nice, allowing the GUP code to drop the mmap_lock
> if it has to sleep.

Hmm. Of all the patches in the series, this simple one is now the only
one I feel makes for ugly code. Certainly not uglier than it used to
be,  but also not as pretty as it could be..

I think you're pretty much just re-implementing
get_user_pages_unlocked(), aren't you?

There are differences - you use mmap_read_lock_killable(), for
example. But I think get_user_pages_unlocked() should too.

The other difference is that you don't set FOLL_TOUCH. So it's not
*exactly* the same thing, but it's close enough that I get the feeling
that this should be cleaned up to use a common helper between the two.

That said, I suspect that falls under the heading of "future cleanup".
I don't think there's any need to re-spin this series for this, it's
just the only slightly negative reaction I had for the whole series
now.

                 Linus
