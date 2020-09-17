Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AAB26E396
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgIQSag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIQSad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:30:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B26C061788
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 11:30:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r24so2898825ljm.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 11:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htmK6gOJ2PblkerFMS2g+5We3gbrehQll78mnvL0XTY=;
        b=bjCkIwlaKtFZnJKWxQwHG7krU4xU2kE4K4vgQFa/oFfQVRJ/3qfz1JYpMMpaX6cbRg
         p6kg57+rvSdzB7ybG9pBz31lLvN8toNTqeOWNKMpnRcB3IO0IOcF7cLQUAbzOcGfoBUy
         mUtJelB0pqUiZn7tHT612RpImUbAXNGTBchE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htmK6gOJ2PblkerFMS2g+5We3gbrehQll78mnvL0XTY=;
        b=EZIbIkeSR0KUI2xM85TqqIHcUjtZ+L9lZmVQdEIBV8c7o5bdxFFDO50AB0dyRWEeKC
         R9J2lU6ThBZraXgM9lT6YZnFQxBCKRiONonZPCSqBALEeADSghK5c0TLihNXZW5actL7
         sw1lNME/0Wx9G61LYIxYHnA7EtrsZN5FDOfVblkfRXIci8izaipqJDSLFWE2dg4YWnWc
         hGTON3v5tvsOBcWqQSC9rc9sbCCY5qucNQUPoUMxvBYkY2yRumgBIAixwz+xwHEy2xD5
         dYOi/UKCQHlDn42wOvd6ydHv/RYPRIOUPr1QBTqQbyAAJdSf9dpccrQEdU1hg5+z1xAQ
         D3Mw==
X-Gm-Message-State: AOAM533GoMJxrkI1M4/wxhWRdaGlKM93YYtNQXCneCtM7IDjNgr9iWWh
        mz0nqS/NHvD0WRKojnSLakZMbWqhuBPqKQ==
X-Google-Smtp-Source: ABdhPJyoJTiBiY6rqEESOhYGlTw6r08pergIpzN+AsMqs3LfFz0+cfB7IVYl67Foprn0/JCfK8HIdg==
X-Received: by 2002:a2e:9ad9:: with SMTP id p25mr9610704ljj.256.1600367418255;
        Thu, 17 Sep 2020 11:30:18 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w12sm64354lfk.193.2020.09.17.11.30.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:30:17 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s205so2885646lja.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 11:30:16 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr9863684ljp.314.1600367416426;
 Thu, 17 Sep 2020 11:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com> <20200917182314.GU5449@casper.infradead.org>
In-Reply-To: <20200917182314.GU5449@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 11:30:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
Message-ID: <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
>             Something like taking
> the i_mmap_lock_read(file->f_mapping) in filemap_fault, then adding a
> new VM_FAULT_I_MMAP_LOCKED bit so that do_read_fault() and friends add:
>
>         if (ret & VM_FAULT_I_MMAP_LOCKED)
>                 i_mmap_unlock_read(vmf->vma->vm_file->f_mapping);
>         else
>                 unlock_page(page);
>
> ... want me to turn that into a real patch?

I can't guarantee it's the right model - it does worry me how many
places we might get that i_mmap_rwlock, and how long we migth hold it
for writing, and what deadlocks it might cause when we take it for
reading in the page fault path.

But I think it might be very interesting as a benchmark patch and a
trial balloon. Maybe it "just works".

I would _love_ for the page lock itself to be only (or at least
_mainly_) about the actual IO synchronization on the page.

That was the origin of it, the whole "protect all the complex state of
a page" behavior kind of grew over time, since it was the only
per-page lock we had.

              Linus
