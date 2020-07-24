Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD722C83C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGXOlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXOlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:41:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0512C0619E4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 07:41:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z6so10036406iow.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9E66nUvcODIIIOq5t+2qbeVH/MSVvQN11l9oNW6GhyI=;
        b=vyzeWhfzUBv+3aCDt4bAbkZMDVC7ooJXOhKnolfXtu9A3d40lBkGooDb91bIunTCM4
         JhOzmmvBtL2Xz7JyAwEraF9uTjtY3wRYHxwIqE4gz8WQPxsaMaCXm12OwNRghR7xDBho
         vaHCMyrYn81hU9KBurVxoZOQgu1Kj2LXvbkrAUPo+aaliJPrSCFcESce3TkrEU0tyzV4
         9qIlhXFbZkyNo7yUsDaqowQQrrDfOwNx3smuImtKSzHEFHB1VgLf3BvyFmDQCioY+YKZ
         9rNBWCGP3SdRjIaEZGWo+VO6ljJKWzf0P4/9cqtBKzW2bJzvJBM26RwR6PjiwvuKQerz
         eKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9E66nUvcODIIIOq5t+2qbeVH/MSVvQN11l9oNW6GhyI=;
        b=oiLHlqqJWyPYaX8AhrmCk99xM+bE/VgpYWJhFr/cvFzh2fuNyb2rjAJbMGLSYQPWWM
         6yR3kg3o+DVVaOrfoJxRYrufhEgmJ2m9w07mjOu3iKOX6RjEaRh1QdbZogGQA/R/yMNn
         Xa6LlU0avAk4G1xfWYDi9llTzVUdFic1mlIpyBz7pE5jX/fKIO8H3wEVMdtQ2whAD8LO
         d3XoaBxyAcTKEMphy8I4snVqrW85+C/EpWcQa3MHr417pPgDRtdlAU5nWKHl04Jnki28
         lAOm9/De6L2bkFUFjLNqKwE0PIQ+9JEST8/2YrWgb25Q5K1VsxM6vMntZOTfy8auqtuZ
         gEkg==
X-Gm-Message-State: AOAM532//u+V3GQ7JY2tiqQf+WosK6vSr8mkHFMVK3rjTn7+M1pNd+cD
        myex+4zFU9tqVkS8hWfj6MrFrQqrxNOZ8qdmpt8OdQ==
X-Google-Smtp-Source: ABdhPJwAGCFsZ6cfW/RCed2pPReLn9Q4orINjlDAatEH6Czg9iP1uAc2Sj/EmE/i1I7eUakHAEQGgWrRJkRjKipv+Lg=
X-Received: by 2002:a5d:97d1:: with SMTP id k17mr10702728ios.100.1595601683730;
 Fri, 24 Jul 2020 07:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com> <20200724094505-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200724094505-mutt-send-email-mst@kernel.org>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 24 Jul 2020 07:41:12 -0700
Message-ID: <CA+EESO40x0+FW2ek5E=EYoHXt_AX2hvJ6QjbS=GSh9CpJQQRAA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Control over userfaultfd kernel-fault handling
To:     "Michael S. Tsirkin" <mst@redhat.com>, kernel@android.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Daniel Colascione <dancol@dancol.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 7:01 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Apr 22, 2020 at 05:26:30PM -0700, Daniel Colascione wrote:
> > This small patch series adds a new flag to userfaultfd(2) that allows
> > callers to give up the ability to handle user-mode faults with the
> > resulting UFFD file object. In then add a new sysctl to require
> > unprivileged callers to use this new flag.
> >
> > The purpose of this new interface is to decrease the change of an
> > unprivileged userfaultfd user taking advantage of userfaultfd to
> > enhance security vulnerabilities by lengthening the race window in
> > kernel code.
>
> There are other ways to lengthen the race window, such as madvise
> MADV_DONTNEED, mmap of fuse files ...
> Could the patchset commit log include some discussion about
> why these are not the concern please?
>
> Multiple subsystems including vhost have come to rely on
> copy from/to user behaving identically to userspace access.
>
> Could the patchset please include discussion on what effect blocking
> these will have? E.g. I guess Android doesn't use vhost right now.
> Will it want to do it to run VMs in 2021?
>
> Thanks!
>
> > This patch series is split from [1].
> >
> > [1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
>
> So in that series, Kees said:
> https://lore.kernel.org/lkml/202002112332.BE71455@keescook/#t
>
> What is the threat being solved? (I understand the threat, but detailing
>   it in the commit log is important for people who don't know it.)
>

Adding Android security folks, Nick and Jeff, to answer.

> Could you pls do that?
>
> > Daniel Colascione (2):
> >   Add UFFD_USER_MODE_ONLY
> >   Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
> >
> >  Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
> >  fs/userfaultfd.c                        | 18 ++++++++++++++++--
> >  include/linux/userfaultfd_k.h           |  1 +
> >  include/uapi/linux/userfaultfd.h        |  9 +++++++++
> >  kernel/sysctl.c                         |  9 +++++++++
> >  5 files changed, 48 insertions(+), 2 deletions(-)
> >
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
>
