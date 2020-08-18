Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F382488BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgHRPI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 11:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHRPI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:08:58 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D09BC061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 08:08:58 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so21770799ljn.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rETSh+8yuTihjWF+BUTSPFBgl5bA8M3eQDalGhxFfpw=;
        b=TuQrlx9ltdfzy2BXM/J2LYEePbtt5B3+P7MjccLQ3uQ6Uy33ZMoL59hwUM94EYTIOP
         ePiPIpJnm9DIZTn2Ko1ylH4l/Q933ORzG7SG9jp22hAoaFi/MjiX1rsLQiS8SriNW/JL
         mXe2msw/QgUbYSRWgfPXE3QkhDFArRTP+3SoLFc2PfnVLXKt/mWT7SD/hoWl5ngIHhiI
         va+68H73TKONrFj3zf3N5eUj8uAHeSnwWoNDgMnJCZ09sW1w+sctB4PPQc6iSPBLgeYf
         InlH9BhM1cZXcll8D7ixfZ/ShMjuzbSZX3SdtYNKtHCh/Fh0NqeniOdJEWiCqGTZFn3E
         /VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rETSh+8yuTihjWF+BUTSPFBgl5bA8M3eQDalGhxFfpw=;
        b=aODarSuzv0sGisguXrfKOmtprx3GroTHS9pD2udkemCGgIBgqHAvnA6ZBHYZahrRJF
         G2zsQUBiiRfQ/Zhhs+DgPrcoRq44t40WTGdy4pKgDoesjZbhVTHgYtltrvKzesAth/4H
         t90+5JewjN9CcbEgGuu5YPoOHYZz7opwhCzC+bZTn1q6xEslP+UPuyXnkyimlA09aO7K
         nEGiUfLgg8XkrqX//9jJGLk+jRjex8zjgaTnR9/LPzDgJGWkDWtWO6HdVqEdhvfOXZCA
         AHIwDSn1YWdVwneggI04pjQuQvLgxUjHLTRmy1wfsP4J/FRnb4OO/Pm7033hAsiBYuSn
         XtNw==
X-Gm-Message-State: AOAM5336KhcuRq+Yy4YsHuYQPQjoeIhpfsxGfn0YxHjj9p2tsShMqQp3
        tGmlXU+ndQff/xS1tXMxLgfzrm/bCHhbukqkMbqQIQ==
X-Google-Smtp-Source: ABdhPJzFP/jL9HqM7+C+ZGX+JQAYbGvU8bb1EZGwmWqFhRvtDxyHbFA1E3GAJH4c/IDsC/tHOeWlK4THJj08BWmGM1c=
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr9176669ljk.139.1597763336196;
 Tue, 18 Aug 2020 08:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com> <20200818061239.29091-3-jannh@google.com>
 <20200818134027.GF29865@redhat.com>
In-Reply-To: <20200818134027.GF29865@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 18 Aug 2020 17:08:30 +0200
Message-ID: <CAG48ez01ZTUzZ+mEqyiz+mUQXq4SPiZfZtP1GmpEY1T2wLtnJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] coredump: Let dump_emit() bail out on short writes
To:     Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 3:40 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 08/18, Jann Horn wrote:
> >
> > +     if (dump_interrupted())
> > +             return 0;
> > +     n = __kernel_write(file, addr, nr, &pos);
> > +     if (n != nr)
> > +             return 0;
> > +     file->f_pos = pos;
>
> Just curious, can't we simply do
>
>         __kernel_write(file, addr, nr, &file->f_pos);
>
> and avoid "loff_t pos" ?

Hm... e.g. ksys_write() has the same pattern of copying the value into
a local variable and back, but I guess maybe there it's done so that
->f_pos can't change when vfs_write() returns a negative value, or
something like that? Or maybe to make the update look more atomic?
None of that is a concern for the core-dumping code, so I guess we
could change it... but then again, maybe we shouldn't diverge from how
it's done in fs/read_write.c (e.g. in ksys_write()) too much.
Coredumping is already a bit too special, no need to make it worse...

It looks like Al Viro introduced this as part of commit 2507a4fbd48a
("make dump_emit() use vfs_write() instead of banging at ->f_op->write
directly"). Before that commit, &file->f_pos was actually passed as a
parameter, just like you're proposing. I don't really want to try
reverting parts of Al's commits without understanding what exactly is
going on...
