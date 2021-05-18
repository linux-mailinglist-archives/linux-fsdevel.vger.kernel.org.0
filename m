Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C983882BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 00:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352744AbhERWat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 18:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhERWas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 18:30:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716EBC061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 15:29:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n10so11074525ion.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJSTAKCZ+krTWG3lgInmgl4vdo4n0Oih7NdB8EZOroE=;
        b=jbuHe9+Qf8UciW37lf7ZswZs7ReoWXczX04sFI1v7v+3FEj4I+EoN+d69cBUfvxZL2
         pppqzzmCpxde7Hh+QW7SdZ1jnX4IX5TcXLfsMzhVJOrTYHglNNe+YSCOyZrx8IZeqH1D
         IXg0zl7mwhjrFeuEQYeofug0VDMviAXFvR3ZUcYWSeo/1nefLar6o+c5Cb94aEOmOEE9
         MQy8UMokWYa8Fi1ImWSqAGd0WJbpPO0JSFgRT6Jmr+Nw5hnSuXw/G4l0obG05YIbnKtn
         XjsnCgoHUZulXA1LHNcZ3wLelpQCj9ucW4gS+3QoYK/5Ibly+MvFuRT9L+37QjSIjH/f
         tnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJSTAKCZ+krTWG3lgInmgl4vdo4n0Oih7NdB8EZOroE=;
        b=bBMMHOw8/JtsPVA/QFVOEESKuvk2/wU1B/8/XknzYKto3R2kNghElqcrGaV++K3sF7
         4aiMwSdEIG0AMx/4ycGUu6NvlQ4NzWsaQOeS6SbhaOS5OaQkYdHeA5tZmkwzFL2C8w5f
         egI0z9lHWE0RDRyeYoTShQ/0GVZt80ExTShhhYYQ3unOEso39S//lLdEqWhcUIOKKpUD
         9FLvGhiagD1L+AG4fDtFjnq+6K7rRxMCI2nHBLYCSfNRH6aL1J+qDiRIs1oUBdcwlMPr
         aWrj0bPVVWexHwLNd+Xb+xUnkWVy5+n/4//Zw4tFz1EGdRzRVRHtaGsbEUuLifGBxCBB
         /qIA==
X-Gm-Message-State: AOAM533jaNxKUVM0N1919/6KbKawm14No219SYcWJKy5MIZm8Wycc41i
        7Lrwy83ys5bWs97F+oiLa8BVfr/FzosSwYylOIzcBQ==
X-Google-Smtp-Source: ABdhPJxg1XeLxXOYntitmR4NlPBu0nqJwFp2PCXTohQRhknrcmZuOxJxUcxf72xJjinay2qMPf2wVkwu5qRUYJyu2as=
X-Received: by 2002:a05:6602:446:: with SMTP id e6mr6560189iov.20.1621376969710;
 Tue, 18 May 2021 15:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-10-axelrasmussen@google.com> <YKQqKrl+/cQ1utrb@t490s>
In-Reply-To: <YKQqKrl+/cQ1utrb@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 18 May 2021 15:28:52 -0700
Message-ID: <CAJHvVch3SZ80yt+FnK5M=m4haJ-pFZqvMtGVYHnw9rs1pBkNcw@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] userfaultfd/selftests: reinitialize test context
 in each test
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
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

I suppose it will be squashed anyway, but in case it's useful feel free to add:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks for catching this, Peter!

On Tue, May 18, 2021 at 1:57 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 27, 2021 at 03:52:43PM -0700, Axel Rasmussen wrote:
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
>
> Hi, Andrew,
>
> There's a conflict on the uffd test case with v5.13-rc1-mmots-2021-05-13-17-23
> between this patch and the uffd pagemap series, so I think we may need to queue
> another fixup patch (to be squashed into this patch of Axel's) which is
> attached.
>
> Thanks,
>
> --
> Peter Xu
