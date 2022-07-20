Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4557C078
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 01:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiGTXFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 19:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiGTXFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:05:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E8B6367
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 16:05:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n7so87855ioo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1T4qbDxhSzNmOGzCQwvKdvIhsg9ftO1mwgvo87Nrw8=;
        b=bhybBTw1im+DhwPHQWv+PzdM9trpgtKREb+kM6QNvHD05jCfagtV+lxooUJ731yakd
         AtmTTjzC8ckolKZiHiuVoq5DcUcI7f0G3HBUlfBmed4XPivrb/aOGboWYwHTinfh/++2
         KRREJxhfTSMu6dTk41fjcd+Bqsc5KPFtBHWAbuwg8IPFwwXIE//5nOy4HCjcrxn47h40
         mLXHvQIlkmaXgPe8ZDzmvua0rHVH5BFWYJyCkSblCjWPH1/rObx2gAxsel7HdAEjQ3FR
         fmrAxAKRzPK/ulKi/nMXeHIsh58mE9P7jvbmC3e7oo0ga1aE+dxNq4jKi8+XsEwstDfN
         YTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1T4qbDxhSzNmOGzCQwvKdvIhsg9ftO1mwgvo87Nrw8=;
        b=gEXXo72N1bg7SLhKHjmNtmVPPjF6hBdUgvZSCVbq78zq0WBJ/LlUILa4gnVftkV+F+
         qksa9Oqy25s9rmvb4pBsUk+CIg9EyRSgaYjNRRN9MML/5o86oLSlRKh/DVUCJHX7P3Fg
         pqktpJ8id0z0s1MaHLrxYcx0MJ2+taWIostbf4J0irC641rqcil1/l6dK6KHWHkgznE7
         kjpRVB8e3QJ5WJSzEu+lBLsCgDlLfrxEh5R2ZqnnuDY2KXZ4xLE2kjWajTHF3oBJYeYA
         M1q5FKEs3DNRvOBf3lVoJYm5andgyUKtx+UHRbEqY4TeMkU6ac8j4Yb2B4vFycg9EmMu
         PHcg==
X-Gm-Message-State: AJIora8VWi93n6DZCuVCYj4kcTvpcn2gXSYU9azKuyRyS2oBVlTNfLas
        o1GaPP/sb3+568F4ZWIrg9tlloyjuEgU88xTOTgvSA==
X-Google-Smtp-Source: AGRyM1vHwHvPWd8988+SD0LKzqKrSlWnqr4l9t8oZmoloK10ndRc8Ai0iTZof6+FZFo8o5tMT3S8rrmuJp1srFev0W4=
X-Received: by 2002:a05:6602:2f03:b0:678:9c7c:97a5 with SMTP id
 q3-20020a0566022f0300b006789c7c97a5mr18761335iow.32.1658358319643; Wed, 20
 Jul 2022 16:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220719195628.3415852-1-axelrasmussen@google.com> <PH7PR11MB6353950F607F7B8F274A3550FD8E9@PH7PR11MB6353.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB6353950F607F7B8F274A3550FD8E9@PH7PR11MB6353.namprd11.prod.outlook.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 20 Jul 2022 16:04:43 -0700
Message-ID: <CAJHvVchusMjvhLxYkWpa+iTaHvXYPFHcX7JGP=bW60e_O1jFGA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Amit, Nadav" <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 3:16 PM Schaufler, Casey
<casey.schaufler@intel.com> wrote:
>
> > -----Original Message-----
> > From: Axel Rasmussen <axelrasmussen@google.com>
> > Sent: Tuesday, July 19, 2022 12:56 PM
> > To: Alexander Viro <viro@zeniv.linux.org.uk>; Andrew Morton
> > <akpm@linux-foundation.org>; Dave Hansen
> > <dave.hansen@linux.intel.com>; Dmitry V . Levin <ldv@altlinux.org>; Gleb
> > Fotengauer-Malinovskiy <glebfm@altlinux.org>; Hugh Dickins
> > <hughd@google.com>; Jan Kara <jack@suse.cz>; Jonathan Corbet
> > <corbet@lwn.net>; Mel Gorman <mgorman@techsingularity.net>; Mike
> > Kravetz <mike.kravetz@oracle.com>; Mike Rapoport <rppt@kernel.org>;
> > Amit, Nadav <namit@vmware.com>; Peter Xu <peterx@redhat.com>;
> > Shuah Khan <shuah@kernel.org>; Suren Baghdasaryan
> > <surenb@google.com>; Vlastimil Babka <vbabka@suse.cz>; zhangyi
> > <yi.zhang@huawei.com>
> > Cc: Axel Rasmussen <axelrasmussen@google.com>; linux-
> > doc@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-mm@kvack.org; linux-
> > kselftest@vger.kernel.org
> > Subject: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine grained
> > access control
>
> I assume that leaving the LSM mailing list off of the CC is purely
> accidental. Please, please include us in the next round.

Honestly it just hadn't occurred to me, but I'm more than happy to CC
it on future revisions.

>
> >
> > This series is based on torvalds/master.
> >
> > The series is split up like so:
> > - Patch 1 is a simple fixup which we should take in any case (even by itself).
> > - Patches 2-6 add the feature, configurable selftest support, and docs.
> >
> > Why not ...?
> > ============
> >
> > - Why not /proc/[pid]/userfaultfd? The proposed use case for this is for one
> >   process to open a userfaultfd which can intercept another process' page
> >   faults. This seems to me like exactly what CAP_SYS_PTRACE is for, though,
> > so I
> >   think this use case can simply use a syscall without the powers
> > CAP_SYS_PTRACE
> >   grants being "too much".
> >
> > - Why not use a syscall? Access to syscalls is generally controlled by
> >   capabilities. We don't have a capability which is used for userfaultfd access
> >   without also granting more / other permissions as well, and adding a new
> >   capability was rejected [1].
> >
> >     - It's possible a LSM could be used to control access instead. I suspect
> >       adding a brand new one just for this would be rejected,
>
> You won't know if you don't ask.

Fair enough - I wonder if MM folks (Andrew, Peter, Nadav especially)
would find that approach more palatable than /proc/[pid]/userfaultfd?
Would it make sense from our perspective to propose a userfaultfd- or
MM-specific LSM for controlling access to certain features?

I remember +Andrea saying Red Hat was also interested in some kind of
access control mechanism like this. Would one or the other approach be
more convenient for you?

>
> >       but I think some
> >       existing ones like SELinux can be used to filter syscall access. Enabling
> >       SELinux for large production deployments which don't already use it is
> >       likely to be a huge undertaking though, and I don't think this use case by
> >       itself is enough to motivate that kind of architectural change.
> >
> > Changelog
> > =========
> >
> > v3->v4:
> >   - Picked up an Acked-by on 5/5.
> >   - Updated cover letter to cover "why not ...".
> >   - Refactored userfaultfd_allowed() into userfaultfd_syscall_allowed().
> > [Peter]
> >   - Removed obsolete comment from a previous version. [Peter]
> >   - Refactored userfaultfd_open() in selftest. [Peter]
> >   - Reworded admin-guide documentation. [Mike, Peter]
> >   - Squashed 2 commits adding /dev/userfaultfd to selftest and making
> > selftest
> >     configurable. [Peter]
> >   - Added "syscall" test modifier (the default behavior) to selftest. [Peter]
> >
> > v2->v3:
> >   - Rebased onto linux-next/akpm-base, in order to be based on top of the
> >     run_vmtests.sh refactor which was merged previously.
> >   - Picked up some Reviewed-by's.
> >   - Fixed ioctl definition (_IO instead of _IOWR), and stopped using
> >     compat_ptr_ioctl since it is unneeded for ioctls which don't take a pointer.
> >   - Removed the "handle_kernel_faults" bool, simplifying the code. The result
> > is
> >     logically equivalent, but simpler.
> >   - Fixed userfaultfd selftest so it returns KSFT_SKIP appropriately.
> >   - Reworded documentation per Shuah's feedback on v2.
> >   - Improved example usage for userfaultfd selftest.
> >
> > v1->v2:
> >   - Add documentation update.
> >   - Test *both* userfaultfd(2) and /dev/userfaultfd via the selftest.
> >
> > [1]: https://lore.kernel.org/lkml/686276b9-4530-2045-6bd8-
> > 170e5943abe4@schaufler-ca.com/T/
> >
> > Axel Rasmussen (5):
> >   selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
> >   userfaultfd: add /dev/userfaultfd for fine grained access control
> >   userfaultfd: selftests: modify selftest to use /dev/userfaultfd
> >   userfaultfd: update documentation to describe /dev/userfaultfd
> >   selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh
> >
> >  Documentation/admin-guide/mm/userfaultfd.rst | 41 +++++++++++-
> >  Documentation/admin-guide/sysctl/vm.rst      |  3 +
> >  fs/userfaultfd.c                             | 69 ++++++++++++++++----
> >  include/uapi/linux/userfaultfd.h             |  4 ++
> >  tools/testing/selftests/vm/run_vmtests.sh    | 11 +++-
> >  tools/testing/selftests/vm/userfaultfd.c     | 69 +++++++++++++++++---
> >  6 files changed, 169 insertions(+), 28 deletions(-)
> >
> > --
> > 2.37.0.170.g444d1eabd0-goog
>
