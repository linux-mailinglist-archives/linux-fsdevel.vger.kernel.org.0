Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B459B3B0B93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhFVRmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhFVRmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:42:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2203DC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 10:40:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h15so18717183lfv.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66ra9JcEZ0eBr3diwYDmK55iDML4YsZIlomivlL4MkM=;
        b=BN8pfadh6kxcRjOo7eBRIxfB3TqOIMMpU5w6SViYi3IbWgrX9pxyb+0MIPuTThh/Uk
         UI374oOHBtqpQVOc5/7Wjq62OSZlw+Cs0ZJ9RtNvwUC7DVtrhmo38JY5T8rAYwai72SJ
         tm4pt9J7lEO2DOp7XU52ViFjgfM4TXiIVDMsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66ra9JcEZ0eBr3diwYDmK55iDML4YsZIlomivlL4MkM=;
        b=VKXyBUPyBNOdGwcetlOLFzWdYmgovm9YZGdNMzAYXwSiR2wpRVk6jpB6O8b0Tp9sWZ
         9FSTLt4ZAbfJii+48utrQHy7BZxvHL0BzmbpDGy/Fiy0ha5mbzrDpOvAni682ZDqVKRB
         KpFq1zbtgPoedBLC3/hUUlqhtRe4MWbF4e4xeu42xQh87bdsoPOkohCAMBu2U+qZy507
         KnyVAzSeZrRu5nofGY5k4k1QPlD2L+3Khw/xDs04Uf8iHzel1778nzVzg4B5veia0J+y
         rct8GJKwZnBUg20fKyZc+o2DeHb5E19LKLGXYHsCwSpWd+ecR3SYUr/OVycqPQcHmerV
         YiCg==
X-Gm-Message-State: AOAM531CiO1YerUR/YqwP2Gz4n2MiomWtjaTZOyaHewhbpueLjP16yps
        ATP9BuKbOLLriHyov61r67cESGQ1wj9aqpxQVUk=
X-Google-Smtp-Source: ABdhPJzoT6eR62enIehY82gtPMQYstSTPj9cs7XyOzqOS970oKwMCszZA5Juzonbo8brJdpRYvU97Q==
X-Received: by 2002:a05:6512:ba8:: with SMTP id b40mr4054808lfv.588.1624383603177;
        Tue, 22 Jun 2021 10:40:03 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id n5sm2273695lft.139.2021.06.22.10.40.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 10:40:02 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id r16so31288642ljk.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 10:40:02 -0700 (PDT)
X-Received: by 2002:a2e:7813:: with SMTP id t19mr4167347ljc.411.1624383601833;
 Tue, 22 Jun 2021 10:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
In-Reply-To: <YNIdJaKrNj5GoT7w@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 10:39:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
Message-ID: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:26 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jun 22, 2021 at 03:36:22PM +0000, Al Viro wrote:
> >
> > Note that the revert you propose is going to do fault-in anyway; we really can't
> > avoid it.  The only thing it does is optimistically trying without that the
> > first time around, which is going to be an overall loss exactly in "slow
> > write_begin" case.  If source pages are absent, you'll get copyin fail;
> > iov_iter_copy_from_user_atomic() (or its replacement) is disabling pagefaults
> > itself.
>
> Let's not overstate the case.  I think for the vast majority of write()
> calls, the data being written has recently been accessed.  So this
> userspace access is unnecessary.

Note that the fault_in_readable is very much necessary - the only
question is whether it happens before the actual access, or after it
in the "oh, it failed, need to retry" case.

There are two cases:

 (a) the user page is there and accessible, and fault_in_readable
isn't necessary

 (b) not

and as you say, case (a) is generally the common one by far, although
it will depend on the exact load (iow, (b) *could* be the common case:
you can have situations where you mmap() things only to then write the
mapping out, and then accesses will fault a lot).

But if it's case (a), then the fault_in_readable is going to be pretty
cheap. We're talking "tens of CPU cycles", unlikely to really be an
issue.

If the case is (b), then the cost is not actually the access at all,
it's the *fault* and the retry. Now we're talking easily thousands of
cycles.

And that's where it matters whether the fault_in_readable is before or
after. If it's before the actual access, then you'll have just _one_
fault, and it will handle the fault.

If the fault_in_readable is only done in the allegedly unlikely
faulting case and is _after_ the actual user space atomic access,
you'll have *two* faults. First the copy_from_user_atomic() will
fault, and return a partial result. But the page won't actually be
populated, so then the fault_in_readable will have to fault _again_,
in order to finally populate the page. And then we retry
(successfully, except for the unbelievably rare case of racing with
pageout) the actual copy_from_user_atomic().

End result: doing the fault_in_readable "unnecessarily" at the
beginning is likely the better optimization. It's basically free when
it's not necessary, and it avoids an extra fault (and extra
lock/unlock and retry) when it does end up faulting pages in.

               Linus
