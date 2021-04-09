Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E735A459
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhDIREq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhDIREo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:04:44 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F4EC061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Apr 2021 10:04:30 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id n4so5261318ili.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZExfZaItW8I8mhIQZwJxd1DH8tD4RWPfY6sL+HgdVY=;
        b=LpGpVWkFN6IMUF2DmNCDOz5Lr43s5Mdk0xGtSotDyp7K7I9pO3VTOb+DwJ1rvNd8Ac
         TS2DvgkHDVuxh4QXFbqqNv0rTiX4bcksCQgLMTKtgAW5hkDSFdjL0gBon4114r48HTIH
         WRb8Co81Ctlicn7/2099Bw28/SUhSV6Fs01MVitACqs+0mqOyWnw5OYof/3cC92vfIGa
         MlT0GGIbZO6AM0+48idHFJrFlGY6XRXUf/wLp9FmxyeNJsSopQVn7MBWGJXlw9H/5edT
         mZMgszZ4Kg6DT+D/MIs1Kk9xu4H+GdFu2CZGz84dFURvWISly+gxFjErlhkBxMaGgFgs
         mMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZExfZaItW8I8mhIQZwJxd1DH8tD4RWPfY6sL+HgdVY=;
        b=q1DbqxnrKzD2BTY3K0JGwhPsJCbXIkgbxr/T2FXtjJGuJm4RNBnS/TRI8EHMBL8Unc
         PGsLMTj6v9KVpHLeNVG/zWRD8NdlcAhvCsz9lnE0Lsc+a5MfGO8BvhmfvUhdFPiD6Gvv
         FblXVk33AptNFINEg2mcjeHP6+p/leFxUG6JjlzTdNyHwjhiNA1QZfD8L7k8ohwUyL2U
         /pW1t6WTSR9DvDomS+4mGZ2H1EaXn4z/DzCWGuXHBTEYK9M4sVpHEhU++RLsscfGyKA4
         zJTTJYSx/SK6nY7a1ySIlEgvWdyEJMwmN+aItmeH/WDhnIj8k1E3+z1Sr41z/DEvTran
         Vj9A==
X-Gm-Message-State: AOAM5313x5bUf14/mzsj+Re6JPUka2hgr2SfFgxQ9whvNThqJjeOrzkc
        9YQz5zV1U+qbBmc8n/lkHRV/MW02UdKHEenZ9f4AsQ==
X-Google-Smtp-Source: ABdhPJzM/e3TJU7ySB/2UMdS6n5bzAsPhMQxYMxjQpi360O8iBGeG86NQBa10fgltinhiL8KYpVlSnqeYcYvkENPNrw=
X-Received: by 2002:a05:6e02:4cd:: with SMTP id f13mr12318125ils.258.1617987869608;
 Fri, 09 Apr 2021 10:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com> <20210408220440.aab59f2f06beb840c22377b3@linux-foundation.org>
In-Reply-To: <20210408220440.aab59f2f06beb840c22377b3@linux-foundation.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 9 Apr 2021 10:03:53 -0700
Message-ID: <CAJHvVcj84fcuh0vXtHdEPoV+DrFDSXjUg1fO+oLFCOaxWBH13w@mail.gmail.com>
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling for shmem
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 8, 2021 at 10:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu,  8 Apr 2021 16:43:18 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> > The idea is that it will apply cleanly to akpm's tree, *replacing* the following
> > patches (i.e., drop these first, and then apply this series):
> >
> > userfaultfd-support-minor-fault-handling-for-shmem.patch
> > userfaultfd-support-minor-fault-handling-for-shmem-fix.patch
> > userfaultfd-support-minor-fault-handling-for-shmem-fix-2.patch
> > userfaultfd-support-minor-fault-handling-for-shmem-fix-3.patch
> > userfaultfd-support-minor-fault-handling-for-shmem-fix-4.patch
> > userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
> > userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
> > userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
> > userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
>
> Well.  the problem is,
>
> > +     if (area_alias == MAP_FAILED)
> > +             err("mmap of memfd alias failed");
>
> `err' doesn't exist until eleventy patches later, in Peter's
> "userfaultfd/selftests: unify error handling".  I got tired of (and
> lost confidence in) replacing "err(...)" with "fprintf(stderr, ...);
> exit(1)" everywhere then fixing up the fallout when Peter's patch came
> along.  Shudder.

Oof - sorry about that!

>
> Sorry, all this material pretty clearly isn't going to make 5.12
> (potentially nine days hence), so I shall drop all the userfaultfd
> patches.  Let's take a fresh run at all of this after -rc1.

That's okay, my understanding was already that it certainly wouldn't
be in the 5.12 release, but that we might be ready in time for 5.13.

>
>
> I have tentatively retained the first series:
>
> userfaultfd-add-minor-fault-registration-mode.patch
> userfaultfd-add-minor-fault-registration-mode-fix.patch
> userfaultfd-disable-huge-pmd-sharing-for-minor-registered-vmas.patch
> userfaultfd-hugetlbfs-only-compile-uffd-helpers-if-config-enabled.patch
> userfaultfd-add-uffdio_continue-ioctl.patch
> userfaultfd-update-documentation-to-describe-minor-fault-handling.patch
> userfaultfd-selftests-add-test-exercising-minor-fault-handling.patch
>
> but I don't believe they have had much testing standalone, without the
> other userfaultfd patches present.  So I don't think it's smart to
> upstream these in this cycle.  Or I could drop them so you and Peter
> can have a clean shot at redoing the whole thing.  Please let me know.

From my perspective, both Peter's error handling and the hugetlbfs
minor faulting patches are ready to go. (Peter's most importantly; we
should establish that as a base, and put all the burden on resolving
conflicts with it on us instead of you :).)

My memory was that Peter's patch was applied before my shmem series,
but it seems I was mistaken. So, maybe the best thing to do is to have
Peter send a version of it based on your tree, without the shmem
series? And then I'll resolve any conflicts in my tree?

It's true that we haven't tested the hugetlbfs minor faults patch
extensively *with the shmem one also applied*, but it has had more
thorough review than the shmem one at this point (e.g. by Mike
Kravetz), and they're rather separate code paths (I'd be surprised if
one breaks the other).

>
