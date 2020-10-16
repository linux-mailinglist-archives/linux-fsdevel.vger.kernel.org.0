Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CE290269
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406500AbgJPKCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 06:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406498AbgJPKCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 06:02:34 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA24C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 03:02:33 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id l23so499110vkm.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2UAmLb0Qij04dFY8btDQwDS1sHsBxgRtlIjW8zX0hU=;
        b=HxuXGdW5l4w+ihhtKYRt3hD/bRT+8E5pe3iSfQPyrw6D67FeV6PB/zpzWqDX1xfdd8
         4K6TneSSeRdgIYXCWGY8595WYwWcd46mNtnaUcSiwffKjIyI3j13jgudt36kpzzwWlop
         JG0WJgcGmXY6SXquDOu/toyDrsl3gtpsxJRu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2UAmLb0Qij04dFY8btDQwDS1sHsBxgRtlIjW8zX0hU=;
        b=O0qx+9FKSk1u/64XyFw08NGU67uRFb6k+AgEp8spcEXYsogItAHZ8mcPS5QQ1zw00m
         gURAcIm28kQQSus9yBi4zvFhZcee+XoQZZxdbMFVroF0lugP9t800TFM6YllXEg4ltRe
         3/V4fVMIU4fZ8QD92XmOEoOedLN1RaIx7Euz5HrunbvBsJsdnFyT/9Li5yDEp738ntNd
         x+jhykExEMA67H7y6KNFj6/WIbdypIoCQvNn11XDE1cV6qaGO5qY9vzf1boa3nC8T5jE
         ZpFVwF6hPObb3jVJXS9gl3JV/aCq1oJ0gRt7xQ7QNJA6UYOBpgiS9rtX0utZlYvM5CTp
         UtCA==
X-Gm-Message-State: AOAM5322WkNcnNlD5s4yMRXehgn9/xRdVG9fT4AWVRYGSu3RncD5E0q/
        /sIKGm1CqM8WHpoHsbb8f8yfvibR0U/upAL4s5L7fw==
X-Google-Smtp-Source: ABdhPJwi3kZwYWwdrcHl+IhxKB+EmYRh7nUgJOgGUsnavnybsSB+2XY2LVZ4yAEPcqe8eMB4+xdF+3zdjIQ6i1w+tBs=
X-Received: by 2002:a1f:3144:: with SMTP id x65mr1594215vkx.3.1602842552307;
 Fri, 16 Oct 2020 03:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw> <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com> <20201015195526.GC226448@redhat.com> <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
In-Reply-To: <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 16 Oct 2020 12:02:21 +0200
Message-ID: <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Qian Cai <cai@lca.pw>,
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

On Thu, Oct 15, 2020 at 11:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 15, 2020 at 12:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > I am wondering how should I fix this issue. Is it enough that I drop
> > the page lock (but keep the reference) inside the loop. And once copying
> > from user space is done, acquire page locks for all pages (Attached
> > a patch below).
>
> What is the page lock supposed to protect?
>
> Because whatever it protects, dropping the lock drops, and you'd need
> to re-check whatever the page lock was there for.
>
> > Or dropping page lock means that there are no guarantees that this
> > page did not get written back and removed from address space and
> > a new page has been placed at same offset. Does that mean I should
> > instead be looking up page cache again after copying from user
> > space is done.
>
> I don't know why fuse does multiple pages to begin with. Why can't it
> do whatever it does just one page at a time?
>
> But yes, you probably should look the page up again whenever you've
> unlocked it, because it might have been truncated or whatever.
>
> Not that this is purely about unlocking the page, not about "after
> copying from user space". The iov_iter_copy_from_user_atomic() part is
> safe - if that takes a page fault, it will just do a partial copy, it
> won't deadlock.
>
> So you can potentially do multiple pages, and keep them all locked,
> but only as long as the copies are all done with that
> "from_user_atomic()" case. Which normally works fine, since normal
> users will write stuff that they just generated, so it will all be
> there.
>
> It's only when that returns zero, and you do the fallback to pre-fault
> in any data with iov_iter_fault_in_readable() that you need to unlock
> _all_ pages (and once you do that, I don't see what possible advantage
> the multi-page array can have).
>
> Of course, the way that code is written, it always does the
> iov_iter_fault_in_readable() for each page - it's not written like
> some kind of "special case fallback thing".

This was added by commit ea9b9907b82a ("fuse: implement
perform_write") in v2.6.26 and remains essentially unchanged, AFAICS.
So this is an old bug indeed.

So what is the page lock protecting?   I think not truncation, because
inode_lock should be sufficient protection.

What it does after sending a synchronous WRITE and before unlocking
the pages is set the PG_uptodate flag, but only if the complete page
was really written, which is what the uptodate flag really says:  this
page is in sync with the underlying fs.

So I think the page lock here is trying to protect against concurrent
reads/faults on not uptodate pages.  I.e. until the WRITE request
completes it is unknown whether the page was really written or not, so
any reads must block until this state becomes known.  This logic falls
down on already cached pages, since they start out uptodate and the
write does not clear this flag.

So keeping the pages locked has dubious value: short writes don't seem
to work correctly anyway.  Which means that we can probably just set
the page uptodate right after filling it from the user buffer, and
unlock the page immediately.

Am I missing something?

Thanks,
Miklos
