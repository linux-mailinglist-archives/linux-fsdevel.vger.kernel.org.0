Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2294028EB4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 04:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgJOCog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 22:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJOCog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 22:44:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90369C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 19:44:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a4so1510158lji.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ID2miLyRzca1e47IO9+77v5sqIUwWiNgIYab8O8WsPw=;
        b=WXWAc3ciMucmkyvNWAoGrn4REmOCOUzeaaHQMmYOa1MWzBMnoa+yAQgkwNPhcw/vv9
         yb9KyKHZzvM3KsB71XIkWDKcpf+2jun/9jMfkxRGmXRW10JzITI7XsAuNVnRu3JW2O2b
         0Q6/cvSRWnt/FFcRqvGqAAag9lu0+Q8mHQ2ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ID2miLyRzca1e47IO9+77v5sqIUwWiNgIYab8O8WsPw=;
        b=LO+590gvwcJZEOyP9tVVR9MyrAfNDz+MdxPHYr8wal13LUEvbWHZK/DiORWPRhSk6w
         QEPvC2gI2oKluvX7Ar6LTqQ8nToqCe0LLWP+/MU7NjWRDg8a9HlOrnVATAL3dKMp+TSf
         eRQwkiebOOKN7rWrBcuNUOE3tJJNyHzZHo3moDzAppelJFg1y/FM5dtnYM5ldnuwAlJj
         OThK9/pOdw2yFWDnJBqv5k5StFOlmeVoLG/QsO066AvHCW/dpcffqFCBJDQlTFMyDS3J
         k/WAA5pYVR0rQ8kpt+OVLDAYAr0PVU2X1EFx9QKv8BE91eRReJx5wklDk8Y3GwRBMLN8
         0p6w==
X-Gm-Message-State: AOAM532YFPgH3d1gMrAtMpQq+KDkfRk6jTbt+vGgykXqDWvr/v0FYxO7
        P5od86DO8X9x17wLffG4pDG76eNVsIwxBg==
X-Google-Smtp-Source: ABdhPJx9AaUt3eLWZKlm7VRM1E2jQEQTNTDTHFrAo6TFTR7lm1jnsYdFYXBfssMkiyKEOkx418YWNw==
X-Received: by 2002:a2e:9bc5:: with SMTP id w5mr361022ljj.454.1602729873504;
        Wed, 14 Oct 2020 19:44:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l20sm670204lje.60.2020.10.14.19.44.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 19:44:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id v6so1713105lfa.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 19:44:32 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr333222lfz.344.1602729871973;
 Wed, 14 Oct 2020 19:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
In-Reply-To: <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 19:44:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
Message-ID: <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Some more lock_page work..
To:     Qian Cai <cai@lca.pw>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 6:48 PM Qian Cai <cai@lca.pw> wrote:
>
> While on this topic, I just want to bring up a bug report that we are chasing an
> issue that a process is stuck in the loop of wait_on_page_bit_common() for more
> than 10 minutes before I gave up.

Judging by call trace, that looks like a deadlock rather than a missed wakeup.

The trace isn't reliable, but I find it suspicious that the call trace
just before the fault contains that
"iov_iter_copy_from_user_atomic()".

IOW, I think you're in fuse_fill_write_pages(), which has allocated
the page, locked it, and then it takes a page fault.

And the page fault waits on a page that is locked.

This is a classic deadlock.

The *intent* is that iov_iter_copy_from_user_atomic() returns zero,
and you retry without the page lock held.

HOWEVER.

That's not what fuse actually does. Fuse will do multiple pages, and
it will unlock only the _last_ page. It keeps the other pages locked,
and puts them in an array:

                ap->pages[ap->num_pages] = page;

And after the iov_iter_copy_from_user_atomic() fails, it does that
"unlock" and repeat.

But while the _last_ page was unlocked, the *previous* pages are still
locked in that array. Deadlock.

I really don't think this has anything at all to do with page locking,
and everything to do with fuse_fill_write_pages() having a deadlock if
the source of data is a mmap of one of the pages it is trying to write
to (just with an offset, so that it's not the last page).

See a similar code sequence in generic_perform_write(), but notice how
that code only has *one* page that it locks, and never holds an array
of pages around over that iov_iter_fault_in_readable() thing.

              Linus
