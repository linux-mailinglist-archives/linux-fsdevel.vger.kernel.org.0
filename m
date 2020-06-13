Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200321F8163
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 08:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFMGxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 02:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMGxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 02:53:36 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5908DC03E96F;
        Fri, 12 Jun 2020 23:53:36 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 9so10771938ilg.12;
        Fri, 12 Jun 2020 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZmV14aQSRUcm2y4A/e4BOaEXbeaA7HzwVKU8FNN/60=;
        b=jwtT8ipprgd7AseQDAlUj4ZfF3NouX0BU4A5re2DoqkBdfJjM/bk+kna0bDAfV0az5
         rDb+u/x7w5bSaxpv+6VWq4kIGtl+TSOBm4aulgnrtaJ8SLZxpIwhxOsI9seg0IlOmmQG
         8QdLPClwcY7izTJgguw9P/PM4jpvreziT3aTrpz6+zpFxgNr7PR5sMHh3FqucWU2ljLz
         qa6R8eR3hvCk4Sz7GQmxtqBWaEVU7hzMGwM77W4+Kh/Q8iNvzmCb72eepE94GD//g9GN
         iE6S5wF8FTYS/k7OoO+FM8rOI0yiMVs7cY8+HJeExH/aZ+Iwym80hrTahFTrOM6cg+lu
         9lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZmV14aQSRUcm2y4A/e4BOaEXbeaA7HzwVKU8FNN/60=;
        b=f+MpczMiTkl5/a3li+aWZI/mRMp9IXia4+mFV5Sn3zyc2O3RC1u/N/YZZZjMAX5FyW
         xmKt2lp7nZgy7hl6FME67Q0VAEGHJj9u+yh0KUaAHjUioulWf/GViqG62sFeWhz2Vx3C
         bRA82Wu3F3ZtygQZ6hDC0gXtlJY8MWBXtc4sB2l5Zn53s/F3UmXDuKs4DZk5K6bz0KSx
         1Qaw5B1l1iY0dGLxAuV3qJjHKpmbD4jI0M2B8UKhimcgcmNsOJ+IL/xnN6Vo1JXSE8l5
         d5bqM1blNXa7Yj/JMR7qzLmlyYWhKnCbtzDRGl7/PgOncFFwPfT/h7UYhfeHwrpKVcUs
         /n1w==
X-Gm-Message-State: AOAM533Gg8CJUR+HNU8s7LEfti6RNenEPSjSVjDJQJ0GY9P22vLQKhpU
        h3h8J1MjwzMV9vOd13ldR2hm6TrIc9qn4DYSDhs=
X-Google-Smtp-Source: ABdhPJxu1Fv5oTvN89HALcUnUPQVdWi2LFb8XAUkbJWwKm+5/Yp5FN9BEbw21Rp0AJk/9bkPJUlS9zPyfoQAKZ1Rb18=
X-Received: by 2002:a92:2a0c:: with SMTP id r12mr16271149ile.275.1592031215605;
 Fri, 12 Jun 2020 23:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk> <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
In-Reply-To: <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 13 Jun 2020 09:53:24 +0300
Message-ID: <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
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

> > Incidentally, can a hugetlbfs be a lower layer, while the upper one
> > is a normal filesystem?  What should happen on copyup?
>
> Yes, that seems to work as expected.  When accessed for write the hugetlb
> file is copied to the normal filesystem.
>
> The BUG found by syzbot actually has a single hugetlbfs as both lower and
> upper.  With the BUG 'fixed', I am not exactly sure what the expected
> behavior is in this case.  I may be wrong, but I would expect any operations
> that can be performed on a stand alone hugetlbfs to also be performed on
> the overlay.  However, mmap() still fails.  I will look into it.
>
> I also looked at normal filesystem lower and hugetlbfs upper.  Yes, overlayfs
> allows this.  This is somewhat 'interesting' as write() is not supported in
> hugetlbfs.  Writing to files in the overlay actually ended up writing to
> files in the lower filesystem.  That seems wrong, but overlayfs is new to me.
>

I am not sure how that happened, but I think that ovl_open_realfile()
needs to fixup f_mode flags FMODE_CAN_WRITE | FMODE_CAN_READ
after open_with_fake_path().

> Earlier in the discussion of these issues, Colin Walters asked "Is there any
> actual valid use case for mounting an overlayfs on top of hugetlbfs?"  I can
> not think of one.  Perhaps we should consider limiting the ways in which
> hugetlbfs can be used in overlayfs?  Preventing it from being an upper
> filesystem might be a good start?  Or, do people think making hugetlbfs and
> overlayfs play nice together is useful?

If people think that making hugetlbfs and overlayfs play nice together maybe
they should work on this problem. It doesn't look like either
hugetlbfs developers
nor overlayfs developers care much about the combination.
Your concern, I assume, is fixing the syzbot issue.

I agree with Colin's remark about adding limitations, but it would be a shame
if overlay had to special case hugetlbfs. It would have been better if we could
find a property of hugetlbfs that makes it inapplicable for overlayfs
upper/lower
or stacking fs in general.

The simplest thing for you to do in order to shush syzbot is what procfs does:
        /*
         * procfs isn't actually a stacking filesystem; however, there is
         * too much magic going on inside it to permit stacking things on
         * top of it
         */
        s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;

Currently, the only in-tree stacking fs are overlayfs and ecryptfs, but there
are some out of tree implementations as well (shiftfs).
So you may only take that option if you do not care about the combination
of hugetlbfs with any of the above.

overlayfs support of mmap is not as good as one might hope.
overlayfs.rst says:
"If a file residing on a lower layer is opened for read-only and then
 memory mapped with MAP_SHARED, then subsequent changes to
 the file are not reflected in the memory mapping."

So if I were you, I wouldn't go trying to fix overlayfs-huguetlb interop...

Thanks,
Amir.
