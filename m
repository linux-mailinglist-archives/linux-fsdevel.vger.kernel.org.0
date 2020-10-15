Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706CB28FA96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 23:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgJOVWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 17:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgJOVWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:22:20 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55741C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 14:22:18 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so367749lfj.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve8APvdbXwr+mkU24Wg+7NdCEN7nDo0UjPZho1mbCAs=;
        b=E/m/evaeyIctAIsX9swfjk8WvVZlpksp1XP2wHwAMLRvoLOERFZzvDjSkGzfrRMJGP
         CdC+DU+x6xnBEixMCNaC3BVB59Pv/9jxQ6Jk8Emwz10xGgnI3ZGVqTjbRo3yJB94tNif
         5L7Ib4iEG+6BAcbtChrvOtZ8ZQbXYOCEvnndM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve8APvdbXwr+mkU24Wg+7NdCEN7nDo0UjPZho1mbCAs=;
        b=p6Z+iBW7Ico560/I3cnFIQYcJgsAiSVRFwdvhfk3z8wKhD90BrwEATc5HfjVUFgZeL
         2D0gw+rXsnXcjnTv3ohiiYbb3FqssVp7H7nmyTmBBhLtflI7QtYH84dSXcbOLEG6ph5G
         g80vXWHjGZFtjpSbIfXwKlFz0IR4I/LP6GN828YUBNNR4iTQCbdqVN4I0J7SSLZOJ5X2
         hV2/ELNXoPs8jNa0XgmU8QMlLMj0jfVM91S9rRNk55DH5/mdHnJJJfyG4+kI2FiCVevc
         DlvnXblStm6FCCMMC9pQDv9aCm3rJM0vogN5ou2ANeft+fvrtrdaggmH5lcHK0PxOLMF
         vE9w==
X-Gm-Message-State: AOAM532DJHSACfY4WoKv8tFHHYlve7kQtNgKiygACElO8pgGICwWDjMe
        2okamM7e2nD5XsoTYFXeghB4IfZAA7vumA==
X-Google-Smtp-Source: ABdhPJyi2IE0IY2jRGe9lIKdmuRBBk06J69G4TF/sRhYGKDy4Q/qUmxcPmFHucpE2FHPuiKLCQa/Jw==
X-Received: by 2002:ac2:419a:: with SMTP id z26mr144396lfh.537.1602796935971;
        Thu, 15 Oct 2020 14:22:15 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y125sm78374lfa.208.2020.10.15.14.22.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 14:22:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j30so358038lfp.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 14:22:14 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr179180lfz.344.1602796934226;
 Thu, 15 Oct 2020 14:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw> <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com> <20201015195526.GC226448@redhat.com>
In-Reply-To: <20201015195526.GC226448@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Oct 2020 14:21:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
Message-ID: <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Qian Cai <cai@lca.pw>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 12:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> I am wondering how should I fix this issue. Is it enough that I drop
> the page lock (but keep the reference) inside the loop. And once copying
> from user space is done, acquire page locks for all pages (Attached
> a patch below).

What is the page lock supposed to protect?

Because whatever it protects, dropping the lock drops, and you'd need
to re-check whatever the page lock was there for.

> Or dropping page lock means that there are no guarantees that this
> page did not get written back and removed from address space and
> a new page has been placed at same offset. Does that mean I should
> instead be looking up page cache again after copying from user
> space is done.

I don't know why fuse does multiple pages to begin with. Why can't it
do whatever it does just one page at a time?

But yes, you probably should look the page up again whenever you've
unlocked it, because it might have been truncated or whatever.

Not that this is purely about unlocking the page, not about "after
copying from user space". The iov_iter_copy_from_user_atomic() part is
safe - if that takes a page fault, it will just do a partial copy, it
won't deadlock.

So you can potentially do multiple pages, and keep them all locked,
but only as long as the copies are all done with that
"from_user_atomic()" case. Which normally works fine, since normal
users will write stuff that they just generated, so it will all be
there.

It's only when that returns zero, and you do the fallback to pre-fault
in any data with iov_iter_fault_in_readable() that you need to unlock
_all_ pages (and once you do that, I don't see what possible advantage
the multi-page array can have).

Of course, the way that code is written, it always does the
iov_iter_fault_in_readable() for each page - it's not written like
some kind of "special case fallback thing".

I suspect the code was copied from the generic write code, but without
understanding why the generic write code was ok.

               Linus
