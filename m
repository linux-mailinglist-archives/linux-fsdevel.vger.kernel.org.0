Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299B0484B05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 00:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiADXEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 18:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiADXEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:04:44 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C848C061761
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 15:04:44 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id o1so65904127uap.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 15:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGTDOKUFi7zO+d79pWO817pqCCSEiZUvdJ5m+8rvxCA=;
        b=Vq2UWrZRZ/V3IkL5xQPw4sK457GrJq/WGgnD994N8UpM5fE4ZpVWKkQjEJSUlRCC+S
         N80GiReieK9NC9xQVyvz9BhxYpwc7LWf6W4aM36q8k0Q69cY4+L2TfuN/oxwngrztnXF
         grm2OJ2nWYPzJUuXJoi/p4GKhsZup4A6WaVvS/mI2TD1KIyXvGEZgG33WSiJ6ccRLS1r
         jFxOohSEa8Jgp0MojMyyxYnPe5RJvAsOP5jXHv6Qqsrb6ENA2zOEmpT6XzjnESBDuUGP
         kDVZmzUh6zyRshn0uZqGSzMas96FCWFCWJbaEtXUxGcZ2vshAc44NreDhAWTpkUIfqvl
         c2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGTDOKUFi7zO+d79pWO817pqCCSEiZUvdJ5m+8rvxCA=;
        b=a/BZltSQ0EyxAAM/BDSm+XUJBTIbTPuNfH+wkX31dXuFDQbIyE1jk+peY5bTm7RHnG
         u4K03Kzudc1XsL9NmJvKixjJ/b+Ng8CG/uXLGZ1tg9RmXquqRvpun1WezbtyVS6xObg0
         UqHnOyAMaOUeQYZdr1kmriQKJbw57RIe0HR27A6YTXyl5Iua3yOWe7BCtY8CzTFrewjL
         dfm40AdaB+siSe//PnK8hniftZaZkIebB2eT7KDXUVxTtaGUdjhTkeTKP9FHrW6f2176
         ksTdbi1IX2TzClmoXZviVXBuNlcSWwJ2ZwuB43k5roXleaGrcwVYwg7JJzLNnHMQPr9x
         3NGA==
X-Gm-Message-State: AOAM530to2xnpAxBLqJrJayF/6/MxU4nr9FlHKD0gh11Ka7dZa83jL2b
        D25HDCc1tjoXKkQR7mE9Nkm769s0D4s4q35r5RcwOw==
X-Google-Smtp-Source: ABdhPJzrzdQ9oZ8c9KxNThr7KVaZnd8IRIGK4zN+HrR/xQOECiyYuhQgixfNU7D+urgXsf2w6BRuPu+/B7sopDGcZBs=
X-Received: by 2002:ab0:6201:: with SMTP id m1mr13499007uao.25.1641337483580;
 Tue, 04 Jan 2022 15:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20211123000102.4052105-1-almasrymina@google.com>
 <YaMBGQGNLqPd6D6f@casper.infradead.org> <CAHS8izM5as_AmN4bSmZd1P7aSXZ86VAfXgyooZivyf7-E5gZcQ@mail.gmail.com>
In-Reply-To: <CAHS8izM5as_AmN4bSmZd1P7aSXZ86VAfXgyooZivyf7-E5gZcQ@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 4 Jan 2022 15:04:31 -0800
Message-ID: <CAHS8izNw87-L=rEwJF7_9WCaAcXLn2dUe68h_SbLErJoSUDzzg@mail.gmail.com>
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 4:22 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Sat, Nov 27, 2021 at 8:10 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> > > Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> > > address is currently mapped by a transparent huge page or not.  Example
> > > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > > mount for example), for a performance critical region of memory.  The
> > > userspace may want to query whether the kernel is actually backing this
> > > memory by hugepages or not.
> >
> > But what is userspace going to _do_ differently if the kernel hasn't
> > backed the memory with huge pages?
>
> Sorry for the late reply here.
>
> My plan is to expose this information as metrics right now and:
> 1. Understand the kind of hugepage backing we're actually getting if any.
> 2. If there are drops in hugepage backing we can investigate the
> cause, whether it's due to normal memory fragmentation or some
> bug/issue.
> 3. Schedule machines for reboots to defragment the memory if the
> hugepage backing is too low.
> 4. Possibly motivate future work to improve hugepage backing if our
> numbers are too low.

Friendly ping on this. It has been reviewed by a few folks and after
Matthew had questions about the use case which I've answered in the
email above. Matthew, are you opposed to this patch?
