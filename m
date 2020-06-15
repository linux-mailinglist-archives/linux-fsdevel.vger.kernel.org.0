Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9401F90B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 09:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgFOHxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 03:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgFOHxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:53:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6CEC061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 00:53:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so16322255ejd.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qply8dKLeFaH4C6xkbOwjlmAeElLYwIxkvYjz4HgFmM=;
        b=HhueOiVcGkaWE4SAMi1on9IbXgdNyb2uhfyf8/Aj9U8ZGUCv/Mi3CZ/HwGvqViJDVf
         S0+D+lmd8efd1yaOoHKUvW0UZqI+mw6hMBbi9slDfrwYO1/c79JN+b4hAlmxLpSpC7Os
         J0aIRDN/JdU3/EuHpQ2pAinRIvOP6ifWBQG0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qply8dKLeFaH4C6xkbOwjlmAeElLYwIxkvYjz4HgFmM=;
        b=rIEMAl5taVyowMJgKpvj1htVpQzG/eZGPULFtua0pHm5xv1SDtqF/z7xflQIKn0hQT
         pLzTLYmwMq1tiiu9MLFentqOziTMXTmwsmJ2FYhAM7GKaTWMv5MSk8hrOHf7uQKHwRtK
         Suxe7MdQMMw6KQdfiZl8qXMG2YlLNt6WnK67hl1m+Nt5GMa5XgzqN/2sGZA6feM91l1/
         mMxEju5WZGIYwtZlUXZuIN+dR7yN7F6uI1CXM5rOPcjnBBSPvxBqAjvR1H7WkoaPp4QX
         m7hFMNW2ESc2WcfdgUUBAZOsnHBSHzC+ZeciCNoVMZZ+pXRzmjpQ8H7zJOyWjPSx8uXO
         WbdQ==
X-Gm-Message-State: AOAM531TxYc6Jugmn/apP2eJEexKSyDdzpsD7M0THJ0hnr/z4vQoZnCU
        xShEoPPsvWw3+2j+itql0Tt+vey1ej6wZwEzbtHw1A==
X-Google-Smtp-Source: ABdhPJzeY6pLBqIqCEq52de509qkwa6bP+P+AW5dk2d1DDvZM/diV9S57KakTHTc8rIWoXqTu9x8Au1BPpStS70hhNI=
X-Received: by 2002:a17:906:31d2:: with SMTP id f18mr23974716ejf.110.1592207625916;
 Mon, 15 Jun 2020 00:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk> <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com> <6e8924b0-bfc4-eaf5-1775-54f506cdf623@oracle.com>
In-Reply-To: <6e8924b0-bfc4-eaf5-1775-54f506cdf623@oracle.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Jun 2020 09:53:35 +0200
Message-ID: <CAJfpegsugobr8LnJ7e3D1+QFHCdYkW1swtSZ_hKouf_uhZreMg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 13, 2020 at 9:12 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 6/12/20 11:53 PM, Amir Goldstein wrote:

> As a hugetlbfs developer, I do not know of a use case for interoperability
> with overlayfs.  So yes, I am not too interested in making them work well
> together.  However, if there was an actual use case I would be more than
> happy to consider doing the work.  Just hate to put effort into fixing up
> two 'special' filesystems for functionality that may not be used.
>
> I can't speak for overlayfs developers.

As I said, I only know of tmpfs being upper layer as a valid use case.
   Does that work with hugepages?  How would I go about testing that?

> > I agree with Colin's remark about adding limitations, but it would be a shame
> > if overlay had to special case hugetlbfs. It would have been better if we could
> > find a property of hugetlbfs that makes it inapplicable for overlayfs
> > upper/lower
> > or stacking fs in general.
> >
> > The simplest thing for you to do in order to shush syzbot is what procfs does:
> >         /*
> >          * procfs isn't actually a stacking filesystem; however, there is
> >          * too much magic going on inside it to permit stacking things on
> >          * top of it
> >          */
> >         s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
> >
> > Currently, the only in-tree stacking fs are overlayfs and ecryptfs, but there
> > are some out of tree implementations as well (shiftfs).
> > So you may only take that option if you do not care about the combination
> > of hugetlbfs with any of the above.
> >
> > overlayfs support of mmap is not as good as one might hope.
> > overlayfs.rst says:
> > "If a file residing on a lower layer is opened for read-only and then
> >  memory mapped with MAP_SHARED, then subsequent changes to
> >  the file are not reflected in the memory mapping."
> >
> > So if I were you, I wouldn't go trying to fix overlayfs-huguetlb interop...
>
> Thanks again,
>
> I'll look at something as simple as s_stack_depth.

Agree.

Thanks,
Miklos
