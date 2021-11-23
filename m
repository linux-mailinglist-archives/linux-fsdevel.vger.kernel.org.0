Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB345AE15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbhKWVN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhKWVN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:13:57 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D23C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:10:49 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e8so399887ilu.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLDl0AcNYTJVo90T0ikRPoOCcN+nFjw2fk9E2jlxHm0=;
        b=ee1y/8pWQqFIlU2moAaj0G8MwXibMQ6JD/r9AjXTqXwO5LlMnDM0X7pPgZnoO/NACK
         uJwc0NegcEpLzeX22d5NEqty/klXVqmtw3K677vBycR6tJYbmVqa1awY5lO/tKfDeXDk
         ULZpu714imlEZzPTgFvqTqbN7DgTpjN4y6IpL6fWdBLkuxFpMzXCLZjQyl/BVcFoVssf
         iukmWDVuuEok+5zDV68mEKEAHOgUC6psjAcpfgKAlUubzhXP7tAGi2l81DnkhgZxcwda
         ri6YPKXUPY+nUVhuHFmLk2QR5heWl3QGGKVRWLF+7d0DMCin3WHQ64sHiWBrSu/QEeRy
         +4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLDl0AcNYTJVo90T0ikRPoOCcN+nFjw2fk9E2jlxHm0=;
        b=otIJkxpRiu6vo7mjfJSoJfeRQS6n9am29f7ASB89l891wpYJyfbwsIHHwQQfTmnE60
         1zdEePNa1jP20E/OhGLyNJas+UUPx28hzLvz3iFB80Jk7VooCiTEH4l91SQH8p5m6Bqc
         SSpL8S09Sg3qDOB85rU7HWVshhdOFUjTCrSPS/AotZ7iEeAIt4dxnkM6RI1kj8OLlSrI
         9iJk2JgZD9PPEfwJWVjzj4VehXYaMlVNQv0vwmDcI9Aj9/STHRThuKwkG2z567iX8OZy
         qYc+J0cSKlLarwdjHsBukOn4TcQd3oj1qd2//Ewq9TMl3O/BbL0dwGGtFXJdwI56UTJu
         lIPQ==
X-Gm-Message-State: AOAM530Howc9r576af9mkBEQlOSRDelAmgOHrc01HOC9WO595OmCBIC1
        hiytxh0rg3sNYeb/bsgdAraxj4ySpR5CC3AqRjOztw==
X-Google-Smtp-Source: ABdhPJwflQAlAlhXlis1geqZoQrYzfqnD13b3VHES42zh8wYx0T2LaXbrlPZHRtoI3mfBEAYceSNyc2pQNjfZr85F6E=
X-Received: by 2002:a05:6e02:1bc3:: with SMTP id x3mr7808639ilv.39.1637701848501;
 Tue, 23 Nov 2021 13:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20211123000102.4052105-1-almasrymina@google.com> <YZ1USY+zB1PP24Z1@casper.infradead.org>
In-Reply-To: <YZ1USY+zB1PP24Z1@casper.infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 23 Nov 2021 13:10:37 -0800
Message-ID: <CAHS8izOhi45RqCACGGXYyB8UAmMo-85TyuNX8Myzdh81xOkBTA@mail.gmail.com>
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

On Tue, Nov 23, 2021 at 12:51 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> > Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> > address is currently mapped by a transparent huge page or not.  Example
> > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > mount for example), for a performance critical region of memory.  The
> > userspace may want to query whether the kernel is actually backing this
> > memory by hugepages or not.
>
> So you want this bit to be clear if the memory is backed by a hugetlb
> page?
>

Yes I believe so. I do not see value in telling the userspace that the
virt address is backed by a hugetlb page, since if the memory is
mapped by MAP_HUGETLB or is backed by a hugetlb file then the memory
is backed by hugetlb pages and there is no vagueness from the kernel
here.

Additionally hugetlb interfaces are more size based rather than PMD or
not. arm64 for example supports 64K, 2MB, 32MB and 1G 'huge' pages and
it's an implementation detail that those sizes are mapped CONTIG PTE,
PMD, CONITG PMD, and PUD respectively, and the specific mapping
mechanism is typically not exposed to the userspace and might not be
stable. Assuming pagemap_hugetlb_range() == PMD_MAPPED would not
technically be correct.

> >               if (page && page_mapcount(page) == 1)
> >                       flags |= PM_MMAP_EXCLUSIVE;
> > +             if (page && is_transparent_hugepage(page))
> > +                     flags |= PM_THP_MAPPED;
>
> because honestly i'd expect it to be more useful to mean "This memory
> is mapped by a PMD entry" and then the code would look like:
>
>                 if (page)
>                         flags |= PM_PMD_MAPPED;
>
> (and put a corresponding change in pagemap_hugetlb_range)
