Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78493611A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 20:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhDOSEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhDOSEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:04:15 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCB6C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:03:52 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b17so20927923ilh.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMi3JQh4ceVfV/j7Lf7DWzkm4A/CG7sUwuBKTI9Y7vs=;
        b=LOWfqGRgHZ2GaLk4r0jnjtm6hmUQDMtLwyD23G/zSp+dciXK8p9hxW5dpWlieJWVov
         9fZxBC9Gq0vChe5/SI2Xz2rZtf5evjuecN76OfNiPb1n7JvJtsnyuPbcU7lyolclN6h9
         xm/USSXnuwH42Jp23W8TX1U8yNA3aiVNF0zBR+WhMg086kxGgjnkrWSXlZ2K1t+dKvX5
         mz6u4JCxYhvmR84+sH+l+BSsbQc2DhNnetCk62Xcxyf/eFiJ8bkw8HN++VM57h/YDUKu
         p8uMAQs2++W6WuNhOtTfjydZwv7nX0X3/sjt3phwy8sk76atjR1aN3znqw1PgpCPveT8
         oH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMi3JQh4ceVfV/j7Lf7DWzkm4A/CG7sUwuBKTI9Y7vs=;
        b=bNgdhgBnLSG28tT7yFMqfrJZN5BfP5R/2sp+K0QEBbyzuFizrYkiRVlzKNIoXLbGIp
         piBdw5LHpEin5xl+ux1PFy5bh3tOBPEfYgDeYaffE1YMbHFE+uabj0kuJFFAMUsLnURC
         EiwR+yrMrzBC/PRs3z+m5dQPW4VTxQAyKBn1nBOzJMiInnTw5BmPkz3shCfZlvHrbDEQ
         s0Prv9M61OzKvrP0uymrP6Oii77wD3ocU0LPf5jIaldJMvEtVgmvXnCstzGsuBdKbmlg
         wUZBSMcnI+rUhyT5aSugUX6p+YOEuOcVsUbz/BFXv2PxTsaBd50DKWMBkty7DUB7BfVe
         3UtQ==
X-Gm-Message-State: AOAM532zfeL2omCWUhdaWg33YKPvw4dxu0FoCuPyR3QEl0CWJrJ267dz
        P5Bhz99g2dlMkB/WAmreq7UlRvugKD6sTnzgvJ3W9A==
X-Google-Smtp-Source: ABdhPJzLg34mG/2F8echbVGsALC+cjlSLd1cDv+gDbhlWGfCHOBwcNyvJAecuz7DsvJdtaeQICx6VrotmYdZLAXz92k=
X-Received: by 2002:a05:6e02:1d06:: with SMTP id i6mr1346852ila.165.1618509831881;
 Thu, 15 Apr 2021 11:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-8-axelrasmussen@google.com> <20210413201535.GD4440@xz-x1>
In-Reply-To: <20210413201535.GD4440@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 15 Apr 2021 11:03:14 -0700
Message-ID: <CAJHvVcix2CO_+qQ7+gWMLYL9H5zyDNz_06UnThd84etMNr-SWQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] userfaultfd/selftests: reinitialize test context
 in each test
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
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

On Tue, Apr 13, 2021 at 1:15 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 12, 2021 at 10:17:19PM -0700, Axel Rasmussen wrote:
> > Currently, the context (fds, mmap-ed areas, etc.) are global. Each test
> > mutates this state in some way, in some cases really "clobbering it"
> > (e.g., the events test mremap-ing area_dst over the top of area_src, or
> > the minor faults tests overwriting the count_verify values in the test
> > areas). We run the tests in a particular order, each test is careful to
> > make the right assumptions about its starting state, etc.
> >
> > But, this is fragile. It's better for a test's success or failure to not
> > depend on what some other prior test case did to the global state.
> >
> > To that end, clear and reinitialize the test context at the start of
> > each test case, so whatever prior test cases did doesn't affect future
> > tests.
> >
> > This is particularly relevant to this series because the events test's
> > mremap of area_dst screws up assumptions the minor fault test was
> > relying on. This wasn't a problem for hugetlb, as we don't mremap in
> > that case.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  tools/testing/selftests/vm/userfaultfd.c | 221 +++++++++++++----------
> >  1 file changed, 127 insertions(+), 94 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > index 1f65c4ab7994..0ff01f437a39 100644
> > --- a/tools/testing/selftests/vm/userfaultfd.c
> > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > @@ -89,7 +89,8 @@ static int shm_fd;
> >  static int huge_fd;
> >  static char *huge_fd_off0;
> >  static unsigned long long *count_verify;
> > -static int uffd, uffd_flags, finished, *pipefd;
> > +static int uffd = -1;
> > +static int uffd_flags, finished, *pipefd;
> >  static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
> >  static char *zeropage;
> >  pthread_attr_t attr;
> > @@ -342,6 +343,121 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
> >
> >  static struct uffd_test_ops *uffd_test_ops;
> >
> > +static int userfaultfd_open(uint64_t *features)
> > +{
> > +     struct uffdio_api uffdio_api;
> > +
> > +     uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>
> Keep UFFD_USER_MODE_ONLY?
>
> [...]
>
> > @@ -961,10 +1045,9 @@ static int userfaultfd_zeropage_test(void)
> >       printf("testing UFFDIO_ZEROPAGE: ");
> >       fflush(stdout);
> >
> > -     uffd_test_ops->release_pages(area_dst);
> > -
> > -     if (userfaultfd_open(0))
> > +     if (uffd_test_ctx_clear() || uffd_test_ctx_init(0))
> >               return 1;
>
> Would it look even nicer to init() at the entry of each test, and clear() after
> finish one test?

I slightly prefer clearing at the beginning, as it means we don't need
to depend on the previous test being correct for this test to
function. And, we don't need more complex error handling in the test
cases to make sure we don't mess things up for the next test.

But, two things we can do to clean this up as-is:

The initialization function can just call clear itself, so tests don't
need to worry about it.

And, with err(), we don't need these functions to return an int any more.

I'll send a version like that, we can see how it looks.

>
> > +
> >       uffdio_register.range.start = (unsigned long) area_dst;
> >       uffdio_register.range.len = nr_pages * page_size;
> >       uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
>
> The rest looks good to me.  Thanks,
>
> --
> Peter Xu
>
